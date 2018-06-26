Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787631F516
	for <e@80x24.org>; Tue, 26 Jun 2018 12:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbeFZMVr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 08:21:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55270 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934072AbeFZMVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 08:21:46 -0400
Received: (qmail 6852 invoked by uid 109); 26 Jun 2018 12:21:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Jun 2018 12:21:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29009 invoked by uid 111); 26 Jun 2018 12:22:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Jun 2018 08:22:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2018 08:21:43 -0400
Date:   Tue, 26 Jun 2018 08:21:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] url schemes should be case-insensitive
Message-ID: <20180626122143.GA14052@sigill.intra.peff.net>
References: <20180624085622.GA28575@sigill.intra.peff.net>
 <xmqqvaa6ohiw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaa6ohiw.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 11:19:51AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We seem to match url schemes case-sensitively:
> >
> >   $ git clone SSH://example.com/repo.git
> >   Cloning into 'repo'...
> >   fatal: Unable to find remote helper for 'SSH'
> >
> > whereas rfc3986 is clear that the scheme portion is case-insensitive.
> > We probably ought to match at least our internal ones with strcasecmp.
> 
> That may break if somebody at DevToolGroup@$BIGCOMPANY got cute and
> named their custom remote helper SSH:// that builds on top of the
> normal ssh:// protocol with something extra and gave it to their
> developers (and they named the http counterpart that has the same
> extra HTTP://, of course).

True, though I am on the fence whether that is a property worth
maintaining. AFAIK it was not planned and is just a "this is how it
happened to work" case that is (IMHO) doing the wrong thing.

c.f. https://xkcd.com/1172/

Is this a hypothetical, or do you know of a $BIGCOMPANY that uses this?
The only similar case I know of is contrib/persistent-https, where we
realized the better way to do it is:

  [url "my-custom-ssh://"]
  insteadOf = ssh://

> If we probe for git-remote-SSH first and
> then fall back to git-remote-ssh, then we won't break these people,
> though.  I agree that it may be a good bite-sized #leftoverbit
> material.

This is probably a little tricky to implement, since there is no
git-remote-ssh, and we handle it internally in a totally separate
code path. So "probe for git-remote-SSH" is probably not "try to run
it", but really "search the PATH for something plausible". That may be
good enough.

It may also interact in a funny way with our allowed-protocol code, if
"SSH" gets a pass as "ssh" under the default config, but actually runs
the otherwise-disallowed git-remote-SSH (though one would _hope_ if you
have such a git-remote-SSH that it behaves just like an ssh remote).

> > We could probably also give an advise() message in the above output,
> > suggesting that the problem is likely one of:
> >
> >   1. They misspelled the scheme.
> >
> >   2. They need to install the appropriate helper.
> >
> > This may be a good topic for somebody looking for low-hanging fruit to
> > get involved in development (I'd maybe call it a #leftoverbits, but
> > since I didn't start on it, I'm not sure if it counts as "left over" ;)).
> [..]
> It may probably be a good idea to do an advice, but I'd think
> "Untable to find remote helper for 'SSH'" may be clear enough.  If
> anything, perhaps saying "remote helper for 'SSH' protocol" would
> make it even clear?  I dunno.

I think it doesn't help much if the user does not know what a remote
helper is, or why Git is looking for one. Though at least it gives a
term to start searching for, I guess. The original motivation for my
mail was the real-world report at:

  https://github.com/git/git-scm.com/issues/1219

-Peff
