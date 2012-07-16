From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 4/8] git-remote-mediawiki: get rid of O(N^2) loop
Date: Mon, 16 Jul 2012 21:46:38 +0200
Message-ID: <1342468002-31818-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
 <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 21:48:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrHV-0000yu-Fo
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab2GPTsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:48:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43806 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471Ab2GPTsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:48:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJjhCw012477
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:45:43 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGJ-0001Sc-6t; Mon, 16 Jul 2012 21:47:19 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SqrGJ-0008IT-5V; Mon, 16 Jul 2012 21:47:19 +0200
X-Mailer: git-send-email 1.7.11.2.258.g5ff3cdf.dirty
In-Reply-To: <1342468002-31818-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jul 2012 21:45:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJjhCw012477
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343072743.89223@8sO2QO8BxUjAyjNu9ia6hw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201560>

The algorithm to find a path from the local revision to the remote one
was calling "git rev-list" and parsing its output N times. Run rev-list
only once, and fill a hashtable with the result to optimize the body of
the loop.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 8e46e4e..fb1e9e0 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -1196,16 +1196,26 @@ sub mw_push_revision {
 	if ($last_local_revid > 0) {
 		my $parsed_sha1 = $remoteorigin_sha1;
 		# Find a path from last MediaWiki commit to pushed commit
+		print STDERR "Computing path from local to remote ...\n";
+		my @local_ancestry = split(/\n/, run_git("rev-list --boundary --parents $local ^$parsed_sha1"));
+		my %local_ancestry;
+		foreach my $line (@local_ancestry) {
+			if (my ($child, $parents) = $line =~ m/^-?([a-f0-9]+) ([a-f0-9 ]+)/) {
+				foreach my $parent (split(' ', $parents)) {
+					$local_ancestry{$parent} = $child;
+				}
+			} elsif (!$line =~ m/^([a-f0-9]+)/) {
+				die "Unexpected output from git rev-list: $line";
+			}
+		}
 		while ($parsed_sha1 ne $HEAD_sha1) {
-			my @commit_info =  grep(/^$parsed_sha1/, split(/\n/, run_git("rev-list --children $local")));
-			if (!@commit_info) {
+			my $child = $local_ancestry{$parsed_sha1};
+			if (!$child) {
+				printf STDERR "Cannot find a path in history from remote commit to last commit\n";
 				return error_non_fast_forward($remote);
 			}
-			my @commit_info_split = split(/ |\n/, $commit_info[0]);
-			# $commit_info_split[1] is the sha1 of the commit to export
-			# $commit_info_split[0] is the sha1 of its direct child
-			push(@commit_pairs, \@commit_info_split);
-			$parsed_sha1 = $commit_info_split[1];
+			push(@commit_pairs, [$parsed_sha1, $child]);
+			$parsed_sha1 = $child;
 		}
 	} else {
 		# No remote mediawiki revision. Export the whole
-- 
1.7.11.2.258.g5ff3cdf.dirty
