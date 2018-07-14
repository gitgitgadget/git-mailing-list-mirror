Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DAB1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 09:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeGNJZX (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 05:25:23 -0400
Received: from smtpout02-ext1.partage.renater.fr ([194.254.241.32]:52180 "EHLO
        smtpout20.partage.renater.fr" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbeGNJZX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 05:25:23 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jul 2018 05:25:22 EDT
Received: from zmtaout02.partage.renater.fr (zmtaout02.partage.renater.fr [194.254.241.30])
        by smtpout20.partage.renater.fr (Postfix) with ESMTP id 16BE9BFAED
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 10:59:05 +0200 (CEST)
Received: from zmtaout02.partage.renater.fr (localhost [127.0.0.1])
        by zmtaout02.partage.renater.fr (Postfix) with ESMTPS id E84032003E;
        Sat, 14 Jul 2018 10:59:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zmtaout02.partage.renater.fr (Postfix) with ESMTP id D824E200B7;
        Sat, 14 Jul 2018 10:59:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zmtaout02.partage.renater.fr
Received: from zmtaout02.partage.renater.fr ([127.0.0.1])
        by localhost (zmtaout02.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ByH96Zg1wo5q; Sat, 14 Jul 2018 10:59:05 +0200 (CEST)
Received: from [82.13.66.114]localhost.localdomain (lb01.partage.renater.fr [194.254.242.1])
        by zmtaout02.partage.renater.fr (Postfix) with ESMTPA id AEDC42003E;
        Sat, 14 Jul 2018 10:59:05 +0200 (CEST)
From:   Jules Maselbas <jules.maselbas@grenoble-inp.org>
To:     git@vger.kernel.org
Cc:     Jules Maselbas <jules.maselbas@grenoble-inp.org>
Subject: [PATCH v2] send-email: Fix tls AUTH when sending batch
Date:   Sat, 14 Jul 2018 10:58:48 +0200
Message-Id: <20180714085848.4031-1-jules.maselbas@grenoble-inp.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180714021440.22995-1-jules.maselbas@grenoble-inp.org>
References: <20180714021440.22995-1-jules.maselbas@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable smtp_encryption must keep it's value between two batches.
Otherwise the authentication is skipped after the first batch.

Signed-off-by: Jules Maselbas <jules.maselbas@grenoble-inp.org>
---
 git-send-email.perl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8ec70e58e..1f9a73f74 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1479,7 +1479,7 @@ sub send_message {
 							 SSL => 1);
 			}
 		}
-		else {
+		elsif (!$smtp) {
 			$smtp_server_port ||= 25;
 			$smtp ||= Net::SMTP->new($smtp_server,
 						 Hello => $smtp_domain,
@@ -1501,7 +1501,6 @@ sub send_message {
 					$smtp->starttls(ssl_verify_params())
 						or die sprintf(__("STARTTLS failed! %s"), IO::Socket::SSL::errstr());
 				}
-				$smtp_encryption = '';
 				# Send again to receive fresh
 				# supported commands
 				$smtp->hello($smtp_domain);
-- 
2.18.0

