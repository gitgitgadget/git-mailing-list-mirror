X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Colourise git-branch output
Date: Fri, 3 Nov 2006 12:06:12 +0000
Message-ID: <200611031206.12515.andyparkins@gmail.com>
References: <200611031052.16095.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 12:06:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611031052.16095.andyparkins@gmail.com>
X-TUID: 2faeccc0a768f2ca
X-UID: 162
X-Length: 3787
Content-Disposition: inline
X-OriginalArrivalTime: 03 Nov 2006 12:07:20.0375 (UTC) FILETIME=[9D018470:01C6FF40]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30834>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfxoS-00081c-Nx for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751552AbWKCMGR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWKCMGR
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:06:17 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:23230 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1751552AbWKCMGQ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:06:16 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Fri, 3 Nov 2006 12:07:20 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfxoM-0005kO-00 for <git@vger.kernel.org>; Fri, 03 Nov
 2006 12:06:14 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I wanted to have a visual indication of which branches are local and which are
remote in git-branch -a output; however Junio was concerned that someone might
be using the output in a script.  This patch addresses the problem by colouring
the git-branch output - which in "auto" mode won't be activated.

I've based it off the colouring code for builtin-diff.c; which means there is a
branch.color configuration variable that needs setting to something before the
color will appear.

This patch chooses green for local, red for remote and bold green for current.

As yet, there is no support for changing the colors using the config file; but
it wouldn't be hard to add.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 6dd33ee..de7f81e 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -5,6 +5,7 @@
  * Based on git-branch.sh by Junio C Hamano.
  */
 
+#include "color.h"
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
@@ -17,6 +18,38 @@ static const char builtin_branch_usage[]
 static const char *head;
 static unsigned char head_sha1[20];
 
+static int branch_use_color;
+static char branch_colors[][COLOR_MAXLEN] = {
+	"\033[m",	/* reset */
+	"",		/* PLAIN (normal) */
+	"\033[31m",	/* REMOTE (red) */
+	"\033[32m",	/* LOCAL (green) */
+	"\033[1;32m",	/* CURRENT (boldgreen) */
+};
+enum color_branch {
+	COLOR_BRANCH_RESET = 0,
+	COLOR_BRANCH_PLAIN = 1,
+	COLOR_BRANCH_REMOTE = 2,
+	COLOR_BRANCH_LOCAL = 3,
+	COLOR_BRANCH_CURRENT = 4,
+};
+
+int git_branch_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "branch.color")) {
+		branch_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
+const char *branch_get_color(enum color_branch ix)
+{
+	if (branch_use_color)
+		return branch_colors[ix];
+	return "";
+}
+
 static int in_merge_bases(const unsigned char *sha1,
 			  struct commit *rev1,
 			  struct commit *rev2)
@@ -157,6 +190,7 @@ static void print_ref_list( int type_wan
 	int i;
 	char c;
 	struct ref_list ref_list;
+	int color;
 
 	memset( &ref_list, 0, sizeof( ref_list ) );
 	ref_list.type_wanted = type_wanted;
@@ -165,11 +199,28 @@ static void print_ref_list( int type_wan
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	for (i = 0; i < ref_list.index; i++) {
+		switch( ref_list.list[i].type ) {
+			case REF_LOCAL_BRANCH:
+				color = COLOR_BRANCH_LOCAL;
+				break;
+			case REF_REMOTE_BRANCH:
+				color = COLOR_BRANCH_REMOTE;
+				break;
+			default:
+				color = COLOR_BRANCH_PLAIN;
+				break;
+		}
+
 		c = ' ';
-		if (!strcmp(ref_list.list[i].name, head))
+		if (!strcmp(ref_list.list[i].name, head)) {
 			c = '*';
+			color = COLOR_BRANCH_CURRENT;
+		}
 
-		printf("%c %s\n", c, ref_list.list[i].name);
+		printf("%c %s%s%s\n", c,
+				branch_get_color(color),
+				ref_list.list[i].name,
+				branch_get_color(COLOR_BRANCH_RESET));
 	}
 
 	tidy_ref_list( &ref_list );
@@ -219,7 +270,7 @@ int cmd_branch(int argc, const char **ar
 	int i;
 	int type_wanted = REF_LOCAL_BRANCH;
 
-	git_config(git_default_config);
+	git_config(git_branch_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-- 
1.4.3.2
