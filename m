From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 9/9] contrib/git-svn: better documenting of CLI switches
Date: Fri, 3 Mar 2006 01:20:09 -0800
Message-ID: <11413776092558-git-send-email-normalperson@yhbt.net>
References: <11413776092524-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Sj-00041U-A1
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbWCCJUY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbWCCJUY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:24 -0500
Received: from hand.yhbt.net ([66.150.188.102]:2435 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752214AbWCCJUK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:10 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1005E7DC028;
	Fri,  3 Mar 2006 01:20:10 -0800 (PST)
In-Reply-To: <11413776092524-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17145>

Also, fix a asciidoc formatting error

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |   29 +++++++++++++++--------------
 contrib/git-svn/git-svn.txt  |   17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 15 deletions(-)

65d8e4920084c96f82b4604ded1bd4e4fa91d3d8
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index db199a3..808b933 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -60,16 +60,7 @@ for (my $i = 0; $i < @ARGV; $i++) {
 	}
 };
 
-# we may be called as git-svn-(command), or git-svn(command).
-foreach (keys %cmd) {
-	if (/git\-svn\-?($_)(?:\.\w+)?$/) {
-		$cmd = $1;
-		last;
-	}
-}
-
-my %opts;
-%opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
+my %opts = %{$cmd{$cmd}->[2]} if (defined $cmd);
 
 GetOptions(%opts, 'help|H|h' => \$_help,
 		'version|V' => \$_version,
@@ -97,15 +88,25 @@ sub usage {
 	print $fd <<"";
 git-svn - bidirectional operations between a single Subversion tree and git
 Usage: $0 <command> [options] [arguments]\n
-Available commands:
+
+	print $fd "Available commands:\n" unless $cmd;
 
 	foreach (sort keys %cmd) {
+		next if $cmd && $cmd ne $_;
 		print $fd '  ',pack('A13',$_),$cmd{$_}->[1],"\n";
+		foreach (keys %{$cmd{$_}->[2]}) {
+			# prints out arguments as they should be passed:
+			my $x = s#=s$## ? '<arg>' : s#=i$## ? '<num>' : '';
+			print $fd ' ' x 17, join(', ', map { length $_ > 1 ?
+							"--$_" : "-$_" }
+						split /\|/,$_)," $x\n";
+		}
 	}
 	print $fd <<"";
-\nGIT_SVN_ID may be set in the environment to an arbitrary identifier if
-you're tracking multiple SVN branches/repositories in one git repository
-and want to keep them separate.  See git-svn(1) for more information.
+\nGIT_SVN_ID may be set in the environment or via the --id/-i switch to an
+arbitrary identifier if you're tracking multiple SVN branches/repositories in
+one git repository and want to keep them separate.  See git-svn(1) for more
+information.
 
 	exit $exit;
 }
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 7306048..8e9a971 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -116,6 +116,8 @@ OPTIONS
 	They are both passed directly to git-diff-tree see
 	git-diff-tree(1) for more information.
 
+ADVANCED OPTIONS
+----------------
 -b<refname>::
 --branch <refname>::
 	Used with 'fetch' or 'commit'.
@@ -131,8 +133,21 @@ OPTIONS
 	This option may be specified multiple times, once for each
 	branch.
 
+-i<GIT_SVN_ID>::
+--id <GIT_SVN_ID>::
+	This sets GIT_SVN_ID (instead of using the environment).  See
+	the section on "Tracking Multiple Repositories or Branches" for
+	more information on using GIT_SVN_ID.
+
 COMPATIBILITY OPTIONS
 ---------------------
+--upgrade::
+	Only used with the 'rebuild' command.
+
+	Run this if you used an old version of git-svn that used
+	'git-svn-HEAD' instead of 'remotes/git-svn' as the branch
+	for tracking the remote.
+
 --no-ignore-externals::
 	Only used with the 'fetch' and 'rebuild' command.
 
@@ -177,7 +192,7 @@ Tracking and contributing to an Subversi
 	git-svn commit remotes/git-svn..my-branch
 # Something is committed to SVN, pull the latest into your branch::
 	git-svn fetch && git pull . remotes/git-svn
-# Append svn:ignore settings to the default git exclude file:
+# Append svn:ignore settings to the default git exclude file::
 	git-svn show-ignore >> .git/info/exclude
 
 DESIGN PHILOSOPHY
-- 
1.2.3.g4676
