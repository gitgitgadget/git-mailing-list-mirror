From: Tim Stoakes <tim@stoakes.net>
Subject: [PATCH] [svn] Add `git svn blame' command
Date: Sun, 10 Feb 2008 15:21:08 +1030
Message-ID: <1202619068-1404-1-git-send-email-tim@stoakes.net>
Cc: gitster@pobox.com, normalperson@yhbt.net,
	Tim Stoakes <tim@stoakes.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 05:52:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO4Ae-0007Bt-7S
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 05:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbYBJEvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 23:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbYBJEvP
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 23:51:15 -0500
Received: from hosted07.westnet.com.au ([203.10.1.223]:44659 "EHLO
	hosted07.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbYBJEvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 23:51:14 -0500
Received: from hosted07.westnet.com.au (hosted07.westnet.com.au [127.0.0.1])
	by hosted07.westnet.com.au (Postfix) with SMTP id 8AA6233D25A;
	Sun, 10 Feb 2008 13:51:11 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted07.westnet.com.au (Postfix) with ESMTP id 28E4D33D240;
	Sun, 10 Feb 2008 13:51:07 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id 4831E28C010;
	Sun, 10 Feb 2008 15:21:06 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 1AA597F1FF; Sun, 10 Feb 2008 15:21:08 +1030 (CST)
X-Mailer: git-send-email 1.5.4
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73313>

This command is identical to `git blame', but it shows SVN revision
numbers instead of git commit hashes.

Signed-off-by: Tim Stoakes <tim@stoakes.net>
---
 Documentation/git-svn.txt |    7 +++++++
 git-svn.perl              |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index b1d527f..340f1be 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -161,6 +161,13 @@ New features:
 +
 Any other arguments are passed directly to `git log'
 
+'blame'::
+       Show what revision and author last modified each line of a file. This is
+       identical to `git blame', but SVN revision numbers are shown instead of git
+       commit hashes.
++
+All arguments are passed directly to `git blame'.
+
 --
 'find-rev'::
 	When given an SVN revision number of the form 'rN', returns the
diff --git a/git-svn.perl b/git-svn.perl
index 7889cce..4437ed5 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -186,6 +186,9 @@ my %cmd = (
 		    "Show info about the latest SVN revision
 		     on the current branch",
 		    { 'url' => \$_url, } ],
+	'blame' => [ \&Git::SVN::Log::cmd_blame,
+	            "Show what revision and author last modified each line of a file",
+	            {} ],
 );
 
 my $cmd;
@@ -4448,6 +4451,24 @@ out:
 	print commit_log_separator unless $incremental || $oneline;
 }
 
+sub cmd_blame {
+	my $path = shift;
+
+	config_pager();
+	run_pager();
+
+	my ($fh, $ctx) = command_output_pipe('blame', @_, $path);
+	while (my $line = <$fh>) {
+		if ($line=~/^([[:xdigit:]]+)\s/) {
+			my (undef, $rev, undef) = ::cmt_metadata($1);
+			$rev = sprintf('%-10s', $rev);
+			$line=~s/^[[:xdigit:]]+(\s)/$rev$1/;
+		}
+		print $line;
+	}
+	command_close_pipe($fh, $ctx);
+}
+
 package Git::SVN::Migration;
 # these version numbers do NOT correspond to actual version numbers
 # of git nor git-svn.  They are just relative.
-- 
1.5.4
