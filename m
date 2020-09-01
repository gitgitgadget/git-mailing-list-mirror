Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8B2C43461
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 04:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56697206EB
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 04:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIAEt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:49:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:45946 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAEt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 00:49:56 -0400
Received: (qmail 23924 invoked by uid 109); 1 Sep 2020 04:49:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2020 04:49:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23467 invoked by uid 111); 1 Sep 2020 04:49:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2020 00:49:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Sep 2020 00:49:54 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/2] credential-cache: use child_process.args
Message-ID: <20200901044954.GB3956172@coredump.intra.peff.net>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com>
 <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
 <xmqqpn76e873.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn76e873.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 31, 2020 at 03:56:00PM -0700, Junio C Hamano wrote:

> > -	argv[0] = "git-credential-cache--daemon";
> > -	argv[1] = socket;
> > -	daemon.argv = argv;
> > +	strvec_pushl(&daemon.args, 
> > +		     "credential-cache--daemon", socket,
> > +		     NULL);
> > +	daemon.git_cmd = 1;
> >  	daemon.no_stdin = 1;
> >  	daemon.out = -1;
> >  
> 
> By the way, an interesting fact is that this cannot graduate UNTIL
> credential-cache becomes a built-in.  Having an intermediate level
> process seems to break t0301.

Hmm, that is interesting. I thought it would work OK because we don't
rely on any process-id magic for finding the daemon, etc, and instead
talk over pipe descriptors. But that proves to be our undoing.

What happens usually is this:

  - credential-cache spawns credential-cache--daemon with its
    stdout connected to a pipe

  - the client calls read_in_full() waiting for the daemon to tell us
    that it started up

  - the daemon opens the socket, then writes "ok\n" to stdout and closes
    the pipe

  - the client gets EOF on the pipe, then compares what it read to
    "ok\n", and continues (or relays an error)

But when we add the extra "git" wrapper process into the mix, we never
see that EOF. The wrapper's stdout also points to that pipe, so closing
it in the daemon process isn't enough for the client to get EOF. And the
wrapper doesn't exit, because it's waiting on the daemon.

So one hacky fix is:

diff --git a/credential-cache.c b/credential-cache.c
index 04df61cf02..9bfddaf050 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -51,7 +51,7 @@ static void spawn_daemon(const char *socket)
 
 	if (start_command(&daemon))
 		die_errno("unable to start cache daemon");
-	r = read_in_full(daemon.out, buf, sizeof(buf));
+	r = read_in_full(daemon.out, buf, 3);
 	if (r < 0)
 		die_errno("unable to read result code from cache daemon");
 	if (r != 3 || memcmp(buf, "ok\n", 3))

which makes t0301 pass. A less-hacky solution might be to loosen its
expectations not to require EOF at all (and just accept anything
starting with "ok\n". But I don't think it's worth doing either, if we
know we're going to switch it to a builtin anyway (and that also makes
me feel slightly better about the plan to do so).

I do wonder if it points to a problem in the git.c wrapper. It's
duplicating all of the descriptors that the child external commands will
see, so callers can't rely on EOF (or EPIPE for its stdin) to know when
the external program has closed them. For the most part that's OK,
because we expect them to close when the external program exits, at
which point the wrapper will exit, too. But things get weird around
half-duplex shutdowns, or programs that try to daemonize.

Perhaps git.c should be closing all descriptors after spawning the
child. Of course that gets weird if it wants to write an error to stderr
about spawning the child. I dunno. It seems as likely to introduce
problems as solve them, so if nothing is broken beyond this cache-daemon
thing, I'd just as soon leave it.

I wouldn't be surprised if older pre-builtin "upload-pack" could run
into problems. But we always called it as "git-upload-pack" back then
anyway. Possibly modern "git daemon" could suffer weirdness, as it's
still a separate program (I shied away from including it in my recent
"slimming" series exactly because I was afraid of these kinds of issues;
but it sounds like being a builtin probably has less-surprising
implications overall).

All of which is to say I'm happy to do nothing, but that turned out to
be a very interesting data point. Thanks for mentioning it. :)

-Peff
