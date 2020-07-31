Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EF8C433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8A820829
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 02:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Do/KM6tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbgGaCKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:10:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53820 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbgGaCKr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 22:10:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 470A064399;
        Thu, 30 Jul 2020 22:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sNT2qRHyptLSM5KssaYtA3kI+As=; b=Do/KM6
        tJaUk7knDcFTY52GbwKc+r6hgShmXgOghWcOecYi4taRCzp9WxVPbJVKlYaGzqEs
        0R1j6xDmaZQsys6RntishZVJ4flANJ8vq8rLlOVFXJUvzlAVHSWvmQcIc1Ua4peI
        +M/j/Wcm02GZZGm0ISXKMefg6aHyMotCOxQPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AawMyp3KeIqTfVZqwQadEM4y1evWLqhD
        GSNiqKko8pZFPCXbnpw4FFvqfdZEnMzGmXNCk+kHtLp+E8sC/XaNu3RcinFlImN0
        PJKLBgmXJ6zbCIZf8CgwTKBvQxtRVGUEZNnkWdt9gpeAE0bdWZaOYjFusf0OVlYS
        pV9UkebS2e0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E23264398;
        Thu, 30 Jul 2020 22:10:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B657764397;
        Thu, 30 Jul 2020 22:10:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emma Brooks <me@pluvano.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: Map names/emails with mailmap
References: <20200730041217.6893-1-me@pluvano.com>
        <20200731010129.GD240563@coredump.intra.peff.net>
Date:   Thu, 30 Jul 2020 19:10:44 -0700
In-Reply-To: <20200731010129.GD240563@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Jul 2020 21:01:29 -0400")
Message-ID: <xmqqtuxo4eor.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AB30C58-D2D3-11EA-AB57-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 30, 2020 at 04:12:17AM +0000, Emma Brooks wrote:
>
>> Add an option to map names and emails to their canonical forms via a
>> .mailmap file. This is enabled by default, consistent with the behavior
>> of Git itself.
>
> I'm quite far from an expert in gitweb, but this seems like a good
> feature to have.
>
> Having a separate implementation to read and apply mailmaps makes me
> worried that it will behave slightly differently than the C code,
> especially around corner cases. Is it possible for us to ask git
> programs that are called by gitweb to do the conversion for us (e.g.,
> by passing "--use-mailmap" or using "%aE" and "%aN" formatters)?
> I won't be surprised if the answer is "no, we access commits using
> lower-level plumbing". But it's worth looking into, I think, if you
> didn't already.

I briefly looked at tweaking "rev-list --header" but because it ends
up calling pretty.c::pp_header() for obvious reasons since we are
doing as little processing as possible in CMIT_FMT_RAW format, we do
not get to pretty.c::pp_user_info() which is where the mailmap
conversion happens for the normal "log" output.

It is tempting to split pp_user_info() into two parts (i.e. the
first few lines up to where map_user() is optionally called, and the
remainder), so that the CMIT_FMT_RAW users can optionally ask for
mailmap to kick in, but I doubt that it is worth it, if the only
potential benefitter is gitweb (which I consider is purely
maintenance mode---I am surprised the world hasn't yet switched to
gitiles, cgit and others).
