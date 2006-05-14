From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/5] commit: allow --pretty= args to be abbreviated
Date: Sun, 14 May 2006 08:19:21 -0700
Message-ID: <1147619963765-git-send-email-normalperson@yhbt.net>
References: <11476199622462-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 14 17:19:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfINm-0004pX-Ay
	for gcvg-git@gmane.org; Sun, 14 May 2006 17:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWENPTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 11:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWENPTa
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 11:19:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:157 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751453AbWENPTY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 11:19:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A4F6E7DC005;
	Sun, 14 May 2006 08:19:23 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11476199622462-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19967>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 commit.c |   42 +++++++++++++++++++++++++++++-------------
 1 files changed, 29 insertions(+), 13 deletions(-)

b6190a2b46acc250277fd55e33e0a7216b7fad75
diff --git a/commit.c b/commit.c
index 2343729..a786371 100644
--- a/commit.c
+++ b/commit.c
@@ -22,23 +22,39 @@ struct sort_node
 
 const char *commit_type = "commit";
 
+struct cmt_fmt_map {
+	const char *n;
+	enum cmit_fmt v;
+} cmt_fmts[] = {
+	{ "raw",	CMIT_FMT_RAW },
+	{ "medium",	CMIT_FMT_MEDIUM },
+	{ "short",	CMIT_FMT_SHORT },
+	{ "full",	CMIT_FMT_FULL },
+	{ "fuller",	CMIT_FMT_FULLER },
+	{ "oneline",	CMIT_FMT_ONELINE },
+};
+
 enum cmit_fmt get_commit_format(const char *arg)
 {
+	int i, found = -1;
 	if (!arg)
 		return CMIT_FMT_DEFAULT;
-	if (!strcmp(arg, "raw"))
-		return CMIT_FMT_RAW;
-	if (!strcmp(arg, "medium"))
-		return CMIT_FMT_MEDIUM;
-	if (!strcmp(arg, "short"))
-		return CMIT_FMT_SHORT;
-	if (!strcmp(arg, "full"))
-		return CMIT_FMT_FULL;
-	if (!strcmp(arg, "fuller"))
-		return CMIT_FMT_FULLER;
-	if (!strcmp(arg, "oneline"))
-		return CMIT_FMT_ONELINE;
-	die("invalid --pretty format");
+	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
+		if (!strcmp(arg, cmt_fmts[i].n))
+			return cmt_fmts[i].v;
+	}
+
+	/* look for abbreviations */
+	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
+		if (strstr(cmt_fmts[i].n, arg)) {
+			if (found >= 0)
+				die("invalid --pretty format: %s", arg);
+			found = i;
+		}
+	}
+	if (found >= 0)
+		return cmt_fmts[found].v;
+	die("invalid --pretty format: %s", arg);
 }
 
 static struct commit *check_commit(struct object *obj,
-- 
1.3.2.g102e322
