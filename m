Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7E220899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdHHWHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:07:38 -0400
Received: from mout.web.de ([212.227.15.3]:53602 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbdHHWHh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:07:37 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MGANT-1dtAcW0PzD-00FDdt; Wed, 09
 Aug 2017 00:07:31 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_file: avoid comparison if no packed hash matches the
 first byte
Message-ID: <0c1f898c-46c4-033d-001b-114b17d7d36f@web.de>
Date:   Wed, 9 Aug 2017 00:07:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:DzHPNpUHg8trD63zVULU4+o0lGGkam1Dcmb0iVYd+/RMkTsmXC3
 ugVGrDyB9O1BH6PMb+d8JdOhSvgQNOMlY/J9ale+zhGb0whRcGWx7AVvPYboWBX2SulfB52
 Zj+BZabBQBIMvjRX6Tt8T0kXEiF62h8NokERFmVIGVzGibFUOKSC67N5MFudJefkF9iFwg7
 orEpV7yKX1dCFhKV6gGqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zcMd0yWc3vY=:nY1N/A3iOPwgYejw49b1gc
 EZoJCw7uTXZn3+bVmDpcgyMAqjbwfFpKLw+eniH8YiM7bB2sbHrrlgNRIUYWGa7rQAHHO9qbC
 v3PRdN8m69P896Wbc5P05vmnHZADfYKhh130eJNkoBx7W9qhpFQl95Eu3WJ3j7mRgPwr1VE7x
 CpRPTaBA4TEzJUaHOXiBSDbkN7LK9uSQsezflNxDShunroqpkcEjNOaGNkoghVG7DVilMluGk
 xq+sJQCuCuIsINPpxi9zruFmxZh2a8yAZoCLt+S1Ymd+NsX0NhzezQwzLpnf4awE0nLPHh9eN
 GEypRRy0bT961nl35Wm+jQPZ6eD7yMIdaPNgAHFI2YMeKDe+6Fz2C5rGNxEiVxvvDMlf3d2ZH
 SF2eaKRr/SmUvn1b6nIec1Fj2iCDI0pLBBXFJJ3n52ZLZBpS8kx/U49Y+bf7nbUXsedEcDEnS
 //gj3PvjuhluarVrBwrm+0mGjiBilee1R2GUVMeMNswe9JgJcZQeJaBdw8826iYrUH14th8WC
 TafRYJIw6j+Kp/Wvx+UknpPjvWxFVTWOQeKFtj6JqywDcXX0qc+SZ5uOivnIkYYTrb58l9QjK
 zVSoROTYGPs0xxH6OIGUP3lLpZz0u+7ses4idpehA5PT2MKwHip4Lndwm3tQ0geiNGuj9hHLC
 R5pIFduyClLqffGEEtjbNl7So9BZsg6JbFF+WFIwHEW8tLvjqAAz+G3PlkyAMVW6+KupHSLvd
 jYCgL/Jh2CvzPkuccCNcWGtvmvwu4yxx1oxjl5OXrCyeiBAHWCf2EJMOQxUqAoFRQcz23PpDh
 dmlCiGzUEybe3UCa+Vs9YhRpQM7QxfKzH6GvFwoO8vyobpTqyM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find_pack_entry_one() uses the fan-out table of pack indexes to find out
which entries match the first byte of the searched hash and does a
binary search on this subset of the main index table.

If there are no matching entries then lo and hi will have the same
value.  The binary search still starts and compares the hash of the
following entry (which has a non-matching first byte, so won't cause any
trouble), or whatever comes after the sorted list of entries.

The probability of that stray comparison matching by mistake is low, but
let's not take any chances and check when entering the binary search
loop if we're actually done already.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index b60ae15f70..11ee69a99d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2799,7 +2799,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 		return nth_packed_object_offset(p, pos);
 	}
 
-	do {
+	while (lo < hi) {
 		unsigned mi = (lo + hi) / 2;
 		int cmp = hashcmp(index + mi * stride, sha1);
 
@@ -2812,7 +2812,7 @@ off_t find_pack_entry_one(const unsigned char *sha1,
 			hi = mi;
 		else
 			lo = mi+1;
-	} while (lo < hi);
+	}
 	return 0;
 }
 
-- 
2.14.0

