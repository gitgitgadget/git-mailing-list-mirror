Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B72203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbdGXRYD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:24:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:47220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754390AbdGXRXh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:23:37 -0400
Received: (qmail 6800 invoked by uid 109); 24 Jul 2017 17:23:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 17:23:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10951 invoked by uid 111); 24 Jul 2017 17:23:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 13:23:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 13:23:35 -0400
Date:   Mon, 24 Jul 2017 13:23:35 -0400
From:   Jeff King <peff@peff.net>
To:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: Remove help advice text from git editors for interactive rebase
 and reword
Message-ID: <20170724172335.hcigpdzt4bewlk6w@sigill.intra.peff.net>
References: <241D60E0-1687-4DD8-A18C-CF7310DBFAEB@jetbrains.com>
 <xmqqshhmerf1.fsf@gitster.mtv.corp.google.com>
 <CEDBC0C9-03F7-4536-809C-9ADB8901B722@jetbrains.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CEDBC0C9-03F7-4536-809C-9ADB8901B722@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 01:26:09AM +0300, Kirill Likhodedov wrote:

> > Not at all interested, as that would mean your tool will tell its
> > users to set such a configuration variable and their interactive use
> > of Git outside your tool will behave differently from other people
> > who use vanilla Git, and they will complain to us.
> 
> That's not true, since the tool can (and would) use the `git -c
> config.var=value rebase -i` syntax to set the configuration variable
> just for this particular command, without affecting the environment.

Yes, but if you are adding a config variable that is only ever meant to
be used from the command line, it probably makes sense to just add a
command-line option.

> Btw, if my proposal is so uninteresting, why the existing advice.*
> variables were previously introduced? I don't know the motivation, but
> assume that it was about making Git less wordy for experienced users.
> So I don't see any difference here.

That is exactly what advice.* is for, but it is about the _user_
deciding that they don't care about seeing that text. Not a tool that is
calling Git deciding that in one particular context, it would like to
suppress the hint text.

So I actually would be OK with having an advice.* option to squelch
rebase and/or commit instructions. But only if users decide they would
never like to see that text. So yes, your tool could piggy-back on that
config option, but it would be a slight abuse of the intent.

> > But stepping back a bit, as you said in the parentheses, your tool
> > would need to grab these "hints" from Git, instead of having a
> > separate hardcoded hints that will go stale while the underlying Git
> > command improves, to be able to show them "separately".  
> 
> There is no need to call Git to get these "hints". They are quite
> obvious, well-known and can be hardcoded. However, I don't plan to use
> these hints anyway, since they are a bit foreign to the GUI of the
> tool I develop. For instance, for reword I'd like to show an editor
> containing just the plain commit message that the user is about to
> change.

If this is all scripted anyway, wouldn't it be an option to just process
the commit message in your program?  The format is well-known, with
hints and instructions on lines marked by core.commentChar ("#" by
default).

I'm not sure exactly of the flow in which the user sees the commit
message buffer (i.e., if you are invoking the editor yourself, or if you
are relying on git-commit to do so). But even in the latter case, you
can hook the editor invocation to do whatever you like. For example:

  GIT_EDITOR='f() { sed -i /^#/d "$1"; $EDITOR "$1"; }; f' git commit

That allows you not only to strip out the existing instructions, but to
insert whatever other instructions you choose.

-Peff
