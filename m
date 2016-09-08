Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4C261F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbcIHH66 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:58:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:52968 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756378AbcIHH65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:58:57 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MWxtA-1bVtgE2HgK-00VyHU; Thu, 08 Sep 2016 09:58:50
 +0200
Date:   Thu, 8 Sep 2016 09:58:35 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/3] Introduce a function to run regexec() on non-NUL-terminated
 buffers
In-Reply-To: <cover.1473321437.git.johannes.schindelin@gmx.de>
Message-ID: <94ee698b2736929d37640012a1b1735b134dd3d6.1473321437.git.johannes.schindelin@gmx.de>
References: <cover.1473319844.git.johannes.schindelin@gmx.de> <cover.1473321437.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cVh0YOy8JC56zj/wnuZZ0rym4CP9+H01i6S4EzcqPktwAgVA9Wq
 DzaBnoe2Jz7wJYr0f2USbqbivvTlZ7QzZk/8BI/h9FAbfSeEK26Cg6Nr7i1EwKGq1t+h/Lv
 qzrUepVLFBK45FKVhJOP1XWf7nJLnXJUxl4ROd3rE7SQy7a2J/CMJFsqT5/AdaebvzZuncx
 T7RPz/4Tu3IrCpN/BNTkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/BCjYZZZl6E=:6/iWQdruWwYY8/6CtbS1Va
 yE6A8hDykESlnsFBRKliHKfpZObBENLi5zuMKCMhV4SuszD/RiKoEi2IPbAK0ecH4yWQ2Sq+M
 kPoFo2MDmYvGKHMRTbHXbfiRAeb/q0oBqSfZ1NQ7sCOQR1F3RzCzwdWqGAXHWrpvvhzcshCYS
 mJk3GheBayh1ajy2Q1ugaPocTtSo5KCr5SFIt1olRFEBlMgVG0SPh3ZI+VzXhzgxl8ZVzEqS3
 fPZYCILSN+T/sQa3El8mIbQs12k0MWfuZi/P3I1FahM+/lFmV+EuRksrICGusdMASPFehcY5i
 K/srIUTKkxHoBXTLQ8EcHJ82NhrFhAZbh/YNqcckrNVzKxIBnfBZZARUMr2R9klkJqc5a/3y5
 cppNXd0BcLYQQQeT6M5S5tRI4n1niySz0OQZBpzWyGo6/bIJdTJY9EuY86neSqoqcKpVIGmCC
 TeR/2ZIqOPh3j6gQ3QWp9s/5eiHXFJcWwnbqZl/stGoYIZeDIInFUwGpQdM0swdNP09seuTmz
 keXw1NveQLw/RDPXgtyCkA+YhsZoWKlfI6XnqfzyIVaSvSVZzvDfFr15vOqX3XdYE31SRwPey
 DmAyFCTmK5DEmMvl5ZJDBKMKTaxJZ8eqMbNTcS+YrSZ4ihf4ZYuWwYMUJXtYxwTdvCsWERcg6
 9Vp5ikUIPiTV0s2LJC+moTjPsKiskYZPw4/bI//eboHbIgMV9t2aUGXHOs/AhSDXXyxzdQQBF
 CoGtliak9yk3sAfysg5IKQcaPAfg1fUfDFCIARVglQo1Mte0LmolIun7upZC9u0Mn/szKCh5l
 abPGvF0
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
 git-compat-util.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index db89ba7..19128b3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -965,6 +965,27 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #define qsort git_qsort
 #endif
 
+static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
+			      size_t nmatch, regmatch_t pmatch[], int eflags)
+{
+#ifdef REG_STARTEND
+	assert(nmatch > 0 && pmatch);
+	pmatch[0].rm_so = 0;
+	pmatch[0].rm_eo = size;
+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
+#else
+	char *buf2 = xmalloc(size + 1);
+	int ret;
+
+	memcpy(buf2, buf, size);
+	buf2[size] = '\0';
+	ret = regexec(preg, buf2, nmatch, pmatch, eflags);
+	free(buf2);
+
+	return ret;
+#endif
+}
+
 #ifndef DIR_HAS_BSD_GROUP_SEMANTICS
 # define FORCE_DIR_SET_GID S_ISGID
 #else
-- 
2.10.0.windows.1.10.g803177d


