Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81FC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD20760F24
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKASUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 14:20:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55071 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhKASUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 14:20:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65EE4161357;
        Mon,  1 Nov 2021 14:18:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v9YPcnzrZjzO/dJ1HbQTKVkCJjGaat2RQnPa62
        7R4qo=; b=VXkqT6Xr8I/zq8rZkLKQ+96VQrFUrEs3RZKmOPIb7a+Pfb5xifOQ2N
        MCrcDWSUrOOxINYaujyjrLASxamUJLk2lqSQbSaoq8YSS09r2JmFmEYMHyES/p1M
        n97/rUvT0nGjDvy/emIHLJyCPbjkAfXj7nOVYQjdBve/1gsl9gGic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B548161356;
        Mon,  1 Nov 2021 14:18:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A20C161352;
        Mon,  1 Nov 2021 14:18:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: timezone related bug of git
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
        <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
        <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
        <xmqqcznldobz.fsf@gitster.g>
        <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
Date:   Mon, 01 Nov 2021 11:18:02 -0700
In-Reply-To: <YX9nLJZXB3rOrMru@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 1 Nov 2021 00:03:56 -0400")
Message-ID: <xmqq1r3zd9k5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D9AEFFE-3B40-11EC-AE0C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I won't be at all surprised if it has funny corner cases. Our
> tm_to_time_t() is pretty basic and hacky. We can't use mktime() because
> it only handles the current system timezone. OTOH, I think the tz_offset
> we're undoing here originally came from comparing mktime() versus
> tm_to_time_t() via local_time_tzoffset(), so it could be cancelling out
> any bugs exactly. :)
>
> So maybe the code below is sufficient, but we'd probably at least want
> some tests on top. Maybe something somebody interested would like to
> pick up and run with?

It would be very hard to write a code that does not work correctly
on a timestamp created in the same zone in the same season. It is
easy to get the direction of the offset wrong and not notice with
such a test, but with another test to show a timestamp from a zone
in a different zone (or across season boundary in an area where
daylight saving time is s thing), such an error can easily be
caught.

> ---
> diff --git a/cache.h b/cache.h
> index eba12487b9..aa6f380d10 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1588,6 +1588,7 @@ timestamp_t approxidate_careful(const char *, int *);
>  timestamp_t approxidate_relative(const char *date);
>  void parse_date_format(const char *format, struct date_mode *mode);
>  int date_overflows(timestamp_t date);
> +time_t tm_to_time_t(const struct tm *tm);
>  
>  #define IDENT_STRICT	       1
>  #define IDENT_NO_DATE	       2
> diff --git a/date.c b/date.c
> index c55ea47e96..84bb4451c1 100644
> --- a/date.c
> +++ b/date.c
> @@ -9,7 +9,7 @@
>  /*
>   * This is like mktime, but without normalization of tm_wday and tm_yday.
>   */
> -static time_t tm_to_time_t(const struct tm *tm)
> +time_t tm_to_time_t(const struct tm *tm)
>  {
>  	static const int mdays[] = {
>  	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
> diff --git a/strbuf.c b/strbuf.c
> index b22e981655..8b8b1900bc 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -1019,6 +1019,13 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>  			strbuf_addstr(&munged_fmt, "%%");
>  			fmt++;
>  			break;
> +		case 's':
> +			strbuf_addf(&munged_fmt, "%"PRItime,
> +				    tm_to_time_t(tm) -
> +				    3600 * (tz_offset / 100) -
> +				    60 * (tz_offset % 100));
> +			fmt++;
> +			break;

In show_date(), we start from UNIX time and go to "struct tm" using
either the system gmtime_r() (after adjusting the value with the tz
offset of the original timestamp) or localtime_r() (when we are
trying to show the value in our local timestamp), but this codepath
needs to undo that.  Our tm_to_time_t() indeed is basic but should
work correctly on a broken down UTC.  So the caller needs to further
compensate for the tz offset.

I have to wonder why gm_time_t() needs to use two separate codepaths
for positive and negative tz_offset, while the new code here can get
away without.  Does it have something to do with the direction of
truncation during division and modulo operation?

Thanks.
