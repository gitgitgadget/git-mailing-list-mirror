From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] fast-export: refactor get_tags_and_duplicates()
Date: Sun,  1 Sep 2013 02:05:48 -0500
Message-ID: <1378019148-1565-3-git-send-email-felipe.contreras@gmail.com>
References: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 09:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG1o7-0007IZ-CL
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 09:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab3IAHKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 03:10:39 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:45115 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab3IAHKg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 03:10:36 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so3464518obc.3
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5mdyQdBKguufkuxbpDv2/660pJDXrHzmYLLXMmQPLAc=;
        b=DRSIKWZbF3wVfuoAsIYW86onyBLuh/Rn802wcUiBOxVn0c+3zNPNaOAtT1g++kTKHP
         3iWWwcrMWXTc0YsS+ueRdgiU6YW7I1jqmZW1ikTsHNEA+zKc6higHDG88Ry/vwcxm+nH
         i9qh/vxeDQJ/vzF7tOYdzu0L3DuG5DLRR3t5E4rQUpMlbaiAe+s+X4G5Ak7/7GGP4twP
         ah97ar3OLO8fc55TAwyJ5hvPJQXURCYFXEaijrjDBC92Hr41IOIqmnzqXK5HmgRjvnws
         Np9MoDolPZSRRIghcVK4F7IuKF2jogYT/G2YFBk6vs2NtHM3CNNECdL1fgw7rjVaA0T0
         evPQ==
X-Received: by 10.60.134.196 with SMTP id pm4mr16631oeb.60.1378019435336;
        Sun, 01 Sep 2013 00:10:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm7196445obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 00:10:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378019148-1565-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233569>

Split into a separate helper function get_commit() so that the part that
finds the relevant commit, and the part that does something with it
(handle tag object, etc.) are in different places.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 68 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 957392c..03e1090 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -485,9 +485,32 @@ static void handle_tag(const char *name, struct tag *tag)
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
@@ -502,41 +525,26 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
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
-				export_blob(tag->object.sha1);
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
+			export_blob(commit->object.sha1);
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
1.8.4-337-g7358a66-dirty
