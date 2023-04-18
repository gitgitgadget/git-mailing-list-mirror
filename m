Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A728DC77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 10:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDRKYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjDRKX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 06:23:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50054EC3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 03:23:21 -0700 (PDT)
Received: (qmail 4866 invoked by uid 109); 18 Apr 2023 10:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 10:23:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 746 invoked by uid 111); 18 Apr 2023 10:23:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 06:23:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 06:23:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <20230418102320.GB508219@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <0f199468a3b8375dbec0f56fdc831c3ac298eb4e.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f199468a3b8375dbec0f56fdc831c3ac298eb4e.1681428696.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2023 at 07:31:46PM -0400, Taylor Blau wrote:

> Avoid using the non-reentrant `strtok()` to separate the parts of each
> incoming command. Instead of replacing it with `strtok_r()`, let's
> instead use the more friendly `string_list_split_in_place_multi()`.

Junio mentioned this offhand in his response, but I wanted to highlight
one difference in before/after behavior here.

  [before]
  $ printf 'add foo    bar\niterate\n' | t/helper/test-tool hashmap
  foo bar

  [after]
  $ printf 'add foo    bar\niterate\n' | t/helper/test-tool hashmap
  foo    bar

I think that's fine for this test script, but it may be an indication
that we want string-list's split to support different semantics.

> @@ -159,21 +161,34 @@ int cmd__hashmap(int argc, const char **argv)
>  
>  	/* process commands from stdin */
>  	while (strbuf_getline(&line, stdin) != EOF) {
> -		char *cmd, *p1 = NULL, *p2 = NULL;
> +		char *cmd, *p1, *p2;
>  		unsigned int hash = 0;
>  		struct test_entry *entry;
>  
> +		/*
> +		 * Because we memdup() the arguments out of the
> +		 * string_list before inserting them into the hashmap,
> +		 * it's OK to set its length back to zero to avoid
> +		 * re-allocating the items array once per line.
> +		 *
> +		 * By doing so, we'll instead overwrite the existing
> +		 * entries and avoid re-allocating.
> +		 */
> +		parts.nr = 0;

I think this is OK, but I wonder if we should wrap it in a function that
makes sure the strings aren't owned by the strdup (and thus aren't being
leaked). Something like:

  void string_list_setlen(struct string_list *sl, size_t nr)
  {
	/* alternatively, I guess we could actually free nr..sl->nr */
	if (sl->strdup_strings)
		BUG("you can't setlen on a string-list which owns its strings");
	if (nr > sl->nr)
		BUG("you can't grow a string-list with setlen");
	sl->nr = nr;
  }

That is probably overkill for these two test helpers, but I wonder if
the pattern might escape into "real" code (especially if we suggest
using string-list instead of strtok).

-Peff
