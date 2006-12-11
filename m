X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 22:10:08 +0000
Message-ID: <200612112210.08327.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:13:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=bRxlgcpRxfgheWrCXNqWItJZC0j6hqivzRMee2akIIt6DuLobo+5/FjryGAeEEarZJME48CQEqsoK8KzZHQR1JoEXwwzXxq+SJsteqjvJ8Dqca26TO4y5RLp8Qq81DNHRXd281YeBwun6T1gAcxDA39rkW0ThsZKf/P4ouywhzk=
X-TUID: 78035e8f31c2b6ef
X-UID: 183
X-Length: 4112
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34041>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttOY-0008V0-1l for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1763156AbWLKWNG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763157AbWLKWNG
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:13:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:10703 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1763156AbWLKWND (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:13:03 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1470386uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:13:02 -0800 (PST)
Received: by 10.78.185.16 with SMTP id i16mr3534270huf.1165875181840; Mon, 11
 Dec 2006 14:13:01 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 18sm3243783hue.2006.12.11.14.13.00; Mon, 11 Dec
 2006 14:13:00 -0800 (PST)
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
I know Junio isn't keen on adding colour all over the place in git; but I
think it's appropriate here.  When running in "git-branch -a" mode (or even
"git-branch -r" mode for that matter), because the "refs/remotes" prefix is
stripped from the branch name, there is no way to distinguish between local
and remote branches.  Colouring them makes it easy to see which is which,
but more importantly doesn't break any scripts because the colour would be
automatically disabled.

 builtin-branch.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3d5cb0e..1c1fa8f 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -5,6 +5,7 @@
  * Based on git-branch.sh by Junio C Hamano.
  */
 
+#include "color.h"
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
@@ -17,6 +18,38 @@ static const char builtin_branch_usage[] =
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
@@ -183,6 +216,7 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 	int i;
 	char c;
 	struct ref_list ref_list;
+	int color;
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -191,18 +225,38 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	for (i = 0; i < ref_list.index; i++) {
+		switch( ref_list.list[i].kind ) {
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
 		if (ref_list.list[i].kind == REF_LOCAL_BRANCH &&
-				!strcmp(ref_list.list[i].name, head))
+				!strcmp(ref_list.list[i].name, head)) {
 			c = '*';
+			color = COLOR_BRANCH_CURRENT;
+		}
 
 		if (verbose) {
-			printf("%c %-*s", c, ref_list.maxwidth,
-			       ref_list.list[i].name);
+			printf("%c %s%-*s%s", c,
+					branch_get_color(color),
+					ref_list.maxwidth,
+					ref_list.list[i].name,
+					branch_get_color(COLOR_BRANCH_RESET));
 			print_ref_info(ref_list.list[i].sha1, abbrev);
 		}
 		else
-			printf("%c %s\n", c, ref_list.list[i].name);
+			printf("%c %s%s%s\n", c,
+					branch_get_color(color),
+					ref_list.list[i].name,
+					branch_get_color(COLOR_BRANCH_RESET));
 	}
 
 	free_ref_list(&ref_list);
@@ -253,7 +307,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
-	git_config(git_default_config);
+	git_config(git_branch_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-- 
1.4.4.1.geeee8
