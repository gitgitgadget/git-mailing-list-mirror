Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963352036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbdJEJoV (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:44:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:33284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751278AbdJEJoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:44:20 -0400
Received: (qmail 15677 invoked by uid 109); 5 Oct 2017 09:44:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 09:44:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25747 invoked by uid 111); 5 Oct 2017 09:44:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 05:44:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 05:44:18 -0400
Date:   Thu, 5 Oct 2017 05:44:18 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com,
        sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v3 5/5] sha1_name: Minimize OID comparisons during
 disambiguation
Message-ID: <20171005094418.irm6omly67bgyvo7@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20171002145651.204984-6-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002145651.204984-6-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 10:56:51AM -0400, Derrick Stolee wrote:

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
> +		uint32_t mid = (first + last) / 2;

This can overflow if we are looking past 2^31. Probably not very common
(things seem to get pretty painful at hundreds of millions of objects).
But it can be written as:

  uint32_t mid = lo + (hi - lo) / 2;

Sadly, this overflow case seems to be present in many of our binary
searches.

> +		const unsigned char *current;
> +		int cmp;
> +
> +		current = nth_packed_object_sha1(p, mid);

nth_packed_object_sha1() has to do some minor computation to come up
with the correct pointer. The normal packfile lookup precomputes the
initial offset and stride outside the loop. I have no idea if that
micro-optimization is actually noticeable, but I thought I'd mention it
as a possible avenue for investigation since you're obviously interested
in squeezing out performance. ;)

-Peff
