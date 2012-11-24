From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 8/9] fast-export: refactor get_tags_and_duplicates()
Date: Sat, 24 Nov 2012 04:25:19 +0100
Message-ID: <1353727520-26039-9-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nu-00079n-1e
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654Ab2KXD0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:26:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab2KXD0B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:26:01 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=v9HtA+sg3zzS6iyVMZW48n0krynHHxsVyT1BFfqURWg=;
        b=bS3N223WHCGBkUHuJYO2SrRl057q/zJy/5KaHR0C5wuR13q2qU9JXFGKUKt1e0pnFW
         LroKbHBbc3ZMq35Oh+fPoXDZXea95t45mbk4IFG6ar9XyCDIeOkcy6bRUkS5hrnwTAt5
         6bYBjqFaNSzRmNdUYuOxshy1wjp8sOwiqoLuWjPXFb+k8dai/LDDttEQsdHPZisA790Z
         sINME4aNff2uH9DlJiCicD3qza6JZQQRze+sQNYOjGBqg1JrRV9s9AeeLSV7ZNxiUmwR
         FfNmS1bliEd3PWo6BzO6kYGiHJBA8FzvCDsErKiDu/gtilFGxe8W5N0JMcLMuzWWlqSs
         LFYw==
Received: by 10.204.148.7 with SMTP id n7mr1775064bkv.76.1353727560667;
        Fri, 23 Nov 2012 19:26:00 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id e22sm5475628bke.14.2012.11.23.19.25.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:59 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210307>

Split into a separate helper function get_commit() so that the part that
finds the relevant commit, and the part that does something with it
(handle tag object, etc.) are in different places.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 68 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5035382..d88fa10 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -475,9 +475,32 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)message_size, (int)message_size, message ? message : "");
 }
 
+static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
+{
+	switch (e->item->type) {
+	case OBJ_COMMIT:
+		return (struct commit *)e->item;
+	case OBJ_TAG: {
+		struct tag *tag = (struct tag *)e->item;
+
+		/* handle nested tags */
+		while (tag && tag->object.type == OBJ_TAG) {
+			parse_object(tag->object.sha1);
+			string_list_append(&extra_refs, full_name)->util = tag;
+			tag = (struct tag *)tag->tagged;
+		}
+		if (!tag)
+			die("Tag %s points nowhere?", e->name);
+		return (struct commit *)tag;
+		break;
+	}
+	default:
+		return NULL;
+	}
+}
+
 static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 {
-	struct tag *tag;
 	int i;
 
 	for (i = 0; i < info->nr; i++) {
@@ -492,41 +515,26 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
 			continue;
 
-		switch (e->item->type) {
-		case OBJ_COMMIT:
-			commit = (struct commit *)e->item;
-			break;
-		case OBJ_TAG:
-			tag = (struct tag *)e->item;
-
-			/* handle nested tags */
-			while (tag && tag->object.type == OBJ_TAG) {
-				parse_object(tag->object.sha1);
-				string_list_append(&extra_refs, full_name)->util = tag;
-				tag = (struct tag *)tag->tagged;
-			}
-			if (!tag)
-				die ("Tag %s points nowhere?", e->name);
-			switch(tag->object.type) {
-			case OBJ_COMMIT:
-				commit = (struct commit *)tag;
-				break;
-			case OBJ_BLOB:
-				handle_object(tag->object.sha1);
-				continue;
-			default: /* OBJ_TAG (nested tags) is already handled */
-				warning("Tag points to object of unexpected type %s, skipping.",
-					typename(tag->object.type));
-				continue;
-			}
-			break;
-		default:
+		commit = get_commit(e, full_name);
+		if (!commit) {
 			warning("%s: Unexpected object of type %s, skipping.",
 				e->name,
 				typename(e->item->type));
 			continue;
 		}
 
+		switch(commit->object.type) {
+		case OBJ_COMMIT:
+			break;
+		case OBJ_BLOB:
+			handle_object(commit->object.sha1);
+			continue;
+		default: /* OBJ_TAG (nested tags) is already handled */
+			warning("Tag points to object of unexpected type %s, skipping.",
+				typename(commit->object.type));
+			continue;
+		}
+
 		/*
 		 * This ref will not be updated through a commit, lets make
 		 * sure it gets properly updated eventually.
-- 
1.8.0
