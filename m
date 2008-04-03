From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] builtin-blame.c: move prepare_final() into a separate
 function.
Date: Thu, 03 Apr 2008 02:13:38 -0700
Message-ID: <7vbq4r2tdp.fsf@gitster.siamese.dyndns.org>
References: <7v4paj486a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 11:14:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhLWn-00074D-Qn
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 11:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828AbYDCJNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 05:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbYDCJNy
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 05:13:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbYDCJNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 05:13:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 487BE239C;
	Thu,  3 Apr 2008 05:13:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6ECF22399; Thu,  3 Apr 2008 05:13:46 -0400 (EDT)
In-Reply-To: <7v4paj486a.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Apr 2008 02:08:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78737>

After parsing the command line, we had a rather long loop to compute the
commit object to start annotating from.  Move the logic to a separate
function, so that later patches become easier to read.

It also makes fill_origin_blob() function to return void; the check on its
return value by its callers is always done on !file->ptr, and nobody looks
at the return value from the function (which is the same as file->ptr).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |   56 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index bfd562d..996f535 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -91,7 +91,7 @@ struct origin {
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
-static char *fill_origin_blob(struct origin *o, mmfile_t *file)
+static void fill_origin_blob(struct origin *o, mmfile_t *file)
 {
 	if (!o->file.ptr) {
 		enum object_type type;
@@ -106,7 +106,6 @@ static char *fill_origin_blob(struct origin *o, mmfile_t *file)
 	}
 	else
 		*file = o->file;
-	return file->ptr;
 }
 
 /*
@@ -2006,6 +2005,10 @@ static int git_blame_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+/*
+ * Prepare a dummy commit that represents the work tree (or staged) item.
+ * Note that annotating work tree item never works in the reverse.
+ */
 static struct commit *fake_working_tree_commit(const char *path, const char *contents_from)
 {
 	struct commit *commit;
@@ -2122,6 +2125,33 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	return commit;
 }
 
+static const char *prepare_final(struct scoreboard *sb, struct rev_info *revs)
+{
+	int i;
+	const char *final_commit_name = NULL;
+
+	/*
+	 * There must be one and only one positive commit in the
+	 * revs->pending array.
+	 */
+	for (i = 0; i < revs->pending.nr; i++) {
+		struct object *obj = revs->pending.objects[i].item;
+		if (obj->flags & UNINTERESTING)
+			continue;
+		while (obj->type == OBJ_TAG)
+			obj = deref_tag(obj, NULL, 0);
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?", revs->pending.objects[i].name);
+		if (sb->final)
+			die("More than one commit to dig from %s and %s?",
+			    revs->pending.objects[i].name,
+			    final_commit_name);
+		sb->final = (struct commit *) obj;
+		final_commit_name = revs->pending.objects[i].name;
+	}
+	return final_commit_name;
+}
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2327,27 +2357,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	setup_revisions(unk, argv, &revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
-	/*
-	 * There must be one and only one positive commit in the
-	 * revs->pending array.
-	 */
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object *obj = revs.pending.objects[i].item;
-		if (obj->flags & UNINTERESTING)
-			continue;
-		while (obj->type == OBJ_TAG)
-			obj = deref_tag(obj, NULL, 0);
-		if (obj->type != OBJ_COMMIT)
-			die("Non commit %s?",
-			    revs.pending.objects[i].name);
-		if (sb.final)
-			die("More than one commit to dig from %s and %s?",
-			    revs.pending.objects[i].name,
-			    final_commit_name);
-		sb.final = (struct commit *) obj;
-		final_commit_name = revs.pending.objects[i].name;
-	}
-
+	final_commit_name = prepare_final(&sb, &revs);
 	if (!sb.final) {
 		/*
 		 * "--not A B -- path" without anything positive;
-- 
1.5.5.rc3.139.g8b2cf
