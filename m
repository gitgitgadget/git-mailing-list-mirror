Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F081FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 20:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdBJUEk (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 15:04:40 -0500
Received: from mout.web.de ([212.227.15.14]:49987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbdBJUEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 15:04:39 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6mgu-1cFMjw3tno-00wVLe; Fri, 10
 Feb 2017 21:03:33 +0100
Subject: [PATCH 2/2] ls-files: move only kept cache entries in prune_cache()
To:     Git List <git@vger.kernel.org>
References: <f480bd26-f74e-9088-844d-26cde0843baa@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <de84d0f4-cfce-1e73-6d5d-ad18df507d32@web.de>
Date:   Fri, 10 Feb 2017 21:03:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f480bd26-f74e-9088-844d-26cde0843baa@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:g7UGRPMbmS+u4rI5GJ34Tb96fqqQtScZovwXjVlgkAeZsXfzcRb
 cX5C38jsJnu4E0hj9LJS6EXAO0JOYS0VsZ9M+tGxu2qkX3aMqwBsOyLNq2QsuyqrG59HfnY
 AmY0IXsUsJLvxJ6dyxuw5l/yyUFVZlNYd1SEc3FEPmtz6fY5nIZHIH2IUzWWm5Z8vTXHGNv
 z2HwcZL4YmFsAIYluHCKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MzVgWqW9oYY=:dSwTDcdKHTN6982DXnZNjU
 MD4naJ5JpboG3r3Q3e51/VSltF303o7RbXB3v/izpqLZMq4o+fd6GDvSFtay60H4J6CaANpTl
 JqxZq+qWpRBXyKvo27fAgeqkEjVq+RD5XE2rbkqpWlytDERin1dB9rk/l3CPHVro7Y/CXV5ef
 4AL6e5AfcCrkPCtFwSy1NRqBpW3Tofw4IX7kBU2zX3Hp5Mbj6hzhRvERGwT5BMbDENLpylQJG
 NogPC1xVO0RsZdlDnTitRNi7pprBEc3KgR+cK5WlpwA6S+dyhvE64XJ3I/hL/16+DUd4IbzQT
 6TvluSIAcfPzB3Hu0y2OtOVMSZG1a4fBX8MMLRhIar14S9guCINwqk6BawsZIG2jz0WqI06Tb
 mmXz/5W9fMs3nY759WXZ8uCxnjMh0YEm5h5Hu8oMWNYH8MpLnwrizq0J/O2akpaRoCsymETMt
 oCYxOYdM+z2zr3T+ofdIFEx4xD4p9FVhNKkTIBsd/yx+gvAjXuesxJR+nOlYy+ieeo+IMM2A9
 zW41X9nn/cKF3By33LcyOpJcmjqe/Q05TozZqIWvwk2opK1ASrvo6JwYktns2SKBN6jts8Sjf
 gTjypEyspDwJp66wO1IGlfa8W/l2MiFZ623YOo4pjhSlUAPGwGi5oiabpXXjggGpPws5S28YA
 Ok8plwoVjjoYtgJAfG11rlbrzATjmVf4lO38io3HvJ/WVe8liVJNJMdtl3UgzXk+uqVjUmDcs
 uGNUmXM2wyscm7+N1Fc+SaAMDaLrQRwDUehbuO5dQ7iLf1iny0vNxVFafyDpZFyd5t5FgrKpt
 yOHpxT2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prune_cache() first identifies those entries at the start of the sorted
array that can be discarded.  Then it moves the rest of the entries up.
Last it identifies the unwanted trailing entries among the moved ones
and cuts them off.

Change the order: Identify both start *and* end of the range to keep
first and then move only those entries to the top.  The resulting code
is slightly shorter and a bit more efficient.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The performance impact is probably only measurable with a *really* big
index.

 builtin/ls-files.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 18105ec7ea..1c0f057d02 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -379,10 +379,7 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 	pos = cache_name_pos(prefix, prefixlen);
 	if (pos < 0)
 		pos = -pos-1;
-	memmove(active_cache, active_cache + pos,
-		(active_nr - pos) * sizeof(struct cache_entry *));
-	active_nr -= pos;
-	first = 0;
+	first = pos;
 	last = active_nr;
 	while (last > first) {
 		int next = (last + first) >> 1;
@@ -393,7 +390,9 @@ static void prune_cache(const char *prefix, size_t prefixlen)
 		}
 		last = next;
 	}
-	active_nr = last;
+	memmove(active_cache, active_cache + pos,
+		(last - pos) * sizeof(struct cache_entry *));
+	active_nr = last - pos;
 }
 
 /*
-- 
2.11.1

