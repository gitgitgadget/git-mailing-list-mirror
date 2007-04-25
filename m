From: Adam Roben <aroben@apple.com>
Subject: [PATCH] git-svn: Don't rely on $_ after making a function call
Date: Wed, 25 Apr 2007 11:50:32 -0700
Message-ID: <11775270321427-git-send-email-aroben@apple.com>
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 20:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgmZj-0000Rt-NW
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 20:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030856AbXDYSuo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 14:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031099AbXDYSuo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 14:50:44 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:56775 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030856AbXDYSun (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 14:50:43 -0400
Received: from relay7.apple.com (relay7.apple.com [17.128.113.37])
	by mail-out4.apple.com (8.13.8/8.13.8) with ESMTP id l3PIogG0012846;
	Wed, 25 Apr 2007 11:50:42 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id CA253304CA;
	Wed, 25 Apr 2007 11:50:42 -0700 (PDT)
X-AuditID: 11807125-a0c4ebb00000097b-47-462fa302545f 
Received: from localhost.localdomain (il0301a-dhcp38.apple.com [17.203.14.166])
	by relay7.apple.com (Apple SCV relay) with ESMTP id B5BF230063;
	Wed, 25 Apr 2007 11:50:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.rc0.14.g520d-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45541>

Many functions and operators in perl set $_, so its value cannot be relied upon
after calling arbitrary functions. The solution is simply to copy the value of
$_ into a local variable that will not get overwritten.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 git-svn.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 077d6b3..90f3bc1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -771,19 +771,19 @@ sub cmt_metadata {
 sub working_head_info {
 	my ($head, $refs) = @_;
 	my ($fh, $ctx) = command_output_pipe('rev-list', $head);
-	while (<$fh>) {
-		chomp;
-		my ($url, $rev, $uuid) = cmt_metadata($_);
+	while (my $hash = <$fh>) {
+		chomp($hash);
+		my ($url, $rev, $uuid) = cmt_metadata($hash);
 		if (defined $url && defined $rev) {
 			if (my $gs = Git::SVN->find_by_url($url)) {
 				my $c = $gs->rev_db_get($rev);
-				if ($c && $c eq $_) {
+				if ($c && $c eq $hash) {
 					close $fh; # break the pipe
 					return ($url, $rev, $uuid, $gs);
 				}
 			}
 		}
-		unshift @$refs, $_ if $refs;
+		unshift @$refs, $hash if $refs;
 	}
 	command_close_pipe($fh, $ctx);
 	(undef, undef, undef, undef);
-- 
1.5.2.rc0.14.g520d-dirty
