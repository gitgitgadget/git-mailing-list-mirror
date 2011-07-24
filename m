From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 5/5] setup_revisions: remember whether a ref was positive or not
Date: Sun, 24 Jul 2011 16:21:22 +0200
Message-ID: <1311517282-24831-6-git-send-email-srabbelier@gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jul 24 16:22:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzZp-0006Dd-83
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893Ab1GXOWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:22:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab1GXOW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:22:28 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so3380781wwe.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JRygBh84x+qgJ7IqJ/9ypWWkNeUiBj29GA6sLQ9qAoo=;
        b=XEe1HsDg66dXsgg6tG966ZYoqIoek9e538mWc08zkfg6VPTAfcJqK3DhFI5MslR3R0
         W1iPbQgyCWXWahgE48EZ8cvkdzmwyrU0nbRmchYj7dclCjL9Ig6NYDRPaCGdz8sR0DJT
         M2n6yCZWb+4pX1nHFZ78rUV3YqaYdv/WI3T4s=
Received: by 10.227.209.20 with SMTP id ge20mr596909wbb.108.1311517346934;
        Sun, 24 Jul 2011 07:22:26 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id fc2sm3526819wbb.35.2011.07.24.07.22.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:22:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.385.g91185.dirty
In-Reply-To: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177758>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

This will be required by fast-export, when no commits were
exported, but the refs should be set, of course.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  And then finally, the fix. Thanks for reading.

 builtin/fast-export.c  |   36 +++++++++++++++++++++++++++++++-----
 t/t9350-fast-export.sh |    2 +-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 628eab0..9c24f4e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -17,6 +17,8 @@
 #include "utf8.h"
 #include "parse-options.h"
 
+#define REF_HANDLED (ALL_REV_FLAGS + 1)
+
 static const char *fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
 	NULL
@@ -456,6 +458,7 @@ static void handle_tag(const char *name, struct tag *tag)
 }
 
 static void get_tags_and_duplicates(struct object_array *pending,
+				    struct string_list *refs,
 				    struct string_list *extra_refs)
 {
 	struct tag *tag;
@@ -507,8 +510,11 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		if (commit->util)
 			/* more than one name for the same object */
 			string_list_append(extra_refs, full_name)->util = commit;
-		else
+		else {
 			commit->util = full_name;
+			/* we might need to set this ref explicitly */
+			string_list_append(refs, full_name)->util = commit;
+		}
 	}
 }
 
@@ -524,10 +530,29 @@ static void handle_reset(const char *name, struct object *object)
 		       sha1_to_hex(object->sha1));
 }
 
-static void handle_tags_and_duplicates(struct string_list *extra_refs)
+static void handle_tags_and_duplicates(struct string_list *refs, struct string_list *extra_refs)
 {
 	int i;
 
+	/* even if no commits were exported, we need to export the ref */
+	for (i = refs->nr - 1; i >= 0; i--) {
+		const char *name = refs->items[i].string;
+		struct object *object = refs->items[i].util;
+
+		if (!(object->flags & REF_HANDLED)) {
+			if (object->type & OBJ_TAG)
+				handle_tag(name, (struct tag *)object);
+			else {
+				if (!prefixcmp(name, "refs/tags/") &&
+				    (tag_of_filtered_mode != REWRITE ||
+				     !get_object_mark(object)))
+					continue;
+				handle_reset(name, object);
+				object->flags |= REF_HANDLED;
+			}
+		}
+	}
+
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
 		const char *name = extra_refs->items[i].string;
 		struct object *object = extra_refs->items[i].util;
@@ -617,7 +642,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = OBJECT_ARRAY_INIT;
-	struct string_list extra_refs = STRING_LIST_INIT_NODUP;
+	struct string_list refs = STRING_LIST_INIT_NODUP, extra_refs = STRING_LIST_INIT_NODUP;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	struct option options[] = {
@@ -669,7 +694,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename && revs.prune_data.nr)
 		full_tree = 1;
 
-	get_tags_and_duplicates(&revs.pending, &extra_refs);
+	get_tags_and_duplicates(&revs.pending, &refs, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
@@ -681,11 +706,12 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 		else {
 			handle_commit(commit, &revs);
+			commit->object.flags |= REF_HANDLED;
 			handle_tail(&commits, &revs);
 		}
 	}
 
-	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates(&refs, &extra_refs);
 
 	if (export_filename)
 		export_marks(export_filename);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index ed0417a..d2d7ef8 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -420,7 +420,7 @@ from $(git rev-parse master)
 
 EOF
 
-test_expect_failure 'refs are updated even if no commits need to be exported' '
+test_expect_success 'refs are updated even if no commits need to be exported' '
 	git fast-export master..master > actual &&
 	test_cmp expected actual
 '
-- 
1.7.6.385.g91185.dirty
