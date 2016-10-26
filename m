Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D5D2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 12:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbcJZMLD (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 08:11:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:34281 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932550AbcJZMLB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 08:11:01 -0400
Received: (qmail 4314 invoked by uid 109); 26 Oct 2016 12:11:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 12:11:00 +0000
Received: (qmail 9854 invoked by uid 111); 26 Oct 2016 12:11:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 08:11:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 08:10:58 -0400
Date:   Wed, 26 Oct 2016 08:10:58 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161026121058.a2pmf57oc7p2mlsp@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
 <20161025151524.y7wwtetohhqgcvob@sigill.intra.peff.net>
 <20161026102921.GA31311@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161026102921.GA31311@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 05:29:21PM +0700, Duy Nguyen wrote:

> > I think you could conditionally make git_path() and all of its
> > counterparts macros, similar to the way the trace code works. It seems
> > like a pretty maintenance-heavy solution, though. I'd prefer
> > conditionally compiling backtrace(); that also doesn't hit 100% of
> > cases, but at least it isn't too invasive.
> 
> OK, a more polished patch is this. There are warnings about
> -fomit-function-pointers in glibc man page, at least in my simple
> tests it does not cause any issue.

Yeah, I tried with -fno-omit-frame-pointer, but it didn't help. The
glibc backtrace(3) manpage specifically says:

  The symbol names may be unavailable without the use of special linker
  options. For systems using the GNU linker, it is necessary to use the
  -rdynamic linker option. Note that names of "static" functions are not
  exposed, and won't be available in the backtrace.

which matches the behavior I get.

Gcc ships with a libbacktrace which does seem to give reliable results
(patch below for reference). But that's still relying on gcc, and on
having debug symbols available. I'm not sure this is really any
convenience over dumping a corefile and using gdb to pull out the
symbols after the fact.

---
diff --git a/config.mak.uname b/config.mak.uname
index 76f885281c..62a14f10d3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -40,6 +40,8 @@ ifeq ($(uname_S),Linux)
 	NEEDS_LIBRT = YesPlease
 	HAVE_GETDELIM = YesPlease
 	SANE_TEXT_GREP=-a
+	BASIC_CFLAGS += -DHAVE_BACKTRACE
+	EXTLIBS += -lbacktrace
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/usage.c b/usage.c
index 17f52c1b5c..4b9762ae62 100644
--- a/usage.c
+++ b/usage.c
@@ -5,6 +5,9 @@
  */
 #include "git-compat-util.h"
 #include "cache.h"
+#ifdef HAVE_BACKTRACE
+#include <backtrace.h>
+#endif
 
 static FILE *error_handle;
 static int tweaked_error_buffering;
@@ -24,6 +27,44 @@ void vreportf(const char *prefix, const char *err, va_list params)
 	fputc('\n', fh);
 }
 
+#ifdef HAVE_BACKTRACE
+static int full_callback(void *fh, uintptr_t pc,
+			 const char *filename, int lineno,
+			 const char *function)
+{
+	if (!function || !filename)
+		return 0;
+	fprintf(fh, "debug:  %s() at %s:%d\n", function, filename, lineno);
+	return 0;
+}
+
+static void error_callback(void *fh, const char *msg, int errnum)
+{
+	fprintf(fh, "backtrace error: %s", msg);
+	if (errnum > 0)
+		fprintf(fh, ": %s", strerror(errnum));
+	fputc('\n', fh);
+}
+
+static void maybe_backtrace(void)
+{
+	FILE *fh = error_handle ? error_handle : stderr;
+	struct backtrace_state *bt;
+
+	if (!git_env_bool("GIT_BACKTRACE_ON_DIE", 0))
+		return;
+
+	/* XXX obviously unportable use of /proc */
+	bt = backtrace_create_state("/proc/self/exe", 0, error_callback, fh);
+	if (bt) {
+		fprintf(fh, "debug: die() called at:\n");
+		backtrace_full(bt, 3, full_callback, error_callback, fh);
+	}
+}
+#else
+#define maybe_backtrace()
+#endif
+
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
 	vreportf("usage: ", err, params);
@@ -33,6 +74,7 @@ static NORETURN void usage_builtin(const char *err, va_list params)
 static NORETURN void die_builtin(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
+	maybe_backtrace();
 	exit(128);
 }
 
