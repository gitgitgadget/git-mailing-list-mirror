From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: delay term initialization
Date: Sun, 14 Sep 2014 08:04:09 +0000
Message-ID: <1410681849-3107-1-git-send-email-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 10:04:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4nZ-0006D1-3A
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbaINIET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:04:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51466 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752397AbaINIEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:04:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCB61FF94;
	Sun, 14 Sep 2014 08:04:15 +0000 (UTC)
X-Mailer: git-send-email 2.1.0.63.g147cd9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257001>

On my Debian 7 system, this gives annoying warnings when the output
of "git svn" commands are redirected:

    Unable to get Terminal Size. The TIOCGWINSZ ioctl didn't work.
    The COLUMNS and LINES environment variables didn't work. The
    resize program didn't work.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Also, manually tested to ensure dcommit --interactive works.

 git-svn.perl | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 40565cd..ce0d7e1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -306,13 +306,16 @@ sub readline {
 }
 package main;
 
-my $term = eval {
-	$ENV{"GIT_SVN_NOTTY"}
-		? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
-		: new Term::ReadLine 'git-svn';
-};
-if ($@) {
-	$term = new FakeTerm "$@: going non-interactive";
+my $term;
+sub term_init {
+	$term = eval {
+		$ENV{"GIT_SVN_NOTTY"}
+			? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
+			: new Term::ReadLine 'git-svn';
+	};
+	if ($@) {
+		$term = new FakeTerm "$@: going non-interactive";
+	}
 }
 
 my $cmd;
@@ -424,6 +427,7 @@ sub ask {
 	my $default = $arg{default};
 	my $resp;
 	my $i = 0;
+	term_init() unless $term;
 
 	if ( !( defined($term->IN)
             && defined( fileno($term->IN) )
-- 
EW
