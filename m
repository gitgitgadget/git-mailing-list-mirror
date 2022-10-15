Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BAC4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 18:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJOSQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOSQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 14:16:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48593476D5
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 11:16:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAD7F1CAA34;
        Sat, 15 Oct 2022 14:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CF2u0UZO/i3sVhiiO43Z271C5+diXDy4Nlf4Ho
        ZSJbE=; b=N5VnLZfTaYv6xsWB8WzyZFPcUJ7BhHrdT5m9FNbvPt63mlxNLcvfFc
        T+g2R6kKwplrzt9iiYeiJ0WFaLc+VDSSgmw0ewECLo8hsjTSQltYCcCw9IylEaUx
        K5QoFWEAMvleXSQVwgY3spmfDSAAeFak9IVreVcAE1p5XABZfuEyo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B39461CAA33;
        Sat, 15 Oct 2022 14:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E6F2F1CAA32;
        Sat, 15 Oct 2022 14:16:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonas Bernoulli <jonas@bernoul.li>, git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
Date:   Sat, 15 Oct 2022 11:16:06 -0700
In-Reply-To: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 15 Oct 2022 14:13:37 -0400")
Message-ID: <xmqqilkl54wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 708F8192-4CB5-11ED-80CA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, that's not too surprising that it's slower. It's exec-ing a bunch
> of shells to do that.
> ...
> I'm not sure if those are exactly equivalent, either. It looks like the
> old code was probably respecting submodule active markers (though in my
> test repo without the submodule actually checked out, it's still
> reported). There is probably room for a user-facing "git submodule list"
> command, but again, I don't really know enough about the space to say
> what it should report.

We could mimic "find" and make "foreach" that has no action default
to an equivalent of "echo" that is done internally without forking.

