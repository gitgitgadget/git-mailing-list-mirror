Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D0A1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbcHXRuC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 13:50:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61094 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755469AbcHXRuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 13:50:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C1073712F;
        Wed, 24 Aug 2016 13:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ET04uxeQ22YLzv7vi5/oakGiOME=; b=WAlfan
        yjkJkjW0Mtji7iYohZZoi/fZ9aDihdXag86ynyctwo+LVDBBLbUph+dQ6b+lJXI4
        aVQimD1sKyDtPsGq/5pNDtGhFp1BQ13Ehxjnun6yQ/7oLg33wieFegoJ4PXx92vu
        OGzL4HR5aSM97rk4Parr+1VisH7h8n5h+nlB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=buJkasMI3DbfbZVp21NRsHcCwd9rUpxC
        SdrjLrRUZNqyvwId27SPaGL80Lby7paONFzrJDq2IltR+zl3clNBNOyYk/R1n1Xx
        TObqHuLKEc28q3VL3acfQUvyp/i4sqW0bdaAfRQ0mhBWZ9W3BoLm3vXVjq849gGt
        P3LtRffPxvw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EB7D3712D;
        Wed, 24 Aug 2016 13:49:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9CA13712B;
        Wed, 24 Aug 2016 13:49:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] cat-file --textconv/--filters: allow specifying the path separately
References: <cover.1471524357.git.johannes.schindelin@gmx.de>
        <cover.1472041389.git.johannes.schindelin@gmx.de>
        <d9e9d8b111efd161986aee32bb3ae0baec0dcf34.1472041389.git.johannes.schindelin@gmx.de>
Date:   Wed, 24 Aug 2016 10:49:56 -0700
In-Reply-To: <d9e9d8b111efd161986aee32bb3ae0baec0dcf34.1472041389.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 24 Aug 2016 14:23:43 +0200
        (CEST)")
Message-ID: <xmqqinuqqcor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CB35B22-6A23-11E6-B758-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -65,6 +68,11 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>  		die("Not a valid object name %s", obj_name);
>  
> +	if (!path)
> +		path = obj_context.path;
> +	else if (obj_context.mode == S_IFINVALID)
> +		obj_context.mode = 0100644;
> +
>  	buf = NULL;
>  	switch (opt) {
>  	case 't':

Mentioned elsewhere, but I think the above should be

	if (!path)
        	path = obj_context.path;

	if (obj_context.mode == S_IFINVALID)
        	obj_context.mode = 0100644;

IOW, even when there is an explicit path supplied, we should fall
back to assumed "regular blob" mode, so that

	git cat-file --filters --path=README $(git rev-parse :README)

would work as expected.
