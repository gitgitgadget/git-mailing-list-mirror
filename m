Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B211F404
	for <e@80x24.org>; Wed, 29 Aug 2018 23:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH3D3o (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 23:29:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:33208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727149AbeH3D3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 23:29:44 -0400
Received: (qmail 25840 invoked by uid 109); 29 Aug 2018 23:30:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 23:30:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20489 invoked by uid 111); 29 Aug 2018 23:30:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 19:30:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 19:30:26 -0400
Date:   Wed, 29 Aug 2018 19:30:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org,
        rpeterso@redhat.com
Subject: Re: [RFC] revision: Don't let ^<rev> cancel out the default <rev>
Message-ID: <20180829233026.GA15005@sigill.intra.peff.net>
References: <20180829200553.19379-1-agruenba@redhat.com>
 <xmqqin3s94vf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqin3s94vf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 02:03:34PM -0700, Junio C Hamano wrote:

> Andreas Gruenbacher <agruenba@redhat.com> writes:
> 
> > Some commands like 'log' default to HEAD if no other revisions are
> > specified on the command line or otherwise.  Unfortunately, excludes
> > (^<rev>) cancel out that default, so when a command only excludes
> > revisions (e.g., 'git log ^origin/master'), the command will not produce
> > any result.
> >
> > If all the specified revisions are excludes, it seems more useful to
> > stick with the default revision instead.
> >
> > This makes writing wrappers that exclude certain revisions much easier:
> > for example, a simple alias l='git log ^origin/master' will show the
> > revisions between origin/master and HEAD by default, and 'l foo' will
> > show the revisions between origin/master and foo, as you would usually
> > expect.
> 
> That is a _huge_ departure from the behaviour established for the
> past 10 years, but it would certainly be more useful.
> 
> As long as we can prove that that a command line with only negative
> revs is absolutely useless, the backward incompatibility may be OK
> to swallow, especially for commands like "git log" that implicitly
> use "--default HEAD", as they are meant for human consumption, and
> not for scripts.
> 
> I am not offhand 100% sure that a rev list with only negative revs
> is totally useless, though.

Yeah, I'm uneasy that somebody is relying on the current behavior,
especially for scripting where we often do something like:

  git rev-list $new --not --all

and an empty $new really should return an empty result (that's our usual
connectivity check, but I'd imagine some pre-receive hooks may end up
doing similar things). For rev-list I think you'd have to specify
--default to trigger this behavior, so that helps. But it still makes me
nervous.

I'm _less_ uneasy with it for git-log, though I think people do have a
habit of scripting around it (because it knows some tricks that rev-list
doesn't).

Given that the mentioned use case was writing wrappers, could we hide
this behind:

  git config alias.l 'git log --default-on-negative ^origin/master'

That's obviously less convenient to type, but I think it would usually
be part of scripted calls (otherwise you'd know already that you have no
positive refs and would just add ".." or HEAD or whatever).

-Peff
