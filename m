From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] pre-commit hook: less easily-tripped conflict marker detection
Date: Tue, 27 Jun 2006 02:06:17 -0700
Message-ID: <11513991771758-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 27 11:06:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fv9Wb-0008R6-5G
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 11:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933048AbWF0JGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 05:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933094AbWF0JGV
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 05:06:21 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8399 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S933048AbWF0JGU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 05:06:20 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4BDE07DC022;
	Tue, 27 Jun 2006 02:06:18 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 02:06:17 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.rc1.g2faf-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22719>

This should make adding asciidoc files to Documentation easier.

Only complain about conflict markers if we see that we have
some combination of '<<<<<<< ', '>>>>>>> ', and '======='.

Also add a NO_VERIFY environment check to this hook, in case
there's something that we want to force in but still gets
tripped by this hook.  It'd be a lot more work to add
--no-verify flags to all things that could potentially call this
hook.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 templates/hooks--pre-commit |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..1657f96 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -1,4 +1,5 @@
 #!/bin/sh
+test -n "$NO_VERIFY" && exit 0
 #
 # An example hook script to verify what is about to be committed.
 # Called by git-commit with no arguments.  The hook should
@@ -24,8 +25,9 @@ perl -e '
     my $filename;
     my $reported_filename = "";
     my $lineno;
-    sub bad_line {
-	my ($why, $line) = @_;
+    my $in_unresolved;
+    my @unresolved;
+    sub bad_common {
 	if (!$found_bad) {
 	    print STDERR "*\n";
 	    print STDERR "* You have some suspicious patch lines:\n";
@@ -36,12 +38,34 @@ perl -e '
 	    print STDERR "* In $filename\n";
 	    $reported_filename = $filename;
 	}
+    }
+    sub bad_line {
+	my ($why, $line) = @_;
+	bad_common();
 	print STDERR "* $why (line $lineno)\n";
 	print STDERR "$filename:$lineno:$line\n";
     }
+    sub show_unresolved {
+	# if we want even less easily-tripped checks,
+	# change the "||" to "&&" here.  Right now, we can deal with
+	# the case where somebody removed one of the <{7} or >{7} lines
+	# but left the other one (as well as ={7}) in there.
+	if (($unresolved[0]->[0] =~ /^<{7} / ||
+				$unresolved[-1]->[0] =~ /^>{7} /) &&
+				grep { $_->[0] =~ /^={7}$/ } @unresolved) {
+	    bad_common();
+	    foreach my $l (@unresolved) {
+		print STDERR "* unresolved merge conflict (line $l->[1])\n";
+		print STDERR "$filename:$l->[1]:$l->[0]\n"
+	    }
+	}
+	@unresolved = ();
+    }
+
     while (<>) {
 	if (m|^diff --git a/(.*) b/\1$|) {
 	    $filename = $1;
+	    show_unresolved() if @unresolved;
 	    next;
 	}
 	if (/^@@ -\S+ \+(\d+)/) {
@@ -61,8 +85,8 @@ perl -e '
 	    if (/^\s* 	/) {
 		bad_line("indent SP followed by a TAB", $_);
 	    }
-	    if (/^(?:[<>=]){7}/) {
-		bad_line("unresolved merge conflict", $_);
+	    if (/^[<>]{7} / || /^={7}$/) {
+		push @unresolved, [ $_, $lineno ];
 	    }
 	}
     }
-- 
1.4.1.rc1.g2faf-dirty
