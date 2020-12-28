Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBCC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A1A22583
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgL1Lak (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:30:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64121 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgL1Laj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:30:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E79CF10F27B;
        Mon, 28 Dec 2020 06:29:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=huWgNOeoYf34WG/F3w3yTkx1RaU=; b=Ar3ME4CcKFD1WpHK2/TS
        xWuskzjgiMKCZz4Y0vxl5FgFVItmjpKligynkKQjtUFuokKRFLOgEZHlmJogLaNj
        hgZBRKu52qqAOUT2w0t+EC1VH2gzq1O5MfXPcr+41/si0lMRa9wGXApQOow8e6J/
        t9KfqyVDb+mKjI4yYiegFLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=Juo6N8AQa1Bliy86STW1hOLjR4kEfws6iKqNQsjGUaHYP0
        ZGtuMsHLk7BHfK2+C/wTofH06vFhLwAz1SbHpdb+MyzJkuTmkxf6QqCyQeLXl5tA
        wbB1wBEkYfZzvYOEh4qaEDqXatBfsHJkH2/QyG422h6Q3UBrzJBBUTxjlt1nc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0A4010F27A;
        Mon, 28 Dec 2020 06:29:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33EA510F279;
        Mon, 28 Dec 2020 06:29:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 8/8] shortlog: allow multiple groups to be specified
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927084015.GH2465761@coredump.intra.peff.net>
Date:   Mon, 28 Dec 2020 03:29:53 -0800
Message-ID: <xmqqbleejhhq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 024BB10C-4900-11EB-A519-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Now that shortlog supports reading from trailers, it can be useful to
> combine counts from multiple trailers, or between trailers and authors.
> This can be done manually by post-processing the output from multiple
> runs, but it's non-trivial to make sure that each name/commit pair is
> counted only once.
>
> This patch teaches shortlog to accept multiple --group options on the
> command line, and pull data from all of them. That makes it possible to
> run:
>
>   git shortlog -ns --group=author --group=trailer:co-authored-by
>
> to get a shortlog that counts authors and co-authors equally.

As I recently had a chance to revisit an old thread back in v2.3.3
days, I recalled that I wished something like this was available,

  https://lore.kernel.org/git/xmqqd24g6uf1.fsf@gitster.dls.corp.google.com/

where I wished to have a way to count non-author contributions
easily to list them.

I am not comfortable with the idea of changing the release
announcement script immediately before the new release, so I'll do
v2.30.0 with the old "authorship only" script, but I'll play with
the new shortlog feature plus ideas from the old thread to see if we
can give more credit to non author contributors.
