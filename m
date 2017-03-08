Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C77F61FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 03:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756632AbdCHDO6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 22:14:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56809 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752579AbdCHDO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 22:14:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9945819C8;
        Tue,  7 Mar 2017 21:36:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yKR1kpfb4IqSunm86QCbxejnGRM=; b=gT7vvP
        QN9Lzxu23qyO/J4J8nqk55EPqIoukK/mzA0JwDYdx+xcFXbNS/UX+7h+4ghNx2nH
        xb8FrL4bBK9G7IICJYW9gZuvm6Roov0D4dxz+IgGaso6cp7Sq3eP5wU5MdTVEnta
        4Bxzi8kaTdTiNfs1dfH4T0F8xJnQdfuPVwMws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BLppuZDztsg/I48JopE/b/a7RxPPJvr5
        Jx2u6iJE/GEeAjoY02EnYKC3Vmi9VoBat8l2Pp8VdRJxiH57XinwYUx43ZHAAa+9
        v6iNYzayKOpI8+b5ko8ify+UeQl4uXIMY/1Q2xuMGmBk5vSsWCiDo0QSHDwxg3ZS
        4KxrARsMLZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2C4F819C7;
        Tue,  7 Mar 2017 21:36:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45751819C6;
        Tue,  7 Mar 2017 21:36:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     valtron <valtron2000@gmail.com>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: Crash on MSYS2 with GIT_WORK_TREE
References: <CAFKRc7y_kpCGNORENUZ2qw_4qBwjjyaaDFxAEQa52fTryj+w7A@mail.gmail.com>
        <alpine.DEB.2.20.1703072345530.3767@virtualbox>
        <alpine.DEB.2.20.1703080104580.3767@virtualbox>
Date:   Tue, 07 Mar 2017 18:36:49 -0800
In-Reply-To: <alpine.DEB.2.20.1703080104580.3767@virtualbox> (Johannes
        Schindelin's message of "Wed, 8 Mar 2017 01:51:22 +0100 (CET)")
Message-ID: <xmqqh9344hq6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 152FFACC-03A8-11E7-9379-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The problem is actually even worse: On *Linux*, this happens:
>
> 	$ GIT_WORK_TREE=c:/invalid git rev-parse HEAD
> 	Segmentation fault (core dumped)
>
> The reason is this: when set_git_work_tree() was converted from using
> xstrdup(real_path()) to real_pathdup(), we completely missed the fact that
> the former passed die_on_error = 1 to strbuf_realpath(), while the latter
> passed die_on_error = 0. As a consequence, work_tree can be NULL now, and
> the current code does not expect set_git_work_tree() to return
> successfully after setting work_tree to NULL.

Ouch.

> Brandon, I have a hunch that pretty much all of the xstrdup(real_path())
> -> real_pathdup() sites have a problem now. The previous contract was that
> real_path() would die() if the passed path is invalid. The new contract is
> that real_pathdup() returns NULL in such a case.

OK, so it appears that we'd better audit all the callsites of
real_pathdup() and see if anybody _assumes_ that the return values
are not NULL.  They all need fixing.

Thanks for digging it through to the root cause.
