Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75891F858
	for <e@80x24.org>; Thu, 28 Jul 2016 21:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcG1V4I (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 17:56:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:50621 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751377AbcG1V4I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 17:56:08 -0400
Received: (qmail 6468 invoked by uid 102); 28 Jul 2016 21:56:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 17:56:07 -0400
Received: (qmail 28863 invoked by uid 107); 28 Jul 2016 21:56:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 17:56:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 17:56:03 -0400
Date:	Thu, 28 Jul 2016 17:56:03 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160728215603.GA22865@sigill.intra.peff.net>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 02:37:04PM -0700, Junio C Hamano wrote:

> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > I'd like to propose changing the default behavior of git-format-patch to
> > --from (and adding a --from-author option to override, and perhaps a
> > config setting).  This will not change the output *except* when
> > formatting patches authored by someone else.  git-am and git-send-email
> > both handle the --from format without any issues.
> 
> I see this in "format-patch --help":
> 
>            Note that this option is only useful if you are actually
>            sending the emails and want to identify yourself as the
>            sender, but retain the original author (and git am will
>            correctly pick up the in-body header).  Note also that
>            git send-email already handles this transformation for
>            you, and this option should not be used if you are
>            feeding the result to git send-email.
> 
> The first one says "only useful", but it seems what it really means
> is "it becomes no-op if you are sending your own patch anyway".  So
> that one does not worry me.  What is most worrysome is the latter
> half of the last sentence.  Is it really "should not be", or is it
> merely "use of this option is just a waste of time, as you would get
> exactly the same result anyway"?  If it is the latter, that is fine.

It does what you want, and omits the in-body header when it would be
redundant.

I think the original reason I did not make "--from" the default is that
I was worried about breaking consumers which do not know how to handle
in-body headers. "git am" knows how to handle them, but if you have a
one-off script that parses only the mail headers, it will start
claiming you as the author of every patch.

E.g., if you do:

  git format-patch -o output ...
  grep -hm1 ^From: output/*

right now that gets you a list of patch authors. With "--from", it would
return your name N times.

That's obviously a toy, but I wonder if people have scripts which behave
similarly.

Another way to think about it is that "--from" is a no-brainer when you
really are going to email the patches (and that's why it is has always
been the default behavior in git-send-email). But if you _aren't_ going
to mail the patches, retaining the original headers is more convenient.
It's not clear to me how many non-mail users of format-patch there are
(certainly rebase is one of them, but because it uses "am" on the
receiving side, I think everything should Just Work).

-Peff
