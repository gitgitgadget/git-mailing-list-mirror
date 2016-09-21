Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D101F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755932AbcIUSYV (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:24:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:54227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755235AbcIUSYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:24:20 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MaJPk-1bXJhY0tUe-00Jq2x; Wed, 21 Sep 2016 20:24:08
 +0200
Date:   Wed, 21 Sep 2016 20:24:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 2/3] regex: add regexec_buf() that can work on a non
 NUL-terminated string
In-Reply-To: <cover.1474482164.git.johannes.schindelin@gmx.de>
Message-ID: <270cea11c4d8bfb332a6c014a11673b7f4666ee4.1474482164.git.johannes.schindelin@gmx.de>
References: <cover.1473321437.git.johannes.schindelin@gmx.de> <cover.1474482164.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UEordNHCdxko6dpRJ+UkIbNb9ii5aMZ7MGQBmxPZ3GZPPoLI6UM
 dLgKSJ7N06oagLPLwAi+WbDoe5yr4ouHu9zsQ3I8mAJeMdL8xEAYQAs3F7GSgfI1F/hS9Zg
 C9mPIH8vwpvcMepQ0Tblx/Ob/VQQNs8gX2HVGR/9jzaTbiFxNiRVPcv5egqypv1IDdoRt5Z
 +KxYp3GXpYUSgKPFZZTww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/i/T4KRNlA0=:b0okjMdQd6arE4iz7+78Mm
 A7E3X+gtxEkx2JfAuREDdFPmWVRY5qw2j1eHREEpuP6x1zzmsddQVsrb/1vf/Prn7y245AQVd
 JcyY12ars6aZ4tFtGyw2CPEAg98brlhhxH1j7gcuz95mxQKAcIWiDdTv/HSCy2Vp1U+bhtYeo
 2a5lQrtlBZlPqELq+17vhzhI5LXCP13cI84nUaNlIeHCQegReNA0O0FGLzV75ASwXUBOmEP56
 2PrXgGYsji9h/P8mKFHdmGlX9btAEa/LNx5OPMnbbQ75d2kbuwyVld7UxMxE5GBo3yV6gNndT
 UcjQvL6Yv5r2AjY/UZsn3/n1Sy5J61DwnXt6Ly9CU684eh/LUpsc37izCGMNm1DaFQ8PUA4Iq
 Ma3E9TnsVwwHCqd1SL0WU9PB068CWhOjVMIeaAfTjORzUkXjKfgXkiZsS2nPq5+pkiK+rEr27
 eEQWmncoeJkJhZL0sWJSuxAkx5/9NBTyxucVR4vgEQBQ8SbehXTZFpnAYuCgJLWGbYV/kqGrU
 CJHEgJ1ZopDJUJHes2Hi/ho7Ke12JHkduNcwjF3weQYjOb0dlY+Y+Kzm2Ll2qm1uKxkDEtgZg
 mpxxEelDcUHXzRChe9INiaqJ+UrT54TXyFcCoiO4fjQLcri40dZsEO+UpslUhnorf8pgVwLlp
 5fxLgt5Cg/CiuRxJmnQLUM5CMv5fATEKeE6sLDVjfj1TNPD9IagyM9rVZ2lx7vHcujKnUlvkP
 BrmnbHoBIPBfiUS9vOak3MpTxxAFPUcTv1ZpCLvU86y/+qkUSvDHfQWPRja8dvjO3K3sen4O+
 KTp9oUB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We just introduced a test that demonstrates that our sloppy use of
regexec() on a mmap()ed area can result in incorrect results or even
hard crashes.

So what we need to fix this is a function that calls regexec() on a
length-delimited, rather than a NUL-terminated, string.

Happily, there is an extension to regexec() introduced by the NetBSD
project and present in all major regex implementation including
Linux', MacOSX' and the one Git includes in compat/regex/: by using
the (non-POSIX) REG_STARTEND flag, it is possible to tell the
regexec() function that it should only look at the offsets between
pmatch[0].rm_so and pmatch[0].rm_eo.

That is exactly what we need.

Since support for REG_STARTEND is so widespread by now, let's just
introduce a helper function that uses it, and fall back to allocating
and constructing a NUL-terminated when REG_STARTEND is not available.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile          |  3 ++-
 git-compat-util.h | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index df4f86b..c6f7f66 100644
--- a/Makefile
+++ b/Makefile
@@ -301,7 +301,8 @@ all::
 # crashes due to allocation and free working on different 'heaps'.
 # It's defined automatically if USE_NED_ALLOCATOR is set.
 #
-# Define NO_REGEX if you have no or inferior regex support in your C library.
+# Define NO_REGEX if your C library lacks regex support with REG_STARTEND
+# feature.
 #
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
diff --git a/git-compat-util.h b/git-compat-util.h
index 37cce07..8aab0c3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -977,6 +977,19 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define qsort git_qsort
 #endif
 
+#ifndef REG_STARTEND
+#error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
+#endif
+
+static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
+			      size_t nmatch, regmatch_t pmatch[], int eflags)
+{
+	assert(nmatch > 0 && pmatch);
+	pmatch[0].rm_so = 0;
+	pmatch[0].rm_eo = size;
+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
+}
+
 #ifndef DIR_HAS_BSD_GROUP_SEMANTICS
 # define FORCE_DIR_SET_GID S_ISGID
 #else
-- 
2.10.0.windows.1.10.g803177d


