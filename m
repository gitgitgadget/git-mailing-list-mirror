Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5630F1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 17:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeDORTC (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 13:19:02 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:1334 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbeDORTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 13:19:01 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Apr 2018 13:19:01 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EUBQAihtNa/wsxuIZchU6DR4knjicUe?=
 =?us-ascii?q?5RjC4UDAoJPNxUBAgEBAQEBAQICAmgohSMBAQEBAgEnEz8QCxgJJQ8FKCGFGAi?=
 =?us-ascii?q?mRzOEV4Nkgi+JWj+EGogjgiQCkGGHAwiOMIdDhROQH4ElMiOBUk0gGIJ/gh8Xj?=
 =?us-ascii?q?hk9jE8Ggj8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EUBQAihtNa/wsxuIZchU6DR4knjicUe5RjC4UDAoJPNxU?=
 =?us-ascii?q?BAgEBAQEBAQICAmgohSMBAQEBAgEnEz8QCxgJJQ8FKCGFGAimRzOEV4Nkgi+JW?=
 =?us-ascii?q?j+EGogjgiQCkGGHAwiOMIdDhROQH4ElMiOBUk0gGIJ/gh8Xjhk9jE8Ggj8BAQ?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 15 Apr 2018 19:08:59 +0200
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1f7l99-00083d-88; Sun, 15 Apr 2018 19:08:59 +0200
Date:   Sun, 15 Apr 2018 19:08:59 +0200
From:   Kim Gybels <kgybels@infogroep.be>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] daemon: use timeout for uninterruptible poll
Message-ID: <20180415170859.GA30197@infogroep.be>
References: <20180412210757.7792-1-kgybels@infogroep.be>
 <20180412210757.7792-2-kgybels@infogroep.be>
 <nycvar.QRO.7.76.6.1804131433250.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1804131433250.65@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (13/04/18 14:36), Johannes Schindelin wrote:
> > The poll provided in compat/poll.c is not interrupted by receiving
> > SIGCHLD. Use a timeout for cleaning up dead children in a timely manner.
> 
> Maybe say "When using this poll emulation, use a timeout ..."?

I will rewrite the commit message when I reroll the patch. Calling the
poll "uninterruptible" might be wrong as well, although the poll
doesn't return with EINTR when a child process terminates, it might
still be interruptible in other ways. On a related note, the handler
for SIGCHLD is simply not called in Git-for-Windows' daemon.

> > diff --git a/daemon.c b/daemon.c
> > index fe833ea7de..6dc95c1b2f 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1147,6 +1147,7 @@ static int service_loop(struct socketlist *socklist)
> >  {
> >  	struct pollfd *pfd;
> >  	int i;
> > +	int poll_timeout = -1;
> 
> Just reuse the line above:
> 
> 	int poll_timeout = -1, i;

Sure.

> > @@ -1161,8 +1162,13 @@ static int service_loop(struct socketlist *socklist)
> >  		int i;
> >  
> >  		check_dead_children();
> > -
> > -		if (poll(pfd, socklist->nr, -1) < 0) {
> > +#ifdef NO_POLL
> > +		poll_timeout = live_children ? 100 : -1;
> > +#endif
> > +		int ret = poll(pfd, socklist->nr, poll_timeout);
> > +		if  (ret == 0) {
> > +			continue;
> > +		} else if (ret < 0) {
> 
> I would find it a bit easier on the eyes if this did not use curlies, and
> dropped the unnecessary `else` (`continue` will take care of that):
> 
> 		if (!ret)
> 			continue;
> 		if (ret < 0)
> 			[...]

Funny, that's how I would normally write it, if I wasn't so focused on
trying to follow the coding quidelines. While I'm at it, I will also
fix that sneaky double space after the if.

Is it ok to add the timeout for all platforms using the poll
emulation, since I only tested for Windows?

Best regards,
Kim
