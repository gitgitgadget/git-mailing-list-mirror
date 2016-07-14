Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7507020196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbcGNSk0 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:40:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:44798 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751161AbcGNSkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:40:25 -0400
Received: (qmail 9516 invoked by uid 102); 14 Jul 2016 18:40:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:40:24 -0400
Received: (qmail 7073 invoked by uid 107); 14 Jul 2016 18:40:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:40:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 14:40:21 -0400
Date:	Thu, 14 Jul 2016 14:40:21 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] mingw: fix regression in t1308-config-set
Message-ID: <20160714184021.GD16497@sigill.intra.peff.net>
References: <6f439a56703ca6fb5c269c75904796ae67e96960.1468504461.git.johannes.schindelin@gmx.de>
 <xmqqr3awry5x.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3awry5x.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 09:18:18AM -0700, Junio C Hamano wrote:

> I added a few missing Cc: and quoted the whole patch here to those
> who were involved; I think this update is correct, but just trying
> to make sure people know.
> 
> Not limited to this particular topic, there probably are some things
> we can and should add to the procedure to prevent further episodes
> like this, but I am not seeing anything immediately obvious offhand.
> There already is a way to prominently mark a topic to be not-ready
> with an outstanding issue called "What's cooking" report, but it is
> maintained manually and it can be leaky without extra set of eyes
> constantly monitoring.

Thanks, this fix looks good.

I'm open to to suggestions to make life easier for Windows folks.
Usually when dealing with paths, the suggestion is to use $(pwd), which
I did in the original, but as 58461bd noted, that broke other cases.

So code-wise, maybe this technique could be more general. I.e., could
$TRASH_DIRECTORY or $HOME already be in whatever format is likely to be
produced by git on the platform? Or does that just screw things up more
because Windows sometimes needs one form and sometimes the other?

Process-wise, I'm not sure. I seem to recall a few times when Windows
issues have come up in the past that somebody (JSixt?) seemed content to
let topics graduate with potential portability problems, and then have
the Git for Windows project fix them up separately. These days GfW seems
to track upstream more closely (which is wonderful!), but it means
portability problems cause a more immediate headache and slow down that
process.

> > 	Side note: it was not at all clear to me how 58461bd fixed the
> > 	problem by replacing $(pwd) with $HOME, given that HOME is set to
> > 	$TRASH_DIRECTORY which is set to $TEST_OUTPUT_DIRECTORY/... after
> > 	TEST_OUTPUT_DIRECTORY was set to TEST_DIRECTORY which in turn was
> > 	set to $(pwd).
> >
> > 	I guess the reason is that -P in `cd -P "$TRASH DIRECTORY"`, but
> > 	then I *really* do not understand how $(pwd) and $PWD could
> > 	disagree.

I don't think they did disagree. The issue is that "cd -P" caused _both_
of them to print the physical directory. But git is not using either of
them. It is blindly using "$HOME". So basically:

  HOME=/path/with/symlinks
  cd -P "$HOME"

will cause "$PWD" and "$HOME" to disagree. Likewise with "$(pwd)" and
"$HOME".

-Peff
