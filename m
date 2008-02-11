From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] [svn] Add `git svn blame' command
Date: Sun, 10 Feb 2008 18:37:59 -0800
Message-ID: <20080211023712.GA18370@soma>
References: <1202619068-1404-1-git-send-email-tim@stoakes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 03:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOOZE-0004eQ-MI
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 03:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbYBKCiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 21:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYBKCiB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 21:38:01 -0500
Received: from hand.yhbt.net ([66.150.188.102]:42129 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499AbYBKCiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 21:38:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 42F507DC08E;
	Sun, 10 Feb 2008 18:37:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1202619068-1404-1-git-send-email-tim@stoakes.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73459>

Thanks Tim,

Minor fixes below:

>From 1209255c50d5437da0b88796519bc2ab1b907c0a Mon Sep 17 00:00:00 2001
From: Tim Stoakes <tim@stoakes.net>
Date: Sun, 10 Feb 2008 15:21:08 +1030
Subject: [PATCH] Add `git svn blame' command

This command is identical to `git blame', but it shows SVN revision
numbers instead of git commit hashes.

[ew: support "^initial commit" and minor formatting fixes]

Signed-off-by: Tim Stoakes <tim@stoakes.net>
Acked-by: Eric Wong <normalperson@yhbt.net>
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
index 7889cce..05fb358 100755
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
+		if ($line =~ /^\^?([[:xdigit:]]+)\s/) {
+			my (undef, $rev, undef) = ::cmt_metadata($1);
+			$rev = sprintf('%-10s', $rev);
+			$line =~ s/^\^?[[:xdigit:]]+(\s)/$rev$1/;
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
Eric Wong
