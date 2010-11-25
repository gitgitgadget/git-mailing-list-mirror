From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] cvsimport: fix the parsing of uppercase config options
Date: Thu, 25 Nov 2010 16:10:55 +0100
Message-ID: <ad36bc3f6a00c5f7bc643be3f97aa2bcfda990ff.1290697830.git.git@drmicha.warpmail.net>
References: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 16:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdVY-0007id-5H
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab0KYPNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 10:13:06 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34768 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751941Ab0KYPNE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 10:13:04 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 31C4696D;
	Thu, 25 Nov 2010 10:13:04 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 25 Nov 2010 10:13:04 -0500
X-Sasl-enc: 4dZsy5DEmQsYy8PpYveV/LQ6/blgwKPJcEP6wISwCKN8 1290697983
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A2B654034E5;
	Thu, 25 Nov 2010 10:13:03 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.614.g03864.dirty
In-Reply-To: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162138>

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
 git-cvsimport.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index f955295..736a7bf 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -97,6 +97,8 @@ sub read_repo_config {
 	foreach my $o (@opts) {
 		my $key = $o;
 		$key =~ s/://g;
+		my $ckey = $key;
+		$ckey .= $ckey if ($key eq uc($key));
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
 
-- 
1.7.3.2.614.g03864.dirty
