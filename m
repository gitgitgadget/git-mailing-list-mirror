Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8228E20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdFXMgm (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:36:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750817AbdFXMgl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:36:41 -0400
Received: (qmail 2125 invoked by uid 109); 24 Jun 2017 12:36:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:36:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23598 invoked by uid 111); 24 Jun 2017 12:36:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:36:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:36:39 -0400
Date:   Sat, 24 Jun 2017 08:36:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2] die(): stop hiding errors due to overzealous
 recursion guard
Message-ID: <20170624123639.scagiuzqalfr72fz@sigill.intra.peff.net>
References: <87podz8v6v.fsf@gmail.com>
 <20170621204742.15722-1-avarab@gmail.com>
 <xmqq1sqdni1r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1sqdni1r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 02:32:16PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > So let's just set the recursion limit to a number higher than the
> > number of threads we're ever likely to spawn. Now we won't lose
> > errors, and if we have a recursing die handler we'll still die within
> > microseconds.
> >
> > There are race conditions in this code itself, in particular the
> > "dying" variable is not thread mutexed, so we e.g. won't be dying at
> > exactly 1024, or for that matter even be able to accurately test
> > "dying == 2", see the cases where we print out more than one "W"
> > above.
> 
> One case I'd be worried about would be that the race is so bad that
> die-is-recursing-builtin never returns 0 even once.  Everybody will
> just say "recursing" and die, without giving any useful information.

I was trying to think how that would happen. If nobody's actually
recursing indefinitely, then the value in theory peaks at the number of
threads (modulo the fact that we're modifying a variable from multiple
threads without any locking; I'm not sure how reasonable it is to assume
in practice that sheared writes may cause us to lose an increment but
not to put nonsense in to the variable). If they are, then one thread
may increment it to 1024 before another thread gets a chance to say
anything. But in that case, the recursion-die is our expected outcome.

Anyway, it might be reasonable to protect the counter with a mutex.
Like:

diff --git a/usage.c b/usage.c
index fc2b31c54b..34fef0f9fa 100644
--- a/usage.c
+++ b/usage.c
@@ -44,9 +44,19 @@ static void warn_builtin(const char *warn, va_list params)
 	vreportf("warning: ", warn, params);
 }
 
+#ifndef NO_PTHREADS
+static pthread_mutex_t recursion_mutex = PTHREAD_MUTEX_INITIALIZER;
+#define recursion_lock() pthread_mutex_lock(&recursion_mutex)
+#define recursion_unlock() pthread_mutex_unlock(&recursion_mutex)
+#else
+#define recursion_lock()
+#define recursion_unlock()
+#endif
+static int recursion_counter;
+
 static int die_is_recursing_builtin(void)
 {
-	static int dying;
+	int dying;
 	/*
 	 * Just an arbitrary number X where "a < x < b" where "a" is
 	 * "maximum number of pthreads we'll ever plausibly spawn" and
@@ -55,7 +65,10 @@ static int die_is_recursing_builtin(void)
 	 */
 	static const int recursion_limit = 1024;
 
-	dying++;
+	recursion_lock();
+	dying = ++recursion_counter;
+	recursion_unlock();
+
 	if (dying > recursion_limit) {
 		return 1;
 	} else if (dying == 2) {

I can't remember if there are problems on Windows with using constant
mutex initializers, though. If so, I guess common-main would have to
initialize it.

I left the rest of the logic as-is, but if we switched to post-increment:

  dying = recursion_counter++;

then I think the numbers around "dying" would make more sense (e.g.,
"dying == 2" would make more sense to me as "dying == 1" to check that
we were already dying).

To be honest, I'm not sure if it's worth giving it much more time,
though. I'd be fine with Ævar's patch as-is.

-Peff
