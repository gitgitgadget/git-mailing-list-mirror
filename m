From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] fast-export: make extra_refs global
Date: Sun,  1 Sep 2013 02:05:47 -0500
Message-ID: <1378019148-1565-2-git-send-email-felipe.contreras@gmail.com>
References: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 09:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG1o6-0007IZ-Qa
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 09:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab3IAHKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 03:10:38 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:44167 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab3IAHKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 03:10:34 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so3464493obc.3
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TSMdsyIx7krvRt8RxGr8lpFI6GVQF4ig1twPEeodnAs=;
        b=ERHSacZiSUpSXK1kFV6i0P8X+t78zpv4hSdHt+dammYO+zuEoONLtYoBc0GpjVfhct
         VFnmitVceXyCnyzu3Nm4f5v/fojdNJzDz8zn73eF+3QQpG2vlPOunKkcZMd12pBRsmZw
         pWRlAq5eE4GFhGBPGybghcb0tfJ8zBZDKUU3f+uiD8uHuG4B/xVw6ogad1UkoTAcFPay
         PBt5UZA9p1fGMumZzOUMkCIpjaG74MjI4mPbr9o79nDal1YFys2pkXOx0CWNPRSlNRtD
         iaAAO/hcRbP/+jm/j12kZg3iHiCcreOOrB7dmSbu1dwmqkXbYvhyo2axEn5v76G09eTo
         K2Hg==
X-Received: by 10.60.133.233 with SMTP id pf9mr22149oeb.46.1378019432581;
        Sun, 01 Sep 2013 00:10:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm7175785obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 00:10:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233568>

There's no need to pass it around everywhere. This would make easier
further refactoring that makes use of this variable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8e19058..957392c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -30,6 +30,7 @@ static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
 static int full_tree;
+static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -484,8 +485,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)message_size, (int)message_size, message ? message : "");
 }
 
-static void get_tags_and_duplicates(struct rev_cmdline_info *info,
-				    struct string_list *extra_refs)
+static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 {
 	struct tag *tag;
 	int i;
@@ -512,7 +512,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
 			/* handle nested tags */
 			while (tag && tag->object.type == OBJ_TAG) {
 				parse_object(tag->object.sha1);
-				string_list_append(extra_refs, full_name)->util = tag;
+				string_list_append(&extra_refs, full_name)->util = tag;
 				tag = (struct tag *)tag->tagged;
 			}
 			if (!tag)
@@ -542,20 +542,20 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info,
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
@@ -657,7 +657,6 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct object_array commits = OBJECT_ARRAY_INIT;
-	struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 	struct commit *commit;
 	char *export_filename = NULL, *import_filename = NULL;
 	uint32_t lastimportid;
@@ -709,7 +708,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename && revs.prune_data.nr)
 		full_tree = 1;
 
-	get_tags_and_duplicates(&revs.cmdline, &extra_refs);
+	get_tags_and_duplicates(&revs.cmdline);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
@@ -725,7 +724,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates();
 
 	if (export_filename && lastimportid != last_idnum)
 		export_marks(export_filename);
-- 
1.8.4-337-g7358a66-dirty
