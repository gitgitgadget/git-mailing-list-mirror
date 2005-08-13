From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --signoff and --verify option to git commit.
Date: Sat, 13 Aug 2005 02:08:15 -0700
Message-ID: <7vzmrmp5kw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 11:08:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3s0J-0004si-JX
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 11:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVHMJIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 05:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVHMJIV
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 05:08:21 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44735 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932135AbVHMJIU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 05:08:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813090815.CQUK3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 05:08:15 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As brought up in the discussion which followed a patch to add a
signed-off-by line with the --sign flag to format-patch from
Johannes Schindelin, add --signoff to the git commit command.

Also add --verify to make sure the lines you introduced are
clean, which is more useful in commit but not very much in
format-patch as it was originally implemented, because finding
botches at format-patch time is too late.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-commit-script |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 72 insertions(+), 4 deletions(-)

2f1c5b4fa572886646d9993129f7cd0a61fe4190
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -9,7 +9,7 @@ usage () {
 	die 'git commit [-a]  [-m <message>] [-F <logfile>] [(-C|-c) <commit>] [<path>...]'
 }
 
-all= logfile= use_commit= no_edit= log_given= log_message=
+all= logfile= use_commit= no_edit= log_given= log_message= verify= signoff=
 while case "$#" in 0) break;; esac
 do
   case "$1" in
@@ -64,6 +64,12 @@ do
     use_commit="$1"
     no_edit=t
     shift ;;
+  -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
+    signoff=t
+    shift ;;
+  -v|--v|--ve|--ver|--veri|--verif|--verify)
+    verify=t
+    shift ;;
   --)
     shift
     break ;;
@@ -86,6 +92,60 @@ t)
 esac
 git-update-cache -q --refresh -- "$@" || exit 1
 
+case "$verify" in
+t)
+	# This is slightly modified from Andrew Morton's Perfect Patch.
+	# Lines you introduce should not have trailing whitespace.
+	# Also check for an indentation that has SP before a TAB.
+	perl -e '
+	    my $fh;
+	    my $found_bad = 0;
+	    my $filename;
+	    my $reported_filename = "";
+	    my $lineno;
+	    sub bad_line {
+		my ($why, $line) = @_;
+		if (!$found_bad) {
+		    print "*\n";
+		    print "* You have some suspicious patch lines:\n";
+		    print "*\n";
+		    $found_bad = 1;
+		}
+		if ($reported_filename ne $filename) {
+		    print "* In $filename\n";
+		    $reported_filename = $filename;
+		}
+		print "* $why (line $lineno)\n$line\n";
+	    }
+	    open $fh, "-|", qw(git-diff-cache -p -M --cached HEAD);
+	    while (<$fh>) {
+		if (m|^diff --git a/(.*) b/\1$|) {
+		    $filename = $1;
+		    next;
+		}
+		if (/^@@ -\S+ \+(\d+)/) {
+		    $lineno = $1 - 1;
+		    next;
+		}
+		if (/^ /) {
+		    $lineno++;
+		    next;
+		}
+		if (s/^\+//) {
+		    $lineno++;
+		    chomp;
+		    if (/\s$/) {
+			bad_line("trailing whitespace", $_);
+		    }
+		    if (/^\s* 	/) {
+			bad_line("indent SP followed by a TAB", $_);
+		    }
+		}
+	    }
+	    exit($found_bad);
+	' || exit ;;
+esac
+
 PARENTS="-p HEAD"
 if [ ! -r "$GIT_DIR/HEAD" ]; then
 	if [ -z "$(git-ls-files)" ]; then
@@ -161,7 +221,14 @@ else
 		export GIT_AUTHOR_DATE
 		git-cat-file commit "$use_commit" |
 		sed -e '1,/^$/d'
-	fi >.editmsg
+	fi |
+	git-stripspace >.editmsg
+	case "$signoff" in
+	t)
+		git-var GIT_COMMITTER_IDENT | sed -e '
+			s/>.*/>/
+			s/^/Signed-off-by: /' >>.editmsg ;;
+	esac
 	git-status-script >>.editmsg
 fi
 if [ "$?" != "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
@@ -176,7 +243,8 @@ case "$no_edit" in
 	;;
 esac
 grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
-if test -s .cmitmsg
+grep -v -i '^Signed-off-by' .cmitmsg >.cmitchk
+if test -s .cmitchk
 then
 	tree=$(git-write-tree) &&
 	commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) &&
@@ -187,5 +255,5 @@ else
 	false
 fi
 ret="$?"
-rm -f .cmitmsg .editmsg
+rm -f .cmitmsg .editmsg .cmitchk
 exit "$ret"
