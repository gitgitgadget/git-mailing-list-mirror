Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB2E203EA
	for <e@80x24.org>; Sun, 11 Dec 2016 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbcLKNAi (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 08:00:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:54876 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751335AbcLKNAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 08:00:38 -0500
Received: (qmail 21388 invoked by uid 109); 11 Dec 2016 13:00:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 11 Dec 2016 13:00:37 +0000
Received: (qmail 32670 invoked by uid 111); 11 Dec 2016 13:01:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 11 Dec 2016 08:01:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Dec 2016 08:00:34 -0500
Date:   Sun, 11 Dec 2016 08:00:34 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ariel <asgit@dsgml.com>, git@vger.kernel.org
Subject: Re: git add -p with new file
Message-ID: <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
 <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
 <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
 <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 02:04:33PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Dec 09, 2016 at 01:43:24PM -0500, Ariel wrote:
> > ...
> >> But it doesn't have to be that way. You could make add -p identical to add
> >> without options, except the -p prompts to review diffs first.
> >
> > The question is whether you would annoy people using "-p" if you started
> > including untracked files by default. I agree because it's inherently an
> > interactive process that we can be looser with backwards compatibility.
> 
> It might be interactive, but it will be irritating that we suddenly
> have to see hundreds of lines in an untracked file before we are
> asked to say "no I do not want to add this file" and have to do so
> for all the untracked files that happen to match the given pathspec.
> 
> It might make it less irritating if one of the interactive choices
> offered in the first prompt were N that tells the command: "No,
> ignore all the untracked paths", though.  I dunno.

Yeah, I agree dumping the contents automatically is annoying. Ariel
suggested asking twice about each path, which sounds clunky to me. I'd
probably give a simple question, with an option to dump the contents.
Like:

  $ echo foo >untracked
  $ git add -p
  New file: untracked
  Stage this file [y,n,v,q,a,d,/,e,?]? v     <-- user types 'v' for "view"

  diff --git a/untracked b/untracked
  index e69de29..257cc56 100644
  --- a/untracked
  +++ b/untracked
  @@ -0,0 +1 @@
  +foo
  Stage this file [y,n,v,q,a,d,/,e?]? y

Alternatively, "v" could just run "$GIT_PAGER <file>". The point is to
refresh your memory on what is in it before making a decision.

I'd also probably add interactive.showUntracked to make the whole thing
optional (but I think it would be OK to default it to on).

Some thought would have to be given handling binary files, as we
wouldn't want to dump their contents (but maybe showing them in a pager
would be OK).. We skip them entirely right now. So a related feature may
be asking "Stage this file" for binary files, with an option to somehow
view the contents.

I don't have plans to work on any of this myself. Just dumping thoughts
on what I'd expect an implementation to deal with.

-Peff
