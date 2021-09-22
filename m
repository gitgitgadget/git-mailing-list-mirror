Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ABAC433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF325610A0
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 19:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbhIVT6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:58:30 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:11939 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhIVT63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 15:58:29 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4HF8Fj5JvXz5tlB;
        Wed, 22 Sep 2021 21:56:57 +0200 (CEST)
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH cb/pedantic-build-for-developers] lazyload.h: fix warnings
 about mismatching function pointer types
Message-ID: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
Date:   Wed, 22 Sep 2021 21:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here, GCC warns about every use of the INIT_PROC_ADDR macro, for example:

In file included from compat/mingw.c:8:
compat/mingw.c: In function 'mingw_strftime':
compat/win32/lazyload.h:38:12: warning: assignment to
   'size_t (*)(char *, size_t,  const char *, const struct tm *)'
   {aka 'long long unsigned int (*)(char *, long long unsigned int,
      const char *, const struct tm *)'} from incompatible pointer type
   'FARPROC' {aka 'long long int (*)()'} [-Wincompatible-pointer-types]
   38 |  (function = get_proc_addr(&proc_addr_##function))
      |            ^
compat/mingw.c:1014:6: note: in expansion of macro 'INIT_PROC_ADDR'
 1014 |  if (INIT_PROC_ADDR(strftime))
      |      ^~~~~~~~~~~~~~

(message wrapper for convenience). Insert a cast to keep the compiler
happy. A cast is fine in these cases because they are generic function
pointer values that have been looked up in a DLL.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 How can this have worked ever without a warning?

 compat/win32/lazyload.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
index d2056cdadf..dc35cf080b 100644
--- a/compat/win32/lazyload.h
+++ b/compat/win32/lazyload.h
@@ -26,7 +26,8 @@ struct proc_addr {
 #define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
 	static struct proc_addr proc_addr_##function = \
 	{ #dll, #function, NULL, 0 }; \
-	static rettype (WINAPI *function)(__VA_ARGS__)
+	typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
+	static proc_type_##function function;
 
 /*
  * Loads a function from a DLL (once-only).
@@ -35,7 +36,7 @@ struct proc_addr {
  * This function is not thread-safe.
  */
 #define INIT_PROC_ADDR(function) \
-	(function = get_proc_addr(&proc_addr_##function))
+	(function = (proc_type_##function)get_proc_addr(&proc_addr_##function))
 
 static inline FARPROC get_proc_addr(struct proc_addr *proc)
 {
-- 
2.33.0.130.g83e2707afc
