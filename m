Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E725C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0C20674
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xikXU6vX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKVGkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:40:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65424 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKVGkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 01:40:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61B5C8DA39;
        Fri, 22 Nov 2019 01:40:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2XhgCQIk5WP6+uKao4tO/6rzhKw=; b=xikXU6
        vXvFzxrytIMCqHzedHrxDlQ+Narhpv2Qrtf41FfU5e9Cih8BWo4fLKGHswh7dKQN
        WuMJegouJQuemB6etGgLUcLa0Id4I5tIIdAr7eYTZX7tk0c/pTh4mPwZvuSaamlH
        peyirxHFwi/K3AAtkZDOjKmXwsaOZ+5haSDG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t4HLh/MS/taTn+7UMGF04TEbyz620W9h
        nTP/9l28ZZ2Dhlkaislr/GidiiW1l0gWU9GAGOdm9Cz69F2YbYFhuwVi2I+5Y5QC
        sA1aX3QoYLpomO/b0hcDEdZFET/dxBtITli49L03dfk20ksbnaqKawH1Tw6tEWQP
        lJ9UOIhAqR0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AA098DA38;
        Fri, 22 Nov 2019 01:40:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 881B68DA37;
        Fri, 22 Nov 2019 01:40:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/1] sequencer: fix empty commit check when amending
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 15:40:09 +0900
In-Reply-To: <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Thu, 21 Nov 2019 14:06:21
        +0000")
Message-ID: <xmqqh82w4do6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEC521D0-0CF2-11EA-BE0F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This fixes a regression introduced in 356ee4659b ("sequencer: try to
> commit without forking 'git commit'", 2017-11-24). When amending a
> commit try_to_commit() was using the wrong parent when checking if the
> commit would be empty. When amending we need to check against HEAD^ not
> HEAD.

Thanks.  That makes sense.

If you compare with HEAD and find there is no difference, that would
mean that the "amend" itself is a no-op (i.e. the user said they
want to make changes, but after all changed their mind)?  It might
be something worth noticing, but certainly not in the same way as
"we were told to skip an empty commit---is this one empty?" gets
treated.
