Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725AC1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 17:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFDRT4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 13:19:56 -0400
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:54622 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbfFDRT4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 13:19:56 -0400
Received: from resomta-po-20v.sys.comcast.net ([96.114.154.244])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id YAi8huRp0pf2NYD6Jhj6O3; Tue, 04 Jun 2019 17:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559668795;
        bh=wDPAAOsmQN43uetY7IVkjmlqdg1xD+0O8Y3y9o7X2cs=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=1SghLomPR5XqtIqde35RhuaJmoILrnho3UJYYWtXxg4jFEp5hGL74HPjcHkc6GCTe
         qBEZZEI4m1SDqlPQm6jgcG3CoazWNvxMBd6hN5N7zEHBZCQE1+KZVf5ZLxq3ctUgJ4
         DTqvHZvcIPhYIazZ0FJ0NjpbKKKVzgtsxvdQbFEy70OEqV5ID/BZSCoQD7NLpGDO2P
         TTOi0iF6FHmFWYquZbPDG46hblIFzz9BTq781TRaGkNLFqXg7DiZQbFAhRkLjIlwo5
         Oge8NI7V3ekCyH3e8umEDJhKAcOzeSg1kvrhsga8qmutAGGBgf+ZuR39IdfWGb5Dpz
         1/AR+57b8YaOQ==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:f95f:aa00:d2b2:a5dd])
        by resomta-po-20v.sys.comcast.net with ESMTPSA
        id YD6HhGwhESHF0YD6IhzM8F; Tue, 04 Jun 2019 17:19:54 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 4 Jun 2019 10:19:52 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190604171952.GI4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
 <20190604161332.GA29603@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604161332.GA29603@sigill.intra.peff.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 12:13:32PM -0400, Jeff King wrote:
> > -	return has_reserved_character(subspec, errbuf) ||
> > -		url_decode(subspec, errbuf) ||
> > -		gently_parse_list_objects_filter(
> > -			&filter_options->sub[new_index], subspec->buf, errbuf);
> > +	decoded = url_percent_decode(subspec->buf);
> 
> I think you can get rid of has_reserved_character() now, too.

The purpose of has_reserved_character is to allow for future
extensibility if someone decides to implement a more sophisticated DSL
and give meaning to these characters. That may be a long-shot, but it
seems worth it.

> The reserved character list is still used on the encoding side. But I
> think you could switch to strbuf_add_urlencode() there?

strbuf_addstr_urlencode will either escape or not escape all rfc3986
reserved characters, and that set includes both : and +. The former
should not require escaping since it's a common character in filter
specs, and I would like the hand-encoded combine specs to be relatively
easy to type and read. The + must be escaped since it is used as part of
the combine:... syntax to delimit sub filters. So
strbuf_addstr_url_encode would have to be more customizable to make it
work for this context. I'd like to add a parameterizable should_escape
predicate (iow function pointer) which strbuf_addstr_urlencode accepts.
I actually think this will be more readable than the current strbuf API.
