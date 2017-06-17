Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0900720401
	for <e@80x24.org>; Sat, 17 Jun 2017 11:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbdFQLzZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 07:55:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:41990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752810AbdFQLzY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 07:55:24 -0400
Received: (qmail 17551 invoked by uid 109); 17 Jun 2017 11:55:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 11:55:24 +0000
Received: (qmail 13716 invoked by uid 111); 17 Jun 2017 11:55:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Jun 2017 07:55:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jun 2017 07:55:22 -0400
Date:   Sat, 17 Jun 2017 07:55:22 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/5] remote: eliminate remote->{fetch,push}_refspec
 and lazy parsing of refspecs
Message-ID: <20170617115522.lbke5wnle5irbunj@sigill.intra.peff.net>
References: <20170616192837.11035-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170616192837.11035-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 09:28:32PM +0200, SZEDER Gábor wrote:

> 'struct remote' stores refspecs twice: once in their original string
> form in remote->{fetch,push}_refspecs and once in their parsed form in
> remote->{fetch,push}.  This is necessary, because we need the refspecs
> for lazy parsing after we finished reading the configuration: we don't
> want to die() on a bogus refspec while reading the configuration of a
> remote we are not going to access at all.
> 
> However, storing refspecs in both forms has some drawbacks:
> 
>   - The same information is stored twice, wasting memory.

I don't think this is really that important. It's rare to have more than
a handful of refspecs, and they're short strings.

>   - remote->{fetch,push}_refspecs, i.e. the string arrays are
>     conveniently ALLOC_GROW()-able with associated
>     {fetch,push}_refspec_{nr,alloc} fields, but remote->{fetch,push}
>     are not.
>   - Wherever remote->{fetch,push} are accessed, the number of parsed
>     refspecs in there is specified by remote->{fetch,push}_refspec_nr.
>     This requires us to keep the two arrays in sync and makes adding
>     additional refspecs cumbersome and error prone.

I think the two-arrays things is more important, because keeping them in
sync is error-prone. On the other hand, if the array are manipulated by
accessors, that keeps the complexity in one spot.

The lazy parsing is an additional headache on top of that, but that's
orthogonal. Without the lazy parsing, then a single add_refspec() would
be simple and keep everything in sync.

>   - And worst of all, it pissed me off while working on
>     sg/clone-refspec-from-command-line-config ;)

That I can sympathize with. ;)

> The idea is to parse refspecs gently while reading the configuration:
> this way we won't need to store all refspecs as strings, and won't
> die() on a bogus refspec right away.  A bogus refspec, if there's one,
> will be stored in the remote it belongs to, so it will be available
> later when that remote is accessed and can be used in the error
> message.

The "turn a parsed refspec struct back into a refspec string" makes me a
little nervous, just because it needs to be the inverse of the parsing
function. So now we have two new things that need to be kept in sync.

If we forget the "storing it twice" argument, would it make sense to
convert the parallel arrays of items into a single array-of-struct?
I.e.:

  struct configured_refspec {
	const char *string;
	struct refspec refspec;
	unsigned parsed:1;
  }

I guess that may run into problems where we really need an
array-of-refspec to pass into sub-functions. So going further, could we
just have "struct refspec" store the text form it was parsed from?

-Peff
