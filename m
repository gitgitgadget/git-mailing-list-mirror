Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE3C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98A920672
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1+VXEZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUUAj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:00:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64815 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:00:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB27DF1875;
        Tue, 21 Jul 2020 16:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EKVDYKJ5l5MCC06KjGt0oe8azTE=; b=l1+VXE
        ZgRhHdvaSRxhmZVF8vdx04whGSNkemRiky3aAjaBNi5y0prG+kdKU+qDeCZgwMum
        2HAeNQEqnbX6jBksxj26mEiXAy7VvBkYjxFueeqOsCrUtk9BI925R56EvJ7gk91h
        6GY2Uy++bdmrt3fHzWKVW6WU80qDjdqTYU6qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kRo9Yk/NE1qUtFZ0gl73soBT3nxy8o5n
        jwWOtWqr0PKaAHConXGoktucOmXuhsW5ZLlrptkMPgO8LosqMQ/OT1EN5px6u5Hy
        Tsf48Fe4NjehI3bb00aaiy+Su3Yq8TcpKF7c2V99mKtyDVjqWbSI6kiZcmZPNdHi
        Lebxiid6fyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3C3BF1874;
        Tue, 21 Jul 2020 16:00:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91ABFF186F;
        Tue, 21 Jul 2020 16:00:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
        <CAHd-oW4_A7JRmdTqCMrDU7b6-PqBSpNVD-csm3y9Bype6Vn9rA@mail.gmail.com>
Date:   Tue, 21 Jul 2020 13:00:30 -0700
In-Reply-To: <CAHd-oW4_A7JRmdTqCMrDU7b6-PqBSpNVD-csm3y9Bype6Vn9rA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 21 Jul 2020 12:39:13
        -0300")
Message-ID: <xmqq1rl48wpt.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D581A884-CB8C-11EA-86DA-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> I was looking further at this code and noticed that the conditions
> under which we fstat() (or lstat()) an entry are slightly different
> throughout entry.c:
>
> - In write_entry()'s footer, we call lstat() iff stat->refresh_cache.
> - In write_entry()'s `write_file_entry` label, we call fstat_output()
> when !to_tempfile.
> - In streaming_write_entry() we call fstat_output() without checking
> if !to_tempfile.
> - And, finally, in fstat_output() itself, we check
> `state->refresh_cache && !state->base_dir_len`.
>
> I understand we always check state->refresh_cache to avoid getting
> stat information we won't really need later, as we are not updating
> the index. But why do we check !to_tempfile and !state->base_dir_len?
> Doesn't writing to a tempfile or using a checkout prefix already imply
> !state->refresh_cache?

You can easily blame the code back to e4c72923 (write_entry(): use
fstat() instead of lstat() when file is open, 2009-02-09).  Back
then, only a single place assigned 0 to state.refresh_cache and that
is in "checkout-index" with either base_dir_len or to_tempfile set.

I do not remember, and I am fairly sure Stolee does not remember
either.  If I have to guess, this was done merely to be extra
cautious, perhaps? As refresh_cache bit is checked first, check for
!to_tempfile and !base_dir_len would be dead at best and redundant
at worst.


