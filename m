Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A8C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8C264FC5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 01:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCKBle (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 20:41:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51933 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKBlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 20:41:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8910AE3CE;
        Wed, 10 Mar 2021 20:41:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UmUJwcZKj2OMtcZlZF+3rXceJvc=; b=LnQdFf
        elUFHj+bhyXP7HaFzSkqXjpSBMCYfSdeATds2PxJ8j2aMAFKrdbhuLeqnoSW25ep
        oGMk+I7UrU/sxRrxjIrdshBWhIwbhxsB35gOWW8dGBNDEHSHrfjdIf4JtXtrdVHU
        daLySNx5am76LEqwrwa75XH5U3t3LnEr7oLg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iwroeyGev1n+93xjwTQzYWY599OY5NtI
        NJSuvYicJPCd9OFgSUx5ZRw4NVZhzbq4q3K0AAve4x254DevQJbuA3A56uQ3bfDh
        1qd5RtbLi91YIhSVPErWDPtolTMhETHa+tac7lY+7eYebzVYu3sJwhDyivQTfFmP
        H0pzlRiVN+Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0AFBAE3CD;
        Wed, 10 Mar 2021 20:41:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32324AE3CC;
        Wed, 10 Mar 2021 20:41:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nmulcahey@google.com
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
References: <xmqq5z1ykckc.fsf@gitster.g>
        <20210310232906.2135256-1-jonathantanmy@google.com>
Date:   Wed, 10 Mar 2021 17:41:16 -0800
In-Reply-To: <20210310232906.2135256-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 10 Mar 2021 15:29:06 -0800")
Message-ID: <xmqq4khih3gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF47871E-820A-11EB-A214-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This probably means that fetch-pack.c itself (instead of
> finish_http_pack_request(), currently being called from a separate
> http_fetch process) should call index-pack for the out-of-band
> packfiles, which is conceptually reasonable. This means that
> finish_http_pack_request() will need to be able to refrain from running
> index-pack itself and instead just return where the pack was downloaded.

The HTTP downloading for packfile specified via the packfile URI
mechansim is so different from the rest of the HTTP codepaths in
nature, isn't it?  It is a straight "download a static file over the
web, and we could even afford to resume, or send multiple requests
to gain throughput" usecase, which does not exist anywhere else in
Git (eh, other than the dumb HTTP protocol nobody sane should be
using anymore).

Since we are not in the business of writing a performant HTTP
downloader, if we can update the codepath not to rely on our http.c
code, and instead spawn one of the command line tools written
specifically for the "download a single large file over HTTP"
usecase (like curl, wget or aria2c), wait for it to do its thing and
then concentrate on the processing specific to Git (like running
index-pack with various options), it would take us closer to the
"make clone resumable" dream, wouldn't it?

Thanks.
