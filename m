From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 6/9] contrib/git-svn: create a more recent master if one does not exist
Date: Fri, 3 Mar 2006 01:20:09 -0800
Message-ID: <11413776092820-git-send-email-normalperson@yhbt.net>
References: <11413776081545-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6Sf-00041U-JG
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbWCCJUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbWCCJUT
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:19 -0500
Received: from hand.yhbt.net ([66.150.188.102]:899 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752207AbWCCJUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:09 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2BAE97DC025;
	Fri,  3 Mar 2006 01:20:09 -0800 (PST)
In-Reply-To: <11413776081545-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17147>

In a new repository, the initial fetch creates a master branch
if one does not exist so HEAD has something to point to.

It now creates a master at the end of the initial fetch run,
pointing to the latest revision.  Previously it pointed to the
first revision imported, which is generally less useful.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

7d3cf853ffbe0d1ce8a15fa5ac3dad793ddb5021
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 5d547e8..69b6be3 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -224,9 +224,6 @@ sub fetch {
 		sys(@svn_co, $SVN_URL, $SVN_WC);
 		chdir $SVN_WC or croak $!;
 		$last_commit = git_commit($base, @parents);
-		unless (-f "$GIT_DIR/refs/heads/master") {
-			sys(qw(git-update-ref refs/heads/master),$last_commit);
-		}
 		assert_svn_wc_clean($base->{revision}, $last_commit);
 	} else {
 		chdir $SVN_WC or croak $!;
@@ -242,6 +239,9 @@ sub fetch {
 		$last_commit = git_commit($log_msg, $last_commit, @parents);
 	}
 	assert_svn_wc_clean($last_rev, $last_commit);
+	unless (-e "$GIT_DIR/refs/heads/master") {
+		sys(qw(git-update-ref refs/heads/master),$last_commit);
+	}
 	return pop @$svn_log;
 }
 
-- 
1.2.3.g4676
