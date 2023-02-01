Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F387C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBALjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBALjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:39:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221283608D
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:39:08 -0800 (PST)
Received: (qmail 31514 invoked by uid 109); 1 Feb 2023 11:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19401 invoked by uid 111); 1 Feb 2023 11:39:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:39:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:39:06 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 3/4] t/lib-httpd: drop SSLMutex config
Message-ID: <Y9pPWroQIBh9NR35@coredump.intra.peff.net>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The SSL config enabled by setting LIB_HTTPD_SSL does not work with
Apache versions greater than 2.2, as more recent versions complain about
the SSLMutex directive. According to
https://httpd.apache.org/docs/current/upgrading.html:

  Directives AcceptMutex, LockFile, RewriteLock, SSLMutex,
  SSLStaplingMutex, and WatchdogMutexPath have been replaced with a
  single Mutex directive. You will need to evaluate any use of these
  removed directives in your 2.2 configuration to determine if they can
  just be deleted or will need to be replaced using Mutex.

Deleting this line will just use the system default, which seems
sensible. The original came as part of faa4bc35a0 (http-push: add
regression tests, 2008-02-27), but no specific reason is given there (or
on the mailing list) for its presence.

Signed-off-by: Jeff King <peff@peff.net>
---
If we can't drop support for 2.2 in patch 2, then this would need to be
adjusted with an IfVersion.

 t/lib-httpd/apache.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 332617f10d..51a4fbcf62 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -203,7 +203,6 @@ SSLCertificateKeyFile httpd.pem
 SSLRandomSeed startup file:/dev/urandom 512
 SSLRandomSeed connect file:/dev/urandom 512
 SSLSessionCache none
-SSLMutex file:ssl_mutex
 SSLEngine On
 </IfDefine>
 
-- 
2.39.1.767.gb4615b3bd3

