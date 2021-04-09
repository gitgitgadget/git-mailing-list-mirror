Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5964FC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F38610E5
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhDISYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:24:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:46804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDISYf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:24:35 -0400
Received: (qmail 956 invoked by uid 109); 9 Apr 2021 18:24:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 18:24:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15447 invoked by uid 111); 9 Apr 2021 18:24:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Apr 2021 14:24:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Apr 2021 14:24:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/6] object-file.c: make oid_object_info() return "enum
 object_type"
Message-ID: <YHCb1JQ7Nv9b6jDK@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-0.6-0000000000-20210409T082935Z-avarab@gmail.com>
 <patch-4.6-ebea1b2b50-20210409T082935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-4.6-ebea1b2b50-20210409T082935Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 09, 2021 at 10:32:52AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change oid_object_info() to return an "enum object_type". Unlike
> oid_object_info_extended() function the simpler oid_object_info()
> explicitly returns the oi.typep member, which is itself an "enum
> object_type".

OK. I don't think there is much difference from the compiler perspective
(because of the equivalence of enums and ints in C), but it gives a clue
to the reader about how the value is meant to be interpreted.

> @@ -405,10 +404,10 @@ static int repo_collect_ambiguous(struct repository *r,
>  static int sort_ambiguous(const void *a, const void *b, void *ctx)
>  {
>  	struct repository *sort_ambiguous_repo = ctx;
> -	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
> -	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
> -	int a_type_sort;
> -	int b_type_sort;
> +	enum object_type a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
> +	enum object_type b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
> +	enum object_type a_type_sort;
> +	enum object_type b_type_sort;

Not new in your patch, but the way this function uses modulo is
interesting:

  a_type_sort = a_type % 4;
  b_type_sort = b_type % 4;

What happens if we got OBJ_BAD as one of the results? We are not
indexing any arrays here, so I guess the worst case is that we sort
things in a weird way (and presumably we'd barf later when trying to
show the output anyway).

> --- a/object-store.h
> +++ b/object-store.h
> @@ -208,7 +208,9 @@ static inline void *repo_read_object_file(struct repository *r,
>  #endif
>  
>  /* Read and unpack an object file into memory, write memory to an object file */
> -int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
> +enum object_type oid_object_info(struct repository *r,
> +				 const struct object_id *,
> +				 unsigned long *);

Also not new in your patch, but that comment sure is misleading. :)

-Peff
