Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698B0C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA9F61212
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 22:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbhIQWCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 18:02:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:50248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhIQWB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 18:01:59 -0400
Received: (qmail 13611 invoked by uid 109); 17 Sep 2021 22:00:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Sep 2021 22:00:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22999 invoked by uid 111); 17 Sep 2021 22:00:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Sep 2021 18:00:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Sep 2021 18:00:35 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] pretty: colorize pattern matches in commit
 messages
Message-ID: <YUUQA1qNCzY7Vx+j@coredump.intra.peff.net>
References: <20210916140943.2442184-1-someguy@effective-light.com>
 <20210916140943.2442184-2-someguy@effective-light.com>
 <CAPig+cRfFZ=GAevJ0b9oBGTR8P3MnSg+R43ujSP0dZJL08riqA@mail.gmail.com>
 <WCKLZQ.YCP2HWKW7YBB2@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <WCKLZQ.YCP2HWKW7YBB2@effective-light.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 05:14:56PM -0400, Hamza Mahfooz wrote:

> 
> On Fri, Sep 17 2021 at 03:10:12 AM -0400, Eric Sunshine
> <sunshine@sunshineco.com> wrote:
> > `buf` and `eol` seem like an accident waiting to happen...
> > 
> > >  +       line_color = opt->colors[GREP_COLOR_SELECTED];
> > >  +       match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
> > >  +
> > >  +       while (grep_next_match(opt, buf, eol, ctx, &match, field,
> > > eflags)) {
> > >  +               if (match.rm_so == match.rm_eo)
> > >  +                       break;
> > >  +
> > >  +               strbuf_grow(sb, strlen(line_color) +
> > > strlen(match_color) +
> > >  +                           (2 * strlen(GIT_COLOR_RESET)));
> > 
> > ... because strbuf_grow() may reallocate the underlying buffer, which
> > means that `buf` and `eol` will end up pointing at freed memory, which
> > will be accessed by the next call to grep_next_match().
> 
> I don't see how it's problematic, since `tmp_sb` isn't modified after `buf`
> is initialized (until strbuf_release() is called, of course).

Yes, you are correct. However, I do think the code would be much clearer
if you skipped the strbuf entirely, like:

  char *line_as_string;
  ...
  line_as_string = xmemdupz(line, linelen);
  ...
  buf = line_as_string;
  eol = buf + linelen;
  ...
  free(line_as_string);

which makes it much clearer that you don't intend to modify it further
(especially with all those other calls operating on the _other_ strbuf,
it's hard to see immediately that this is the case).

The "as_string" name is assuming the purpose is to get a NUL-terminated
string. I'm not sure why we need one, though, since we pass the buf/eol
pointers to grep_next_match(). A comment above the xmemdupz() line might
be a good place to explain that (which would help especially if the
reasons change later and we can get rid of it).

-Peff
