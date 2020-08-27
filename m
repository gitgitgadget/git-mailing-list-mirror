Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A929C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140532080C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgH0EWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:22:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:42198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgH0EWf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:22:35 -0400
Received: (qmail 13156 invoked by uid 109); 27 Aug 2020 04:22:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 04:22:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22368 invoked by uid 111); 27 Aug 2020 04:22:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 00:22:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 00:22:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/2] credential-cache: use child_process.args
Message-ID: <20200827042234.GD3346457@coredump.intra.peff.net>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com>
 <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <20200827041328.GA3346457@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827041328.GA3346457@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 12:13:28AM -0400, Jeff King wrote:

> On Wed, Aug 26, 2020 at 02:37:39PM -0700, Junio C Hamano wrote:
> 
> > diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
> > index d0fafdeb9e..195335a783 100644
> > --- a/builtin/credential-cache.c
> > +++ b/builtin/credential-cache.c
> > @@ -42,13 +42,13 @@ static int send_request(const char *socket, const struct strbuf *out)
> >  static void spawn_daemon(const char *socket)
> >  {
> >  	struct child_process daemon = CHILD_PROCESS_INIT;
> > -	const char *argv[] = { NULL, NULL, NULL };
> >  	char buf[128];
> >  	int r;
> >  
> > -	argv[0] = "git-credential-cache--daemon";
> > -	argv[1] = socket;
> > -	daemon.argv = argv;
> > +	strvec_pushl(&daemon.args, 
> > +		     "credential-cache--daemon", socket,
> > +		     NULL);
> > +	daemon.git_cmd = 1;
> 
> Yep, this makes sense. I don't recall any reason to use the dashed form
> back then, but probably it was just that I knew it was a separate
> program. Doing it this way will mean an extra parent "git" process
> hanging around, but I don't think it's that big a deal. We never try to
> kill it by PID, etc (instead we connect to the socket and ask it to
> exit). And anyway, it is becoming a builtin in a parallel topic, so that
> extra process will go away. :)

...and if I had read the diff header more carefully, I'd see that you
did this on top of that topic. :)

-Peff
