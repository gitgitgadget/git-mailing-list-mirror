Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D2C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6045F206D8
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xeJwP8xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2U2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:28:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58799 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2U2R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:28:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E450E62ECF;
        Wed, 29 Jul 2020 16:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kPLMiIBzubF4oRt/I01uWLf0C0M=; b=xeJwP8
        xT+Q6WE4IeBAJ7kBta5+5bYaPLXrif/ViZvH2hgMLRRwNxvatTtTeTP233qjYPJb
        cFEzZI9T61WqUcWFZQ1zqYa9m94ohQ/tDXGJ+ki96aXkhaoGH5g5Tr3DtT0xlpyE
        5lS0xZdgBaQw1dD80eTeUcMCAnO65APxpqYJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OZ82aoYUVWuKseJ3VovzjNcOfV901RpO
        6aOvLH3QmIxaoRJ4tggWhFlzq6K7IvLCBux7D2Brk2E6UQZn0+yNNDpKiZn8bnWv
        sN6sck7Ib8QEB1DKjvSe5ljDZSbNjr7PgFF8uol19jgOu6l8L/jVqw9bwCoDE66u
        vtS0LqCDRT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDA1162ECE;
        Wed, 29 Jul 2020 16:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E31762ECD;
        Wed, 29 Jul 2020 16:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 3/7] log: enable "-m" automatically with "--first-parent"
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <20200729201028.GC2989342@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 13:28:13 -0700
In-Reply-To: <20200729201028.GC2989342@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 16:10:28 -0400")
Message-ID: <xmqqeeou9ici.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 075B8EEE-D1DA-11EA-9A03-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 39b3d773a9..83b147c23a 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -731,6 +731,9 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
>  	/* Turn --cc/-c into -p --cc/-c when -p was not given */
>  	if (!rev->diffopt.output_format && rev->combine_merges)
>  		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
> +
> +	if (rev->first_parent_only && rev->ignore_merges < 0)
> +		rev->ignore_merges = 0;

Nice; thanks to the previous "initialize to -1 and override only
when not touched", this becomes quite straight-forward.
