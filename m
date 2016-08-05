Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980412018E
	for <e@80x24.org>; Fri,  5 Aug 2016 07:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759523AbcHEH7B (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 03:59:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:55145 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759178AbcHEH6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 03:58:42 -0400
Received: (qmail 10415 invoked by uid 102); 5 Aug 2016 07:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:58:43 -0400
Received: (qmail 24004 invoked by uid 107); 5 Aug 2016 07:59:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 03:59:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 03:58:38 -0400
Date:	Fri, 5 Aug 2016 03:58:38 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 6/7] trace: disable key after write error
Message-ID: <20160805075838.zkwoyorvdc4ljn6l@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
 <20160803230103.daexq233ufrttnmn@sigill.intra.peff.net>
 <xmqq8twc1cx4.fsf@gitster.mtv.corp.google.com>
 <20160804212244.cilov7i2uelg7lnh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160804212244.cilov7i2uelg7lnh@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 05:22:44PM -0400, Jeff King wrote:

> On Thu, Aug 04, 2016 at 01:45:11PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > If we get a write error writing to a trace descriptor, the
> > > error isn't likely to go away if we keep writing. Instead,
> > > you'll just get the same error over and over. E.g., try:
> > >
> > >   GIT_TRACE_PACKET=42 git ls-remote >/dev/null
> > >
> > > You don't really need to see:
> > >
> > >   warning: unable to write trace for GIT_TRACE_PACKET: Bad file descriptor
> > >
> > > hundreds of times. We could fallback to tracing to stderr,
> > > as we do in the error code-path for open(), but there's not
> > > much point. If the user fed us a bogus descriptor, they're
> > > probably better off fixing their invocation. And if they
> > > didn't, and we saw a transient error (e.g., ENOSPC writing
> > > to a file), it probably doesn't help anybody to have half of
> > > the trace in a file, and half on stderr.
> > 
> > Yes, I think I like this better than "we cannot open the named file,
> > so let's trace into standard error stream" that is done in the code
> > in the context of [3/7].  We should do the same over there.
> 
> Yeah, I was tempted to strip that out, too. I'll look into preparing a
> patch on top.

Here's a patch that can go on the tip of jk/trace-fixup.

-- >8 --
Subject: [PATCH] trace: do not fall back to stderr

If the trace code cannot open a specified file, or does not
understand the contents of the GIT_TRACE variable, it falls
back to printing trace output to stderr.

This is an attempt to be helpful, but in practice it just
ends up annoying. The user was trying to get the output to
go somewhere else, so spewing it to stderr does not really
accomplish that. And as it's intended for debugging, they
can presumably re-run the command with their error
corrected.

So instead of falling back, this patch disables bogus trace
keys for the rest of the program, just as we do for write
errors. We can drop the "Defaulting to..." part of the error
message entirely; after seeing "cannot open '/foo'", the
user can assume that tracing is skipped.

Signed-off-by: Jeff King <peff@peff.net>
---
 trace.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/trace.c b/trace.c
index 083eb98..7508aea 100644
--- a/trace.c
+++ b/trace.c
@@ -61,10 +61,9 @@ static int get_trace_fd(struct trace_key *key)
 	else if (is_absolute_path(trace)) {
 		int fd = open(trace, O_WRONLY | O_APPEND | O_CREAT, 0666);
 		if (fd == -1) {
-			warning("could not open '%s' for tracing: %s\n"
-				"         Defaulting to tracing on stderr...",
+			warning("could not open '%s' for tracing: %s",
 				trace, strerror(errno));
-			key->fd = STDERR_FILENO;
+			trace_disable(key);
 		} else {
 			key->fd = fd;
 			key->need_close = 1;
@@ -72,10 +71,9 @@ static int get_trace_fd(struct trace_key *key)
 	} else {
 		warning("unknown trace value for '%s': %s\n"
 			"         If you want to trace into a file, then please set %s\n"
-			"         to an absolute pathname (starting with /)\n"
-			"         Defaulting to tracing on stderr...",
+			"         to an absolute pathname (starting with /)",
 			key->key, trace, key->key);
-		key->fd = STDERR_FILENO;
+		trace_disable(key);
 	}
 
 	key->initialized = 1;
-- 
2.9.2.707.g48ee8b7

