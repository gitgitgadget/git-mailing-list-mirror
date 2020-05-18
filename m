Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A770C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00649207F9
	for <git@archiver.kernel.org>; Mon, 18 May 2020 22:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NAu+zPSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgERWwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 18:52:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52325 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgERWwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 18:52:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC47F64E7D;
        Mon, 18 May 2020 18:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jYy7UXO9J/012nENIydcHlPQiyU=; b=NAu+zP
        SN96ErxdN2y5jo0G1lO1Jx8WyISixEQLpwleGCu5VqatkixKGuiGSWyANkAoBsGY
        czn6rOFp5HUf2YCkeyvgV9G8dBXlAWW3NbaKWIfGem7reWW5jgUK9yQZKKYlVPZJ
        veVQQ22mpFbaT/4eVSlNfuftLcFV/3VnL2nMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qda/ipaxioDM9hCDi69Uwqd2HoaLfjcv
        GeQPZkmMO2d/QmQQUZ9u7SKaMPKuP4oNKjErk6AW0ywtXZNKinzkklzwtWbY9W/v
        8yyLichuCkvM2OA5SweUzzMGBz0k13ucSGM/Jt4REEYDe0C+rhj5it49PuafaCfZ
        Ixmk5nR029g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4C8D64E7C;
        Mon, 18 May 2020 18:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2CC4A64E7B;
        Mon, 18 May 2020 18:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] remote-curl: fix deadlocks when remote server disconnects
References: <cover.1589393036.git.liu.denton@gmail.com>
        <cover.1589816718.git.liu.denton@gmail.com>
        <20200518165056.GD42240@coredump.intra.peff.net>
        <20200518173652.GB2462058@generichostname>
        <20200518205854.GB63978@coredump.intra.peff.net>
Date:   Mon, 18 May 2020 15:52:42 -0700
In-Reply-To: <20200518205854.GB63978@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 18 May 2020 16:58:54 -0400")
Message-ID: <xmqqh7wc26v9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4894639E-995A-11EA-8072-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think our options are probably:
>
>   1. detect flush packets in remote-curl, and either:
>
>      a. don't print an error, just hang up. That prevents a hang in the
> 	caller and produces no extra message on a real error. It may be
> 	less informative than it could be if the connection hangs up
> 	(though we may print a curl error message, and the caller will
> 	at least say "the helper hung up")
>
>      b. like (a), but always print an error; this is your original
> 	patch, but I _suspect_ (but didn't test) that it would produce
> 	extra useless messages for errors the server reports
>
>      c. between the two: inspect the final packet data for evidence of
>         ERR/sideband 3 and suppress any message if found
>
>   2. helper signals end-of-response to caller (then it never produces a
>      message itself; only the caller does, and it would abort on an ERR
>      packet before then)
>
>      a. using a special pktline (your "0002" patch)
>
>      b. some other out-of-band mechanism (e.g., could be another fd)
>
> I think this is pushing me towards 2a, your "0002" patch. It sidesteps
> the error-message questions entirely (and I think 2b is too convoluted
> to be worth pursuing, especially on Windows where setting up extra pipes
> is tricky). But I'd also be OK with 1a or 1c.

Thanks for a detailed analysis.  I guess we'd take 0002, then?
