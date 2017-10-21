Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA06202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 03:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbdJUDfh (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 23:35:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752664AbdJUDfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 23:35:36 -0400
Received: (qmail 4311 invoked by uid 109); 21 Oct 2017 03:35:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 03:35:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21807 invoked by uid 111); 21 Oct 2017 03:35:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 23:35:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 23:35:34 -0400
Date:   Fri, 20 Oct 2017 23:35:34 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/4] fsmonitor: Delay updating state until after split
 index is merged
Message-ID: <20171021033534.pgjtyiwlhvheuueo@sigill.intra.peff.net>
References: <20171020011136.14170-1-alexmv@dropbox.com>
 <05670bb6e3c6378119b1649144c80dd6d72bfe29.1508461850.git.alexmv@dropbox.com>
 <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710201503380.40514@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 03:16:20PM +0200, Johannes Schindelin wrote:

> >  void tweak_fsmonitor(struct index_state *istate)
> >  {
> > +	int i;
> > +
> > +	if (istate->fsmonitor_dirty) {
> > +		/* Mark all entries valid */
> > +		trace_printf_key(&trace_fsmonitor, "fsmonitor is enabled; cache is %d", istate->cache_nr);
> 
> Sadly, a call to trace_printf_key() is not really a noop when tracing is
> disabled. The call to trace_printf_key() hands off to trace_vprintf_fl(),
> which in turn calls prepare_trace_line() which asks trace_want() whether
> we need to trace, which finally calls get_trace_fd(). This last function
> initializes a trace key if needed, and this entire call stack takes time.

It seems like we could pretty easily turn noop traces into a trivial
conditional, like:

diff --git a/trace.h b/trace.h
index 179b249c59..c46b92cbde 100644
--- a/trace.h
+++ b/trace.h
@@ -80,8 +80,11 @@ extern void trace_performance_since(uint64_t start, const char *format, ...);
 #define trace_printf(...) \
 	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
 
-#define trace_printf_key(key, ...) \
-	trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__)
+#define trace_printf_key(key, ...) do { \
+	if (!key->initialized || key->fd) \
+		trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__) \
+} while(0)
+
 
 #define trace_argv_printf(argv, ...) \
 	trace_argv_printf_fl(TRACE_CONTEXT, __LINE__, argv, __VA_ARGS__)


(OK, that's got an OR, but if we are really pinching instructions we
could obviously store a single "I've been initialized and am disabled"
flag).

I don't have an opinion one way or the other on these particular
messages, but in general I'd like to see _more_ tracing in Git, not
less. I've often traced Git with a debugger or other tools like perf,
but there's real value in the author of code annotating high-level
logical events.

-Peff
