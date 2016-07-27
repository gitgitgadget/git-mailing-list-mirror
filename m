Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98709203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbcG0R41 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:56:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:49940 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754303AbcG0R41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:56:27 -0400
Received: (qmail 32654 invoked by uid 102); 27 Jul 2016 17:56:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 13:56:26 -0400
Received: (qmail 18818 invoked by uid 107); 27 Jul 2016 17:56:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 Jul 2016 13:56:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2016 13:56:23 -0400
Date:	Wed, 27 Jul 2016 13:56:23 -0400
From:	Jeff King <peff@peff.net>
To:	Phil Pennock <phil@pennock-tech.com>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
Message-ID: <20160727175622.GA9961@sigill.intra.peff.net>
References: <20160727081414.GA21451@breadbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160727081414.GA21451@breadbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 27, 2016 at 04:14:14AM -0400, Phil Pennock wrote:

> The reflog contains timestamp information, but these were not exposed to
> `--pretty`.  Four of the six author/committer format string
> second-letters were still available and copied, but `d`/`D` are taken
> for reflog selector formatting.  So use `%gT` for "time" instead of
> "date" mnemonic for using `--date=...` formatting.

So as I mentioned before, this is similar to another recent patch. But I
kind of like this one better, so let me give this one a more thorough
review.

> Implementation trade-off: could use `format_person_part()` if bounce
> information out of the reflog as a buffer-constructed string, then parse
> it back again, _and_ then use a hacky letter override for 'T' becoming
> 'd'.  That would avoid reimplementing the specification of the five
> added timestamp rendering cases.  Instead, we allow exporting the
> timestamp information from the reflog, and if we get it, we add the same
> data.  No memory alloc and string construction/parsing, a small amount
> of duplication of meaning.

I think this is a good tradeoff. Even if you handled 'd' in a hacky way
now, you _don't_ want to "%g*" to magically grow to learn new placeholders
that "%a*" does, as they might conflict with other "%g" formats in the
same way that "%gd" (i.e., we would need to do a hacky workaround for
_those_ too, but nothing would warn the person adding the new
placeholders).

> +		/*
> +		 * all the date options except those taken for other reflog handling
> +		 * (so not 'd' or 'D').
> +		 */
> +		case 'r':
> +			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
> +				strbuf_addstr(sb, show_date(timestamp, tz, DATE_MODE(RELATIVE)));
> +			}
> +			return 2;
> +		case 't':
> +			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
> +				strbuf_addf(sb, "%lu", timestamp);
> +			}
> +			return 2;
> +		case 'i':
> +			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
> +				strbuf_addstr(sb, show_date(timestamp, tz, DATE_MODE(ISO8601)));
> +			}
> +			return 2;
> +		case 'I':
> +			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
> +				strbuf_addstr(sb, show_date(timestamp, tz, DATE_MODE(ISO8601_STRICT)));
> +			}
> +			return 2;

These all look good. If for whatever reason we don't have a reflog
entry, we write nothing (but still eat the placeholder), which seems
sensible.

One alternative interface would be more like get_reflog_message(), where
it either puts something in a strbuf or not. And then your calls would
look like:

  get_reflog_date(sb, c->pretty_cx->reflog_info, DATE_MODE(ISO8601));

or whatever. Your way here is more flexible, though, if we ever add more
callers.

> +		/*
> +		 * reflog d/D are taken, so we can't use those for dates
> +		 * but we do want to support using --date= format overrides
> +		 * so we steal 'T' for those ('time' instead of 'date')
> +		 */
> +		case 'T':
> +			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
> +				strbuf_addstr(sb, show_date(timestamp, tz, &c->pretty_ctx->date_mode));
> +			}
> +			return 2;
>  		}

I think we can drop this one. It's a nice direction to go eventually,
but without the extra placeholders I mentioned elsewhere, it doesn't buy
us much.

> +int get_reflog_timeinfo(unsigned long *timestamp_out,
> +			 int *tz_out,
> +			 struct reflog_walk_info *reflog_info)
> +{
> +	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
> +	struct reflog_info *info;
> +
> +	if (!commit_reflog)
> +		return 0;
> +
> +	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
> +	*timestamp_out = info->timestamp;
> +	*tz_out = info->tz;
> +	return 1;
> +}

Our usual error-return is "0 is success", "-1 is error".

Though we don't _always_ adhere to that, and I won't be surprised if you
simply copied this from other nearby code.

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index d9f6242..9d211ab 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -533,4 +533,30 @@ EOF
>  	test_cmp expected actual1
>  '
>  
> +refhead1_short=$(git rev-parse --short --verify HEAD@{0}) &&
> +refhead2_short=$(git rev-parse --short --verify HEAD@{1}) &&

We try to push as much as possible into a test_expect_success block,
since it handles things like unexpected output to stderr. I guess you
put these outside because they are used in multiple tests. You don't
have to do that, because tests can affect the greater environment. But
if you do keep something outside of a test, you _don't_ want to use
&&-chaining, as it means that the lines below it (i.e., the next test!)
would simply not be run at all.

But...

> +test_expect_success 'can access the reflog' '
> +	git reflog -n 2 >actual &&
> +	cat >expected <<EOF &&
> +$refhead1_short HEAD@{0}: commit (amend): shorter
> +$refhead2_short HEAD@{1}: commit (amend): short
> +EOF
> +	test_cmp expected actual
> +'

I'm not sure what this is testing. Just that we have reflogs turned on
at all? I think we can skip this, as it's implicit in the
reflog-formatting test below.

And then you can move your environment variables down into that test
(though see below).

> +test_expect_success 'reflog tformat timestamps work' '
> +	git log -g -n 2 \
> +		--pretty=tformat:"%h %gd / %gr %gt%n %gi %gI%n %gT : %gs" > actual &&
> +	cat >expected <<EOF &&
> +$refhead1_short HEAD@{0} / 11 years ago 1112912173
> + 2005-04-07 15:16:13 -0700 2005-04-07T15:16:13-07:00
> + Thu Apr 7 15:16:13 2005 -0700 : commit (amend): shorter
> +$refhead2_short HEAD@{1} / 11 years ago 1112912173
> + 2005-04-07 15:16:13 -0700 2005-04-07T15:16:13-07:00
> + Thu Apr 7 15:16:13 2005 -0700 : commit (amend): short
> +EOF
> +	test_cmp expected actual
> +'

You can use "<<-" to ask the shell to strip leading tabs from the
here-doc. And then you can indent the contents to match the rest of the
test.

I kind of wonder if it would be better to drop "%h" from your format,
too. You're just testing the timestamps, and handling the shortening is
cluttering up the test. So maybe just:

  test_expect_success 'reflog tformat timestamps work' '
	cat >expected <<-\EOF &&
	HEAD@{0}
	11 years ago
	1112912173
	2005-04-07 15:16:13 -0700
	2005-04-07T15:16:13-07:00

	HEAD@{1}
	11 years ago
	1112912173
	2005-04-07 15:16:13 -0700
	2005-04-07T15:16:13-07:00
	EOF
	git log -g -2 --format="%gd%n%gr%n%gt%n%gi%n%gI%n" >actual &&
	test_cmp expected actual
  '

(I did a few more tweaks to the format to hopefully make it easier to
read). It would probably be a more interesting test if the two reflogs
actually had different timestamps, though.

Also, come to think of it, that "%gr" test is going to break in about
year. :-/

We do test relative date formatting via test-date, which can take a
special value for "when is now", but you can't do so via regular
git-log. So the best we could do is check "%gr" separately and just make
sure that it output _something_.

-Peff
