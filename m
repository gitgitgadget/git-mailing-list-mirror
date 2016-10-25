Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41F42035F
	for <e@80x24.org>; Tue, 25 Oct 2016 15:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbcJYPP2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 11:15:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:33944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbcJYPP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 11:15:27 -0400
Received: (qmail 630 invoked by uid 109); 25 Oct 2016 15:15:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 15:15:27 +0000
Received: (qmail 2164 invoked by uid 111); 25 Oct 2016 15:15:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Oct 2016 11:15:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Oct 2016 11:15:25 -0400
Date:   Tue, 25 Oct 2016 11:15:25 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161025151524.y7wwtetohhqgcvob@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 07:38:30PM +0700, Duy Nguyen wrote:

> > diff --git a/environment.c b/environment.c
> > index cd5aa57..b1743e6 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -164,8 +164,11 @@ static void setup_git_env(void)
> >         const char *replace_ref_base;
> >
> >         git_dir = getenv(GIT_DIR_ENVIRONMENT);
> > -       if (!git_dir)
> > +       if (!git_dir) {
> > +               if (!startup_info->have_repository)
> > +                       die("BUG: setup_git_env called without repository");
> 
> YES!!! Thank you for finally fixing this.

Good, I'm glad somebody besides me is excited about this. I've been
wanting to write this patch for a long time, but it took years of
chipping away at all the edge cases.

> The "once we've identified" part could be tricky though. This message
> alone will not give us any clue where it's called since it's buried
> deep in git_path() usually, which is buried deep elsewhere. Without
> falling back to core dumps (with debug info), glibc's backtrace
> (platform specifc), the best we could do is turn git_path() into a
> macro that takes __FILE__ and __LINE__ and somehow pass the info down
> here, but "..." in macros is C99 specific, sigh..
> 
> Is it too bad to turn git_path() into a macro when we know the
> compiler is C99 ? Older compilers will have no source location info in
> git_path(), Hopefully they are rare, which means chances of this fault
> popping up are also reduced.

I think you could conditionally make git_path() and all of its
counterparts macros, similar to the way the trace code works. It seems
like a pretty maintenance-heavy solution, though. I'd prefer
conditionally compiling backtrace(); that also doesn't hit 100% of
cases, but at least it isn't too invasive.

But I think I still prefer just letting the corefile and the debugger do
their job. This error shouldn't happen much, and when it does, it should
be easily reproducible. Getting the bug reporter to give either a
reproduction recipe, or to run "gdb git" doesn't seem like that big a
hurdle.

For fun, here's a patch that uses backtrace(), but it does not actually
print the function names unless you compile with "-rdynamic" (and even
then it misses static functions). There are better libraries, but of
course that's one more thing for the user to deal with when building.

-Peff

---
diff --git a/usage.c b/usage.c
index 17f52c1b5c..4917c6bdfd 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,9 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#ifdef HAVE_BACKTRACE
+#include <execinfo.h>
+#endif
 
 static FILE *error_handle;
 static int tweaked_error_buffering;
@@ -24,6 +27,32 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	fputc('\n', fh);
 }
 
+#ifdef HAVE_BACKTRACE
+static void maybe_backtrace(void)
+{
+	void *bt[100];
+	char **symbols;
+	int nr;
+
+	if (!git_env_bool("GIT_BACKTRACE_ON_DIE", 0))
+		return;
+
+	nr = backtrace(bt, ARRAY_SIZE(bt));
+	symbols = backtrace_symbols(bt, nr);
+	if (symbols) {
+		FILE *fh = error_handle ? error_handle : stderr;
+		int i;
+
+		fprintf(fh, "die() called from:\n");
+		for (i = 0; i < nr; i++)
+			fprintf(fh, "  %s\n", symbols[i]);
+		free(symbols);
+	}
+}
+#else
+#define maybe_backtrace()
+#endif
+
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
 	vreportf("usage: ", err, params);
@@ -33,6 +62,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 static NORETURN void die_builtin(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
+	maybe_backtrace();
 	exit(128);
 }
 
