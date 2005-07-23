From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Help scripts that use git-rev-parse to grok args with SP/TAB/LF
Date: Fri, 22 Jul 2005 19:08:32 -0700
Message-ID: <7v7jfi8ean.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:09:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9RS-0008AW-Jk
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVGWCIg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVGWCIg
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:08:36 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56539 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262275AbVGWCIe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:08:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723020831.ZJZD22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:08:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The git-rev-parse command uses LF to separate each argument it
parses, so its users at least need to set IFS to LF to be able
to handle filenames with embedded SPs and TABs.  Some commands,
however, can take and do expect arguments with embedded LF,
notably, "-S" (pickaxe) of diff family, so even this workaround
does not work for them.

When --sq flag to git-rev-parse is given, instead of showing one
argument per line, it outputs arguments quoted for consumption
with "eval" by the caller, to remedy this situation.

As an example, this patch converts git-whatchanged to use this
new feature.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-whatchanged |    9 ++++++---
 rev-parse.c     |   34 +++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 6 deletions(-)

707db3532150cc9b1a6a61c66e7533dd7383093d
diff --git a/git-whatchanged b/git-whatchanged
--- a/git-whatchanged
+++ b/git-whatchanged
@@ -1,4 +1,7 @@
 #!/bin/sh
-git-rev-list $(git-rev-parse --default HEAD --revs-only "$@") |
-	git-diff-tree --stdin --pretty -r $(git-rev-parse --no-revs "$@") |
-	LESS="$LESS -S" ${PAGER:-less}
+rev_list_args=$(git-rev-parse --sq --default HEAD --revs-only "$@") &&
+diff_tree_args=$(git-rev-parse --sq --no-revs "$@") &&
+
+eval "git-rev-list $rev_list_args" |
+eval "git-diff-tree --stdin --pretty -r $diff_tree_args" |
+LESS="$LESS -S" ${PAGER:-less}
diff --git a/rev-parse.c b/rev-parse.c
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -15,6 +15,7 @@ static int do_rev_argument = 1;
 static int output_revs = 0;
 static int flags_only = 0;
 static int no_flags = 0;
+static int output_sq = 0;
 
 #define NORMAL 0
 #define REVERSED 1
@@ -49,19 +50,42 @@ static int is_rev_argument(const char *a
 	}
 }
 
+static void show(const char *arg)
+{
+	if (output_sq) {
+		int sq = '\'', ch;
+
+		putchar(sq);
+		while ((ch = *arg++)) {
+			if (ch == sq)
+				fputs("'\\'", stdout);
+			putchar(ch);
+		}
+		putchar(sq);
+		putchar(' ');
+	}
+	else
+		puts(arg);
+}
+
 static void show_rev(int type, const unsigned char *sha1)
 {
 	if (no_revs)
 		return;
 	output_revs++;
-	printf("%s%s\n", type == show_type ? "" : "^", sha1_to_hex(sha1));
+
+	/* Hexadecimal string plus possibly a carret;
+	 * this does not have to be quoted even under output_sq.
+	 */
+	printf("%s%s%c", type == show_type ? "" : "^", sha1_to_hex(sha1),
+	       output_sq ? ' ' : '\n');
 }
 
 static void show_rev_arg(char *rev)
 {
 	if (no_revs)
 		return;
-	puts(rev);
+	show(rev);
 }
 
 static void show_norev(char *norev)
@@ -70,7 +94,7 @@ static void show_norev(char *norev)
 		return;
 	if (revs_only)
 		return;
-	puts(norev);
+	show(norev);
 }
 
 static void show_arg(char *arg)
@@ -328,6 +352,10 @@ int main(int argc, char **argv)
 				single_rev = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--sq")) {
+				output_sq = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--not")) {
 				show_type ^= REVERSED;
 				continue;
