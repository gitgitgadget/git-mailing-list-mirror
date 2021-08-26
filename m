Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46101C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7E460F5B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 20:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbhHZUWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:22:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62244 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhHZUWN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 16:22:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 846B514BD08;
        Thu, 26 Aug 2021 16:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d1LChuk+k+IjgJwnN+Qy2aDoe/P19EkWFCdfTq
        Am2Vk=; b=CckfmgOPzQ6Va5Mz/32FnNZjkn0+ewNnu3YHDN61bd6MfODsOLd4k1
        Zcxun16Vn9uwhewjRccW4+q2S+/c559dOkFt0z6FG0oBu4jJbBic6sLaaN98fFAs
        r9zv4eBFLZoc9Lz/8u0JMu2wh36Ki6qEnVyBalZeDPDS68Av8Dq/Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C54C14BD07;
        Thu, 26 Aug 2021 16:21:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C159514BD06;
        Thu, 26 Aug 2021 16:21:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
        <20210826100648.10333-1-jacob@gitlab.com>
        <20210826100648.10333-2-jacob@gitlab.com> <xmqqpmu0f9ob.fsf@gitster.g>
Date:   Thu, 26 Aug 2021 13:21:21 -0700
In-Reply-To: <xmqqpmu0f9ob.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        26 Aug 2021 09:33:08 -0700")
Message-ID: <xmqqv93sc5z2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E542E14-06AB-11EC-8117-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> IIUC, the most notable difference between this round and the
> previous one is that now we are no longer buffering more than one
> packet worth of data because we let the stdio to accumulate them.
> I was a bit surprised that we still want to have a strbuf inside
> this structure (which is there only because it wants to persist
> during the whole conversation with the other side).
>
> Ahh, sorry, scratch that.  I do remember the discussion/patch that
> it was hurting to make calls to strbuf-init/strbuf-release once per
> ref, and it is an easy way to have the structure here to reuse it.

But that means this majorly overlaps what Patrick is already doing
in his ps/ls-refs-strbuf-optim topic.  Perhaps these should be
rebased on top of that topic branch, I wonder?
