Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86DFD202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdGGJYg (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:24:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33586 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750903AbdGGJYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:24:35 -0400
Received: (qmail 9152 invoked by uid 109); 7 Jul 2017 09:24:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 09:24:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20897 invoked by uid 111); 7 Jul 2017 09:24:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Jul 2017 05:24:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Jul 2017 05:24:33 -0400
Date:   Fri, 7 Jul 2017 05:24:33 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 6/7] reflog-walk: stop using fake parents
Message-ID: <20170707092432.u7dz3zniprp4zvkr@sigill.intra.peff.net>
References: <20170707090507.ko2ygry7j4zv7t3s@sigill.intra.peff.net>
 <20170707091407.nm4pm3bdvx6alohs@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170707091407.nm4pm3bdvx6alohs@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 07, 2017 at 05:14:07AM -0400, Jeff King wrote:

> @@ -3132,7 +3132,10 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  			if (revs->max_age != -1 &&
>  			    (commit->date < revs->max_age))
>  				continue;
> -			if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
> +
> +			if (revs->reflog_info)
> +				try_to_simplify_commit(revs, commit);
> +			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
>  				if (!revs->ignore_missing_links)
>  					die("Failed to traverse parents of commit %s",
>  						oid_to_hex(&commit->object.oid));

There's one other subtle change from v1 here. In my original, we called
try_to_simplify_commit() much later, and then we had to check whether it
marked the commit as TREESAME. That felt really hacky to me, and the
reason is because I was using the function wrong. The intent is for
try_to_simplify to be called earlier (i.e., here), when we start looking
at the commit's parents. And then the TREESAME flag it sets is later
picked up by get_commit_action(), which is called by simplify_commit(),
which is used later in get_revision_1().

So by calling try_to_simplify here, where it would normally be called
for a non-reflog walk, that's all we have to do. I don't think the
original patch had any visible bugs, but this way is much cleaner and
more future-proof.

-Peff
