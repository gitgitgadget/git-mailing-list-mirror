Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D318AC432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0DB60F46
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhH2VBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 17:01:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:33516 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234667AbhH2VBI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 17:01:08 -0400
Received: (qmail 24461 invoked by uid 109); 29 Aug 2021 21:00:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 29 Aug 2021 21:00:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2861 invoked by uid 111); 29 Aug 2021 21:00:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Aug 2021 17:00:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Aug 2021 17:00:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <YSv1XZJvYdYj1JtP@coredump.intra.peff.net>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSvsQcGNpCMZwS8o@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 04:21:21PM -0400, Taylor Blau wrote:

> > +++ b/merge-recursive.c
> > @@ -55,10 +55,7 @@ static int path_hashmap_cmp(const void *cmp_data,
> [...]
> 
> Looks obviously right to me. I found another spot in
> t/helper/test-hashmap.c:test_entry_cmp() that could be cleaned up in the
> same way. But this looks fine with or without the following diff:
> 
> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index 36ff07bd4b..ab34bdfecd 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -28,10 +28,7 @@ static int test_entry_cmp(const void *cmp_data,
>         e1 = container_of(eptr, const struct test_entry, ent);
>         e2 = container_of(entry_or_key, const struct test_entry, ent);
> 
> -       if (ignore_case)
> -               return strcasecmp(e1->key, key ? key : e2->key);
> -       else
> -               return strcmp(e1->key, key ? key : e2->key);
> +       return fspathcmp(e1->key, key ? key : e2->key);
>  }
> 
>  static struct test_entry *alloc_test_entry(unsigned int hash,

Maybe also:

diff --git a/dir.c b/dir.c
index 03c4d21267..ee46290cbb 100644
--- a/dir.c
+++ b/dir.c
@@ -669,9 +669,7 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 			 ? ee1->patternlen
 			 : ee2->patternlen;
 
-	if (ignore_case)
-		return strncasecmp(ee1->pattern, ee2->pattern, min_len);
-	return strncmp(ee1->pattern, ee2->pattern, min_len);
+	return fspathncmp(ee1->pattern, ee2->pattern, min_len);
 }
 
 static char *dup_and_filter_pattern(const char *pattern)

This is fun. :)

-Peff
