Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAB5C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 20:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiHQUXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbiHQUXh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 16:23:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289E82CE1C
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 13:23:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 100461B3830;
        Wed, 17 Aug 2022 16:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=oUBfqFq/lxRfNcDsXbCadclsT0gRd8P8vSPx5BgzaaU=; b=t4Bu
        Ro+MsK3qR4IJRXbbPh37PjdhCKtfwuQRyusxoaQaCmVYc333odqNVi6LHdsiZ3GU
        2excn6wSLFy0tqvhBydL3BUFc+FC5VQNPpUH5PiMmPTPj5ayWeIpzM2NuhLqKq++
        fWC5xsNaZQLHGExMABOr6uz3M2AtVMvxYfCU3XI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA7301B382F;
        Wed, 17 Aug 2022 16:23:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9B83C1B382E;
        Wed, 17 Aug 2022 16:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/6] compat: add function to enable nonblocking pipes
References: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
        <YvyFBzdO8PN7Ou0W@coredump.intra.peff.net>
Date:   Wed, 17 Aug 2022 13:23:25 -0700
Message-ID: <xmqqwnb6ty9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73344014-1E6A-11ED-B292-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We'd like to be able to make some of our pipes nonblocking so that
> poll() can be used effectively, but O_NONBLOCK isn't portable. Let's
> introduce a compat wrapper so this can be abstracted for each platform.
>
> The interface is as narrow as possible to let platforms do what's
> natural there (rather than having to implement fcntl() and a fake
> O_NONBLOCK for example, or having to handle other types of descriptors).
>
> The next commit will add Windows support, at which point we should be
> covering all platforms in practice. But if we do find some other
> platform without O_NONBLOCK, we'll return ENOSYS. Arguably we could just
> trigger a build-time #error in this case, which would catch the problem
> earlier. But since we're not planning to use this compat wrapper in many
> code paths, a seldom-seen runtime error may be friendlier for such a
> platform than blocking compilation completely. Our test suite would
> still notice it.

Very well reasoned.

The only small "huh?" factor was that the name of the helper is not
enable_nonblock(), but singles out pipe as valid thing to work on.
I think it is perfectly fine, given that the current plan we have is
to use this on the pipe with the command we spawn with
pipe_command(), and it probably is even preferrable to explicitly
declare that this is designed to only work with pipes and future
developers who try to abuse it on other kinds of file descriptors
are on their own.  And "pipe" in the name of this helper may be such
a declaration that is strong enough.

Thanks.
