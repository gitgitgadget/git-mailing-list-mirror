From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] git-svn: cache max revision in rev_db databases
Date: Sun, 10 Jun 2007 21:04:54 +1200
Message-ID: <20070610091304.C3E0413A4F8@magnus.utsl.gen.nz>
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJU1-0000WW-Qo
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbXFJJNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbXFJJNI
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:13:08 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33621 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbXFJJNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:13:06 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003)
	id C3E0413A4F8; Sun, 10 Jun 2007 21:13:04 +1200 (NZST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49695>

Cache the maximum revision for each rev_db URL rather than looking it
up each time.  This saves a lot of time when rebuilding indexes on a
freshly cloned repository.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 610563c..c9758a0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -804,6 +804,7 @@ sub working_head_info {
 	my ($head, $refs) = @_;
 	my ($fh, $ctx) = command_output_pipe('log', $head);
 	my $hash;
+	my %max;
 	while (<$fh>) {
 		if ( m{^commit ($::sha1)$} ) {
 			$hash = $1;
@@ -812,11 +813,14 @@ sub working_head_info {
 		next unless s{^\s+(git-svn-id:)}{$1};
 		my ($url, $rev, $uuid) = extract_metadata($_);
 		if (defined $url && defined $rev) {
+			next if $max{$url} and $max{$url} < $rev;
 			if (my $gs = Git::SVN->find_by_url($url)) {
 				my $c = $gs->rev_db_get($rev);
 				if ($c && $c eq $hash) {
 					close $fh; # break the pipe
 					return ($url, $rev, $uuid, $gs);
+				} else {
+					$max{$url} ||= $gs->rev_db_max;
 				}
 			}
 		}
-- 
1.5.0.4.210.gf8a7c-dirty
