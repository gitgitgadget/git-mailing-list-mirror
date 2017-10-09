Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927A120372
	for <e@80x24.org>; Mon,  9 Oct 2017 13:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754841AbdJINth (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 09:49:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:46902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754563AbdJINtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 09:49:36 -0400
Received: (qmail 15126 invoked by uid 109); 9 Oct 2017 13:43:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 13:43:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16378 invoked by uid 111); 9 Oct 2017 13:49:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Oct 2017 09:49:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Oct 2017 09:49:33 -0400
Date:   Mon, 9 Oct 2017 09:49:33 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com
Subject: Re: [PATCH v4 4/4] sha1_name: minimize OID comparisons during
 disambiguation
Message-ID: <20171009134933.vmba67adelqbkx4y@sigill.intra.peff.net>
References: <20171008184942.69444-1-dstolee@microsoft.com>
 <20171008184942.69444-5-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171008184942.69444-5-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 02:49:42PM -0400, Derrick Stolee wrote:

> @@ -505,6 +506,65 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
>  	return 0;
>  }
>  
> +static void find_abbrev_len_for_pack(struct packed_git *p,
> +				     struct min_abbrev_data *mad)
> +{
> +	int match = 0;
> +	uint32_t num, last, first = 0;
> +	struct object_id oid;
> +
> +	open_pack_index(p);
> +	num = p->num_objects;
> +	last = num;
> +	while (first < last) {
> [...]

Your cover letter lists:

  * Silently skip packfiles that fail to open with open_pack_index()

as a change from the previous version. But this looks the same as the
last round. I think this _does_ end up skipping such packfiles because
p->num_objects will be zero. Is it worth having a comment to that
effect (or even just an early return) to make it clear that the
situation is intentional?

Although...

> +	/*
> +	 * first is now the position in the packfile where we would insert
> +	 * mad->hash if it does not exist (or the position of mad->hash if
> +	 * it does exist). Hence, we consider a maximum of three objects
> +	 * nearby for the abbreviation length.
> +	 */
> +	mad->init_len = 0;
> +	if (!match) {
> +		nth_packed_object_oid(&oid, p, first);
> +		extend_abbrev_len(&oid, mad);

If we have zero objects in the pack, what would nth_packed_object_oid()
be returning here?

So I actually think we do want an early return, not just when
open_packed_index() fails, but also when p->num_objects is zero.

-Peff
