Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A165D1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757519AbcIHHbb (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:31:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:62993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757516AbcIHHba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:31:30 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MY86C-1bUmmH1Vvk-00UpaQ; Thu, 08 Sep 2016 09:31:13
 +0200
Date:   Thu, 8 Sep 2016 09:31:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] Introduce a function to run regexec() on non-NUL-terminated
 buffers
In-Reply-To: <cover.1473319844.git.johannes.schindelin@gmx.de>
Message-ID: <94ee698b2736929d37640012a1b1735b134dd3d6.1473319844.git.johannes.schindelin@gmx.de>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <cover.1473319844.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QthCk8Bm0M0YmcSGAHhERkSn+PRm31To16uo1jjO6euPimHkqC0
 FY3wvVKTsTHhoWk58AW3Zv9hVKiY3wXiBFC8XXOgM4UliRwCjWU/nIr+DmB+6LxCSqDPwuk
 dE3c6x/va2aLdZJe0NWNL7QH+WyatkoBO21OqlL2/gFQso8waasSfliz8NODB9ow3Tzq2YT
 4va7pbm9TMcRGXEdgISsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8pUtp0E/0lw=:a+EgKs1K6v1H5eTUTQIAm0
 +DSV6YjOl+o1BMICZUvECuFMqoXCnnxRnCrVyOKZprzTDHxw2RqlqQZ8dgBSxUGShHTKcMPzX
 hOaSLvHw83O3fBLevXIcCDKIO95MYsujflaulYPwUryoLPgSnrVgJ3GDomC305aIZToZS8vyU
 gJrSHCGgqLot66hYyCIFTEXsg673RPSnDD8Tb1BUDUcx1bxSrUDivHyvKGjdncUWQYSTmMr2d
 kSHKT1iTTXOWpxPknvV4KVYCfdyi6KaUOUY+nbmGW5Ce0JpUX1ODHUDKLCS5bLoSpwyQGyf2t
 ebdkbHBIBAqoqZixPpy8Pp6UvfC27Ay0S5BoaLDFJXDflqtYJWmm8zSDA+pW9qz2d4GtkRyML
 1LEHjUAk/SbE0NeZbFnuB7OPHEY/opmTEr4dQGppLFjbuFDtzc4ZvbzkYq+aG8xyDQ/vDmYvO
 p/dkQAagF5XsbBgnr2VnNiEB14Pr57P7NWYlnWTvfK+xyEP9jMesTl57pt9fyQKQuY2PIYJap
 cZCNfQyvkLeZW/97JMhkO1aMG76uXgdyhxiDfYU+Dq+MCizdICqFQSTw6axaipq5V5ikT8R3F
 xuI4Ynlv2guHm01Df474hWMPrG8V9qeo//OFRLr+KAHmg5CpYu6px+yZhtzNokUl4stdBBsEw
 ooESRu3zfrvKhz4+YPsQLQunSgAqD3wxhP+CuQuzbno/cpyxGYookJn9Cicb1KJ+0Y6TUWY0D
 Y+sxaf4Aj7Yu7xeoF0LwOPxZ0H25qTiVc9pRC82As2LEfEPddNdgVIAT9qk0cMUHa61PJnZ+H
 ttRXPlW
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


