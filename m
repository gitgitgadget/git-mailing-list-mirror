Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13501F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbcG2SwP (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:52:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:51288 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750834AbcG2SwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:52:14 -0400
Received: (qmail 7893 invoked by uid 102); 29 Jul 2016 18:52:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:52:14 -0400
Received: (qmail 4585 invoked by uid 107); 29 Jul 2016 18:52:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:52:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:52:11 -0400
Date:	Fri, 29 Jul 2016 14:52:11 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
Message-ID: <20160729185211.GA5591@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
 <20160729181121.GB14953@sigill.intra.peff.net>
 <xmqq60ronvlj.fsf@gitster.mtv.corp.google.com>
 <20160729183911.GA10268@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160729183911.GA10268@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 02:39:11PM -0400, Jeff King wrote:

> From my limited testing, "git pull --rebase" is perfectly fine. The
> culprit is "--rebase=preverse", which complains even if it would be a
> fast-forward.

That should be preserve, of course. :)

And I think I see what is happening. "preserve" implies
interactive-rebase, which makes an early check that we have valid
committer info, even though we might not actually write any new commits.

So doing this:

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index ded4595..f0f4777 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1180,9 +1180,6 @@ To continue rebase after editing, run:
 	;;
 esac
 
-git var GIT_COMMITTER_IDENT >/dev/null ||
-	die "$(gettext "You need to set your committer info first")"
-
 comment_for_reflog start
 
 if test ! -z "$switch_to"

fixes it for me. I can't figure out if that would have any bad side
effects, though. That check comes from Dscho's original 1b1dce4 (Teach
rebase an interactive mode, 2007-06-25), so there's not much comment on
why it was added specifically.

We would notice the bogus ident later when we actually do try to create
a commit object, but I can guess that this up-front check might give us
a better error message. You get warned up-front, rather than something
like:

  Rebasing (1/1)
  *** Please tell me who you are.
  [...]
  fatal: no name was given and auto-detection is disabled
  Could not pick 8ebea123853128ca2411b2b449f76a1a4b0d026c

and dumped in the middle of an interactive rebase that you cannot
complete. OTOH, that is how a regular non-interactive merge works. And
if your next step is to set up your ident, then it's natural to do:

  git config user.email whatever
  git rebase --continue

So I'd lean towards dropping it, but maybe there are other hidden
gotchas.

-Peff
