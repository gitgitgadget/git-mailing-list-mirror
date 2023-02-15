Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D6C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 18:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBOSCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 13:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOSCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 13:02:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34583CE10
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 10:02:11 -0800 (PST)
Received: (qmail 13140 invoked by uid 109); 15 Feb 2023 18:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Feb 2023 18:02:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16165 invoked by uid 111); 15 Feb 2023 18:02:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Feb 2023 13:02:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Feb 2023 13:02:10 -0500
From:   Jeff King <peff@peff.net>
To:     rsbecker@nexbridge.com
Cc:     'Git List' <git@vger.kernel.org>
Subject: Re: [Bug] Test 1450.91 Fails on NonStop
Message-ID: <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 12:44:59PM -0500, rsbecker@nexbridge.com wrote:

> + + git hash-object -w --stdin
> + test-tool genzeros 104857601
> blob=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

That's not right. e69de29bb is the empty blob. A hundred megabytes (plus
one) of zeroes should be d748d1b68b9dc69c4717ebc070dbc547d129bcc6.

So that is the root of your problem (the empty file will obviously not
trigger the "too large" fsck check), but I don't know why it would be
failing.

Maybe check the output of "test-tool genzeros 104857601" to make sure
that it as expected? If not, then the bug is somewhere in
t/helper/test-genzeros.c.

It's on the left-hand side of pipe. Maybe it is getting a write() error,
but we are ignoring it? Maybe a patch like this would help diagnose:

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 8ca988d621..0574917005 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -18,14 +18,14 @@ int cmd__genzeros(int argc, const char **argv)
 	/* Writing out individual NUL bytes is slow... */
 	while (count < 0)
 		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
-			return -1;
+			die_errno("write()");
 
 	while (count > 0) {
 		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
 			  count : ARRAY_SIZE(zeros));
 
 		if (n < 0)
-			return -1;
+			die_errno("write()");
 
 		count -= n;
 	}

-Peff
