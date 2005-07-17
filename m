From: Junio C Hamano <junkio@cox.net>
Subject: [RFC/PATCH] git-rev-parse vs IFS
Date: Sat, 16 Jul 2005 23:59:57 -0700
Message-ID: <7vmzol29zm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 09:00:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du38O-0008IY-3M
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 09:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVGQHAB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 03:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVGQHAB
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 03:00:01 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:5573 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261172AbVGQHAA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 03:00:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050717065958.SAKF22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Jul 2005 02:59:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"git whatchanged" does not work with parameters that have an IFS
character; this includes a filename with SP in it.  A silly
example:

    $ git-whatchanged --max-count=1
    diff-tree 98800286dffc76736549d7279622157ca2be9a3b (from 9171e0...
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Sat Jul 16 23:13:03 2005 -0700

        add foo

    :000000 100644 0000000000000000000000000000000000000000 8b13789...
    $ git-whatchanged --max-count=1 'foo bar'
    $ ;# no output!

This is because the tail parameter to git-diff-tree used in
git-whatchanged is $(git-rev-parse --no-revs "$@"), and the
output from git-rev-parse is split at $IFS, so it ends up
getting "foo" and "bar" separately).

If it were just embedded SP and TAB in the filnames, I would say
we can set IFS to LF in the script that use git-rev-parse,
declare that we do not support filenames with embedded LF, and
be done with it.  The thing is, for pickaxe, it is very natural
to give a multi-line parameter, so setting IFS to LF is not a
general workaround.

Doing this portably is possible but a bit of pain.  I can add
git-rev-parse ability to sq_quote its outputs, and change the
callers to build a command line to "eval" using it.  Here is an
RFC patch that does it.  My barf-o-tolerance for shell quoting
and evaling is usually much higher than others, so while I feel
this is not too ugly, it may offend your aesthetics.

------------
Help scripts that use git-rev-parse to grok args with SP/TAB/LF

The git-rev-parse command uses LF to separate each arguments it
parses, so its users at least need to set IFS to LF to be able
to handle filenames with embedded SPs and TABs.  Some commands,
however, can take and do expect arguments with embedded LF
(notably, -Spickaxe of diff family), so even this workaround
does not work for them.

When --sq flag to git-rev-parse is given, instead of showing one
argument per line, it outputs arguments quoted for consumption
with "eval" by the caller, to remedy this situation.

As an example, this patch converts git-whatchanged to use this
new feature.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-whatchanged |    9 ++++++---
 rev-parse.c     |   36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 5 deletions(-)

79cdb9505b0ee9a47969c3cbc8c8bf2a35b23ca8
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
@@ -54,14 +55,41 @@ static void show_rev(int type, const uns
 	if (no_revs)
 		return;
 	output_revs++;
+
+	/* Hexadecimal string plus possibly a carret;
+	 * this does not have to be quoted even under output_sq.
+	 */
 	printf("%s%s\n", type == show_type ? "" : "^", sha1_to_hex(sha1));
 }
 
+static void show(const char *arg)
+{
+	if (output_sq) {
+		int sq = '\'';
+		const char *next;
+
+		putchar(sq);
+		while (*arg) {
+			next = strchr(arg, sq);
+			if (!next) {
+				fputs(arg, stdout);
+				break;
+			}
+			fputs("'\\''", stdout);
+			arg = next + 1;
+		}
+		putchar(sq);
+		putchar('\n');
+	}
+	else
+		puts(arg);
+}
+
 static void show_rev_arg(char *rev)
 {
 	if (no_revs)
 		return;
-	puts(rev);
+	show(rev);
 }
 
 static void show_norev(char *norev)
@@ -70,7 +98,7 @@ static void show_norev(char *norev)
 		return;
 	if (revs_only)
 		return;
-	puts(norev);
+	show(norev);
 }
 
 static void show_arg(char *arg)
@@ -328,6 +356,10 @@ int main(int argc, char **argv)
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
