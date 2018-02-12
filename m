Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC831F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeBLAVE (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:21:04 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45826 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeBLAVD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:21:03 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id l1rieIT63ykf2l1rje7513; Mon, 12 Feb 2018 00:21:03 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B8mXLtlM c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=7MJ32Hh79HAaw6CPLDQA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] Makefile: suppress a sparse warning for pack-revindex.c
Message-ID: <a57fbfc1-a5a5-0e86-2bbf-82c33909458e@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 00:21:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHkN82CnrrXl6U7/Ym6ddy+7FmQ4AMipoWAvFjgB1x12sVwS0a4ZNo5bk7/CSFaMUWcFcrtj9rLMsd5Y4ur7Ejy91j4q3D432eaOCXLGJArDKph18NZP
 Ywi8uzFqWlfQye3Xz+Kiao7cuUWvt60AoMNnKdx+UzPOelg66YCE5j6JSAm0A0xGPBtEgKsU5zNJTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Sparse has, for a long time, been issuing the following warning against
the pack-revindex.c file:

      SP pack-revindex.c
  pack-revindex.c:64:23: warning: memset with byte count of 262144

This results from a unconditional check, with a hard-coded limit, which
is really only appropriate for the kernel source code. (The check is for
a 'large' byte count in a call to memcpy(), memset(), copy_from_user()
and copy_to_user() functions).

A recent release of sparse (v0.5.1) has introduced some options to allow
this check to be turned off (-Wno-memcpy-max-count) or to specify the
actual limit used (-fmemcpy-max-count=COUNT), rather than a hard-coded
limit of 100000.

In order to suppress the warning, add a target for pack-revindex.sp that
adds the '-Wno-memcpy-max-count' option to the SPARSE_FLAGS variable.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 1a9b23b67..7f40f7673 100644
--- a/Makefile
+++ b/Makefile
@@ -2176,6 +2176,8 @@ gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
 http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARSE_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
+pack-revindex.sp: SPARSE_FLAGS += -Wno-memcpy-max-count
+
 ifdef NO_EXPAT
 http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
-- 
2.16.0
