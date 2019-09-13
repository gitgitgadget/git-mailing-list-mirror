Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FD61F463
	for <e@80x24.org>; Fri, 13 Sep 2019 19:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIMTFN (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 15:05:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51676 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfIMTFM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 15:05:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A91BA2DFED;
        Fri, 13 Sep 2019 15:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mfVxJIn5sBm2J/P7DzBrLFEyagw=; b=tq9w9s
        Gtf/utrNKGpyWG0iOEMuj76HOqkQajN6nmNXnU5DJRjRWlJ2eQfcQEOVOYZNsq0c
        yKKCnMcnfTMoC9g/FtO2xWk/Ddvo/90B2/oXMazBSwTYWmcexlBRtTvshhmqGQpv
        v878DP0R0eyFGHNKRFaPj2eGBxblEvFeAkvu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ve+oHjO/PCXW2FVW9BdZofiCKTLV6671
        I9lpkb3q0yFO9G1vJV7daNJe6+eTO1sJCcy8gCx1EXLyr91EbzDQGpYiS91QJ/k8
        uyjk3k3dAeyhgTENJJFk1UM5njc4dYd9BYt7j8QG88zr1XzoCKX0o5wfo3kuuP+p
        PN2IKfegySQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C8C92DFEA;
        Fri, 13 Sep 2019 15:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9550E2DFDA;
        Fri, 13 Sep 2019 15:05:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Asc?= =?utf-8?Q?ens=C3=A3o?= 
        <rafa.almas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v3 03/12] dir: fix off-by-one error in match_pathspec_item
References: <20190905154735.29784-1-newren@gmail.com>
        <20190912221240.18057-1-newren@gmail.com>
        <20190912221240.18057-4-newren@gmail.com>
Date:   Fri, 13 Sep 2019 12:05:08 -0700
In-Reply-To: <20190912221240.18057-4-newren@gmail.com> (Elijah Newren's
        message of "Thu, 12 Sep 2019 15:12:31 -0700")
Message-ID: <xmqq7e6cdnkr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67F93EC2-D659-11E9-8943-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> For a pathspec like 'foo/bar' comparing against a path named "foo/",
> namelen will be 4, and match[namelen] will be 'b'.  The correct location
> of the directory separator is namelen-1.

And the reason why name[namelen-1] may not be slash, in which case
your new code makes offset 0, is because we need to handle what
case?  When path is "foo" (not "foo/")?  Just makes me wonder why
this callee allows the caller(s) to be inconsistent, sometimes
including the trailing slash in <name, nemelen> tuple, sometimes
not.

> The reason the code worked anyway was that the following code immediately
> checked whether the first matchlen characters matched (which they do) and
> then bailed and return MATCHED_RECURSIVELY anyway since wildmatch doesn't
> have the ability to check if "name" can be matched as a directory (or
> prefix) against the pathspec.

Nicely spotted and explained.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index a9168bed96..bf1a74799e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -356,8 +356,9 @@ static int match_pathspec_item(const struct index_state *istate,
>  	/* Perform checks to see if "name" is a super set of the pathspec */
>  	if (flags & DO_MATCH_SUBMODULE) {
>  		/* name is a literal prefix of the pathspec */
> +		int offset = name[namelen-1] == '/' ? 1 : 0;
>  		if ((namelen < matchlen) &&
> -		    (match[namelen] == '/') &&
> +		    (match[namelen-offset] == '/') &&
>  		    !ps_strncmp(item, match, name, namelen))
>  			return MATCHED_RECURSIVELY;
