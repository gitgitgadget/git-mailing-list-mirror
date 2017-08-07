Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E732047F
	for <e@80x24.org>; Mon,  7 Aug 2017 13:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdHGN5g (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 09:57:36 -0400
Received: from mout.web.de ([212.227.17.11]:63705 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbdHGN5f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 09:57:35 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M73SD-1dSwmW2QpZ-00wlUh; Mon, 07
 Aug 2017 15:57:33 +0200
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] test-path-utils: handle const parameter of basename and
 dirname
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Message-ID: <5bfd3c7c-c3c8-5115-713a-63f6f8cd7eb7@web.de>
Date:   Mon, 7 Aug 2017 15:57:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:w4mGhEBzeEgk6UHAZOPhjSVzGKqwKsnTnIHUqlw/MhKFydlBsMl
 d6emSukgTK46rKzqnIwFbOxyVvkZKEul50ry+ROITuZmZtmauXDPWxn6mq7+FthhtDIsrN7
 +LID3vY5Xh2Xo1PulT///cVXBFmvABIo52qHEB4abSQxQH1YQt/xMCZ6YsDn+ivaHy5kJjM
 mwv8OMsN5vxTSMc3W5TlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wXmY373NDVc=:6shGSJ62OWvPReBx+ChbhQ
 n2FIdOJU/tmwvi5vLA+/TmiTMUFPv+K7nruSG24ngfZWLaOv0WpRr5fLRc7+5WV19YBQ3tJQA
 cURzZttbUAFz49OAphpUwDPyINIPaviE0ePO3P/wFZ6ocCfIV42tc2rrhTVHz6UOftCYhNQIx
 6gPGmPZSwrPG8oXOcbgKiTnfsY68uIxdg7hv/1N787orGlXbCyvkiBRSfwUsM0x4Y8UV33nF6
 eo+F5h4gYKFfNc0VFYJbVMse1U5sqBuLyuRWWZSSxd+CYSdtnXYDDc9x686TWsMM0r4qhgcuK
 qXx1Y8FI41gIbIXlgWcP6Cyvor00jpzUhMhp/uxY6pIgSAdq7b/2Shs5ZfrCHPiV6NpHNIx/v
 6AyDzeCS6iCLWqhEQWPRV6wWlE9uPRQeNoW8rzYuGKoa6DGeAWGLEFlRoW7kNpcD+Z2I4tCYQ
 KNPxJYVO8GMc2xJV7iGg1pkBdqjMcEu0aS43lAZpeblDlpSVezjEcCHep7SsYdFMwfwQ0l2qp
 RIT6dWakCi1UkD3pymj+zeviK6lapEKVUj2Go5DJN6EcI35Jah98nEGPpsyS2qdqqZ+0hXl8W
 Fl/6UAqhfqiPiiMcgt/JMnblyiCFDkHmCcfiFbr26vRE/2Np+tyJJwj864q3uVJtkXXjULYj4
 b1cfOpcv7TR3YajNbIH97MhxWm2W97B366my0bH+n8q+UhQbVTVYv1D/Qvm4D480hdLplD9Wd
 aaogkGZd1NpkkY317hss0qpSURhY735xmi24h1PbWpUcZuBWNG4Yy3GRuwYdXc8Tn3Q+TwsTz
 3NCXLZybOgRC2Uguf2lIAyjSTjPEWnEd/bQi+6l9DfD4GNd4Sw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parameter to basename(3) and dirname(3) traditionally had the type
"char *", but on OpenBSD it's been "const char *" for years.  That
causes (at least) Clang to throw an incompatible-pointer-types warning
for test-path-utils, where we try to pass around pointers to these
functions.

Avoid this warning (which is fatal in DEVELOPER mode) by ignoring the
promise of OpenBSD's implementations to keep input strings unmodified
and enclosing them in POSIX-compatible wrappers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/helper/test-path-utils.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 1ebe0f750c..2b3c5092a1 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -38,6 +38,20 @@ struct test_data {
 	const char *alternative; /* output: ... or this.      */
 };
 
+/*
+ * Compatibility wrappers for OpenBSD, whose basename(3) and dirname(3)
+ * have const parameters.
+ */
+static char *posix_basename(char *path)
+{
+	return basename(path);
+}
+
+static char *posix_dirname(char *path)
+{
+	return dirname(path);
+}
+
 static int test_function(struct test_data *data, char *(*func)(char *input),
 	const char *funcname)
 {
@@ -251,10 +265,10 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (argc == 2 && !strcmp(argv[1], "basename"))
-		return test_function(basename_data, basename, argv[1]);
+		return test_function(basename_data, posix_basename, argv[1]);
 
 	if (argc == 2 && !strcmp(argv[1], "dirname"))
-		return test_function(dirname_data, dirname, argv[1]);
+		return test_function(dirname_data, posix_dirname, argv[1]);
 
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
-- 
2.14.0

