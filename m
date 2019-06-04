Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D351F462
	for <e@80x24.org>; Tue,  4 Jun 2019 14:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfFDOcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:32:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:45890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727204AbfFDOcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:32:42 -0400
Received: (qmail 22458 invoked by uid 109); 4 Jun 2019 14:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jun 2019 14:32:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14533 invoked by uid 111); 4 Jun 2019 14:33:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Jun 2019 10:33:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2019 10:32:40 -0400
Date:   Tue, 4 Jun 2019 10:32:40 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 5/5] fetch: fix regression with transport helpers
Message-ID: <20190604143240.GC10598@sigill.intra.peff.net>
References: <20190604021330.16130-1-felipe.contreras@gmail.com>
 <20190604021330.16130-6-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604021330.16130-6-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 03, 2019 at 09:13:30PM -0500, Felipe Contreras wrote:

> Commit e198b3a740 changed the behavior of fetch with regards to tags.
> Before, null oids where not ignored, now they are, regardless of whether
> the refs have been explicitly cleared or not.
> 
>   e198b3a740 (fetch: replace string-list used as a look-up table with a hashmap)
> 
> When using a transport helper the oids can certainly be null. So now
> tags are ignored and fetching them is impossible.
> 
> This patch fixes that by having a specific flag that is set only when we
> explicitly want to ignore the refs, restoring the original behavior.

Makes sense. Prior to e198b3a740, we indicated "ignored" by setting the
oid (in item->util) to NULL. But since it's no longer a pointer after
that commit, we can't do so.

So the obvious alternative to this is going back to having it as a
pointer. I think I prefer your solution, though, since it keeps the
memory management a bit simpler, and more clearly expresses the intent.

If we add any new code that has to similarly ignore an item in the hash,
it will have to remember to use clear_item() rather than oidclr(). But I
don't think that's a big risk.

>  builtin/fetch.c           | 5 +++--
>  t/t5801-remote-helpers.sh | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)

The code change itself looks obviously correct.

-Peff
