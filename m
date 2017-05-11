Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702A3201A0
	for <e@80x24.org>; Thu, 11 May 2017 21:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756222AbdEKV7y (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 17:59:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:49938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754977AbdEKV7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 17:59:53 -0400
Received: (qmail 21928 invoked by uid 109); 11 May 2017 21:59:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 21:59:51 +0000
Received: (qmail 19325 invoked by uid 111); 11 May 2017 22:00:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 18:00:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 17:59:49 -0400
Date:   Thu, 11 May 2017 17:59:49 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170511215948.yhxirikfqujzzgqk@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170511211403.5252-1-jonathantanmy@google.com>
 <20170511213517.GA21723@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170511213517.GA21723@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 02:35:17PM -0700, Jonathan Nieder wrote:

> This structure could be simplified by putting the lazy-initializing
> tip_oids lookup in a separate function.  For example:
> 
> 	int tip_oids_contain(struct oidset *tip_oids,
> 		struct ref *unmatched, struct ref *newlist,
> 		const struct oid *id)
> 	{
> 		if (oidset_is_empty(tip_oids)) {
> 			add_refs_to_oidset(tip_oids, unmatched);
> 			add_refs_to_oidset(tip_oids, newlist);
> 		}
> 		return oidset_contains(tip_oids, id);
> 	}

Yeah, I started to write it that way, but in the empty-ref case it will
try to add the empty refs over and over. I guess that's not that big a
deal, though, as we know the noop add is O(1) then. :)

> That way, the caller could be kept simple (eliminating can_append
> and the repeated if).

Yes, shoving it all into the sub-function is a big win for readability.

-Peff
