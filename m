From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config options
Date: Wed,  1 Dec 2010 13:53:21 +0100
Message-ID: <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
References: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 13:56:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmEG-0003d0-BR
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007Ab0LAMzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:55:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39330 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755196Ab0LAMzm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 07:55:42 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4757C573;
	Wed,  1 Dec 2010 07:55:42 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 01 Dec 2010 07:55:42 -0500
X-Sasl-enc: G3XTEYdw5t/UlF+G9K8ZQVha+KS/9lFB4sTh8OhzNdiV 1291208141
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CE8C5400DE0;
	Wed,  1 Dec 2010 07:55:41 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.617.g84f63
In-Reply-To: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1291207768.git.git@drmicha.warpmail.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162508>

The current code leads to

fatal: bad config value for 'cvsimport.r' in .git/config

for a standard use case with cvsimport.r set:

cvsimport sets internal variables by checking the config for each
possible command line option. The problem is that config items are case
insensitive, so config.r and config.R are the same. The ugly error is
due to that fact that cvsimport expects a bool for -R (and thus
config.R) but a remote name for -r (and thus config.r).

Fix this by making cvsimport expect the config item "cvsimport.capital-r"
for the command line option "-R" etc.

(config options for cvsimport have been undocumented so far, though
present in the code and advertised in several tutorials. So one may read
"enhance" for "fix".)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-cvsimport.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 7888b77..0bb5e32 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -97,10 +97,12 @@ sub read_repo_config {
 	foreach my $o (@opts) {
 		my $key = $o;
 		$key =~ s/://g;
+		my $ckey = $key;
+		$ckey = 'capital-' . $ckey if ($key eq uc($key));
 		my $arg = 'git config';
 		$arg .= ' --bool' if ($o !~ /:$/);
 
-		chomp(my $tmp = `$arg --get cvsimport.$key`);
+		chomp(my $tmp = `$arg --get cvsimport.$ckey`);
 		if ($tmp && !($arg =~ /--bool/ && $tmp eq 'false')) {
 			no strict 'refs';
 			my $opt_name = "opt_" . $key;
-- 
1.7.3.2.617.g84f63
