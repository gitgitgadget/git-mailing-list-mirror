Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D0C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F6C206DD
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbgJOTaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:30:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33368 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391545AbgJOTaF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:05 -0400
Received: (qmail 24164 invoked by uid 109); 15 Oct 2020 19:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32178 invoked by uid 111); 15 Oct 2020 19:30:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:30:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2 1/2] usage: define a type for a reporting function
Message-ID: <20201015193004.GA1129761@coredump.intra.peff.net>
References: <20201015192845.GD1108210@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015192845.GD1108210@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usage, die, warning, and error routines all work with a function
pointer that takes the message to be reported. We usually just mention
the function's full type inline. But this makes the use of these
pointers hard to read, especially because C's syntax for returning a
function pointer is so awful:

  void (*get_error_routine(void))(const char *err, va_list params);

Unless you read it very carefully, this looks like a function pointer
declaration. Let's instead use a single typedef to define a reporting
function, which is the same for all four types.

Note that this also removes the "extern" from these declarations to
match the surrounding functions. They were missed in 554544276a (*.[ch]:
remove extern from function declarations using spatch, 2019-04-29)
presumably because of the unusual syntax.

Signed-off-by: Jeff King <peff@peff.net>
---
This replaces the tip of jk/report-fn-typedef.

 git-compat-util.h | 12 +++++++-----
 usage.c           | 18 +++++++++---------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 7a0fb7a045..adfea06897 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -489,11 +489,13 @@ static inline int const_error(void)
 #define error_errno(...) (error_errno(__VA_ARGS__), const_error())
 #endif
 
-void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
-void set_error_routine(void (*routine)(const char *err, va_list params));
-extern void (*get_error_routine(void))(const char *err, va_list params);
-void set_warn_routine(void (*routine)(const char *warn, va_list params));
-extern void (*get_warn_routine(void))(const char *warn, va_list params);
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
2.29.0.rc1.562.g7bd9bc8902

