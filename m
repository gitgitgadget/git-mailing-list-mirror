From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add commit hook and make the verification customizable.
Date: Thu, 18 Aug 2005 18:05:09 -0700
Message-ID: <7vslx6d9dm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 19 03:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5vJu-0002nY-PV
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 03:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbVHSBFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 21:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVHSBFN
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 21:05:13 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12694 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964789AbVHSBFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 21:05:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819010509.IOLS550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 21:05:09 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There are three hooks:

    - 'pre-commit' is given an opportunity to inspect what is
      being committed, before we invoke the EDITOR for the
      commit message;

    - 'commit-msg' is invoked on the commit log message after
      the user prepares it;

    - 'post-commit' is run after a successful commit is made.

The first two can interfere to stop the commit.  The last one is
for after-the-fact notification.

The earlier built-in commit checker is now moved to pre-commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-commit-script            |   75 +++++++++++++-----------------------------
 templates/hooks--commit-msg  |   14 ++++++++
 templates/hooks--post-commit |    8 ++++
 templates/hooks--pre-commit  |   60 ++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 52 deletions(-)
 create mode 100644 templates/hooks--commit-msg
 create mode 100644 templates/hooks--post-commit
 create mode 100644 templates/hooks--pre-commit

971fd26a05c6a5f71c727b7350c091d5bdb4ebb7
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -6,10 +6,10 @@
 . git-sh-setup-script || die "Not a git archive"
 
 usage () {
-	die 'git commit [-a]  [-m <message>] [-F <logfile>] [(-C|-c) <commit>] [<path>...]'
+	die 'git commit [-a] [-v | --no-verify]  [-m <message>] [-F <logfile>] [(-C|-c) <commit>] [<path>...]'
 }
 
-all= logfile= use_commit= no_edit= log_given= log_message= verify= signoff=
+all= logfile= use_commit= no_edit= log_given= log_message= verify=t signoff=
 while case "$#" in 0) break;; esac
 do
   case "$1" in
@@ -67,6 +67,9 @@ do
   -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
     signoff=t
     shift ;;
+  -n|--n|--no|--no-|--no-v|--no-ve|--no-ver|--no-veri|--no-verif|--no-verify)
+    verify=
+    shift ;;
   -v|--v|--ve|--ver|--veri|--verif|--verify)
     verify=t
     shift ;;
@@ -101,56 +104,10 @@ git-update-cache -q --refresh || exit 1
 
 case "$verify" in
 t)
-	# This is slightly modified from Andrew Morton's Perfect Patch.
-	# Lines you introduce should not have trailing whitespace.
-	# Also check for an indentation that has SP before a TAB.
-	perl -e '
-	    my $fh;
-	    my $found_bad = 0;
-	    my $filename;
-	    my $reported_filename = "";
-	    my $lineno;
-	    sub bad_line {
-		my ($why, $line) = @_;
-		if (!$found_bad) {
-		    print "*\n";
-		    print "* You have some suspicious patch lines:\n";
-		    print "*\n";
-		    $found_bad = 1;
-		}
-		if ($reported_filename ne $filename) {
-		    print "* In $filename\n";
-		    $reported_filename = $filename;
-		}
-		print "* $why (line $lineno)\n$line\n";
-	    }
-	    open $fh, "-|", qw(git-diff-cache -p -M --cached HEAD);
-	    while (<$fh>) {
-		if (m|^diff --git a/(.*) b/\1$|) {
-		    $filename = $1;
-		    next;
-		}
-		if (/^@@ -\S+ \+(\d+)/) {
-		    $lineno = $1 - 1;
-		    next;
-		}
-		if (/^ /) {
-		    $lineno++;
-		    next;
-		}
-		if (s/^\+//) {
-		    $lineno++;
-		    chomp;
-		    if (/\s$/) {
-			bad_line("trailing whitespace", $_);
-		    }
-		    if (/^\s* 	/) {
-			bad_line("indent SP followed by a TAB", $_);
-		    }
-		}
-	    }
-	    exit($found_bad);
-	' || exit ;;
+	if test -x "$GIT_DIR"/hooks/pre-commit
+	then
+		"$GIT_DIR"/hooks/pre-commit || exit
+	fi
 esac
 
 PARENTS="-p HEAD"
@@ -255,6 +212,15 @@ case "$no_edit" in
 	${VISUAL:-${EDITOR:-vi}} .editmsg
 	;;
 esac
+
+case "$verify" in
+t)
+	if test -x "$GIT_DIR"/hooks/commit-msg
+	then
+		"$GIT_DIR"/hooks/commit-msg .editmsg || exit
+	fi
+esac
+
 grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
 grep -v -i '^Signed-off-by' .cmitmsg >.cmitchk
 if test -s .cmitchk
@@ -269,4 +235,9 @@ else
 fi
 ret="$?"
 rm -f .cmitmsg .editmsg .cmitchk
+
+if test -x "$GIT_DIR"/hooks/post-commit && test "$ret" = 0
+then
+	"$GIT_DIR"/hooks/post-commit
+fi
 exit "$ret"
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
new file mode 100644
--- /dev/null
+++ b/templates/hooks--commit-msg
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# An example hook script to check the commit log message.
+# Called by git-commit-script with one argument, the name of the file
+# that has the commit message.  The hook should exit with non-zero
+# status after issuing an appropriate message if it wants to stop the
+# commit.  The hook is allowed to edit the commit message file.
+#
+# To enable this hook, make this file executable.
+
+# This example catches duplicate Signed-off-by lines.
+
+test "" = "$(grep '^Signed-off-by: ' "$1" |
+	 sort | uniq -c | sed -e '/^[ 	]*1 /d')"
diff --git a/templates/hooks--post-commit b/templates/hooks--post-commit
new file mode 100644
--- /dev/null
+++ b/templates/hooks--post-commit
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# An example hook script that is called after a successful
+# commit is made.
+#
+# To enable this hook, make this file executable.
+
+: Nothing
diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
new file mode 100644
--- /dev/null
+++ b/templates/hooks--pre-commit
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by git-commit-script with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message if
+# it wants to stop the commit.
+#
+# To enable this hook, make this file executable.
+
+# This is slightly modified from Andrew Morton's Perfect Patch.
+# Lines you introduce should not have trailing whitespace.
+# Also check for an indentation that has SP before a TAB.
+perl -e '
+    my $fh;
+    my $found_bad = 0;
+    my $filename;
+    my $reported_filename = "";
+    my $lineno;
+    sub bad_line {
+	my ($why, $line) = @_;
+	if (!$found_bad) {
+	    print "*\n";
+	    print "* You have some suspicious patch lines:\n";
+	    print "*\n";
+	    $found_bad = 1;
+	}
+	if ($reported_filename ne $filename) {
+	    print "* In $filename\n";
+	    $reported_filename = $filename;
+	}
+	print "* $why (line $lineno)\n$line\n";
+    }
+    open $fh, "-|", qw(git-diff-cache -p -M --cached HEAD);
+    while (<$fh>) {
+	if (m|^diff --git a/(.*) b/\1$|) {
+	    $filename = $1;
+	    next;
+	}
+	if (/^@@ -\S+ \+(\d+)/) {
+	    $lineno = $1 - 1;
+	    next;
+	}
+	if (/^ /) {
+	    $lineno++;
+	    next;
+	}
+	if (s/^\+//) {
+	    $lineno++;
+	    chomp;
+	    if (/\s$/) {
+		bad_line("trailing whitespace", $_);
+	    }
+	    if (/^\s* 	/) {
+		bad_line("indent SP followed by a TAB", $_);
+	    }
+	}
+    }
+    exit($found_bad);
+'
+
