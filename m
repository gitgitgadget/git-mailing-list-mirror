Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F24FC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJUFsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJUFsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:48:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2022D5F0
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:48:23 -0700 (PDT)
Received: (qmail 10545 invoked by uid 109); 21 Oct 2022 05:48:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:48:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1877 invoked by uid 111); 21 Oct 2022 05:48:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:48:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:48:22 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 4/6] shortlog: support arbitrary commit format
 `--group`s
Message-ID: <Y1IyppKatD7piHOO@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <4a36c0ca4e840d53e2fd257e2d97498ced6fb28c.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a36c0ca4e840d53e2fd257e2d97498ced6fb28c.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:38PM -0400, Taylor Blau wrote:

> +static void insert_records_from_format(struct shortlog *log,
> +				       struct strset *dups,
> +				       struct commit *commit,
> +				       struct pretty_print_context *ctx,
> +				       const char *oneline)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item(item, &log->format) {
> +		strbuf_reset(&buf);
> +
> +		format_commit_message(commit, item->string, &buf, ctx);
> +
> +		if (!(log->format.nr > 1 || log->trailers.nr) ||
> +		    strset_add(dups, buf.buf))
> +			insert_one_record(log, buf.buf, oneline);
> +	}

Just to be clear, since I talked about this conditional in the other
thread: what you have here is correct, and now seeing it again in
context, I think it's OK in terms of readability.

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 7547da539d..13ac0bac64 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -244,6 +244,36 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'shortlog --group=format' '
> +	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
> +		HEAD >actual &&
> +	cat >expect <<-\EOF &&
> +	     4	C O Mitter (2005)
> +	     1	Sin Nombre (2005)
> +	EOF
> +	test_cmp expect actual
> +'

OK, so this is a basic test of the feature, and makes sure the --date
support works.

> +test_expect_success 'shortlog --group=<format> DWIM' '
> +	git shortlog -s --date="format:%Y" --group="%cN (%cd)" HEAD >actual &&
> +	test_cmp expect actual
> +'

And this is the same thing but without "format:". Good...

> +test_expect_success 'shortlog multiple --group=format' '
> +	git shortlog -s --date="format:%Y" --group="format:%cN (%cd)" \
> +		HEAD >actual &&
> +	cat >expect <<-\EOF &&
> +	     4	C O Mitter (2005)
> +	     1	Sin Nombre (2005)
> +	EOF
> +	test_cmp expect actual
> +'

...but this one seems redundant. It is not using multiple formats. And
you test that later, in the "can match multiple format groups" test. Is
this one just leftover from development?

> +test_expect_success 'shortlog bogus --group' '
> +	test_must_fail git shortlog --group=bogus HEAD 2>err &&
> +	grep "unknown group type" err
> +'

This one is a nice inclusion. I was surprised we didn't have it already. :)

> +test_expect_success 'shortlog can match multiple format groups' '
> +	cat >expect <<-\EOF &&
> +	     2	User B <b@example.com>
> +	     1	A U Thor <author@example.com>
> +	     1	User A <a@example.com>
> +	EOF
> +	git shortlog -ns \
> +		--group="%(trailers:valueonly,key=some-trailer)" \
> +		--group="%(trailers:valueonly,key=another-trailer)" \
> +		-2 HEAD >actual.raw &&
> +	grep -v "^$" actual.raw >actual &&
> +	test_cmp expect actual
> +'

And this one is correct, though I think avoiding trailers is more to the
point; see the other mail I sent.

-Peff
