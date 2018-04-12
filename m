Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3A521F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDLVYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:24:46 -0400
Received: from sif.is.scarlet.be ([193.74.71.28]:24107 "EHLO sif.is.scarlet.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752270AbeDLVYq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:24:46 -0400
X-Greylist: delayed 961 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2018 17:24:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scarlet.be;
        s=scarlet; t=1523567307;
        bh=t/k/chKXKmQQUMAUZ4r5+4GHkXm4BKDaG+CyZiwS7MM=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=rwQ6Y9miZ6TF5V4gK0a4UEXo7bwwDFAgirybu8yOO0igtiw+zHY1ZF3WjwyS1mhrI
         0KKV9XV00GZ8INaBorwxlczE7VJPPxZG3EVDx/LUy6UF2ZIp0TA3uqEGbUVV2Eo5ti
         /FRKmQWzlV3XbSj6urnfU9DrPG1EtweVmW5v+vDk=
Received: from localhost.localdomain (ip-83-134-143-61.dsl.scarlet.be [83.134.143.61])
        by sif.is.scarlet.be (8.14.9/8.14.9) with ESMTP id w3CL8Qbd002436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Apr 2018 23:08:27 +0200
X-Scarlet: d=1523567307 c=83.134.143.61
From:   Kim Gybels <kgybels@infogroep.be>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Kim Gybels <kgybels@infogroep.be>
Subject: [PATCH 0/2] Fix early EOF with GfW daemon
Date:   Thu, 12 Apr 2018 23:07:55 +0200
Message-Id: <20180412210757.7792-1-kgybels@infogroep.be>
X-Mailer: git-send-email 2.17.0.windows.1
X-DCC-scarlet.be-Metrics: sif 20001; Body=5 Fuz1=5 Fuz2=6
X-Virus-Scanned: clamav-milter 0.98.1-exp at sif
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been reported [1] that cloning from a Git-for-Windows daemon would
sometimes fail with an early EOF error:

  $ git clone git://server/test
  Cloning into 'test'...
  remote: Counting objects: 36, done.
  remote: Compressing objects: 100% (24/24), done.
  fatal: read error: Invalid argument
  fatal: early EOF
  fatal: index-pack failed

These patches solve the issue by only changing git-daemon, its child processes
can remain unaware that stdin/stdout are actually network connections.

[1] https://github.com/git-for-windows/git/issues/304

Kim Gybels (2):
  daemon: use timeout for uninterruptible poll
  daemon: graceful shutdown of client connection

 daemon.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

-- 
2.17.0.windows.1

