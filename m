Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0821F462
	for <e@80x24.org>; Tue, 28 May 2019 21:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfE1VEa (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 17:04:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:40452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727273AbfE1VEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 17:04:30 -0400
Received: (qmail 4797 invoked by uid 109); 28 May 2019 21:04:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 21:04:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18086 invoked by uid 111); 28 May 2019 21:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 17:05:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 17:04:28 -0400
Date:   Tue, 28 May 2019 17:04:28 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] bundle verify: error out if called without an object
 database
Message-ID: <20190528210428.GE24650@sigill.intra.peff.net>
References: <pull.226.git.gitgitgadget@gmail.com>
 <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
 <20190528015133.GA29724@sigill.intra.peff.net>
 <xmqqftoy1h4h.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqftoy1h4h.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 01:03:26PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As Gábor noted in the earlier thread, if the bundle doesn't have any
> > prerequisites, this _used_ to work before b1ef400eec (setup_git_env:
> > avoid blind fall-back to ".git", 2016-10-20). I don't know if anybody
> > cares about that case or not, but we could do something like:
> >
> >   if (p->nr)
> > 	verify_prerequisites();
> >
> >   /* otherwise, fall through to the printing portions */
> >
> > and then just check for a repository in verify_prerequisites(), which is
> > the only part that needs to look at the repository object at all.
> 
> It depends on how important we consider the use of bundles that can
> be cloned from.  If it is important enough, what you suggest is an
> improvement worth doing over what Dscho did.
> 
> A bundle that can be cloned from (i.e. no prerequisite) is meant to
> be used without having any repository by definition, so it is a
> grave regression to require object store when verifying such a
> bundle.
> 
> On the other hand, a bundle that cannot be cloned from but only
> usabel for an incremental sneaker-net update needs receiving
> repository anyway, so it is perfectly fine to require object store.

I was thinking this was matters only for "bundle verify", which is not
all that interesting (either you can clone from it, or you cannot).

It is also used as part of unbundle(), which is called from the
transport code. But at that point of a clone, we'd already have created
the new repository we're writing into. I.e., "git clone .../foo.bundle"
still works fine either way.

So I guess you are asking only about the part that I dismissed above as
"not all that interesting". I.e., do people actually run:

  git bundle verify foo.bundle &&
  git clone foo.bundle

That is not nonsense, per-se, but it is somewhat pointless since the
clone will verify the bundle itself anyway. But then, I guess I do not
see much point in anyone calling "bundle verify" in the first place.

-Peff
