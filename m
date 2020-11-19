Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD9C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2AD2085B
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 20:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZYF3ZBfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKSUhk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:37:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58796 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSUhk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 15:37:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A40C115FEE;
        Thu, 19 Nov 2020 15:37:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=64WMsXeJJ+vAE06DU28d+/B39BE=; b=ZYF3ZB
        fQDqi/JwHoAevmbmADals/iU1ciMg1PBGAH/vmWkhYFq2bXKNDbkYwnFLLNcNlhR
        nLK0u3T6nCi2V6uFZfwz1LLY5OEzliTrb+/uEjyPzVLHG7TNfouVI/nWW18NgJ4n
        G4PMMfJWb2/yYDAiH3hhLsl/1OCj2+9ialIto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l4oQMWIWlMlch6QEU3IgdKDIoHIMGTq1
        zIErhHL8OUunZV4rhqUqktq9ZhUQymYLq6OPepZJvbLvPIHyWyjQK6UDONug3S7w
        jqyfjtIofTd1uslXZUQ3iHdKKkwWPiskSQ4+qehip2eLKBCld9xi1PodKz3i4wZt
        x5TdduIn9ms=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E02C3115FED;
        Thu, 19 Nov 2020 15:37:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F1DF115FEC;
        Thu, 19 Nov 2020 15:37:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        shouryashukla.oo@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, pc44800@gmail.com, chriscool@tuxfamily.org,
        stefanbeller@gmail.com
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
References: <xmqqd01sugrg.fsf@gitster.c.googlers.com>
        <20201118231331.716110-1-jonathantanmy@google.com>
        <871rgprdt1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Nov 2020 12:37:33 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 19 Nov 2020 13:38:16 +0100 (CET)")
Message-ID: <xmqq8saxxeuq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E42D7C8-2AA7-11EB-91C4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> At this stage I suspect that having a little more patience would make more
> sense. After `cmd_update` is converted, we can simply finish the
> conversion, without having to keep the shell script around.

That matches how I view the current state.  We seem to be reviewer
bandwidth limited and folks who took a look at this series to help
moving it forward certainly deserve a lot of gratitude.

Thanks.
