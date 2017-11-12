Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE97E201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 14:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdKLORm (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 09:17:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:53932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751360AbdKLORl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 09:17:41 -0500
Received: (qmail 31765 invoked by uid 109); 12 Nov 2017 14:17:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 14:17:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15011 invoked by uid 111); 12 Nov 2017 14:17:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 09:17:53 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 14:17:38 +0000
Date:   Sun, 12 Nov 2017 14:17:38 +0000
From:   Jeff King <peff@peff.net>
To:     gennady.kupava@gmail.com
Cc:     git@vger.kernel.org, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH] Reduce performance penalty for turned off traces
Message-ID: <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
References: <20171111192858.27255-1-gennady.kupava@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171111192858.27255-1-gennady.kupava@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 07:28:58PM +0000, gennady.kupava@gmail.com wrote:

> From: Gennady Kupava <gkupava@bloomberg.net>
> 
> Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>

Thanks, and welcome to the list.

> ---
> One of the tasks siggested in scope of 'Git sprint weekend'.
> Couple of chioces made here:

These kinds of choices/caveats (along with the motivation for the patch)
should go into the commit message so people running "git log" later can
see them.

>  1. Use constant instead of NULL to indicate default trace level, this just
> makes everything simpler.

I think this makes sense, as we were translating NULL into this default
struct behind the scenes already. As we discussed off-list, this does
mean that you can no longer do:

  trace_printf_key(NULL, "foo");

to send to the default key, and instead must do:

  trace_printf("foo");

The second one has always been the preferred way of spelling it, but the
first one happened to work. So the only fallout would be if somebody is
using the non-preferred method, they'd now segfault. There aren't any
such calls in the current code base, though, and I find it rather
unlikely that there would be new instances in topics other people are
working on.

I think it may be worth splitting that out into a separate preparatory
patch to make it more clear what's going on (especially if our
assumption turns out wrong and somebody does end up tracing a problem
back to it).

>  2. Move just enough from implementation to header, to be able to do check
> before calling actual functions.

Makes sense.

>  3. Most controversail: do not support optimization for older
>     compilers not supporting variadic templates in macroses. Problem
>     is that theoretically someone may write some complicated trace
>     while would work in 'modern' compiler and be too slow in more
>     'classic' compilers, however expectation is that risk of that is
>     quite low and 'classic' compilers will go away eventually.

I think this is probably acceptable. I know we've discussed elsewhere
recently how common such compilers actually are, and whether we could
give up on them altogether.

If we wanted to, we could support that case by using inline functions in
the header (though it does make me wonder if compilers that old also do
not actually end up inlining).

I did manually disable HAVE_VARIADIC_MACROS and confirmed that the
result builds and passes the test suite (though I suspect that GIT_TRACE
is not well exercised by the suite).

> diff --git a/trace.c b/trace.c
> index 7508aea02..180ee3b00 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -25,26 +25,14 @@
>  #include "cache.h"
>  #include "quote.h"
>  
> -/*
> - * "Normalize" a key argument by converting NULL to our trace_default,
> - * and otherwise passing through the value. All caller-facing functions
> - * should normalize their inputs in this way, though most get it
> - * for free by calling get_trace_fd() (directly or indirectly).
> - */
> -static void normalize_trace_key(struct trace_key **key)
> -{
> -	static struct trace_key trace_default = { "GIT_TRACE" };
> -	if (!*key)
> -		*key = &trace_default;
> -}
> +struct trace_key trace_default_key = { TRACE_KEY_PREFIX, 0, 0, 0 };

Makes sense. We no longer auto-normalize, but just expect the
appropriate functions to pass a pointer to the default key themselves.

> +struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);

This change was unexpected, but I think you just moved this up to keep
all the pre-declared structs together. Makes sense.

>  /* Get a trace file descriptor from "key" env variable. */
>  static int get_trace_fd(struct trace_key *key)
>  {
>  	const char *trace;
>  
> -	normalize_trace_key(&key);
> -
>  	/* don't open twice */
>  	if (key->initialized)
>  		return key->fd;

And this and similar changes to drop normalize_trace_key() all make
sense with the earlier hunk. Good.

> @@ -341,7 +324,7 @@ void trace_repo_setup(const char *prefix)
>  
>  int trace_want(struct trace_key *key)
>  {
> -	return !!get_trace_fd(key);
> +       return !!get_trace_fd(key);
>  }

This line accidentally swapped out the tab for spaces.

> diff --git a/trace.h b/trace.h
> index 179b249c5..64326573a 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -4,6 +4,8 @@
>  #include "git-compat-util.h"
>  #include "strbuf.h"
>  
> +#define TRACE_KEY_PREFIX "GIT_TRACE"
> [..]
> -#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
> +#define TRACE_KEY_INIT(name) { TRACE_KEY_PREFIX "_" #name, 0, 0, 0 }

I see you pulled this out so you could use TRACE_KEY_PREFIX elsewhere
for the default key. Yes, the default key and the prefix do happen to be
related in that way, but I actually think it was a bit less obfuscated
the original way, even it repeated the string "GIT_TRACE" twice.

> +#define trace_pass(key) ((key)->fd || !(key)->initialized)

Factoring this out makes sense, since we have to repeat it in each
macro.

Speaking of macros, one side effect of this whole patch is that the
"key" parmaeter is going to be evaluated multiple times. I think that's
an acceptable tradeoff, as we'd basically always expect to pass the
address of a static struct here.

If that's a problem I think we _could_ do it with a combination of
macros and inline functions. The macro has to go in the outer layer in
order to set __LINE__ properly. But something like:

  static inline
  void trace_printf_key_helper(const char *context, int line,
                               struct trace_key *key,
			       const char *fmt, ...)
  {
	if (trace_pass(key)) {
		va_list ap;
		va_start(ap, fmt);
		trace_vprintf_key_fl(context, line, key, fmt, ap);
		va_end(ap);
	}
  }

  #define trace_printf_key(key, ...) \
	trace_printf_key_helper(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__);

would work, I think.

> +#define trace_printf(...)						    \
> +	do {								    \
> +		if (trace_pass(&trace_default_key))			    \
> +			trace_printf_key_fl(TRACE_CONTEXT, __LINE__,        \
> +					    &trace_default_key,__VA_ARGS__);\
> +	} while(0)
> +
> +#define trace_printf_key(key, ...)					    \
> +	do {								    \
> +		if (trace_pass(key))					    \
> +			trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
> +					    __VA_ARGS__);		    \
> +	} while(0)

Now that these definitions are getting a bit more complex, I wonder if
we can implement them in terms of each other. I.e., could the first one
be:

  #define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)

I'm not sure if there are any gotchas with recursive variadic macros. If
it's just this one macro that's not too big a deal, and it looks like
most of the rest of them end up having to call different functions and
can't nest like this. So it may not be worth troubling about.

> +#define trace_argv_printf(argv, ...)					    \
> [...]

The rest of this looks good.

I tried timing a simple loop like:

diff --git a/git.c b/git.c
index 9e96dd4090..f3dbc15a99 100644
--- a/git.c
+++ b/git.c
@@ -626,6 +626,11 @@ int cmd_main(int argc, const char **argv)
 {
 	const char *cmd;
 	int done_help = 0;
+	int i;
+
+	for (i = 0; i < 1000000; i++)
+		trace_printf("item %d", i);
+	return 0;
 
 	cmd = argv[0];
 	if (!cmd)

Without your patch, the times for GIT_TRACE=1 and GIT_TRACE=0 are about
500ms and 9ms respectively.

After your patch, the GIT_TRACE=1 time remains the same but GIT_TRACE=0
drops to 1ms.

So it is measurable, and we might expect that tracing a really big loop
(say over all of the objects in the repository) would benefit. OTOH, a
real loop would actually be doing other stuff, so the speedup would be
less dramatic. Still, it seems like an easy win.

-Peff
