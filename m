Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E37DC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1984860C40
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhH0VwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:52:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhH0VwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:52:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71938EF386;
        Fri, 27 Aug 2021 17:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wi/1dsRBZmphU1jZ2bvUzt9XwRYkQ+Yt96pGTi
        ZRdqk=; b=vra/qPWZHEkAvcMcafx3gXKXlK4zTlIM99wCY29y0MDDDV9pitu2G6
        bAz4UD7VNUvExmF+sHJE2TPM6ggt8XU5cX+LrKRO27JiE15LS3BeaErk+VmrzDJP
        U7OV7Wjwcgk9c6xNYGGUZzlmEESuiLi4ZAUsSxejICJeyOpJvPV48=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65DB7EF385;
        Fri, 27 Aug 2021 17:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C844AEF384;
        Fri, 27 Aug 2021 17:51:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: git log --encoding=HTML is not supported
References: <9896630.2IqcCWsCYL@localhost.localdomain>
        <CAGyf7-FhLQKQyCOishyrZHg0J+jk6=aszE3hMoH=L0j+0+TP7Q@mail.gmail.com>
        <xmqq5yvsgqt7.fsf@gitster.g>
        <3883941.fE8Og5qy2N@localhost.localdomain>
        <xmqqk0k6c1zn.fsf@gitster.g>
        <YSkw6DSHenXHGx0b@coredump.intra.peff.net>
Date:   Fri, 27 Aug 2021 14:51:23 -0700
In-Reply-To: <YSkw6DSHenXHGx0b@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 27 Aug 2021 14:37:28 -0400")
Message-ID: <xmqqczpya750.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC9A9202-0780-11EC-A26D-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wouldn't be opposed to an option for the pretty formatter to have
> encodings. Something like:
>
>   git log --format='%(authorname:quote=html)'
>
> I'd probably put off implementing that until we actually unify the
> for-each-ref and pretty formats, though (we do not even have
> %(authorname) at this point!). The latter already has a quoting
> mechanism for shell/perl/python/tcl (though it is not per-atom, and I
> wouldn't be opposed to a --format-quote option that quoted all pretty.c
> placeholders).

Yeah, per-atom would be nice, as we can specify which piece needs
what kind of quoting, e.g.

    git log --format='
	if test %(authoremail:quote=shell) != "gitster@pobox.com"
	then
	    echo %(authorname:quote=html+shell)
	fi
    ' | sh

can be used to write a script to produce an "echo" command with a
shell literal string as its argument, where that literal string
writes author's name in a way that can be inserted in an HTML
document, but omitting the commits by me.
