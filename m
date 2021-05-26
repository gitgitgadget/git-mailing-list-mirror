Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124FDC47082
	for <git@archiver.kernel.org>; Wed, 26 May 2021 22:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDB7613CA
	for <git@archiver.kernel.org>; Wed, 26 May 2021 22:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhEZWUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 18:20:30 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60072 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhEZWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 18:20:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A4A2139128;
        Wed, 26 May 2021 18:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BhreXUgCm54u
        oBAj4SRw0odDe8XfwahONoQfXyTas8k=; b=gg9gyDXuR4cLNVACk2udBPWItPT/
        QyzUin9/rliqVCqF8XjXHd7kVwifclPEKDLTV2hKX2JM16Tjs/6PWc6yfgU7p9h4
        nNr3Qb6rFFYrIz+VnMQhAlSDtoS5f+7WBz7EatuRSWxqTl8nqh3fyEROToS0Vol3
        Lwt7IGuryZLAubQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02015139127;
        Wed, 26 May 2021 18:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F4D3139125;
        Wed, 26 May 2021 18:18:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     git@vger.kernel.org, entwicklung@pengutronix.de
Subject: Re: time needed to rebase shortend by using --onto?
References: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de>
Date:   Thu, 27 May 2021 07:18:52 +0900
In-Reply-To: <20210526100932.2hw4rbazgvd6mzff@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 26 May 2021 12:09:32
 +0200")
Message-ID: <xmqqim35b0kz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5BF62922-BE70-11EB-AFF6-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> It rebases clean on v5.10:
>
> 	$ time git rebase v5.10
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Successfully rebased and updated detached HEAD.
>
> 	real	3m47.841s
> 	user	1m25.706s
> 	sys	0m11.181s
>
> If I start with the same rev checked out and explicitly specify the
> merge base, the rebase process is considerably faster:
>
> 	$ time git rebase --onto v5.10 v5.4
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Performing inexact rename detection: 100% (36806539/36806539), done.
> 	Successfully rebased and updated detached HEAD.
>
> 	real	1m20.588s
> 	user	1m12.645s
> 	sys	0m6.733s
>
> Is there some relevant complexity in the first invocation I'm not seein=
g
> that explains it takes more than the double time? I would have expected
> that
>
> 	git rebase v5.10
>
> does the same as:
>
> 	git rebase --onto v5.10 $(git merge-base HEAD v5.10)

There is a voodoo called fork-point detection that walks back the
reflogs and repeatedly computes merge bases, and giving --onto to
explicitly give a commit on which the history is transplanted should
remove the need to do the computation, so that is a possibility.

But according to the manpage, it should not kick in for invocations
in the above example that specify the <upstream> (the
rebase.forkpoint configuration variable can clobber this default).
