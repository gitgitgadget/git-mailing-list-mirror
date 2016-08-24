Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D302018E
	for <e@80x24.org>; Wed, 24 Aug 2016 18:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755910AbcHXSZ5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:25:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754160AbcHXSZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:25:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E06238209;
        Wed, 24 Aug 2016 14:25:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N1z3Blop+pEMnw0Pbi3mgk8C1OI=; b=Rx9r0W
        mYoC5HkKVegfK4HQE6jRe6bEv53KstjcuI1drRrOzOfFHE4kX9Ya4OGTMKzsjVaj
        Qg1tsI3jM0PZp+hy1DWW/JjHd+IEq7JV5IxP8Hm2v4TjtEX2fuUQVIyQHAkYb4Cr
        VslPju3QCHUKeYpP5BQ12GrHagNziK+yCJHdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=plnABV517qO+Hbb0zkiMiQYPXARyOj3W
        GSC3asjJzcCqLUdRnpJZQYUMQy1aJIiUUvMU/j6InHwG++jgsXTtb5TIxY+vshsl
        L4Ce6Z8P/tMI1qzqTi87hzN8f4fbxlP+p4Q3mVeEJaqccLUlaZxwW/vNtHONbWlM
        1lUHOF+ores=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 872A438208;
        Wed, 24 Aug 2016 14:25:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F51B381FC;
        Wed, 24 Aug 2016 14:25:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] cat-file --textconv/--filters: allow specifying the path separately
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <d9e9d8b111efd161986aee32bb3ae0baec0dcf34.1472041389.git.johannes.schindelin@gmx.de>
        <xmqqinuqqcor.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Aug 2016 11:25:51 -0700
In-Reply-To: <xmqqinuqqcor.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 24 Aug 2016 10:49:56 -0700")
Message-ID: <xmqqwpj6owgg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30CDEB3C-6A28-11E6-8F4C-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Mentioned elsewhere, but I think the above should be
>
> 	if (!path)
>         	path = obj_context.path;
>
> 	if (obj_context.mode == S_IFINVALID)
>         	obj_context.mode = 0100644;
>
> IOW, even when there is an explicit path supplied, we should fall
> back to assumed "regular blob" mode, so that
>
> 	git cat-file --filters --path=README $(git rev-parse :README)
>
> would work as expected.

Actually, I am reading the conditional the other way, but the
conclusion "defaulting from unknown mode to regular blob is
necessary whether the user gave us a path or not" is the same.

The current code may fail if --path is not available and 40-hex that
does not give us any context of look up is given because it won't be
able to decide how to filter, so using "else if" would not have
practical difference there, but conceptually it still is wrong.
