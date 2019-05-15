Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6561F461
	for <e@80x24.org>; Wed, 15 May 2019 05:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEOFQn (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 01:16:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51598 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOFQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 01:16:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 722AA13BB6A;
        Wed, 15 May 2019 01:16:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JhYEHM7GekDnsyaKmaKdlTZYyB0=; b=T4/p3Z
        0S9XP1LQwJUmTYRvepTkleDFn3tAx4tBNlyjdzeJY+6lq7JRVnSndidg3vAuNiYb
        y90EA4tf0uIHh+pJ9VJUI3JJMCa8U9ggDVODyhTpIq0ZGWfZKmNtanHDDvGViLf5
        k42XygfvgRp7lJEA071b/pYX1b65G9E348eGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MqtEbJLxwflHgzdinS/WIumhVOoj68hZ
        BlYnrYEJ1/Go++mwRvvEXEV4kirBPyVpXuNpbAmWTEzFtxgd5q6K1E6LEjK4+X6S
        rzIuYb3r6lhrldIHut+VjleFdpiP5T0gN9yHUtIs4Cuepqlcqb/Yz1wvzApmvbcL
        8DRbHkfC93Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6993013BB69;
        Wed, 15 May 2019 01:16:41 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1EE813BB67;
        Wed, 15 May 2019 01:16:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Eric Wong <e@80x24.org>,
        Antonio Ospite <ao2@ao2.it>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] get_oid: handle NULL repo->index
References: <20190511205711.tdclwrdixaau75zv@dcvr>
        <20190511223120.GA25224@sigill.intra.peff.net>
        <20190511230204.GA18474@sigill.intra.peff.net>
        <20190514135455.GA17927@sigill.intra.peff.net>
        <CACsJy8AvsyOz2G1zjRjpKYVZ0DLKj02-v=hXJHS0BRHnxoeWAw@mail.gmail.com>
        <20190515014622.GB13255@sigill.intra.peff.net>
Date:   Wed, 15 May 2019 14:16:39 +0900
In-Reply-To: <20190515014622.GB13255@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 14 May 2019 21:46:22 -0400")
Message-ID: <xmqqh89w70w8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F42E0CE-76D0-11E9-9D13-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Also from my earlier message, if you missed it:
>
>   I also wondered if we should simply allocate an empty index whenever
>   we have a non-toplevel "struct repository", which might be less
>   surprising to other callers. I don't have a strong opinion either way.
>   I did grep around for other callers which might have similar problems,
>   but couldn't find any.

That is an approach to make it harder to make mistakes by accepting
possibly a small wasted resource; but at that point, I think calling
repo_read_index() unconditionally from here and similar places would
be a simpler fix in the same spirit.
