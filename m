Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C0CC6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 11:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjDVLMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 07:12:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6E4103
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 04:12:14 -0700 (PDT)
Received: (qmail 10837 invoked by uid 109); 22 Apr 2023 11:12:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 11:12:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27657 invoked by uid 111); 22 Apr 2023 11:12:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 07:12:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 07:12:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <20230422111213.GB2969939@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 03:18:43PM -0400, Taylor Blau wrote:

> Introduce a variant of the `string_list_split_in_place()` function that
> takes a string of accepted delimiters.
> 
> By contrast to its cousin `string_list_split_in_place()` which splits
> the given string at every instance of the single character `delim`, the
> `_multi` variant splits the given string any any character appearing in
> the string `delim`.
> 
> Like `strtok()`, the `_multi` variant skips past sequential delimiting
> characters. For example:
> 
>     string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
> 
> would place in `xs` the elements "foo", "bar", and "baz".

I have mixed feelings on this.

There are multiple orthogonal options here: single/multiple delimiter,
and how to deal with sequential delimiters (you call it "runs" here,
though I think of it inverted as "allow empty fields"). Plus existing
ones like maxsplit.

Your underlying function, string_list_split_in_place_1(), handles these
independently. But it seems like a subtle gotcha that
string_list_split_in_place() and its _multi() variant, which purport to
differ only in one dimension (representation of delimiter list), also
subtly differ in another dimension. Especially because it's a facet that
might not come up in simple tests, I can see somebody incorrectly
applying one or the other.

Obviously one solution is to add the "runs" option to all variants. But
I'd be hesitant to burden existing callers. So I'd propose one of:

  1. Make your _1() function public, with a name like _with_options() or
     something (though the function name is sadly already quite long).
     Leave string_list_split_in_place() as a wrapper that behaves as
     now, and have the few new callers use the with_options() variant.

  2. Don't bother implementing the "runs" version. The only users would
     be test programs, and nobody cares much either way for their cases.
     Document in the commit message (and possibly above the function)
     that this isn't a strict replacement for strtok(). That would
     hopefully be enough for a potential caller to think about the
     behavior, and we can add "runs" if and when somebody actually wants
     it.

-Peff
