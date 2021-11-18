Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F7C433FE
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22C0C611CC
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbhKRHWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:22:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57266 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbhKRHWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 02:22:12 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7602B162120;
        Thu, 18 Nov 2021 02:19:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=WDR5W+XIpBgJKG18B3YbL5eTdOln/WZqqyTzVvpMrSc=; b=hsC0
        YtvAJMtPw8/mUPjB4YvdisIGWsDAKQWq3o1D+8BLNzBFpemn27kNEB1pR45/M45j
        i/sM3HjZwhQ2cZQRonKPl+vxijuChHnUtmDkiroc/g7zqymrb641zDFQ5SSLI3uN
        xC6rstDin9+anOYUcclqcy2oPlKwUyH7smFJXI0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6FCD416211F;
        Thu, 18 Nov 2021 02:19:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D20AC16211E;
        Thu, 18 Nov 2021 02:19:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
        <20211116033542.3247094-2-sandals@crustytoothpaste.net>
        <xmqq1r3f5izn.fsf@gitster.g>
        <YZWJy16Emrkr6qVL@camp.crustytoothpaste.net>
Date:   Wed, 17 Nov 2021 23:19:08 -0800
Message-ID: <xmqqv90qx76b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2D244AA-483F-11EC-A4C8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-11-17 at 07:39:08, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > Finally, add a self-test option here to make sure that our buffer
>> > handling is correct and we aren't truncating data.  We simply read 64
>> > KiB and then make sure we've seen each byte.  The probability of this
>> > test failing spuriously is less than 10^-100.
>> 
>> I saw that 10^-100 math in the other message, and have no problem
>> with that, but I am not sure how such a test makes "sure that our
>> buffer handling is correct and we aren't truncating data."  If you
>> thought you are generate 64kiB of random bytes but a bug caused you
>> to actually use 32kiB of random bytes with 32kiB of other garbage,
>> wouldn't you still have enough entropy left that you would be likely
>> to paint all 256 buckets?
>
> True, but our code processes smaller chunks at a time, which means that
> theoretically we'd notice before then.  For example, getentropy(2) won't
> process chunks larger than 256 bytes.

Sorry, you lost me.

> If we don't think there's value, I can just remove it.

It is not that I do not think there is value.  I am not sure where
this code is getting its value from.

We grab 1k at a time and repeat that 64 times.  

Presumably csprn_bytes() grabs bytes from underlying mechanism in
smaller chunk, but would not return until it fills the buffer---ah,
your "make sure our buffer handling is correct" is primarily about
the check that we get full 1k bytes in the loop?  We ask 1k chunk 64
times and we must get full 1k chunk every time?

What I was wondering about was the other half of the check, ensuring
all buckets[] are painted that gave us the cute 10^-100 math.

+	int buckets[256] = { 0 };
+	unsigned char buf[1024];
+	unsigned long count = 64 * 1024;
+	int i;
+
+	while (count) {
+		if (csprng_bytes(buf, sizeof(buf)) < 0) {
+			perror("failed to read");
+			return 3;
+		}
+		for (i = 0; i < sizeof(buf); i++)
+			buckets[buf[i]]++;
+		count -= sizeof(buf);
+	}
