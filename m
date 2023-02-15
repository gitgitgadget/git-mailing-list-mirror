Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CBDC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 19:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBOTmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 14:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBOTmG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 14:42:06 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73483B65F
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 11:42:03 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31FJfUbY2299910
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 19:41:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Jeff King'" <peff@peff.net>, "'Git List'" <git@vger.kernel.org>
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>     <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>      <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com> <xmqqwn4iycbt.fsf@gitster.g>
In-Reply-To: <xmqqwn4iycbt.fsf@gitster.g>
Subject: RE: [Bug] Test 1450.91 Fails on NonStop
Date:   Wed, 15 Feb 2023 14:41:43 -0500
Organization: Nexbridge Inc.
Message-ID: <001301d94175$8baf97a0$a30ec6e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFlBHy1D1yynoWJMXR7ix1CE7kV4gGiJvNtAetN2VwCaLwQ16+JL4dg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, February 15, 2023 2:10 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> So, this looks like we do not have to hold the 2.39.2 release for this
problem. I will
>run the packaging job for the platform release.
>>
>> + test-tool genzeros 104857601
>> fatal: write(): Invalid function argument
>>
>> That explains it. We had to push the use of xwrite() because of issues
>> associated with writing large buffers exceeding through write(). We
>> could use MAX_IO_SIZE to limit the write size (at least on NonStop)
>> into acceptable chunks.
>
>True.
>
>Curious that this use of write(2) is from late 2021 and its uses in tests
came from the
>same era (e.g. t1051 has two calls added in the same timeperiod).  So it is
nothing
>new even to your platform, I suspect.

I have been looking at the past log (pre-2.39) and this test has not failed
previously - although git blame on t1450 shows 6-Feb-2023, so that might be
why I've not seen this previously. It is possible test-genzeros was not used
in this way previously.

>There are a handful of raw write() in reftable implementation whose size I
am not
>sure about (and I am not touching), and a deliberate use of it in
trace2/tr2_dst.c that
>is well explained (and I do not think touching is a good idea).  Everything
else looks
>like they are aware that they are making a short write, but some of them
might still
>want to become xwrite() to benefit from auto retrying a short write (which
I didn't
>check).

I would not want to touch those either, although I do keep an eye out for
new write() usage and whine about it if I notice. ;-)

>In any case, I think the attached is a sensible first step to have.
>
> t/helper/test-genzeros.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git c/t/helper/test-genzeros.c w/t/helper/test-genzeros.c index
>8ca988d621..9a1d3ee221 100644
>--- c/t/helper/test-genzeros.c
>+++ w/t/helper/test-genzeros.c
>@@ -17,12 +17,12 @@ int cmd__genzeros(int argc, const char **argv)
>
> 	/* Writing out individual NUL bytes is slow... */
> 	while (count < 0)
>-		if (write(1, zeros, ARRAY_SIZE(zeros)) < 0)
>+		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
> 			return -1;
>
> 	while (count > 0) {
>-		n = write(1, zeros, count < ARRAY_SIZE(zeros) ?
>-			  count : ARRAY_SIZE(zeros));
>+		n = xwrite(1, zeros, count < ARRAY_SIZE(zeros) ?
>+			   count : ARRAY_SIZE(zeros));
>
> 		if (n < 0)
> 			return -1;

This works well as a fix. Please go with it with my blessing.
--Randall

