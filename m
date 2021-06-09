Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C21C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DC860C3F
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFIENr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:13:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:49854 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhFIENp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:13:45 -0400
Received: (qmail 967 invoked by uid 109); 9 Jun 2021 04:11:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Jun 2021 04:11:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17106 invoked by uid 111); 9 Jun 2021 04:11:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Jun 2021 00:11:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Jun 2021 00:11:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [RFE] Teach git textconv to support %f
Message-ID: <YMA/h9Hpb8z+D3W3@coredump.intra.peff.net>
References: <01f901d75c7c$5a8bcb10$0fa36130$@nexbridge.com>
 <xmqq8s3jna0w.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s3jna0w.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 09:42:39AM +0900, Junio C Hamano wrote:

> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > The filter structure provides a mechanism for providing the
> > working directory's file name path to a filter using a %f
> > argument. This request is to teach the textconv mechanism to
> > support the same capability.
> >
> > The use case comes from a complex content renderer that needs to
> > know what the original file name is, so as to be able to find
> > additional content, by name, that describes the file (base
> > name+different extension).
> >
> > If this is considered a good idea, I would be happy to implement
> > this but need a pointer or two of where to look in the code to
> > make it happen.
> 
> Both in diff, grep and cat-file, textconv eventually triggers
> diff.c::fill_textconv() and calls run_textconv() unless there is a
> cached copy of the resut of running textconv earlier on the same
> contents.  This is because for each textconv driver, the output is
> expected to be purely a function of the input bytestream, and that
> is why it does not take any other input.
> 
> So, if we have two identical blobs in a tree object under different
> pathnames, making the output from textconv different for them
> because they sit at different pathnames directly goes against the
> basic design of the system at the philosophical level.
> 
> Having said that, I _suspect_ (but not verified) that as long as the
> driver is marked as non-cacheable, it may be acceptable to export a
> new environment variable, say, GIT_TEXTCONV_PATH, and allow the
> textconv program to produce different results for the same input.  I
> am not offhand sure if it is OK to allow command line substitutions
> like the filter scripts, though.  It would be nice from the point of
> view of consistency if we could do so, but those who use an existing
> textconv program at a pathname with per-cent in it may get negatively
> affected.

As the person who implemented both textconv and its caching, all of that
sounds quite sensible to me. :)

The caching mechanism has never been turned on by default, and probably
will never be (because one of the original uses for which I wanted
textconv is decrypting blobs on the fly, and storing the result would
defeat the purpose). So it may be sufficient to say "if it hurts to turn
on caching with a filter that depends on the path, then don't do it".

It may be possible to make it work with a cache, too. The caching
mechanism also has a validity key, which looks something like this:

  [prime the cache with a silly filter]
  $ git -c diff.perl.textconv='tr a-z A-Z <' \
        -c diff.perl.cachetextconv=true \
        log -p '*.perl' >/dev/null

  [the result is stored via git-notes; the body is the cache-key]
  $ git cat-file commit refs/notes/textconv/perl
  tree a27c3c18d222e47a7943c2844f9ed6c75710d8c4
  author Jeff King <peff@peff.net> 1623211550 -0400
  committer Jeff King <peff@peff.net> 1623211550 -0400
  
  tr a-z A-Z <

I thought at first we could put the pathname into that key, but it's
really a key for the _whole_ cache, not an individual entry. So that
wouldn't work. You'd have to redesign the cache mechanism (which in turn
might require assistance from the notes code). So I lean towards "if it
hurts, don't do it". :)

One final note. Randall said:

> > The use case comes from a complex content renderer that needs to
> > know what the original file name is, so as to be able to find
> > additional content, by name, that describes the file (base
> > name+different extension).

That needs the filename, but there's also the implication there that
ancillary data would be coming from _other_ files based on that name.
That seems a lot more complicated. If I'm a filter and am asked to
convert "foo.one", I might want to see "foo.two". But how do I know from
which commit to get it? It is OK if "foo.two" is a globally unambiguous
name across time, but I'd imagine in most cases you want "foo.two" that
accompanied "foo.one" at the time. And now the cache is not even a
property of a blob/filename pair, but rather of the whole tree.

-Peff
