From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/9] git-svn: Allow for more argument types for commit (from..to)
Date: Mon, 20 Feb 2006 10:57:26 -0800
Message-ID: <1140461846433-git-send-email-normalperson@yhbt.net>
References: <11404618464102-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 19:58:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGE2-0001PS-Se
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWBTS5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWBTS5a
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56507 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932630AbWBTS52 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:28 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 549212DC09C;
	Mon, 20 Feb 2006 10:57:26 -0800 (PST)
In-Reply-To: <11404618464102-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16494>

Allow 'from..to' notation from the command line.

More liberal sha1 parsing when reading from stdin no longer requires the
sha1 to be the first character, so a leading 'commit ' string is OK.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn     |   13 ++++++++++---
 contrib/git-svn/git-svn.txt |    2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

4d8326c4868461e8a48a4e25ef11ece6e9f92843
diff --git a/contrib/git-svn/git-svn b/contrib/git-svn/git-svn
index 477ec16..5f23d6b 100755
--- a/contrib/git-svn/git-svn
+++ b/contrib/git-svn/git-svn
@@ -216,14 +216,21 @@ sub commit {
 		print "Reading from stdin...\n";
 		@commits = ();
 		while (<STDIN>) {
-			if (/^([a-f\d]{6,40})\b/) {
+			if (/\b([a-f\d]{6,40})\b/) {
 				unshift @commits, $1;
 			}
 		}
 	}
 	my @revs;
-	foreach (@commits) {
-		push @revs, (safe_qx('git-rev-parse',$_));
+	foreach my $c (@commits) {
+		chomp(my @tmp = safe_qx('git-rev-parse',$c));
+		if (scalar @tmp == 1) {
+			push @revs, $tmp[0];
+		} elsif (scalar @tmp > 1) {
+			push @revs, reverse (safe_qx('git-rev-list',@tmp));
+		} else {
+			die "Failed to rev-parse $c\n";
+		}
 	}
 	chomp @revs;
 
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 9912f5a..07a236f 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -149,7 +149,7 @@ Tracking and contributing to an Subversi
 # Commit only the git commits you want to SVN::
 	git-svn commit <tree-ish> [<tree-ish_2> ...]
 # Commit all the git commits from my-branch that don't exist in SVN::
-	git rev-list --pretty=oneline git-svn-HEAD..my-branch | git-svn commit
+	git commit git-svn-HEAD..my-branch
 # Something is committed to SVN, pull the latest into your branch::
 	git-svn fetch && git pull . git-svn-HEAD
 
-- 
1.2.0.gdee6
