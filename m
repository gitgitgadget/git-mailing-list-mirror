Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65536C3B1BF
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 06:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110C20659
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 06:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgBPGvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 01:51:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:45058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725866AbgBPGvD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 01:51:03 -0500
Received: (qmail 32623 invoked by uid 109); 16 Feb 2020 06:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Feb 2020 06:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1269 invoked by uid 111); 16 Feb 2020 07:00:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Feb 2020 02:00:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Feb 2020 01:51:01 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, gitster@pobox.com, rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200216065101.GA2937208@coredump.intra.peff.net>
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
 <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 15, 2020 at 06:34:13PM -0300, Matheus Tavares wrote:

> If a tag describes a commit, we currently output not the tag's ref but
> its embedded name. This means that when the tag is locally stored under
> a different name, the output given cannot be used to access the tag in
> any way. A warning is also emitted in this case, but the message is not
> very enlightening:
> 
> $ git tag -am "testing tag body" testing-tag
> $ mv .git/refs/tags/testing-tag .git/refs/tags/testing-tag-with-new-name
> $ git describe --tags --abbrev=0
> warning: tag 'testing-tag' is really 'testing-tag-with-new-name' here
> testing-tag
> 
> Let's make git-describe output the tag's local name instead and
> rephrase the warning to reflect the situation a little better.

Thanks. I had this on my "eh, we should probably do it before we forget"
pile, so I was quite happy to see that somebody had already handled it. :)

I think the conversion of the die() to warning() makes sense here. Do we
want to cover that with a test?

> Since the embedded name will no longer be needed for correct output, we
> can convert the die() call in append_name() when a tag doesn't have the
> embedded name to a warning(). Also, this function will now have two
> disconnected responsibilities: verifying if the tag's embedded name
> matches the ref and actually appending the ref to a given buffer (which
> does not depend on the parsed tag object itself). Thus, to increase
> intelligibility, let's make the function specialize in the former and do
> the latter outside it.

Pulling the buffer append out of the function makes a lot of sense as
well. I was puzzled at first that this old code:

> -
> -	if (n->tag) {
> -		if (all)
> -			strbuf_addstr(dst, "tags/");
> -		strbuf_addstr(dst, n->tag->tag);
> -	} else {
> -		strbuf_addstr(dst, n->path);
> -	}
>  }

...used "tags/" for "--all", but the new code doesn't:

> @@ -313,7 +305,8 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
>  		/*
>  		 * Exact match to an existing ref.
>  		 */
> -		append_name(n, dst);
> +		verify_tag_embedded_name(n);
> +		strbuf_addstr(dst, n->path);

But that makes sense. As the else clause in the old code shows, our
n->path is already set up correctly. So not only are we splitting out
the "append" concern, but we're able to make it simpler. Good.

> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 09c50f3f04..d34c091e0b 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -129,9 +129,9 @@ test_expect_success 'rename tag A to Q locally' '
>  	mv .git/refs/tags/A .git/refs/tags/Q
>  '
>  cat - >err.expect <<EOF
> -warning: tag 'A' is really 'Q' here
> +warning: tag 'Q' is externally known as 'A'
>  EOF
> -check_describe A-* HEAD
> +check_describe Q-* HEAD
>  test_expect_success 'warning was displayed for Q' '
>  	test_i18ncmp err.expect err.actual

And this test change makes sense. I had to look up how check_describe
works, but that first argument is the expected output.

So the whole thing looks good to me, with or without the die/warning
test I mentioned above.

-Peff
