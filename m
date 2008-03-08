From: John Goerzen <jgoerzen@complete.org>
Subject: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat,  8 Mar 2008 16:04:05 -0600
Message-ID: <1205013845-22286-1-git-send-email-jgoerzen@complete.org>
Cc: normalperson@yhbt.net, John Goerzen <jgoerzen@complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 23:06:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7AN-0007ch-5M
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbYCHWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbYCHWEP
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:04:15 -0500
Received: from b01s02mr.corenetworks.net ([64.85.160.192]:34904 "EHLO
	glockenspiel.complete.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYCHWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:04:14 -0500
Received: from 63-245-179-205.kitusa.com ([63.245.179.205] helo=erwin.lan.complete.org)
	by glockenspiel.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(TLS peer CN erwin.complete.org, certificate verified)
	(Exim 4.63)
	id 1JY79F-0007eQ-9m; Sat, 08 Mar 2008 16:04:11 -0600
Received: from katherina.lan.complete.org ([10.200.0.4])
	by erwin.lan.complete.org with esmtps
	(with TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(No TLS peer certificate)
	(Exim 4.67)
	id 1JY79B-0008Pv-Ja; Sat, 08 Mar 2008 16:04:05 -0600
Received: from jgoerzen by katherina.lan.complete.org with local (Exim 4.69)
	(envelope-from <jgoerzen@complete.org>)
	id 1JY79B-0005np-G1; Sat, 08 Mar 2008 16:04:05 -0600
X-Mailer: git-send-email 1.5.4.2
X-Spam-Status: No (score 0.1): AWL=0.056
X-Virus-Scanned: by Exiscan on glockenspiel.complete.org at Sat, 08 Mar 2008 16:04:11 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76592>

When the rewriteRoot setting is used with git-svn, it causes the svn
IDs added to commit messages to bear a different URL than is actually
used to retrieve Subversion data.

It is common for Subversion repositories to be available multiple
ways: for instance, HTTP to the public, and svn+ssh to people with
commit access.  The need to switch URLs for access is fairly common as
well -- perhaps someone was just given commit access.  To switch URLs
without having to rewrite history, one can use the old url as a
rewriteRoot, and use the new one in the svn-remote url setting.

This works well for svn fetching and general git commands.

However, git-svn dcommit, rebase, and perhaps other commands do not
work in this scenario.  They scan the svn ID lines in commit messages
and attempt to match them up with url lines in [svn-remote] sections
in the git config.

This patch allows them to match rewriteRoot options, if such options
are present.

Signed-off-by: John Goerzen <jgoerzen@complete.org>
---
 git-svn.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 9e2faf9..1195569 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1540,9 +1540,14 @@ sub find_by_url { # repos_root and, path are optional
 			                    $remotes->{$repo_id}->{$_});
 		}
 		my $p = $path;
+		my $rwr = rewrite_root({repo_id => $repo_id});
 		unless (defined $p) {
 			$p = $full_url;
-			$p =~ s#^\Q$u\E(?:/|$)## or next;
+			my $z = $u;
+			if ($rwr) {
+				$z = $rwr;
+			}
+			$p =~ s#^\Q$z\E(?:/|$)## or next;
 		}
 		foreach my $f (keys %$fetch) {
 			next if $f ne $p;
-- 
1.5.4.2

