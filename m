Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8472C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D24206F6
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 04:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ApaO7gap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgHDEhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:37:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgHDEhh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 00:37:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B456D7732;
        Tue,  4 Aug 2020 00:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0CNrJ/gaCw0F
        LoL3wOPR+hxy0PM=; b=ApaO7gapHnslvV8ENiyL7xBX6Mt7Fo9n36jBmZ9aEB37
        4TkNgqrKIMgxhzuOrV6NAphLBCChLnpEnUqt1w94SneS75ZDcgRpwn1h9fqYoYxc
        Kc6bfKHC3M00vHIEq9e4sEYftNuUnmLKWoGezKaUwNGrhINk5L38AuKoRnU7icY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=s38ZxN
        JmhCkZoGLmhU/YcVk621VjH1Mhz1+iZt2PdRLphYvzvEr1a8BETCZcFuh2gWEL5E
        sS7FZJ2G0KHdSv/lJ3zBqEvc7j+uBdge3T3ONvLqbbUZ4p6O/bDwEoWO8JvPwTR9
        mela7E41ujaVYwytISIP3Zv6t8QODQ1bkAJFI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 140E0D7731;
        Tue,  4 Aug 2020 00:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 614EFD7730;
        Tue,  4 Aug 2020 00:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Chris Torek <chris.torek@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
        <CAPx1GveChRzsA=FayzhZRSQLPz+o1Po3-_9ZvAGLPztpH5Jg9w@mail.gmail.com>
        <1fd18b0c-8c2c-54ab-89aa-357b046eb403@kdbg.org>
        <fdf66f66-b7ed-f733-22d0-23ec17209f40@web.de>
        <90b839cd-29e0-3d20-8661-a2a73eff9ced@web.de>
Date:   Mon, 03 Aug 2020 21:37:32 -0700
In-Reply-To: <90b839cd-29e0-3d20-8661-a2a73eff9ced@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 4 Aug 2020 06:31:24 +0200")
Message-ID: <xmqqd047t4ab.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 374F4E66-D60C-11EA-A152-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Somehow staying with write(2) and its friends and just adding strbuf
> based buffering looks attractive to me now. :-/

Indeed :-/
