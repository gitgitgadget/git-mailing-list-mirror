From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/3] cvsimport: fix the parsing of uppercase config options
Date: Sun, 28 Nov 2010 20:39:46 +0100
Message-ID: <d501b7423a370f9b7f95c8f23c4b6adfc2963643.1290973138.git.git@drmicha.warpmail.net>
References: <4CF2ADC9.8020504@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMn5p-0001kx-Ee
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab0K1TjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:39:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57158 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753193Ab0K1TjS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 14:39:18 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9986C731;
	Sun, 28 Nov 2010 14:39:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 28 Nov 2010 14:39:18 -0500
X-Sasl-enc: rcSEy3ut0qkwQStJITrE48dU7LdXGSM51ACW4OkGatRr 1290973157
Received: from localhost (p5485894A.dip0.t-ipconnect.de [84.133.137.74])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E85E7406EFE;
	Sun, 28 Nov 2010 14:39:17 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.614.g03864.dirty
In-Reply-To: <4CF2ADC9.8020504@drmicha.warpmail.net>
In-Reply-To: <468f815beeede312f98daa66986ce8bf887724b3.1290973138.git.git@drmicha.warpmail.net>
References: <468f815beeede312f98daa66986ce8bf887724b3.1290973138.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162352>

The current code leads to

fatal: bad config value for 'cvsimport.r' in .git/config

for a standard use case with cvsimport.r set:

cvsimport sets internal variables by checking the config for each
possible command line option. The problem is that config items are case
insensitive, so config.r and config.R are the same. The ugly error is
due to that fact that cvsimport expects a bool for -R (and thus
config.R) but a remote name for -r (and thus config.r).

Fix this by making cvsimport expect the config item "cvsimport.RR"
for the command line option "-R" etc.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-cvsimport.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7888b77..736a7bf 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -97,10 +97,12 @@ sub read_repo_config {
 	foreach my $o (@opts) {
 		my $key = $o;
 		$key =~ s/://g;
+		my $ckey = $key;
+		$ckey .= $ckey if ($key eq uc($key));
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
 
-		chomp(my $tmp = `$arg --get cvsimport.$key`);
+		chomp(my $tmp = `$arg --get cvsimport.$ckey`);
 		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
 			no strict 'refs';
 			my $opt_name = "opt_" . $key;
-- 
1.7.3.2.614.g03864.dirty
