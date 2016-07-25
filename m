Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8876C203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 08:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbcGYIn7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 04:43:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51348 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbcGYIn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 04:43:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B9AE203C1;
	Mon, 25 Jul 2016 08:43:57 +0000 (UTC)
Date:	Mon, 25 Jul 2016 08:43:57 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: escape "From " lines recognized by
 mailsplit
Message-ID: <20160725084357.GA8025@starla>
References: <20160722224739.GA22961@whir>
 <xmqqk2gb8q81.fsf@gitster.mtv.corp.google.com>
 <xmqqd1m3825y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1m3825y.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Eric Wong <e@80x24.org> writes:
> >
> >> Users have mistakenly copied "From " lines into commit messages
> >> in the past, and will certainly make the same mistakes in the
> >> future.  Since not everyone uses mboxrd, yet, we should at least
> >> prevent miss-split mails by always escaping "From " lines based
> >> on the check used by mailsplit.
> >>
> >> mailsplit will not perform unescaping by default, yet, as it
> >> could cause further invocations of format-patch from old
> >> versions of git to generate bad output.  Propagating the mboxo
> >> escaping is preferable to miss-split patches.  Unescaping may
> >> still be performed via "--mboxrd".
> >
> > As a tool to produce mbox file, quoting like this in format-patch
> > output may make sense, I would think, but shouldn't send-email undo
> > this when sending individual patches?
> 
> Also, doesn't it break "git rebase" (non-interactive), or anything
> that internally runs format-patch to individual files and then runs
> am on each of them, anything that knows that each output file from
> format-patch corresponds to a single change and there is no need to
> split, badly if we do this unconditionally?

Yes, rebase should probably unescape is_from_line matches.

Anything which spawns an editor should probably warn/reprompt
users on is_from_line() matches, too, to prevent user errors
from sneaking in.

> IOW, shouldn't this be an optional feature to format-patch that is
> triggered by passing a new command line option that currently nobody
> is passing?

I added --pretty=mboxrd as the optional feature for this reason.
It'll take a while for people to start using it (or perhaps make
it the default in git 3.0).
In the meantime, I would prefer extra ">" being injected rather
than breaking mailsplit completely.
