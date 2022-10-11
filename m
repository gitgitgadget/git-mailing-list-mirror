Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC8C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 01:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJKBMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 21:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJKBMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 21:12:49 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4B4CA00
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 18:12:47 -0700 (PDT)
Received: (qmail 29922 invoked by uid 109); 11 Oct 2022 01:12:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Oct 2022 01:12:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16027 invoked by uid 111); 11 Oct 2022 01:12:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Oct 2022 21:12:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Oct 2022 21:12:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com
Subject: Re: [PATCH 4/7] shortlog: support arbitrary commit format `--group`s
Message-ID: <Y0TDDvzeCxIMFbG5@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f38990cc2ea8460ce37437e0770784d9b712dab.1665448437.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 08:34:12PM -0400, Taylor Blau wrote:

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index 4982ceee21..ca15643f45 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -59,6 +59,8 @@ OPTIONS
>     example, if your project uses `Reviewed-by` trailers, you might want
>     to see who has been reviewing with
>     `git shortlog -ns --group=trailer:reviewed-by`.
> + - `<format>`, any string accepted by the `--format` option of 'git log'.
> +   (See the "PRETTY FORMATS" section of linkgit:git-log[1].)

I have a slight preference here to call this:

  --group=format:<format>

and then DWIM:

  --group=<format>

as long as <format> contains a percent. This is similar to how --pretty
works, but leaves us more room for changing things later if we need to.

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
> +		if (strset_add(dups, buf.buf))
> +			insert_one_record(log, buf.buf, oneline);
> +	}
> +
> +	strbuf_release(&buf);
> +}

Versus the earlier patch we discussed, this is one identity per --group,
so it matches how --group=trailer works. Good.

> @@ -243,6 +266,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>  	if (log->groups & SHORTLOG_GROUP_TRAILER) {
>  		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
>  	}
> +	insert_records_from_format(log, &dups, commit, &ctx, oneline_str);

Hmm. I see why we don't need to guard this with:

  if (log->groups & SHORTLOG_GROUP_FORMAT)

since our helper function is a noop if log->format is empty. But I
wonder if:

  - it's more clear to match the others (although it looks like they are
    going away later, so that potentially becomes a non-issue)

  - it's useful to have a conditional that lets us skip any setup work.
    For trailers, in particular, we call logmsg_reencode(), which is
    potentially expensive. OTOH, it would be easy for the helper
    function to just return early when log->format.nr is 0.

So I'll reserve judgement until seeing the end state.

> diff --git a/shortlog.h b/shortlog.h
> index dc388dd459..4850a8c30f 100644
> --- a/shortlog.h
> +++ b/shortlog.h
> @@ -22,8 +22,10 @@ struct shortlog {
>  		SHORTLOG_GROUP_AUTHOR = (1 << 0),
>  		SHORTLOG_GROUP_COMMITTER = (1 << 1),
>  		SHORTLOG_GROUP_TRAILER = (1 << 2),
> +		SHORTLOG_GROUP_FORMAT = (1 << 3),
>  	} groups;
>  	struct string_list trailers;
> +	struct string_list format;

Given that "shortlog --format" does a totally different thing, I wonder
if this needs a more descriptive name like group_format or something.
Probably not. That other format feature is all in rev_info, and it's not
like "trailers" above doesn't have a similar issue.

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 3095b1b2ff..2417ac8896 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -237,6 +237,15 @@ test_expect_success 'shortlog --group=trailer:signed-off-by' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'shortlog --group=<format>' '
> +	git shortlog -s --date="format:%Y" --group="%cN (%cd)" HEAD >actual &&
> +	cat >expect <<-\EOF &&
> +	     4	C O Mitter (2005)
> +	     1	Sin Nombre (2005)
> +	EOF
> +	test_cmp expect actual
> +'

Makes sense. Two other tests that might be worth including:

  - "shortlog --group=bogus" generates an error (we might already have
    such a test; I didn't check)

  - since the multiple-option behavior is so subtle, maybe show a case
    where two formats partially overlap. A plausible one is "--group=%aN
    --group=%cN", but the test setup might need tweaked to cover both.
    There's an existing "multiple groups" test that might come in handy.

-Peff
