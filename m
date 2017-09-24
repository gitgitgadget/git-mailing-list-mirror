Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4A820281
	for <e@80x24.org>; Sun, 24 Sep 2017 01:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdIXB0q (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 21:26:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51173 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdIXB0p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 21:26:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6B71A1CBD;
        Sat, 23 Sep 2017 21:26:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=swaR4adnHhxc
        CWxVdQL5o2UOfrg=; b=BcjOX+wexrpcG6HQcGdJwtMaESDH3j2K2L2T0nKjyMAV
        u87L8rp51gdz44VBSOh2RtkPajuumS2AjxmZ5uBDFB6f9mRWQl9ZJYHfXFtviOkg
        p0124g/r1kqSxt4JjVtmN+sAIi8WyQOmJzNh+8d54y8BVFxTa/m09NHWgT9vyOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=VESoik
        VhX7paMNQIXdHIduq7oH/t5EUiQD0MiFvScSX/ZQ7RWsefqtZ8QCeOrdAbWvf8xN
        mH/UaTwiMUE5YsLq2LXIuI/8oXgk+Ohhnz+pbs9ialdN9p1jrvMKiUTFmbShPwPh
        kYtioUGORsqh54x0868tnvnCmOwPgULXbvBpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD290A1CBA;
        Sat, 23 Sep 2017 21:26:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0755A1CB9;
        Sat, 23 Sep 2017 21:26:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] refs: make sha1 output parameter of refs_resolve_ref_unsafe() optional
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
Date:   Sun, 24 Sep 2017 10:26:42 +0900
In-Reply-To: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 23 Sep 2017 11:41:45 +0200")
Message-ID: <xmqq60c8j38t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6C969E94-A0C7-11E7-84A0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Allow callers of refs_resolve_ref_unsafe() to pass NULL if they don't
> need the resolved hash value.  We already allow the same for the flags
> parameter.  This new leniency is inherited by the various wrappers like
> resolve_ref_unsafe().
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

The patches all make sense, and I'd expect them to be something a
competent contributor would write after coming to this realization:
it seems that many many callers, when they have a ref that could be
a symbolic ref, want to learn (1) if it is a symref and (2) where it
points at, and nothing else, most notably they do not care what the
object pointed by the (symbolic) ref is.

I wonder if we want a dedicated helper for them (perhaps about a
dozen callers we have that fall into this pattern?) to call for the
exact purpose, implemented as a thin-wrapper around the
resolve_ref_unsafe() function, though.

Thanks.
