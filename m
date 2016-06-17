Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA9820179
	for <e@80x24.org>; Fri, 17 Jun 2016 15:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbcFQPBo (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 11:01:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:56176 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752355AbcFQPBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 11:01:43 -0400
Received: (qmail 18787 invoked by uid 102); 17 Jun 2016 15:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 11:01:42 -0400
Received: (qmail 26151 invoked by uid 107); 17 Jun 2016 15:01:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 11:01:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 11:01:38 -0400
Date:	Fri, 17 Jun 2016 11:01:38 -0400
From:	Jeff King <peff@peff.net>
To:	Saksham Saxena <saksham.saxena.1994@ieee.org>
Cc:	git@vger.kernel.org
Subject: Re: URL rewrite in local config unable to override global config rule
Message-ID: <20160617150137.GA9197@sigill.intra.peff.net>
References: <CABYP2JZU5wqxCK1B7b_fDB0Lqz4-7a_Erb5dHKReZHQecxC8QQ@mail.gmail.com>
 <20160616121353.GB15988@sigill.intra.peff.net>
 <CABYP2JZ5nNHh_cRkgpRMkn7Qfs4zAjy+wfaputJ0CvZ-M4FW6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABYP2JZ5nNHh_cRkgpRMkn7Qfs4zAjy+wfaputJ0CvZ-M4FW6w@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 17, 2016 at 08:05:47PM +0530, Saksham Saxena wrote:

> > ..even if I have an existing "url.git://.insteadOf=https://". But I
> > could believe that having other config confuses things. The
> > url-rewriting is not "last one wins", but rather that we try all of
> >
> > > them, and the longest match wins.
> 
> Longest? Could you elaborate please?

The one that matches the longest number of characters. So
"https://example.com" is a preferred match over "https://".

I don't think that's what's going on here, though.

> Here you go (https://gist.github.com/sakshamsaxena/a1cee9c39ddc127ae659e92d02d58f0b).
> The commands are run in that sequence.

OK, so you have:

  url.git://.insteadof=https://

in your initial config, to convert https URLs to git.

Later you add:

  url.https://.insteadof=git://

to do the opposite.

The URL in your config uses http:

  remote.origin.url=https://github.com/sakshamsaxena/sails-hook-jbvcs.wiki.git

And when you push, this gets converted to "git://".

I think this is the expected behavior, due to the first insteadOf, which
converts https to git. Both rules are "active", in the sense that the
later one does not replace the former; together they make a list of
rules to try applying.

Git doesn't recursively apply insteadOf transformations. So the "convert
https to git" rule triggers, and we stop. The "convert git to https" one
doesn't trigger initially (because we are already https). And if we were
to apply rules recursively in this case, it would loop infinitely.

So I this is all operating as intended. And what you really want is a
way to say "erase any earlier rewrite rules; I do not want them applied
in this repository". There's currently not any way to do that.

For other "multi-valued configs" like this one (i.e., ones that form a
list rather than overriding earlier values), we have started using the
convention that assigning the empty value resets the list. But this
particular config key has not learned that trick yet, so it would
require a patch to git.

> > You should be able to clone, fetch, or push wiki repositories using any
> > of the normal protocols. So:
> >
> >   git@github.com:username/repo.wiki.git
> >
> > should work. Likewise, git:// will work if the repository is public, but
> >
> > > you cannot push over it.
> 
> True. Can't push over git:// and that's why I'm limited to https://

You can over ssh, though (which I thought you said earlier was your
preferred protocol).

-Peff
