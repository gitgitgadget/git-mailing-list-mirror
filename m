From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 7/9] fast-export: make extra_refs global
Date: Sat, 24 Nov 2012 04:25:18 +0100
Message-ID: <1353727520-26039-8-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nk-0006y1-Dp
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab2KXDZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:59 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2KXDZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:58 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=rGGeEZl59Mqztur+fZCBip50/+VjNGfjFWcgDukq91A=;
        b=yb0aPgGYr+EHX5VpUS6ANOEoWICbeNXmlC/JTnkUOvKibd1P19Z9K3YKRcitYFVSKr
         yDErBC6i7xhww/oJW+W+nmUsJccUgoaE8qQXQGMZhp0VVbXmqQImOcS4491+E58Kfvx9
         GyQFTcZL8Dc6M8FZJ/t4FDpoOSEKhAM8gHbPXlmFyhZ8NXzYxKzWChrk1t9vjx/TZaHy
         /ioj7OBnjpxguuOHtxI7emYYWdQquD99bBcCuiHTK8Ezq6hsGZudijj0/O7BI80w9Q09
         gjRXyFtFDENY7j4mGjMFdsveJbIK1T7wN2QedgrjM3c3IITOsPQh6E1vTx5WNU/JmHlq
         jK1w==
Received: by 10.205.120.3 with SMTP id fw3mr1741470bkc.40.1353727557152;
        Fri, 23 Nov 2012 19:25:57 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id j16sm4403480bkv.1.2012.11.23.19.25.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:56 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210305>

There's no need to pass it around everywhere. This would make easier
further refactoring that makes use of this variable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 77dffd1..5035382 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -30,6 +30,7 @@ static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
 static int full_tree;
+static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -474,8 +475,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)message_size, (int)message_size, message ? message : "");
 }
 
-static void get_tags_and_duplicates(struct rev_cmdline_info *info,
-				    struct string_list *extra_refs)
+static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 {
 	struct tag *tag;
 	int i;
@@ -502,7 +502,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 			/* handle nested tags */
 			while (tag && tag->object.type == OBJ_TAG) {
 				parse_object(tag->object.sha1);
-				string_list_append(extra_refs, full_name)->util = tag;
+				string_list_append(&extra_refs, full_name)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -532,20 +532,20 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 		 * sure it gets properly updated eventually.
 		 */
 		if (commit->util || commit->object.flags & SHOWN)
-			string_list_append(extra_refs, full_name)->util = commit;
+			string_list_append(&extra_refs, full_name)->util = commit;
 		if (!commit->util)
 			commit->util = full_name;
 	}
 }
 
-static void handle_tags_and_duplicates(struct string_list *extra_refs)
+static void handle_tags_and_duplicates(void)
 {
 	struct commit *commit;
 	int i;
 
-	for (i = extra_refs->nr - 1; i >= 0; i--) {
-		const char *name = extra_refs->items[i].string;
-		struct object *object = extra_refs->items[i].util;
+	for (i = extra_refs.nr - 1; i >= 0; i--) {
+		const char *name = extra_refs.items[i].string;
+		struct object *object = extra_refs.items[i].util;
 		switch (object->type) {
 		case OBJ_TAG:
 			handle_tag(name, (struct tag *)object);
@@ -638,7 +638,6 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = OBJECT_ARRAY_INIT;
-	struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	struct option options[] = {
@@ -688,7 +687,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename && revs.prune_data.nr)
 		full_tree = 1;
 
-	get_tags_and_duplicates(&revs.cmdline, &extra_refs);
+	get_tags_and_duplicates(&revs.cmdline);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
@@ -704,7 +703,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates();
 
 	if (export_filename)
 		export_marks(export_filename);
-- 
1.8.0
