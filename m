Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A579C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiCIXa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiCIXax (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:30:53 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D2119416
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:29:52 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7367110E229;
        Wed,  9 Mar 2022 18:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fB45FR2ZEc2S1wtp8tyOtwbJkv/GrgLyh5m9nR
        yXsGM=; b=tNKdO1j/My7ePn90248+qjYv59wnuLZDLGgDeqGs9fxb3t8E2ac3Ni
        RA91hMHuBR1DYKBn53smTyElplpd/2f7ufMZid4n2NBY3hXsE3lFZw4HCk8oZFxh
        GhKlJOlVnpRzWpef6DObef4whu7bzx2NwxGVOAWX3WxKTArVdJhBM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AE2710E228;
        Wed,  9 Mar 2022 18:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D146110E227;
        Wed,  9 Mar 2022 18:29:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 1/5] wrapper: move inclusion of CSPRNG headers the
 wrapper.c file
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
        <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
        <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 15:29:49 -0800
In-Reply-To: <685b1db888079c83573cfd984ae64f46284544af.1646866998.git.gitgitgadget@gmail.com>
        (Neeraj Singh via GitGitGadget's message of "Wed, 09 Mar 2022 23:03:14
        +0000")
Message-ID: <xmqq8rtiln6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1037D92-A000-11EC-988C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Including NTSecAPI.h in git-compat-util.h causes build errors in any
> other file that includes winternl.h. That file was included in order to
> get access to the RtlGenRandom cryptographically secure PRNG. This
> change scopes the inclusion of all PRNG headers to just the wrapper.c
> file, which is the only place it is really needed.

It is true that wrapper.c is the only thing that needs these headers
included as part of its implementation detail of csprng_bytes(), and
I think I very much like this change for that reason.

Having said that, if it true that including these two header files
in the same file will lead to compilation failure?  That sounds like
either (1) they represent two mutually incompatible APIs that will
cause breakage when code that use them, perhaps in two separate
files to avoid compilation failures, are linked together, or (2)
these system header files are simply broken.  Or something else?

> -/*
> - * Including the appropriate header file for RtlGenRandom causes MSVC to see a
> - * redefinition of types in an incompatible way when including headers below.
> - */
> -#undef HAVE_RTLGENRANDOM

This comment hints it is more like (1) above?  A type used in one
part of the system is defined differently in other parts of the
system?  I cannot imagine anything but bad things happen when a
piece of code uses one definition of the type to declare a function,
and another piece of code uses the other definition of the same type
to declare a variable and passes it as a parameter to that function.

I do not know this patch makes the situation worse, and I am not a
Windows person with boxes to dig deeper to begin with.  Hence I do
not mind the change itself, but justifying the change primarily as a
workaround for some obscure header type clashes on a single system
leaves a bad taste.  If the first sentence weren't there, I wouldn't
have spent this many minutes wondering if this is a good change ;-)
