Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D08C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 03:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821C420724
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 03:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCXDwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:52:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:48962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727050AbgCXDwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 23:52:17 -0400
Received: (qmail 14725 invoked by uid 109); 24 Mar 2020 03:52:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Mar 2020 03:52:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20205 invoked by uid 111); 24 Mar 2020 04:02:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Mar 2020 00:02:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Mar 2020 23:52:16 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.26.0 - Test Results NonStop Platform
Message-ID: <20200324035216.GB51305@coredump.intra.peff.net>
References: <02d901d60159$94b3b250$be1b16f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02d901d60159$94b3b250$be1b16f0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 05:25:25PM -0400, Randall S. Becker wrote:

> On March 22, 2020 9:10 PM, Junio C Hamano wrote:
> > The latest feature release Git v2.26.0 is now available at the usual places.  It
> > is comprised of 504 non-merge commits since v2.25.0, contributed by 64
> > people, 12 of which are new faces.
> 
> We had t0301 fail again. This is run entirely within bash as we gave
> up on ksh. I need some advice on what to do here. It does look like
> this is actually in git rather than the tests, based on below.
> 
> What is really strange is that the subtests are transiently failing
> and not the same test each time. I cannot get any consistency during
> test runs. I also do not see anything in the differences that might
> account for this, unless somehow the unicode length. I did revert and
> retried the test, which also resulted in transient failures. It all
> works fine when I use -x, so I can't shed light on it from there. An
> example of the failure is:

t0301 is about credential-cache, which involves daemonizing a process
and talking to it over a unix socket. I could very well believe that
there is some portability weirdness there on an exotic platform.

In particular:

> --- expect-stdout       2020-03-23 20:40:57 +0000
> +++ stdout      2020-03-23 20:40:58 +0000
> @@ -1,4 +1,4 @@
>  protocol=https
>  host=example.com
> -username=askpass-username
> -password=askpass-password
> +username=store-user
> +password=store-pass
> not ok 21 - helper (cache) can forget host

The point of that test is to tell the cache daemon to throw away the
entry, which means the next "fill" should have to resort to askpass. But
clearly it doesn't.

The "forgetting" is all internal to the daemon, so I don't think we'd
have a bug there. But is it possible that the client wasn't able to
contact the daemon? It would consider that a success (if there is no
daemon, then everything is already forgotten). If that happens
intermittently (when there actually _is_ a cache daemon there), it would
explain the behavior you're seeing.

Maybe try a patch like this:

diff --git a/credential-cache.c b/credential-cache.c
index 1cccc3a0b9..26baf74332 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -78,6 +78,8 @@ static void do_cache(const char *socket, const char *action, int timeout,
 			spawn_daemon(socket);
 			if (send_request(socket, &buf) < 0)
 				die_errno("unable to connect to cache daemon");
+		} else {
+			die_errno("cache daemon not available");
 		}
 	}
 	strbuf_release(&buf);

That will cause tests 1 and 14 of t0301 to fail consistently, but
possibly it could shed some light if other tests fail with it, too.

-Peff
