Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D417CC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09F024696
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392569AbgAPRvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:51:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:38054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390818AbgAPRvj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 12:51:39 -0500
Received: (qmail 31480 invoked by uid 109); 16 Jan 2020 17:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Jan 2020 17:51:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8130 invoked by uid 111); 16 Jan 2020 17:58:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2020 12:58:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jan 2020 12:51:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] Makefile: use compat regex with SANITIZE=address
Message-ID: <20200116175138.GA691238@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent versions of the gcc and clang Address Sanitizer produce test
failures related to regexec(). This triggers with gcc-10 and clang-8
(but not gcc-9 nor clang-7). Running:

  make CC=gcc-10 SANITIZE=address test

results in failures in t4018, t3206, and t4062.

The cause seems to be that when built with ASan, we use a different
version of regexec() than normal. And this version doesn't understand
the REG_STARTEND flag. Here's my evidence supporting that.

The failure in t4062 is an ASan warning:

  expecting success of 4062.2 '-G matches':
  	git diff --name-only -G "^(0{64}){64}$" HEAD^ >out &&
  	test 4096-zeroes.txt = "$(cat out)"

  =================================================================
  ==672994==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7fa76f672000 at pc 0x7fa7726f75b6 bp 0x7ffe41bdda70 sp 0x7ffe41bdd220
  READ of size 4097 at 0x7fa76f672000 thread T0
      #0 0x7fa7726f75b5  (/lib/x86_64-linux-gnu/libasan.so.6+0x4f5b5)
      #1 0x562ae0c9c40e in regexec_buf /home/peff/compile/git/git-compat-util.h:1117
      #2 0x562ae0c9c40e in diff_grep /home/peff/compile/git/diffcore-pickaxe.c:52
      #3 0x562ae0c9cc28 in pickaxe_match /home/peff/compile/git/diffcore-pickaxe.c:166
      [...]

In this case we're looking in a buffer which was mmap'd via
reuse_worktree_file(), and whose size is 4096 bytes. But libasan's
regex tries to look at byte 4097 anyway! If we tweak Git like this:

  diff --git a/diff.c b/diff.c
  index 8e2914c031..cfae60c120 100644
  --- a/diff.c
  +++ b/diff.c
  @@ -3880,7 +3880,7 @@ static int reuse_worktree_file(struct index_state *istate,
           */
          if (ce_uptodate(ce) ||
              (!lstat(name, &st) && !ie_match_stat(istate, ce, &st, 0)))
  -               return 1;
  +               return 0;

          return 0;
   }

to use a regular buffer (with a trailing NUL) instead of an mmap, then
the complaint goes away.

The other failures are actually diff output with an incorrect funcname
header. If I instrument xdiff to show the funcname matching like so:

  diff --git a/xdiff-interface.c b/xdiff-interface.c
  index 8509f9ea22..f6c3dc1986 100644
  --- a/xdiff-interface.c
  +++ b/xdiff-interface.c
  @@ -197,6 +197,7 @@ struct ff_regs {
   	struct ff_reg {
   		regex_t re;
   		int negate;
  +		char *printable;
   	} *array;
   };

  @@ -218,7 +219,12 @@ static long ff_regexp(const char *line, long len,

   	for (i = 0; i < regs->nr; i++) {
   		struct ff_reg *reg = regs->array + i;
  -		if (!regexec_buf(&reg->re, line, len, 2, pmatch, 0)) {
  +		int ret = regexec_buf(&reg->re, line, len, 2, pmatch, 0);
  +		warning("regexec %s:\n  regex: %s\n  buf: %.*s",
  +			ret == 0 ? "matched" : "did not match",
  +			reg->printable,
  +			(int)len, line);
  +		if (!ret) {
   			if (reg->negate)
   				return -1;
   			break;
  @@ -264,6 +270,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
   			expression = value;
   		if (regcomp(&reg->re, expression, cflags))
   			die("Invalid regexp to look for hunk header: %s", expression);
  +		reg->printable = xstrdup(expression);
   		free(buffer);
   		value = ep + 1;
   	}

then when compiling with ASan and gcc-10, running the diff from t4018.66
produces this:

  $ git diff -U1 cpp-skip-access-specifiers
  warning: regexec did not match:
    regex: ^[     ]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])
    buf: private:
  warning: regexec matched:
    regex: ^((::[[:space:]]*)?[A-Za-z_].*)$
    buf: private:
  diff --git a/cpp-skip-access-specifiers b/cpp-skip-access-specifiers
  index 4d4a9db..ebd6f42 100644
  --- a/cpp-skip-access-specifiers
  +++ b/cpp-skip-access-specifiers
  @@ -6,3 +6,3 @@ private:
          void DoSomething();
          int ChangeMe;
  };
          void DoSomething();
  -       int ChangeMe;
  +       int IWasChanged;
   };

That first regex should match (and is negated, so it should be telling
us _not_ to match "private:"). But it wouldn't if regexec() is looking
at the whole buffer, and not just the length-limited line we've fed to
regexec_buf(). So this is consistent again with REG_STARTEND being
ignored.

The correct output (compiling without ASan, or gcc-9 with Asan) looks
like this:

  warning: regexec matched:
    regex: ^[     ]*[A-Za-z_][A-Za-z_0-9]*:[[:space:]]*($|/[/*])
    buf: private:
  [...more lines that we end up not using...]
  warning: regexec matched:
    regex: ^((::[[:space:]]*)?[A-Za-z_].*)$
    buf: class RIGHT : public Baseclass
  diff --git a/cpp-skip-access-specifiers b/cpp-skip-access-specifiers
  index 4d4a9db..ebd6f42 100644
  --- a/cpp-skip-access-specifiers
  +++ b/cpp-skip-access-specifiers
  @@ -6,3 +6,3 @@ class RIGHT : public Baseclass
          void DoSomething();
  -       int ChangeMe;
  +       int IWasChanged;
   };

So it really does seem like libasan's regex engine is ignoring
REG_STARTEND. We should be able to work around it by compiling with
NO_REGEX, which would use our local regexec(). But to make matters even
more interesting, this isn't enough by itself.

Because ASan has support from the compiler, it doesn't seem to intercept
our call to regexec() at the dynamic library level. It actually
recognizes when we are compiling a call to regexec() and replaces it
with ASan-specific code at that point. And unlike most of our other
compat code, where we might have git_mmap() or similar, the actual
symbol name in the compiled compat/regex code is regexec(). So just
compiling with NO_REGEX isn't enough; we still end up in libasan!

We can work around that by having the preprocessor replace regexec with
git_regexec (both in the callers and in the actual implementation), and
we truly end up with a call to our custom regex code, even when
compiling with ASan. That's probably a good thing to do anyway, as it
means anybody looking at the symbols later (e.g., in a debugger) would
have a better indication of which function is which. So we'll do the
same for the other common regex functions (even though just regexec() is
enough to fix this ASan problem).

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile             | 3 +++
 compat/regex/regex.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 09f98b777c..9cd9826800 100644
--- a/Makefile
+++ b/Makefile
@@ -1220,6 +1220,9 @@ endif
 ifneq ($(filter leak,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
 endif
+ifneq ($(filter address,$(SANITIZERS)),)
+NO_REGEX = NeededForASAN
+endif
 endif
 
 ifndef sysconfdir
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 08a2609663..2d3412860d 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -41,6 +41,11 @@
 extern "C" {
 #endif
 
+#define regcomp git_regcomp
+#define regexec git_regexec
+#define regerror git_regerror
+#define regfree git_regfree
+
 /* The following two types have to be signed and unsigned integer type
    wide enough to hold a value of a pointer.  For most ANSI compilers
    ptrdiff_t and size_t should be likely OK.  Still size of these two
-- 
2.25.0.318.gee4019ba55
