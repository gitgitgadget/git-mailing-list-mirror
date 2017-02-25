Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A2320254
	for <e@80x24.org>; Sat, 25 Feb 2017 16:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdBYQBM (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 11:01:12 -0500
Received: from mout.web.de ([217.72.192.78]:56234 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdBYQBM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 11:01:12 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY6wu-1cm6lP38xU-00UszT; Sat, 25
 Feb 2017 17:00:35 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: add strbuf_add_real_path()
Message-ID: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
Date:   Sat, 25 Feb 2017 17:00:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:s7b9Opld6su+qi+XSvbAZvmIOsHA0CkZVX90DqPuecd2TZDlGHE
 GQd5ID53vURbEd0GrsPrICQJ0qPDauh5qkIFABKZyDMCAZK1bBwpnynQJsZgJnk3q/lY3rU
 oLlxeyhltFtLpz4cP7quQAaJe+pY09mrOeCZ5aZxRX55aTTYozNv2AD1PW9L2cMFYObTFEk
 Ndgyc5kCMr1pNvZ1MGREw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/UUp8D9sfw4=:T3KocpB4Bu7yO3Bx/EFTD7
 7FhoZK5dvxbi84PfVnUyRUyXVt280oFdmoFRPEBnngE6tUZMVPeX4XIJblCxJzCYvVFDj/+bW
 pBUcRnCSUo4w8JXCvsBtQGe+w1v9Omdh/i52fMajNG9yC3hvekoRG3k0VCkuehS2GjOgI8Vrj
 DWDM3Xg3eyuGKgSvatPN4dyV91T5wO93DVCCS8eeJi24eCTvICwTjaw2BvSX0nDsbjQDAF+bm
 H/nOi23lLXCLxd/Wl5YEkzOt2+d/RHNTUlTNNaXGaItQdAMc9+g6Zg4NeLNbiz4qWghDaf2HF
 orqOrYS0ADhv+Q1xW1honpAEnPfYmQuy/RcycEyapnLW+Hhn6FBleXCTf5YTQ6T2cQqmJkxAU
 2ML0ebScvXY8jNpVN3rzJ3GWcbZT8Dri0W4/PLgoCsA5KmOq4Ypzz/fVZFfSIzlxi4aaZaP5P
 ZfukewloNSJFsc7C2MmaNYPEcpIQASFyKh78dnoyw2zJxJxCqaM2qdAgmV/5EdH6MAlTKc38Y
 +NBvTBINMRs3PEQd3XdtABKbD6dmheWb8fojOoxaKShSPu68KZ1XRcrEdDDjbm+NMr15abHQ5
 XJX9BuNNR14uWtOk59M+FDsZ/uoe1agsF2sWKzFpDYJ4DvEF7kXjRSptVycr8Pz8p/e+SOW+n
 VT+ksvDQMmvawhwlvDnatBlf8TZCcw9mKpdwbab3ZDhlWnQw8Gi0YRGBn+9yw70GstB6BjqUa
 rhtADwmVOzyN+BjDsrk7k4sUx4bBBfGKovPB1ntW85koFn/d6T9GXn7yy4jQSen5emwddbT1i
 8Mc0er1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function for appending the canonized absolute pathname of a given
path to a strbuf.  It keeps the existing contents intact, as expected of
a function of the strbuf_add() family, while avoiding copying the result
if the given strbuf is empty.  It's more consistent with the rest of the
strbuf API than strbuf_realpath(), which it's wrapping.

Also add a semantic patch demonstrating its intended usage and apply it
to the current tree.  Using strbuf_add_real_path() instead of calling
strbuf_addstr() and real_path() avoids an extra copy to a static buffer.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/strbuf.cocci |  6 ++++++
 setup.c                         |  2 +-
 strbuf.c                        | 11 +++++++++++
 strbuf.h                        | 14 ++++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 63995f22ff..1d580e49b0 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -38,3 +38,9 @@ expression E1, E2, E3;
 @@
 - strbuf_addstr(E1, find_unique_abbrev(E2, E3));
 + strbuf_add_unique_abbrev(E1, E2, E3);
+
+@@
+expression E1, E2;
+@@
+- strbuf_addstr(E1, real_path(E2));
++ strbuf_add_real_path(E1, E2);
diff --git a/setup.c b/setup.c
index 967f289f1e..f14cbcd338 100644
--- a/setup.c
+++ b/setup.c
@@ -254,7 +254,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
 		if (!is_absolute_path(data.buf))
 			strbuf_addf(&path, "%s/", gitdir);
 		strbuf_addbuf(&path, &data);
-		strbuf_addstr(sb, real_path(path.buf));
+		strbuf_add_real_path(sb, path.buf);
 		ret = 1;
 	} else {
 		strbuf_addstr(sb, gitdir);
diff --git a/strbuf.c b/strbuf.cq
index 8fec6579f7..ace58e7367 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -707,6 +707,17 @@ void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
 	strbuf_addstr(sb, path);
 }
 
+void strbuf_add_real_path(struct strbuf *sb, const char *path)
+{
+	if (sb->len) {
+		struct strbuf resolved = STRBUF_INIT;
+		strbuf_realpath(&resolved, path, 1);
+		strbuf_addbuf(sb, &resolved);
+		strbuf_release(&resolved);
+	} else
+		strbuf_realpath(sb, path, 1);
+}
+
 int printf_ln(const char *fmt, ...)
 {
 	int ret;
diff --git a/strbuf.h b/strbuf.h
index cf1b5409e7..cf8e4bf532 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -441,6 +441,20 @@ extern int strbuf_getcwd(struct strbuf *sb);
  */
 extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
 
+/**
+ * Canonize `path` (make it absolute, resolve symlinks, remove extra
+ * slashes) and append it to `sb`.  Die with an informative error
+ * message if there is a problem.
+ *
+ * The directory part of `path` (i.e., everything up to the last
+ * dir_sep) must denote a valid, existing directory, but the last
+ * component need not exist.
+ *
+ * Callers that don't mind links should use the more lightweight
+ * strbuf_add_absolute_path() instead.
+ */
+extern void strbuf_add_real_path(struct strbuf *sb, const char *path);
+
 
 /**
  * Normalize in-place the path contained in the strbuf. See
-- 
2.12.0

