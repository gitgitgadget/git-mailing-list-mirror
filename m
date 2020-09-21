Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC9AC4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC20A20888
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 18:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uMVwSGoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgIUSLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 14:11:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57172 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgIUSLs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 14:11:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C667EF46DB;
        Mon, 21 Sep 2020 14:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kz2X/pJfgSaimBgkB4RTkAiSoQc=; b=uMVwSG
        oJ2u2s/7XV5PWkHqNRo/cvSJSuXMIqup2O5auZCDAqhSIE+hkh96rT2X02gvcV6Z
        w7PpGpi/7+M+kqErzCvcZBs7M3j6WoEQqj3VsyZPIJYic+lgBRTwT+V8Vt0c1AOI
        3ibAb8aJdy61QoVUlIK7WD7N9Dl82nBIxz1aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p/n7RS5GsY9ehsETjaXSG+BwwledhGqL
        nPfXkNYzQq2vtYRBSasRUozEiGUpaPSzgxCWD3vhnt31HJymS9jvHJF3SQd683JT
        5D1DOD0mS4bxrHe9ozUorfIlDPJKRvhnmY1KugAq4yyI7jovZ3iIVuDXDN579PWc
        j2iMHRNmM/Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C04FEF46D9;
        Mon, 21 Sep 2020 14:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8B74F46D8;
        Mon, 21 Sep 2020 14:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
        <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
        <xmqqft7djzz0.fsf@gitster.c.googlers.com>
        <f6bb2b1f-0f1b-f196-59f1-893580430cf2@gmail.com>
        <xmqqv9g7f6r9.fsf@gitster.c.googlers.com>
Date:   Mon, 21 Sep 2020 11:11:42 -0700
In-Reply-To: <xmqqv9g7f6r9.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 21 Sep 2020 09:12:58 -0700")
Message-ID: <xmqqmu1jf19d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7B44046-FC35-11EA-8957-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Meaning we first check the timestamp of the topmost reflog entry of
> remote-tracking branch (i.e. the time *we* acquired the tip commit
> that we are about to lose), and leverage on the fact that no local
> commit older than that timestamp can possibly be written with the
> knowledge of that remote work?  Assuming that local timestamp is
> monotonically increasing, it is a quite valid optimization (and the
> clock skew we often talk about in the context of revision traversal
> are often discrepancy between matchines).
>
> Having said that.
>
> The new generation number based on (adjusted) timestamp is being
> worked in, and that work is supposed to bring such an optimization
> to us automatically (at least on the reachability's side, i.e. logic
> that uses get_merge_bases()), I think, so we probably do *not* want
> to add such a heuristics specifically for this codepath.

Eh, I spoke too soon before I thought it through.  I do not think we
will gain "assume that any commit whose timestamp is older than this
externally given one will never reach the other commit" even with
the reachability index based on (adjusted) timestamp.  At least,
stopping the traversal of reflog entries of the local side at the
timestamp of the topmost reflog entry of remote-tracking branch in
question would be an easy, worthwhile and sensible optimization.

Thanks.
