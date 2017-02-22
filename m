Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC69201A9
	for <e@80x24.org>; Wed, 22 Feb 2017 02:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbdBVCpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 21:45:20 -0500
Received: from ns2.cosmo.co.jp ([122.212.38.242]:60551 "EHLO nmx3.cosmo.co.jp"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752850AbdBVCpS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 21:45:18 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Feb 2017 21:45:18 EST
Received: from vm_mars.gtd.cosmo.co.jp (mars.gtd.cosmo.co.jp [192.168.201.58])
        by nmx3.cosmo.co.jp (Postfix/COSMO-R1.3) with ESMTP id 3FB1113F7E5;
        Wed, 22 Feb 2017 11:38:04 +0900 (JST)
Received: from localhost.localdomain (unknown [192.168.206.51])
        by vm_mars.gtd.cosmo.co.jp (Postfix/COSMO-R1.2) with ESMTP id 3564E6193B;
        Wed, 22 Feb 2017 11:38:04 +0900 (JST)
From:   Hiroshi Shirosaki <h.shirosaki@gmail.com>
To:     git@vger.kernel.org
Cc:     Hiroshi Shirosaki <h.shirosaki@gmail.com>
Subject: [PATCH] git svn branch fails with authenticaton failures
Date:   Wed, 22 Feb 2017 11:37:35 +0900
Message-Id: <1487731055-29153-1-git-send-email-h.shirosaki@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have the following authentication failure while svn rebase and
svn dcommit works fine without authentication failures.

$ git svn branch v7_3
Copying https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx at r27519
to https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/v7_3...
Can't create session: Unable to connect to a repository at URL
'https://xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx': No more
credentials or we tried too many times.
Authentication failed at
C:\Program Files\Git\mingw64/libexec/git-core\git-svn line 1200.

I can workaround the issue to add auth configuration to
SVN::Client->new().
---
 git-svn.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index fa42364..13fa4ad 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1175,10 +1175,10 @@ sub cmd_branch {
 	::_req_svn();
 	require SVN::Client;
 
+	my ($config, $baton, $callbacks) = Git::SVN::Ra::prepare_config_once();
 	my $ctx = SVN::Client->new(
-		config => SVN::Core::config_get_config(
-			$Git::SVN::Ra::config_dir
-		),
+		auth => $baton,
+		config => $config,
 		log_msg => sub {
 			${ $_[0] } = defined $_message
 				? $_message
-- 
2.7.4

