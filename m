Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC93F20954
	for <e@80x24.org>; Mon,  4 Dec 2017 17:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdLDRXn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 12:23:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:47550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751077AbdLDRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 12:23:42 -0500
Received: (qmail 818 invoked by uid 109); 4 Dec 2017 17:23:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 17:23:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24807 invoked by uid 111); 4 Dec 2017 17:24:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 12:24:02 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 12:23:40 -0500
Date:   Mon, 4 Dec 2017 12:23:40 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: Native clean/smudge filter for UTF-16 files
Message-ID: <20171204172340.GB13332@sigill.intra.peff.net>
References: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
 <20171124180401.GB29190@sigill>
 <759F0C3A-8C46-4685-BB27-6D508B26BB49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <759F0C3A-8C46-4685-BB27-6D508B26BB49@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 03, 2017 at 07:48:01PM +0100, Lars Schneider wrote:

> > - if core.convertEncoding is true, then for any file with an
> >   encoding=foo attribute, internally run iconv(foo, utf8) in
> >   convert_to_git(), and likewise iconv(utf8, foo) in
> >   convert_to_working_tree.
> > 
> > - I'm not sure if core.convertEncoding should be enabled by default. If
> >   it's a noop as long as there's no encoding attribute, then it's
> >   probably fine. But I would not want accidental conversion or any
> >   slowdown for the common case that the user wants no conversion.
> 
> I think we should mimic the behavior of "eol=crlf/lf" attribute.
> 
> AFAIK whenever I set "*.ext text eol=crlf", then I can be sure the 
> file is checked out with CRLF independent of any of my local config
> settings. Isn't that correct? I would expect a similar behavior if
> "*.ext text encoding=utf16" is set. Wouldn't that mean that we do
> not need a "core.convertEncoding" config?

Yeah, on further thought, that's probably the right thing. Both "eol"
and "encoding" attributes are definite indications of what should happen
(unlike "text", which is just saying you _could_ convert line endings if
you wished to, and therefore has to be used in conjunction with a config
setting).

I like the name "encoding" for the attribute, but I do wonder if this
would bite anybody using it already for other purposes (like gitk).

> > There is one other approach, which is to really store utf-16 in the
> > repository and better teach the diff tools to handle it (which are
> > really the main thing in git that cares about looking into the blob
> > contents). You can do this already with a textconv filter, but:
> > 
> >  1. It's slow (though cacheable).
> > 
> >  2. It doesn't work unless each repo configures the filter (so not on
> >     sites like GitHub, unless we define a micro-format that diff=utf16
> >     should be textconv'd on display, and get all implementations to
> >     respect that).
> 
> Actually, rendering diffs on Git hosting sites such as GitHub is one
> of my goals. Therefore, storing content as UTF-16 wouldn't be a solution
> for me.

If there were a convention for specifying the attribute, I think sites
like GitHub would start respecting it in the server-side diffs (though
like I said, we could also just auto-detect via BOM without even
requiring any attributes to be set up).

> >  3. Textconv patches look good, but can't be applied. This occasionally
> >     makes things awkward, depending on your workflow.
> 
> TBH I dont't understand what you mean here. What do you mean with
> "textconv patches"?

I mean the patch produced by "git diff" when textconv is in effect. That
patch cannot be applied to the original content. E.g.:

  git init
  echo "* diff=foo" >.git/info/attributes
  git config diff.foo.textconv "sed s/^/foo:/"

  echo base >file
  git add file
  git commit -m base

  echo change >file
  git diff >patch

  git reset --hard
  git apply patch

That works in the absence of the textconv, but not with it. (For a real
binary file, you'd probably need "diff --binary" to produce a usable
patch, but the principle is the same).

-Peff
