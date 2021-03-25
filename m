Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E42C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE8761A3C
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCYSqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:46:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51085 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhCYSqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 14:46:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA50A3FC5;
        Thu, 25 Mar 2021 14:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KsVIttEPzDPTeEL0HSd05v0xZIw=; b=Qkv1sU
        lMOWoXlTdmCX5bGv3KIcmKoSc4M5ykVUzwzNIBJHKf/pf8+b8jBVRROXcwsJ+q7P
        N9ZIMN+8WoHjQC3Rtw1kXi3zziS1xbuffRwdZayeIEXQ1BIBefASyMqdUr9+EVn5
        KHrDf0PtDsgOSViP5Y8a6GP7Vc9jRNILFBGjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KUBrIbRA5WwoK77ALoJsrOlJZyOmuFhh
        fO5xd1kKG+MH+ef9MN8stXtVSWERp822V7ZwcdXAGGbzvyQoQD8dNfZIAOKO453T
        YDE2I51osKcJaoXpAzNtfx3dcGPMxPJ1LV8pV4EjcoCJt/IO6hI+g25l4gXpOc+h
        PtcbIRzKrwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3440A3FC3;
        Thu, 25 Mar 2021 14:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 563D8A3FBF;
        Thu, 25 Mar 2021 14:46:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] csum-file: flush less often
References: <pull.914.git.1616608219602.gitgitgadget@gmail.com>
        <84ccabca-0bd3-d0cb-6b38-f96d75c0bbd6@gmail.com>
Date:   Thu, 25 Mar 2021 11:46:20 -0700
In-Reply-To: <84ccabca-0bd3-d0cb-6b38-f96d75c0bbd6@gmail.com> (Derrick
        Stolee's message of "Thu, 25 Mar 2021 07:55:55 -0400")
Message-ID: <xmqq8s6bvzpf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6463FE10-8D9A-11EB-A8DB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> But...is there something we could still do here?
>
> My confusion about flushing is mostly due to my error, but upon
> reflection the loop is doing a lot of different things, but most of
> the time we know which behavior we need at the start, in the middle,
> and at the end:
>
>      1. Fill the existing buffer with the beginning of 'buf'. If the
>         hashfile's buffer is full, then flush.

"But do not do this if f->buffer is empty, and we are writing out
more than sizeof(f->buffer)." is missing, isn't it?

>      2. Flush sizeof(f->buffer) chunks directly out of 'buf' as long as
>         possible.
>     
>      3. Copy the remaining bytes out of 'buf' into the hashfile's buffer.

It is debatable if the existing loop, which came mostly from Nico's
a8032d12 (sha1write: don't copy full sized buffers, 2008-09-02), is
too clever; I personally find it concise and readable enough, but my
reading is tainted.

If you use a couple of helpers to reduce the repeated "crc and hash"
pattern in your variant, it may become easier to follow than the
original, but I dunno.

> Here is a rewrite that more explicitly follows this flow:
>
> void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
> {
> 	const int full_buffer = sizeof(f->buffer);
> 	unsigned left = full_buffer - f->offset;
> 	unsigned nr = count > left ? left : count;
>
> 	/*
> 	 * Initially fill the buffer in a batch until it
> 	 * is full, then flush.
> 	 */
> 	if (f->do_crc)
> 		f->crc32 = crc32(f->crc32, buf, nr);
>
> 	memcpy(f->buffer + f->offset, buf, nr);

Here, if the f->buffer was empty, we end up memcpy a full bufferful
unconditionally.  Nico's original cleverly takes advantage of the
fact that 'nr' would be the full buffer size only when the f->buffer
was empty upon entry to the function and we have more byte than the
size of the buffer to copy out directly from 'buf'.

> 	f->offset += nr;
> 	count -= nr;
> 	buf = (char *) buf + nr;
>
> 	if (left == nr)
> 		hashflush(f);
>
> 	/*
> 	 * After filling the hashfile's buffer and flushing, take
> 	 * batches of full_buffer bytes directly from the input
> 	 * buffer.
> 	 */
> 	while (count >= full_buffer) {
> 		if (f->do_crc)
> 			f->crc32 = crc32(f->crc32, buf, full_buffer);
>
> 		the_hash_algo->update_fn(&f->ctx, buf, full_buffer);
> 		flush(f, buf, full_buffer);
>
> 		count -= full_buffer;
> 		buf = (char *) buf + full_buffer;
> 	}
>
> 	/*
> 	 * Capture any remaining bytes at the end of the input buffer
> 	 * into the hashfile's buffer. We do not need to flush because
> 	 * count is strictly less than full_buffer here.
> 	 */
> 	if (count) {
> 		if (f->do_crc)
> 			f->crc32 = crc32(f->crc32, buf, count);
>
> 		memcpy(f->buffer + f->offset, buf, count);
> 		f->offset = count;
> 	}
> 	
> 	if (f->base)
> 		hashwrite(f->base, buf, count);
> }
> ...
> So, I'm of two minds here:
>
>  1. This is embarassing. I wasted everyone's time for nothing. I can retract
>     this patch.
>
>  2. This is embarassing. I overstated the problem here. But we might be able
>     to eke out a tiny performance boost here.
>
> I'm open to either. I think we should default to dropping this patch unless
> someone thinks the rewrite above is a better organization of the logic. (I
> can then send a v2 including that version and an updated commit message.)

3. The current code around "if (nr == sizeof(f->buffer))" might be a
   bit too clever for readers who try to understand what is going
   on, and the whole "while" loop may deserve a comment based on
   what you wrote before your replacement implementation.
