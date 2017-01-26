Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745651F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 17:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbdAZRsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 12:48:40 -0500
Received: from mout.web.de ([212.227.15.14]:63569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754145AbdAZRsi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 12:48:38 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtoCT-1cPYJL3YYv-011Ag0; Thu, 26
 Jan 2017 18:47:54 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: PATCH 1/2] abspath: add absolute_pathdup()
Message-ID: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
Date:   Thu, 26 Jan 2017 18:47:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:j62IhujzvX6Yt0ppwzUsVyElj7Ij69OKJ33Qa/CD1Bfcm9KUrbF
 Z4DpbyNDVXrRqZ4KIGpuFwl8qItCvVRLmLFX9z9wFNGmxYK0ugYeoBvw8wCqBsPumvQXFu6
 EcBC5dfznUraCPR3yXUqCBHJFeQfTEFBMdGYV5EGYXd7XfD85OLYH1nnwK/it9kUpeprA6j
 t/Y93PMxn3vedF6SG5Evw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XA4Tcz9dwr0=:T6yYBJXOESpphQ5Ltr5xUb
 +sdKE5TjZOMgsXio2CUKLLB50Ejp6bTP8qb4GMcJy9baH7zJD129OhOb4IefmyBsbsv/5Qsf4
 dcBY5oiRW4SPtKTQmDVtfYj6cx/+h7H97WvkuQhY6RGM3TC7zEOfeHdgVCRI2vzxTcPT3t5Gl
 VeDVOuKPSycvx4butH9xgKjmD5ybiOMZezgi70utnES31XPKwNB5V5POfvfsIKYvAadWdjqTt
 1CTgN8AmjAdsK7WWgcWQ/sJfd/SmYOS2BV1Y2DAUqHrFzH0AB9cSFTxyi/+pl9/d0YsjbACJU
 AvG58Ph1PQmzSciGegi22OzIms+Nyfy/4X1cp1OS7K2AvFsudbIPr2p05RT5MdxitR39UiBQJ
 WC/r5c/4DxaLoo/Ry0sG+PWc7hk+tq5EZQEK4qVL8ArmtHSDeXXFLdK9URJV3mjHMbayNsQfj
 agP2wQJqjxo/qp/RIkAV03Vf7H1yENEYSeJ73PgjfZL/tzE6nZusjZ+gGxwE39NXCk479TzG1
 8eDb4s96wYaMEGRLKvOri0UcRo7C4YEqXiczi+qgzfpIAXYcN8NZkOPMrTUnAmkMcLS7qaYvn
 qltbmLsYoWk4zjatUB8Qb/rWMqYudXN1XkTHLIdWSwYal+gVNDJhbkntc/wvzYmcypaA1ytpT
 dhE3dd6oeyxhg0zK1V37Co/w5XBVQVu001A0abNdPP6Y5P6mbGODSmWwTsYmO0/Vq66mrkhw1
 fUN3S6+CGGYICNZr5lA30oWzbgxwDu/WrYQlSG4yYhiUBHEG6o/JFrmw+BGtNRk8LU4sI3lPN
 7UPd05O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function that returns a buffer containing the absolute path of its
argument and a semantic patch for its intended use.  It avoids an extra
string copy to a static buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 abspath.c                                | 7 +++++++
 cache.h                                  | 1 +
 contrib/coccinelle/xstrdup_or_null.cocci | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/abspath.c b/abspath.c
index fce40fddcc..2f0c26e0e2 100644
--- a/abspath.c
+++ b/abspath.c
@@ -239,6 +239,13 @@ const char *absolute_path(const char *path)
 	return sb.buf;
 }
 
+char *absolute_pathdup(const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_add_absolute_path(&sb, path);
+	return strbuf_detach(&sb, NULL);
+}
+
 /*
  * Unlike prefix_path, this should be used if the named file does
  * not have to interact with index entry; i.e. name of a random file
diff --git a/cache.h b/cache.h
index 00a029af36..d7b7a8cd7a 100644
--- a/cache.h
+++ b/cache.h
@@ -1069,6 +1069,7 @@ const char *real_path(const char *path);
 const char *real_path_if_valid(const char *path);
 char *real_pathdup(const char *path);
 const char *absolute_path(const char *path);
+char *absolute_pathdup(const char *path);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
diff --git a/contrib/coccinelle/xstrdup_or_null.cocci b/contrib/coccinelle/xstrdup_or_null.cocci
index 3fceef132b..8e05d1ca4b 100644
--- a/contrib/coccinelle/xstrdup_or_null.cocci
+++ b/contrib/coccinelle/xstrdup_or_null.cocci
@@ -5,3 +5,9 @@ expression V;
 - if (E)
 -    V = xstrdup(E);
 + V = xstrdup_or_null(E);
+
+@@
+expression E;
+@@
+- xstrdup(absolute_path(E))
++ absolute_pathdup(E)
-- 
2.11.0

