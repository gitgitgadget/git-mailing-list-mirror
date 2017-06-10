Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46461FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdFJHNq (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 03:13:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbdFJHNp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 03:13:45 -0400
Received: (qmail 31385 invoked by uid 109); 10 Jun 2017 07:13:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 07:13:44 +0000
Received: (qmail 29126 invoked by uid 111); 10 Jun 2017 07:13:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 03:13:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 03:13:43 -0400
Date:   Sat, 10 Jun 2017 03:13:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive
 clone
Message-ID: <20170610071342.gdmpgjqlho2xfvdt@sigill.intra.peff.net>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
 <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
 <20170606181024.GA189073@google.com>
 <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
 <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net>
 <xmqqbmpw4mpo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmpw4mpo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2017 at 11:10:11AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In an ideal world the user do:
> >
> >   git submodule add git://host/repo.git path
> >
> > which adds the gitlink and the .gitmodules entry. But it doesn't seem
> > unreasonable for somebody unfamiliar with submodules to do:
> >
> >   git clone git://host/repo.git path
> >   git add path
> >
> > This does add the entry as a gitlink, but doesn't write any sort of
> > .gitmodules entry.
> 
> I actually would think that is a perfectly valid state.  In that
> original repository pair (i.e. the superproject with a submodule
> without an entry in .gitmodules), as long as the configuration in
> the submodule repository "path/.git/config" has necessary remote
> definitions, "git push/fetch --recursive" etc., should also be able
> to work without having to consult .gitmodules at the top-level
> superproject, I would think.

Certainly I think it _could_ be a valid state. But traditionally it
caused "clone --recursive" to barf. And from what Stefan and Brandon
have said, we are moving in the opposite direction entirely, with
.gitmodules becoming the source of truth.

I could see arguments for going in either direction (gitlinks versus
.gitmodules as source of truth for submodules). But it bothers me that
it's so easy to create a state that will behave in a confusing manner.

> But even in such a clone, once the user who cloned learns where the
> submodule commit that is recorded in the superproject's tree can be
> obtained out-of-band and makes a clone at "path" manually (which
> replicates the state the original repository pair), things that only
> need to look at "path/.git/config" should be able to work (e.g. "git
> fetch --recursive"), I'd say.

I agree that's possible. But I think one problem that our submodule
support has traditionally suffered from is leaving open what is possible
and not making any policy choices, or providing any guidance. Unless you
are an expert user who plans on circumventing the usual "git submodule"
process (and having your collaborators do so, too), I don't think you'd
ever want to do a "git add" as above. You want "git submodule add".

Allowing both is not in itself wrong.  But because we provide no
guidance for the expert route, it's easy to shoot yourself in the foot
and not even realize it. Which is why I suggested a warning and not
forbidding the operation. Or better still, an advise() block that tells
you how to recover (probably "git submodule add", though it might need
to learn to handle already-present gitlinks). And which can be disabled
if you really are an expert user.

-Peff
