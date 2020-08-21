Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BBBC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1C820791
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xX24Xu1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgHUTAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:00:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62384 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHUTAF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:00:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7663585F5F;
        Fri, 21 Aug 2020 15:00:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HzuibW8hihumpL83oIybvt3KUdE=; b=xX24Xu
        1Bn9N9gXCoy8dssOmuq9pfEjoNca95RGqIWlrtbjAARO/uLBMzwGip4oog4qt4rm
        DS1QQJSHsxvPnjZH6PIWnxzVY+ecZ5Wyg9w1ABOG7VBhSFfx4Wc2Av5CiaPI6gn2
        lrE7Py2lXxhZYH5gezbiNWoHE2VKaEo69Lwwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GiEdMrFDxe/oygPxP7fqERk/g6+O6Iav
        9EKHA5nmf3phBwzCpm1yqt3Xx78hxYCq2/ObPJglTxZ1J/mVIMYnv9rPbPqPep+I
        vUoFn49I8MXhzsmsycJ1UEraxK3LL58fo/YJ1Y+TQQOtkFlRcxMse3DC8hPfjfoR
        ij849oP71HI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B71085F5C;
        Fri, 21 Aug 2020 15:00:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 492DE85F56;
        Fri, 21 Aug 2020 15:00:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] index-pack threading defaults
References: <20200821175153.GA3263018@coredump.intra.peff.net>
        <20200821184459.GB3263614@coredump.intra.peff.net>
Date:   Fri, 21 Aug 2020 11:59:58 -0700
In-Reply-To: <20200821184459.GB3263614@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 21 Aug 2020 14:44:59 -0400")
Message-ID: <xmqqmu2n964x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83F79EC6-E3E0-11EA-A192-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 21, 2020 at 01:51:53PM -0400, Jeff King wrote:
>
>> That value was determined experimentally in 2012. I'm not sure of the
>> exact reason it's different now (modern processors are better at
>> parallelism, or modern git is better at parallelism, or the original
>> experiment was just a fluke). But regardless, I can get on the order of
>> a two-to-one speedup by bumping the thread count. See the final patch
>> for timings and more specific discussion.
>
> After writing a response elsewhere in the thread, it occurred to me that
> a good candidate for explaining this may be that our modern sha1dc
> implementation is way slower than what we were using in 2012 (which
> would have been either block-sha1, or the even-faster openssl
> implementation). And since a good chunk of index-pack's time is going to
> computing sha1 hashes on the resulting objects, that means that since
> 2012, we're spending relatively more time in the hash computation (which
> parallelizes per-object) and less time in the other parts that happen
> under a lock.

Believable conjecture that is.  You could benchmark again with
block-sha1 on today's hardware, but because the performance profile
with sha1dc is what matters in the real world anyway...

Thanks.
