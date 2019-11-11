Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D52C1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfKKIjl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:39:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:44294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726770AbfKKIjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:39:41 -0500
Received: (qmail 17970 invoked by uid 109); 11 Nov 2019 08:39:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 08:39:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3970 invoked by uid 111); 11 Nov 2019 08:43:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 03:43:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 03:39:40 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 9/9] sequencer: fallback to sane label in making
 rebase todo list
Message-ID: <20191111083940.GC17984@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573452046.git.congdanhqx@gmail.com>
 <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 01:03:42PM +0700, Doan Tran Cong Danh wrote:

> In later stage of rebasing, we will make a ref in
> refs/rewritten/<label>, this label is extracted from the subject of
> current merge commit.
> 
> If that subject has forbidden character for refname, git couldn't create
> the rewritten ref. One such case is the merge commit subject has
> a multibyte character encoded in ISO-2022-JP.
> 
> Provide a sane fallback in order to help git-rebase works in such case

Good find. Not having worked much with this part of the sequencer code,
I don't have a strong opinion on the fallback label. But it seems better
than the current behavior would be.

I suspect there may be other subtle problems, too, for filesystems that
can't represent some part of the subject (e.g., I wonder if some of your
ISO-2022-JP tests might already have trouble on HFS+, which excepts all
paths to be UTF-8).

> @@ -4607,9 +4608,15 @@ static int make_script_with_merges(struct pretty_print_context *pp,
>  			if (isspace(*p1))
>  				*(char *)p1 = '-';
>  
> +		hex_oid = oid_to_hex(&commit->object.oid);
> +
> +		if (check_refname_format(label.buf, REFNAME_ALLOW_ONELEVEL) < 0) {
> +			strbuf_reset(&label);
> +			strbuf_addf(&label, "label-%s", hex_oid);
> +		}
> +
>  		strbuf_reset(&buf);
> -		strbuf_addf(&buf, "%s -C %s",
> -			    cmd_merge, oid_to_hex(&commit->object.oid));
> +		strbuf_addf(&buf, "%s -C %s", cmd_merge, hex_oid);

A minor nit, but I think it's better here to just call oid_to_hex()
twice, rather than assigning to the hex_oid variable. It's returning a
pointer to a static buffer, so holding onto the pointers for too long is
dangerous. What you have here is definitely OK, because nothing
interesting happens in between, but seeing any assignment of the result
of "oid_to_hex" makes auditing harder.

And it's not like it's that expensive, or that this is
performance-critical code (and if it were, we'd do better to use
oid_to_hex_r() directly into the strbuf anyway).

-Peff
