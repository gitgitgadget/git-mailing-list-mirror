Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7475C47425
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBAE206A1
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 15:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xi9vrfq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbgJAPqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 11:46:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57898 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbgJAPqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 11:46:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CCE4107BFD;
        Thu,  1 Oct 2020 11:46:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=457IrKJqzCwJ4MhL48My49IJ/N8=; b=xi9vrf
        q/0CO7CUPyO9OnaJ2jTj2eEGawxJ/bgj1OvJO1vQMYM2rADKPDd/9BZ0d1L9GiOz
        KZixgyMafmILGPGwrxoec0XMjFXT7t0ZnJHP143g6zNxO1Zptcyvq3hMKmwAylw6
        5vvw3d6Bk6hKOzC5Rx/H4oMCLXB83gda/n1Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MCfwZ415xlm/sKybr/QoId6SUtaIGlWT
        DFRPex4LTMsvd5oa5GxAfJoxhR64A+Y0wh/kSP6pIHyrv6lnN0xceovOlXXZNELk
        cvCOwCQEao8s6X4dcK0X9wBpBq/8V80BoB5XaRQ8Qzg+0OKHWj5SFzu9yyK6OI5F
        PIrcu5qY8qY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85417107BFC;
        Thu,  1 Oct 2020 11:46:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9037107BFB;
        Thu,  1 Oct 2020 11:46:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 0/3] push: add "--[no-]force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
Date:   Thu, 01 Oct 2020 08:46:13 -0700
In-Reply-To: <20201001082118.19441-1-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Thu, 1 Oct 2020 13:51:15 +0530")
Message-ID: <xmqqlfgqc5kq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CE7A872-03FD-11EB-B7B2-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> Changes since v8:
>   - Disable "commit-graph" when "in_merge_bases_many()" is called
>     for this check, because it returns different results depending
>     on whether "commit-graph" is enabled [1].

Is that a wise move, though?  If the "different results" is
expected, then it is a different story, but I would think it is a
bug in commit-graph codepath if it produces a result different from
what the callers expect, and disabling from the caller's end would
mean that we lose one opportunity to help commit-graph folks to go
and fix their bugs, no?

Other than that, I think the topic is in quite a good shape.  Thanks
for working on polishing it.

