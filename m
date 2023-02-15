Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812BDC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 18:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBOSuC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 15 Feb 2023 13:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOSuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 13:50:01 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA5AB
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 10:49:58 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31FInbwr2287448
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 18:49:38 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>
Cc:     "'Git List'" <git@vger.kernel.org>
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com> <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
In-Reply-To: <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
Subject: RE: [Bug] Test 1450.91 Fails on NonStop
Date:   Wed, 15 Feb 2023 13:49:50 -0500
Organization: Nexbridge Inc.
Message-ID: <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlBHy1D1yynoWJMXR7ix1CE7kV4gGiJvNtr6u7RbA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, February 15, 2023 1:02 PM, Jeff King wrote:
>On Wed, Feb 15, 2023 at 12:44:59PM -0500, rsbecker@nexbridge.com wrote:
>
>> + + git hash-object -w --stdin
>> + test-tool genzeros 104857601
>> blob=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>
>That's not right. e69de29bb is the empty blob. A hundred megabytes (plus
>one) of zeroes should be d748d1b68b9dc69c4717ebc070dbc547d129bcc6.
>
>So that is the root of your problem (the empty file will obviously not trigger the "too
>large" fsck check), but I don't know why it would be failing.
>
>Maybe check the output of "test-tool genzeros 104857601" to make sure that it as
>expected? If not, then the bug is somewhere in t/helper/test-genzeros.c.
>
>It's on the left-hand side of pipe. Maybe it is getting a write() error, but we are
>ignoring it? Maybe a patch like this would help diagnose:
>
>diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c index
>8ca988d621..0574917005 100644
>--- a/t/helper/test-genzeros.c
>+++ b/t/helper/test-genzeros.c
>@@ -18,14 +18,14 @@ int cmd__genzeros(int argc, const char **argv)
> 	/* Writing out individual NUL bytes is slow... */
> 	while (count < 0)
> 		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
>-			return -1;
>+			die_errno("write()");
>
> 	while (count > 0) {
> 		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
> 			  count : ARRAY_SIZE(zeros));
>
> 		if (n < 0)
>-			return -1;
>+			die_errno("write()");
>
> 		count -= n;
> 	}
>

So, this looks like we do not have to hold the 2.39.2 release for this problem. I will run the packaging job for the platform release.

+ test-tool genzeros 104857601
fatal: write(): Invalid function argument

That explains it. We had to push the use of xwrite() because of issues associated with writing large buffers exceeding through write(). We could use MAX_IO_SIZE to limit the write size (at least on NonStop) into acceptable chunks.



