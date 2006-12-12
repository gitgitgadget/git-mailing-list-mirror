X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Colourise git-branch output
Date: Tue, 12 Dec 2006 06:41:52 +0000
Message-ID: <200612120641.52556.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 06:44:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=lYxRH809/LzK+djlejh3vw1EsMeJ+qOuKqlDfcax3EsPTPgW9AXxEeiBDzJcHbnh3LDefjM18YwH0EMslzmvc/CYUifjatMlkJAgHa47DZVaQkgH35V7Gu/+HR19nUsXFIYat0/1uaZQKOH4CzcejKwKmNoVl6WP/vRp4LRWouc=
X-TUID: 8f1ec808d8edb826
X-UID: 190
X-Length: 5122
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34064>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu1Nk-0001s5-0z for gcvg-git@gmane.org; Tue, 12 Dec
 2006 07:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932079AbWLLGot (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 01:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWLLGot
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 01:44:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:55550 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932079AbWLLGos (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 01:44:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1574311uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 22:44:47 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr11181470ugg.1165905886800; Mon,
 11 Dec 2006 22:44:46 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id q40sm8320013ugc.2006.12.11.22.44.45; Mon, 11 Dec
 2006 22:44:46 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I wanted to have a visual indication of which branches are local and
which are remote in git-branch -a output; however Junio was concerned
that someone might be using the output in a script.  This patch
addresses the problem by colouring the git-branch output - which in
"auto" mode won't be activated.

I've based it off the colouring code for builtin-diff.c; which means
there is a branch color configuration variable that needs setting to
something before the color will appear.

The colour parameter is "color.branch" rather than "branch.color" to
avoid clashing with the default namespace for default branch merge
definitions.

This patch chooses green for local, red for remote and bold green for
current.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 builtin-branch.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 3d5cb0e..7c87b8d 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -5,6 +5,7 @@
  * Based on git-branch.sh by Junio C Hamano.
  */
 
+#include "color.h"
 #include "cache.h"
 #include "refs.h"
 #include "commit.h"
@@ -17,6 +18,58 @@ static const char builtin_branch_usage[] =
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
+static int parse_branch_color_slot(const char *var, int ofs)
+{
+	if (!strcasecmp(var+ofs, "plain"))
+		return COLOR_BRANCH_PLAIN;
+	if (!strcasecmp(var+ofs, "reset"))
+		return COLOR_BRANCH_RESET;
+	if (!strcasecmp(var+ofs, "remote"))
+		return COLOR_BRANCH_REMOTE;
+	if (!strcasecmp(var+ofs, "local"))
+		return COLOR_BRANCH_LOCAL;
+	if (!strcasecmp(var+ofs, "current"))
+		return COLOR_BRANCH_CURRENT;
+	die("bad config variable '%s'", var);
+}
+
+int git_branch_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "color.branch")) {
+		branch_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+	if (!strncmp(var, "color.branch.", 13)) {
+		int slot = parse_branch_color_slot(var, 13);
+		color_parse(value, var, branch_colors[slot]);
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
@@ -183,6 +236,7 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
 	int i;
 	char c;
 	struct ref_list ref_list;
+	int color;
 
 	memset(&ref_list, 0, sizeof(ref_list));
 	ref_list.kinds = kinds;
@@ -191,18 +245,38 @@ static void print_ref_list(int kinds, int verbose, int abbrev)
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
@@ -253,7 +327,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int kinds = REF_LOCAL_BRANCH;
 	int i;
 
-	git_config(git_default_config);
+	git_config(git_branch_config);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -297,6 +371,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--color")) {
+			branch_use_color = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-color")) {
+			branch_use_color = 0;
+			continue;
+		}
 		usage(builtin_branch_usage);
 	}
 
-- 
1.4.4.1.geeee8
