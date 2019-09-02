Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 972B31F461
	for <e@80x24.org>; Mon,  2 Sep 2019 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfIBPre (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 11:47:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:36686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725806AbfIBPre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 11:47:34 -0400
Received: (qmail 26003 invoked by uid 109); 2 Sep 2019 15:47:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Sep 2019 15:47:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24840 invoked by uid 111); 2 Sep 2019 15:49:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Sep 2019 11:49:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Sep 2019 11:47:33 -0400
From:   Jeff King <peff@peff.net>
To:     Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190902154732.GD18593@sigill.intra.peff.net>
References: <20190828145640.GC14432@sigill.intra.peff.net>
 <20190826191455.GA25695@sigill.intra.peff.net>
 <20190831131748.GA13001@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190831131748.GA13001@instance-1.europe-west6-a.c.vaulted-journal-250706.internal>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 31, 2019 at 01:17:48PM +0000, Giuseppe Crinò wrote:

> On Mon, Aug 26, 2019 at 03:14:55PM -0400, Jeff King wrote:
> > We'd still want to keep the low-level removal of "<>\n", since those are
> > syntactically significant to Git (i.e., if they sneak in you end up with
> > a broken commit object).
> 
> Would it work to change `strbuf_addstr_without_crud()` such that instead of
> removing crud from the beginning and *then* crud from the end, it removes crud
> as long as it's palindromic? Then the function proceeds to remove "<>\n" from
> the string as before.
> 
> That would implement the following _mappings_:
> 
> 'Foo bar' => Foo bar
> Micheal Jr. => Micheal Jr.
> Mr. McDonalds => Mr. McDonalds
> "John Baz" => John Baz
> "JJ\x0a" => JJ
> 
> What do you think?

I think we don't have enough data to really know how much it will help
or hurt. :)

On the plus side, it is less risky than dropping the end-point crud removal
entirely.

But it still risks losing a case where some code path relies on the crud
cleanup for odd cases (mismatched delimiters, or interleaved delimiters,
or non-delimiter crud mixed in with delimiters).

On the one hand, I am actually OK with dropping the crud removal
entirely and seeing what happens, and this is a lesser form of that. On
the other hand, it puts us in a funny in-between situation where tools
can _usually_ get away without cleaning up the names, but occasionally
get bit. It might be easier to just say that we don't do cleanup.

So I dunno. There is no patch to be discussed, and I am not volunteering
to write one.  So I think whoever chooses to do so has a lot of control
over what is proposed. :)

-Peff
