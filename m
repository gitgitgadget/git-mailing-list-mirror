Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37EB201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdKLRHM (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 12:07:12 -0500
Received: from avasout05.plus.net ([84.93.230.250]:44635 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdKLRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 12:07:12 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Nov 2017 12:07:11 EST
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id Dvbee8W182du7DvbfebJNw; Sun, 12 Nov 2017 16:59:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=a6FAzQaF c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=BNFp--SqAAAA:8
 a=orGbg3ZDba64v-sq4BQA:9 a=wCHOS_8tIzIYXQCUOVd6:22
From:   Charles Bailey <charles@hashpling.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Fix NO_LIBPCRE1_JIT to fully disable JIT
Date:   Sun, 12 Nov 2017 16:59:38 +0000
Message-Id: <20171112165938.8787-1-charles@hashpling.org>
X-Mailer: git-send-email 2.10.2
X-CMAE-Envelope: MS4wfKU1QDNlqfnBrkrfgrMIKhCXOOk+W4JL2mliVaJ12coCqSyTUpaimI/Jghas+9LUXgLWF+HJv/H5tSCdcOzAr4HIR2Lj7v65CAbUQ1GRO7hHUE45ueH7
 jHt+HbecmQPiaTf77XurntadwEFNKmcb6WKY0YWJ1X5Qb/gmUiy/vkFIypYeU3Gc0wLXKfaC7D8vVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Charles Bailey <cbailey32@bloomberg.net>

If you have a pcre1 library which is compiled with JIT enabled then
PCRE_STUDY_JIT_COMPILE will be defined whether or not the
NO_LIBPCRE1_JIT configuration is set.

This means that we enable JIT functionality when calling pcre_study
even if NO_LIBPCRE1_JIT has been explicitly set and we just use plain
pcre_exec later.

Fix this by using own macro (GIT_PCRE_STUDY_JIT_COMPILE) which we set to
PCRE_STUDY_JIT_COMPILE only if NO_LIBPCRE1_JIT is not set and define to
0 otherwise, as before.
---

I was bisecting an issue with the PCRE support that was causing a test
suite failure on our Solaris builds and reached fbaceaac47 ("grep: add
support for the PCRE v1 JIT API"). It appeared to be a misaligned memory
access somewhere inside the libpcre code. I tried disabling the use of
JIT with NO_LIBPCRE1_JIT but it turned out that even with this set we
were still triggering the JIT code path in the call to pcre_study.

Yes, we probably should fix our PCRE1 library build on Solaris or move
to PCRE2, but really NO_LIBPCRE1_JIT should have prevented us from
triggering this crash.

 grep.c | 2 +-
 grep.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index ce6a48e..d0b9b6c 100644
--- a/grep.c
+++ b/grep.c
@@ -387,7 +387,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
-	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, PCRE_STUDY_JIT_COMPILE, &error);
+	p->pcre1_extra_info = pcre_study(p->pcre1_regexp, GIT_PCRE_STUDY_JIT_COMPILE, &error);
 	if (!p->pcre1_extra_info && error)
 		die("%s", error);
 
diff --git a/grep.h b/grep.h
index 52aecfa..399381c 100644
--- a/grep.h
+++ b/grep.h
@@ -7,11 +7,12 @@
 #if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
 #ifndef NO_LIBPCRE1_JIT
 #define GIT_PCRE1_USE_JIT
+#define GIT_PCRE_STUDY_JIT_COMPILE PCRE_STUDY_JIT_COMPILE
 #endif
 #endif
 #endif
-#ifndef PCRE_STUDY_JIT_COMPILE
-#define PCRE_STUDY_JIT_COMPILE 0
+#ifndef GIT_PCRE_STUDY_JIT_COMPILE
+#define GIT_PCRE_STUDY_JIT_COMPILE 0
 #endif
 #if PCRE_MAJOR <= 8 && PCRE_MINOR < 20
 typedef int pcre_jit_stack;
-- 
2.10.2

