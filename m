Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC0C2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5664220CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 18:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xsueO6YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgAaSIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:08:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50911 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 13:08:41 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC2BA514C5;
        Fri, 31 Jan 2020 13:08:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d+cjKtAMZLHO92Qy9iUBWSeUL1U=; b=xsueO6
        YXLQHVY1v/2FrpPFYcgaCB1+zDWA1owpOfLUKvbNoA3XzP5/0zR6Q1oDbXauh2dL
        RxpQ356Q2KlxC0KciQPXIKsYiQPz5iLo67Gvxje/iMUDopqIvfWPoFTgoDsdz0TB
        K9zoRwTl0VGv579ZCTB9TG9tu4UwY+wXBlRGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=spiU55xYKUuPbg+4DUDYxQpaADsdWxob
        dNiWcT8cQsDZHHtl/yr/1o42adf+Hsb8TWMJl+bqbsCttyzgOUZRaLz7dtmijI8s
        y0/lrSEF9zRq/5m7Sl3HN8u3f3g6q4hm61uWQ6hIiFKxGurBI3nWSOhsmCx78PGs
        +SGP4aJvMvs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E3DAA514C4;
        Fri, 31 Jan 2020 13:08:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F75E514C3;
        Fri, 31 Jan 2020 13:08:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] diff: only prefetch for certain output formats
References: <20200130055136.GA2184413@coredump.intra.peff.net>
        <20200130232002.203193-1-jonathantanmy@google.com>
        <20200131001416.GB2394563@coredump.intra.peff.net>
Date:   Fri, 31 Jan 2020 10:08:36 -0800
In-Reply-To: <20200131001416.GB2394563@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Jan 2020 19:14:16 -0500")
Message-ID: <xmqqeevfbisb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B46FF7FA-4454-11EA-9D89-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> fetches anything at all). I.e., for "diff -M -p", you'd want:
>
>   1. diffcore_std() sees "-p" and fetches everything
>
>   2. diffcore_rename() sees there's nothing we don't already have
>
> rather than:
>
>   1. diffcore_rename() fetches a few blobs to do rename detection
>
>   2. diffcore_std() fetches a few more blobs that weren't rename
>      candidates, but we need for "-p"

Hmph, a pure rename only change will cause no blobs transferred with
the latter (because there is no content change for "-p" to report,
and the rename detection for R100 paths would be done at the object
name level), but all blobs in filepairs (before rename matches A/D
up) with the former, no?

