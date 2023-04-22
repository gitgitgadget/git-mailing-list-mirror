Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F21C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 11:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDVLRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVLRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 07:17:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCB419B1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 04:16:59 -0700 (PDT)
Received: (qmail 10919 invoked by uid 109); 22 Apr 2023 11:16:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Apr 2023 11:16:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27690 invoked by uid 111); 22 Apr 2023 11:16:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Apr 2023 07:16:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Apr 2023 07:16:57 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] t/helper/test-hashmap.c: avoid using `strtok()`
Message-ID: <20230422111657.GD2969939@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
 <0ae07dec3663d7cbb0f8662c47485c0667a879b9.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ae07dec3663d7cbb0f8662c47485c0667a879b9.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 03:18:49PM -0400, Taylor Blau wrote:

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
> +		string_list_setlen(&parts, 0);
>  		/* break line into command and up to two parameters */
> -		cmd = strtok(line.buf, DELIM);
> +		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
> +

I'd argue we can drop this comment now. Having string_list_setlen()
makes it a blessed pattern, and I don't think there's anything special
about this caller that makes it more or less so. Obviously yes, the
string list items won't be valid as we enter a new loop iteration. But
that is always true of split_in_place(), not to mention strtok(),
because we are overwriting the buffer in each loop.

Ditto for the later commits which have similar (if shorter) comments.

-Peff
