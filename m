Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6225C4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F3D61074
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbhHaTf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:35:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:35468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240857AbhHaTf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 15:35:57 -0400
Received: (qmail 13198 invoked by uid 109); 31 Aug 2021 19:35:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 19:35:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29344 invoked by uid 111); 31 Aug 2021 19:35:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 15:35:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 15:35:00 -0400
From:   Jeff King <peff@peff.net>
To:     Tal Kelrich via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tal Kelrich <hasturkun@gmail.com>
Subject: Re: [PATCH] fast-export: fix anonymized tag using original length
Message-ID: <YS6EZKXCxohA7Wt8@coredump.intra.peff.net>
References: <pull.1030.git.1630425354496.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1030.git.1630425354496.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 03:55:54PM +0000, Tal Kelrich via GitGitGadget wrote:

> From: Tal Kelrich <hasturkun@gmail.com>
> 
> Commit 7f4075949686 (fast-export: tighten anonymize_mem() interface to
> handle only strings, 2020-06-23) changed the interface used in anonymizing
> strings, but failed to update the size of annotated tag messages to match
> the new anonymized string.
> 
> As a result, exporting tags having messages longer than 13 characters
> would create output that couldn't be parsed by fast-import,
> as the data length indicated was larger than the data output.
> 
> Reset the message size when anonymizing, and add a tag with a "long"
> message to the test.

Thanks, good catch and nicely explained. I wondered where the "13" came
from, and it is "tag message %d" (so really, it depends how many tags
you have :) ).

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 3c20f164f0f..95e8e89e81f 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -821,6 +821,7 @@ static void handle_tag(const char *name, struct tag *tag)
>  			static struct hashmap tags;
>  			message = anonymize_str(&tags, anonymize_tag,
>  						message, message_size, NULL);
> +			message_size = strlen(message);
>  		}
>  	}

In the other callers, we just treat the return value from
anonymize_str() like a string afterwards, so they naturally adapted to
the anonymized content. But here the rest of the tag code uses the size,
so we have to update it. Makes sense (both why the fix here, but why a
similar fix is not needed elsewhere).

> diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
> index 1c6e6fcdaf3..77047e250dc 100755
> --- a/t/t9351-fast-export-anonymize.sh
> +++ b/t/t9351-fast-export-anonymize.sh
> @@ -18,7 +18,8 @@ test_expect_success 'setup simple repo' '
>  	git update-index --add --cacheinfo 160000,$fake_commit,link1 &&
>  	git update-index --add --cacheinfo 160000,$fake_commit,link2 &&
>  	git commit -m "add gitlink" &&
> -	git tag -m "annotated tag" mytag
> +	git tag -m "annotated tag" mytag &&
> +	git tag -m "annotated tag with long message" longtag
>  '

I was curious why the existing tests did not catch even the truncation.
I think we only assert that the original tag content does not appear.
But moreover, the values before/after anonymization coincidentally have
exactly the same length:

  annotated tag
  tag message 1

so it did not even trigger the bug.

-Peff
