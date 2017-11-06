Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB12C202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 10:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdKFKsE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 05:48:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:47454 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751490AbdKFKsD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 05:48:03 -0500
Received: (qmail 20179 invoked by uid 109); 6 Nov 2017 10:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 10:48:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19730 invoked by uid 111); 6 Nov 2017 10:48:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Nov 2017 05:48:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Nov 2017 05:48:01 -0500
Date:   Mon, 6 Nov 2017 05:48:01 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, hkleynhans@bloomberg.net,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/DONOTAPPLY 0/4] first steps towards
 pager.foo.{command,enable}
Message-ID: <20171106104801.73n27fgmn43y6m3v@sigill.intra.peff.net>
References: <20171104092850.5fthdgvnihd3y4fm@sigill.intra.peff.net>
 <cover.1509879269.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1509879269.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 05, 2017 at 12:58:18PM +0100, Martin Ågren wrote:

> On 4 November 2017 at 10:28, Jeff King <peff@peff.net> wrote:
> >  - the pager.<cmd> config is mis-designed, because our config keys
> >    cannot represent all possible command names (e.g., case folding and
> >    illegal characters). This should be pager.<cmd>.enable or similar.
> >    Some discussion in (this message and the surrounding thread):
> >
> >      https://public-inbox.org/git/20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net/
> >
> >    But I think you could find more by searching the archive.
> 
> I'm posting four patches I have on this to save others from redoing my
> work and findings. These patches feel a bit incomplete, which is why I
> put them to the side some time ago (and eventually forgot about them).

Thanks for sharing these; it's nice if we can avoid duplicating work.
We'll see if somebody at the event wants to pick up this topic.

> In particular, they do not teach `--paginate` to use the pager
> configured by `pager.foo.command`. It is already now possible to use
> `pager.foo` to say "I don't want you to page, but if I later give you
> `pager.foo=true`, this is the pager I want you to use". That does not
> work with `--paginate`, but this can all be explained -- indeed, we
> document that `--paginate` overrules `pager.foo`.

Hmm. I think the current behavior is actually buggy. I assume the
documentation you mean is from git.txt:

  --paginate::
          Pipe all output into 'less' (or if set, $PAGER) if standard
          output is a terminal.  This overrides the `pager.<cmd>`
          configuration options (see the "Configuration Mechanism" section
          below).

That comes from 06300d9753 (git.1: Clarify the behavior of the
--paginate option, 2010-02-14). But I think that commit was just trying
to clarify that "--paginate" overrides the defaults and config, but not
does say "always paginate".

I suspect nobody really noticed it in practice because once you've
configured "pager.foo", there's basically no need to ever use
"--paginate".

> If we teach `--paginate` to respect `pager.foo.command`, it seems that
> we would either 1) introduce a small (and possibly hard to understand
> and explain) difference between the old-style and the new-style
> pager-configuration or 2) knowingly change the behavior of `--paginate`
> with `pager.foo` or 3) knowingly change the behavior of
> `pager.foo=false` as documented in the first patch.

I think I'm suggesting (2), then.

-Peff
