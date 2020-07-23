Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514ADC433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2260320714
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eeBxtJVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWSGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:06:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63211 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGWSGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 14:06:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1540CDBC1E;
        Thu, 23 Jul 2020 14:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oM+tPNwewkhVA1Wj/c9JGXicmLA=; b=eeBxtJ
        VvUnfnTj2km909ENpNM9lUuNB+PeiaUYQx8R9eGKIZPbVFCsultTTO6amoTfq2yR
        ved4uqBWoVCdv+TnMI5wiC6qrXiI9o20gGctpmAl3OfB7KSWmV6p+YPHC0o2E2WT
        wVYA9829VLHznCTY3xzR+EZC3xgy268OnJrgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UjlKb05Noa8u5g3VeUz6ISAEwc4FvJuB
        MXZSvcJ1yrFvnha2amUHrhs1qQ6iCu0Gnbu5eOM5EwB/NkibrxZ5YcNLV5tw7XsE
        s84KXT9JUNdaU8IszbbIFHi5LZqRbtxKR7Yw6TKnUxIuwRCj/4Hd9NTQF3VViyhf
        KVw/JIiD6P4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DB94DBC1D;
        Thu, 23 Jul 2020 14:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33B35DBC1B;
        Thu, 23 Jul 2020 14:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1-file: make pretend_object_file() not prefetch
References: <20200721225020.1352772-1-jonathantanmy@google.com>
        <xmqq4kq078ks.fsf@gitster.c.googlers.com>
        <20200723174747.GA3975154@coredump.intra.peff.net>
Date:   Thu, 23 Jul 2020 11:06:14 -0700
In-Reply-To: <20200723174747.GA3975154@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 23 Jul 2020 13:47:47 -0400")
Message-ID: <xmqq5zaertrd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 339BE172-CD0F-11EA-A2BF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree this patch is fine, but I wonder if it could go even further. If
> we are pretending some particular contents, shouldn't we override
> anything that might be in the object database? I.e., could we eliminate
> this has_object_file() entirely?
>
> That should be OK for the same reason that it's OK to use QUICK.
>
> There's only one caller of this function (git-blame), which I think
> would be happy with such a change.

I actually have to take that "we could even lie to say that content
that does not hash to X is object X" back---that was never the
intention of this mechanism.

It was to ensure that operations that are supposedly read-only can
avoid writing into the repository---"blame" uses it to pretend as if
the working tree file already has a corresponding object in the
object store, IIRC.

The only reason why hash_object_file() is used here is to allow us
discarding the memory held for that working tree copy if it happens
to match what is stored in the object database.  The saving would be
within a few hundred kilobytes to a single digit megabyte range at
most, hopefully, so we could drop it (oh, saying "a single digit
megabyte" reminds me that my first Linux computer was 486dx with
4MB ram---on that box, it may have mattered).

