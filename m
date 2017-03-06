Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B379A1FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdCFJos (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:44:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:39077 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753086AbdCFJob (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:44:31 -0500
Received: (qmail 28389 invoked by uid 109); 6 Mar 2017 09:43:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 09:43:37 +0000
Received: (qmail 16158 invoked by uid 111); 6 Mar 2017 09:43:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 04:43:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Mar 2017 04:43:34 -0500
Date:   Mon, 6 Mar 2017 04:43:34 -0500
From:   Jeff King <peff@peff.net>
To:     ankostis <ankostis@gmail.com>
Cc:     David Lang <david@lang.hm>, Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170306094334.whtuvotyppvcom2f@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <nycvar.QRO.7.75.62.1703050258200.6590@qynat-yncgbc>
 <CA+dhYEXHbQfJ6KUB1tWS9u1MLEOJL81fTYkbxu4XO-i+379LPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+dhYEXHbQfJ6KUB1tWS9u1MLEOJL81fTYkbxu4XO-i+379LPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 10:29:33AM +0100, ankostis wrote:

> On 5 March 2017 at 12:02, David Lang <david@lang.hm> wrote:
> >> Translation table
> >> ~~~~~~~~~~~~~~~~~
> >> A fast bidirectional mapping between sha1-names and sha256-names of
> >> all local objects in the repository is kept on disk. The exact format
> >> of that mapping is to be determined.
> >>
> >> All operations that make new objects (e.g., "git commit") add the new
> >> objects to the translation table.
> >
> >
> > This seems like a rather nontrival thing to design. It will need to hold
> > millions of mappings, and be quickly searchable from either direction
> > (sha1->new and new->sha1) while still be fairly fast to insert new records
> > into.
> >
> > For Linux, just the list of hashes recording the commits is going to be in
> > the millions, whiel the list of hashes of individual files for all those
> > commits is going to be substantially larger.
> 
> Apologies if it is a stupid idea, but could we avoid the mappings-table
> just by
> hard-linking to the same object from both (or more) hashes?
> So instead of creating a text-db format, just use the filesystem.

No, for a few reasons:

  1. Most of these objects will not be in the filesystem at all, but
     rather in a packfile.

  2. It's not just a different hash over the same bytes. The sha256-name
     is taken over the sha256-content (which refers to other objects
     using sha256). So they really are different objects. You probably
     wouldn't keep the sha1 version around separately, but rather
     generate it on the fly during a push to a sha1 server.

  3. You really need to be able to take a sha256 name and convert it to
     a sha1 and vice versa. Hardlinks don't help with that, because they
     only point in one direction. That get you to the same _content_,
     but not the other name (and I guess this is where your "look up the
     name and then compute the other digest comes in, but that's
     probably too expensive to be workable).

I do think updating the mapping could potentially be deferred until
interacting with a sha1 server. But because it needs to be generated in
reverse-topological order, it's conceptually easier to do it one object
at a time.

-Peff
