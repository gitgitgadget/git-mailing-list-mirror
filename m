From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 2/3] blame: extract find_single_final
Date: Mon, 26 Oct 2015 07:26:56 +0200
Message-ID: <1445837217-4252-4-git-send-email-max@max630.net>
References: <1445837217-4252-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 06:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqaJW-0000tz-IX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 06:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbbJZF1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 01:27:16 -0400
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:56576
	"EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751172AbbJZF1L (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 01:27:11 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-05.prod.phx3.secureserver.net with 
	id ZhSy1r00P5B68XE01hT9vt; Sun, 25 Oct 2015 22:27:10 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445837217-4252-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280173>

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/blame.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 295ce92..38f6267 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2401,16 +2401,11 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	return commit;
 }
 
-static char *prepare_final(struct scoreboard *sb)
+static struct object_array_entry *find_single_final(struct rev_info *revs)
 {
 	int i;
-	const char *final_commit_name = NULL;
-	struct rev_info *revs = sb->revs;
+	struct object_array_entry *found = NULL;
 
-	/*
-	 * There must be one and only one positive commit in the
-	 * revs->pending array.
-	 */
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
@@ -2419,14 +2414,24 @@ static char *prepare_final(struct scoreboard *sb)
 			obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
-		if (sb->final)
+		if (found)
 			die("More than one commit to dig from %s and %s?",
 			    revs->pending.objects[i].name,
-			    final_commit_name);
-		sb->final = (struct commit *) obj;
-		final_commit_name = revs->pending.objects[i].name;
+			    found->name);
+		found = &(revs->pending.objects[i]);
+	}
+	return found;
+}
+
+static char *prepare_final(struct scoreboard *sb)
+{
+	struct object_array_entry *found = find_single_final(sb->revs);
+	if (found) {
+		sb->final = (struct commit *) found->item;
+		return xstrdup(found->name);
+	} else {
+		return NULL;
 	}
-	return xstrdup_or_null(final_commit_name);
 }
 
 static char *prepare_initial(struct scoreboard *sb)
-- 
2.3.4.2801.g3d0809b
