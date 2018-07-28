Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48B51F597
	for <e@80x24.org>; Sat, 28 Jul 2018 09:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeG1LW4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 07:22:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:34032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727644AbeG1LW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 07:22:56 -0400
Received: (qmail 11032 invoked by uid 109); 28 Jul 2018 09:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 28 Jul 2018 09:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2128 invoked by uid 111); 28 Jul 2018 09:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 28 Jul 2018 05:57:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2018 05:56:59 -0400
Date:   Sat, 28 Jul 2018 05:56:59 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UGF3ZcWC?= Paruzel <pawelparuzel95@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clone and case sensitivity
Message-ID: <20180728095659.GA21450@sigill.intra.peff.net>
References: <24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com>
 <20180727205909.GC376343@genre.crustytoothpaste.net>
 <20180728043559.GA29185@duynguyen.home>
 <CACsJy8A3pd85fDrbak8TCnmkMb_FDmmpaNd5tBSCKBGkGswKCg@mail.gmail.com>
 <20180728044857.GA10444@sigill.intra.peff.net>
 <20180728051105.GA32243@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180728051105.GA32243@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 28, 2018 at 07:11:05AM +0200, Duy Nguyen wrote:

> > It might be enough to just issue a warning and give an advise() hint
> > that tells the user what's going on. Then they can decide what to do
> > (hide both paths, or just work in the index, or move to a different fs,
> > or complain to upstream).
> 
> Yeah that may be the best option. Something like this perhaps? Not
> sure how much detail the advice should be here.

Yeah, something along these lines.  I agree with Simon's comment
elsewhere that this should probably mention the names. I don't know if
we'd want to offer advice pointing them to using the sparse feature to
work around it.

> +static int has_duplicate_icase_entries(struct index_state *istate)
> +{
> +	struct string_list list = STRING_LIST_INIT_NODUP;
> +	int i;
> +	int found = 0;
> +
> +	for (i = 0; i < istate->cache_nr; i++)
> +		string_list_append(&list, istate->cache[i]->name);
> +
> +	list.cmp = strcasecmp;
> +	string_list_sort(&list);
> +
> +	for (i = 1; i < list.nr; i++) {
> +		if (strcasecmp(list.items[i-1].string,
> +			       list.items[i].string))
> +			continue;
> +		found = 1;
> +		break;
> +	}
> +	string_list_clear(&list, 0);
> +
> +	return found;
> +}

strcasecmp() will only catch a subset of the cases. We really need to
follow the same folding rules that the filesystem would.

For the case of clone, I actually wonder if we could detect during the
checkout step that a file already exists. Since we know that the
directory we started with was empty, then if it does, either:

  - there's some funny case-folding going on that means two paths in the
    repository map to the same name in the filesystem; or

  - somebody else is writing to the directory at the same time as us

Either of which I think would be worth warning about. I'm not sure if we
already lstat() the paths we're writing anyway as part of the checkout,
so we might even get the feature "for free".

-Peff
