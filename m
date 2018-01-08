Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642251FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934212AbeAHT4Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:56:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59259 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934068AbeAHT4O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:56:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8005B5F96;
        Mon,  8 Jan 2018 14:56:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xP0okqHeCwU+EPoLF6iYmP2ilXs=; b=YJZjiG
        D0Byy75s939xHy1KvnTkysm7GsNYCVbQcp91WywH41q6HgIFMorgYLVrnU3NGU+G
        BwgVsZD4NZVl+6WQoTwdehf9hwWqSBkEGWpS9eosvG4FbmnH8MjVuBqOUhMHAqdH
        IX7dJ6PCkmx9Bu8WN7CBXvyJm5s3ZhQ/SVBWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PGNgSAYvVaoJ4fl+FelcbI58DKU84vxE
        bUGmkG20nGoQy7MK/uSqis8BI01XPZe009/B/F9t9Hv+p4ZJg7Y82VRochzwTVsQ
        Ho/dqKUXLB+Gh6gfgpyaiYf5yHKq0D1pk1OG1dve6ApKKJCS7WCCpfyVJY74dDRa
        xyzQx0SdHhw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF28CB5F95;
        Mon,  8 Jan 2018 14:56:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C38AB5F94;
        Mon,  8 Jan 2018 14:56:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCHv3 4/4] builtin/blame: highlight recently changed lines
References: <20171110011002.10179-1-sbeller@google.com>
        <20180104224007.214548-1-sbeller@google.com>
        <20180104224007.214548-5-sbeller@google.com>
Date:   Mon, 08 Jan 2018 11:56:11 -0800
In-Reply-To: <20180104224007.214548-5-sbeller@google.com> (Stefan Beller's
        message of "Thu, 4 Jan 2018 14:40:07 -0800")
Message-ID: <xmqqfu7g86qs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA423DCC-F4AD-11E7-B056-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +static struct color_field {
> +	timestamp_t hop;
> +	char col[COLOR_MAXLEN];
> +} *colorfield;
> +static int colorfield_nr, colorfield_alloc;
> +
> +static void parse_color_fields(const char *s)
> +{
> +	struct string_list l = STRING_LIST_INIT_DUP;
> +	struct string_list_item *item;
> +	enum { EXPECT_DATE, EXPECT_COLOR } next = EXPECT_COLOR;
> +
> +	/* Ideally this would be stripped and split at the same time? */
> +	string_list_split(&l, s, ',', -1);
> +	ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
> +
> +	for_each_string_list_item(item, &l) {
> +		switch (next) {
> +		case EXPECT_DATE:
> +			colorfield[colorfield_nr].hop = approxidate(item->string);
> +			next = EXPECT_COLOR;
> +			colorfield_nr++;
> +			ALLOC_GROW(colorfield, colorfield_nr + 1, colorfield_alloc);
> +			break;

This should make sure cf[i].hop is monotonically increasing to avoid
end-user mistakes, I would think (what's 'hop' by the way?).

> +		case EXPECT_COLOR:
> +			if (color_parse(item->string, colorfield[colorfield_nr].col))
> +				die(_("expecting a color: %s"), item->string);

When you have a typo in one of your configuration files, say "[color
"blame"] highlightrecent = 1,week,blue,...", you'd want to see a bit
more than just "expecting a color: week" to help you diagnose and
resolve the issue.  Giving the name of the variable and the file the
wrong definition was found in would be needed, givin that this is
called from the config callback git_blame_config() below.

> +			next = EXPECT_DATE;
> +			break;
> +		}
> +	}
> +
> +	if (next == EXPECT_COLOR)
> +		die (_("must end with a color"));

Same here.

>  		OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line differently"), OUTPUT_COLOR_LINE),
>  		OPT_BIT(0, "color-fields", &output_option, N_("color redundant metadata fields from previous line differently"), OUTPUT_COLOR_FIELDS),
> +		OPT_BIT(0, "heated-lines", &output_option, N_("color lines by age"), OUTPUT_HEATED_LINES),

These options may be useful while having fun experimenting, but my
gut feeling is that these are too fine-grained for end-users to
tweak per invocation basis (which is what command line options are
for).  

But perhaps I am biased (as anybody else), as personally I find
anything beyond step 2/4 uninteresting, and not adding too many of
these options is consistent with that viewpoint ;-)

In any case, thanks for a fun read.

