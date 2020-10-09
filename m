Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD5C83030
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C312B20691
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJIT5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:57:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:55580 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbgJIT5E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 15:57:04 -0400
Received: (qmail 10139 invoked by uid 109); 9 Oct 2020 19:57:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Oct 2020 19:57:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5647 invoked by uid 111); 9 Oct 2020 19:57:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Oct 2020 15:57:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Oct 2020 15:57:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
Message-ID: <20201009195701.GA967869@coredump.intra.peff.net>
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
 <20201009015505.GB1314@generichostname>
 <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
 <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
 <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 12:27:28PM -0700, Junio C Hamano wrote:

> The document recommends not to write "extern" in front of a function
> declaration, with justification that a decl by default is extern.
> 
> While it is true that by default decls are extern unless marked with
> "static", it does not justify the choice.  It only justifies why we
> could omit it if we wanted to, but does not say anything about the
> reason why we would want to omit it in the first place.

True, but I think that is perhaps a failing of the document, not of the
original motivation. The reason to have _a_ standard is that it is
confusing when some functions say "extern" and some do not (and it was a
continued source of review friction when people pointed out
inconsistencies). But the reason to standardize on omitting it is that
it clutters the line, making it longer and harder to read.

The argument for including it is less clear to me. You say below:

> [...]By doing so, we would also prevent a
> mistake of not writing "extern" when we need to (i.e. decls of data
> items, that are not functions) when less experienced developers try
> to mimic how the existing surrounding declarations are written.

but to my recollection that has not been a big problem. And it's one
that's usually easily caught by the compiler. A missing "extern" on a
variable will usually get you a multiple-definition warning at
link-time (if you manage to also omit the actual definition you won't
see that, though "make sparse" will warn that your variable ought to be
static).

So I have a mild preference to omit it, if we were starting from
scratch. But starting form where we are now, without "extern", my
preference is even stronger, because I don't want to waste submitter or
reviewer time switching all of the existing cases.

> But a function that returns a pointer to a function looks similar:
> 
>     extern void (*get_error_routine(void))(const char *message, ...);

IMHO the real problem here is that C's syntax for returning a function
pointer is so horrendous. How about this (on top of your earlier patch
to drop the extern from that declaration)?

-- >8 --
Subject: [PATCH] usage: define a type for a reporting function

The usage, die, warning, and error routines all work with a function
pointer that takes the message to be reported. We usually just mention
the function's full type inline. But this makes the use of these
pointers hard to read, especially because C's syntax for returning a
function pointer is so awful:

  void (*get_error_routine(void))(const char *err, va_list params);

Unless you read it very carefully, this looks like a function pointer
declaration. Let's instead use a single typedef to define a reporting
function, which is the same for all four types.

Signed-off-by: Jeff King <peff@peff.net>
---
I wondered if the compiler would complain about attaching a noreturn
attribute to an already-typedef'd pointer (rather than including it in
the typedef). gcc seems to be fine with it, but we could also define two
types, one with noreturn and one without.

 git-compat-util.h | 12 +++++++-----
 usage.c           | 18 +++++++++---------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 56e0e1e79d..adfea06897 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -489,11 +489,13 @@ static inline int const_error(void)
 #define error_errno(...) (error_errno(__VA_ARGS__), const_error())
 #endif
 
-void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
-void set_error_routine(void (*routine)(const char *err, va_list params));
-void (*get_error_routine(void))(const char *err, va_list params);
-void set_warn_routine(void (*routine)(const char *warn, va_list params));
-void (*get_warn_routine(void))(const char *warn, va_list params);
+typedef void (*report_fn)(const char *, va_list params);
+
+void set_die_routine(NORETURN_PTR report_fn routine);
+void set_error_routine(report_fn routine);
+report_fn get_error_routine(void);
+void set_warn_routine(report_fn routine);
+report_fn get_warn_routine(void);
 void set_die_is_recursing_routine(int (*routine)(void));
 
 int starts_with(const char *str, const char *prefix);
diff --git a/usage.c b/usage.c
index 58fb5fff5f..06665823a2 100644
--- a/usage.c
+++ b/usage.c
@@ -108,33 +108,33 @@ static int die_is_recursing_builtin(void)
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
  * (ugh), so keep things static. */
-static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
-static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
-static void (*error_routine)(const char *err, va_list params) = error_builtin;
-static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
+static NORETURN_PTR report_fn usage_routine = usage_builtin;
+static NORETURN_PTR report_fn die_routine = die_builtin;
+static report_fn error_routine = error_builtin;
+static report_fn warn_routine = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
 
-void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
+void set_die_routine(NORETURN_PTR report_fn routine)
 {
 	die_routine = routine;
 }
 
-void set_error_routine(void (*routine)(const char *err, va_list params))
+void set_error_routine(report_fn routine)
 {
 	error_routine = routine;
 }
 
-void (*get_error_routine(void))(const char *err, va_list params)
+report_fn get_error_routine(void)
 {
 	return error_routine;
 }
 
-void set_warn_routine(void (*routine)(const char *warn, va_list params))
+void set_warn_routine(report_fn routine)
 {
 	warn_routine = routine;
 }
 
-void (*get_warn_routine(void))(const char *warn, va_list params)
+report_fn get_warn_routine(void)
 {
 	return warn_routine;
 }
-- 
2.29.0.rc1.559.g850010a3b3

