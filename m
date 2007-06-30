From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] git-svn: cache max revision in rev_db databases
Date: Sat, 30 Jun 2007 20:56:14 +1200
Message-ID: <11831937823184-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
 <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlL-0006AV-PJ
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbXF3I4h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXF3I4g
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:36 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56648 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbXF3I4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:25 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008Ty-B0; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 4A53462CE9; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <11831937822346-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51202>

From: Sam Vilain <sam@vilain.net>

Cache the maximum revision for each rev_db URL rather than looking it
up each time.  This saves a lot of time when rebuilding indexes on a
freshly cloned repository.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 556cd7d..a8b6669 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -801,6 +801,7 @@ sub working_head_info {
 	my ($head, $refs) = @_;
 	my ($fh, $ctx) = command_output_pipe('log', $head);
 	my $hash;
+	my %max;
 	while (<$fh>) {
 		if ( m{^commit ($::sha1)$} ) {
 			unshift @$refs, $hash if $hash and $refs;
@@ -810,11 +811,14 @@ sub working_head_info {
 		next unless s{^\s*(git-svn-id:)}{$1};
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
1.5.2.1.1131.g3b90
