Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD3C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGVd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 17:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiJGVdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 17:33:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E511C270
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 14:33:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B32B1A6B77;
        Fri,  7 Oct 2022 17:33:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oBv9ZhHYC0Xak1Mg8S67+SmRtrIM1Ks/BdPyrl
        teMH0=; b=oEKSPsD/bjqd7HDkUIgDw1Zfa3ppOaLUY7kn6+vgYGwABK1/IuVlx8
        3aGWkE6HpiYOREcwVoo8BjGBTWa0DOLPSjdp25MwuregxestYeoNpqD3Gs1PuT6H
        ElH+Fjc+Dc+2MQZpSIK56OmgbTZyaez9fAuxYavcM1+sZWvF9m0Xw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5289C1A6B75;
        Fri,  7 Oct 2022 17:33:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 87C0A1A6B72;
        Fri,  7 Oct 2022 17:33:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
        <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
        <xmqqpmf3frr5.fsf@gitster.g>
        <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
        <58d3ef47-2196-4f59-692a-fc86dfbc1252@jeffhostetler.com>
Date:   Fri, 07 Oct 2022 14:33:34 -0700
In-Reply-To: <58d3ef47-2196-4f59-692a-fc86dfbc1252@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 7 Oct 2022 16:56:01 -0400")
Message-ID: <xmqqtu4fco9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2FB83B6-4687-11ED-AC2B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> So if I understand you correctly, Apple clang 11 is broken
> and Apple clang 12 is good.
>
> I was getting ready to send (as soon as the CI finished)
> the following a simple to add the -Wno... for clang 11 and
> below on Darwin.
>
> +ifeq ($(uname_S),Darwin)
> +# Older versions of Apple clang complain about initializing a
> +# struct-within-a-struct using just "{0}" rather than "{{0}}".
> +# More recent versions do not.  This error is considered a
> +# false-positive and not worth fixing, so just disable it.
> +ifeq ($(filter clang12,$(COMPILER_FEATURES)),)
> +DEVELOPER_CFLAGS += -Wno-missing-braces
> +endif
> +endif
>
> I'm not sure I understand all of what your suggestion does.

I do agree that one is dense, but aims for the same thing, and a bit
more.  It might be easier to read if written in longhand, but ...

ifeq ($(uname_s),Darwin)
ifeq ($(filter clang12,$(COMPILER_FEATURES)),)
DEVELOPER_CFLAGS += -Wno-missing-braces
endif
else
ifeq ($(filter clang9,$(COMPILER_FEATURES)),)
DEVELOPER_CFLAGS += -Wno-missing-braces
endif
endif

... we'd need to repeat ourselves, so...
