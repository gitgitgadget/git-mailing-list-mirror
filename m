Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475EEC43457
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03B920BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fdHfThry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgJMUDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:03:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60641 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbgJMUDV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 16:03:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3070739AE;
        Tue, 13 Oct 2020 16:03:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xi/yhQuC16jM5kcGQO/umHqBCNA=; b=fdHfTh
        ry1dpP6pMEG6pOa1QWQ1BfA//rkaguzZjA0sjGZBOW97sM8+V+hS4p36YAfEHAWG
        8Yhu/lpqww5Ghbh3qf3fhKi8sv9/BNYYJ1dmMWoXHa2qF4sE/r5F2P/TQGlvNm8u
        gsLgTdDcfUKlPBLiltx5D73xvE743CwkBeGQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JfliNREU8fnRkZN4GzpuYTNAgTLrausJ
        wg+fElUM/ijylyTgQdCiBowne/M2ptAefAd7nJnpshQKN4g8KkIrWHso5UI9PoqB
        NH/tSMfAfvXFw8f/r6vZ4M8M9hhhO9j5iwYwlf3sGmaBnpOOdZJ6vC9Wt4+4N47l
        UvDM7vVz3SA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9CB8739AD;
        Tue, 13 Oct 2020 16:03:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2224F739AC;
        Tue, 13 Oct 2020 16:03:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [WIP v2 1/2] Adding a record-time-zone command option for commit
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20201013052851.373029-1-shengfa@google.com>
        <20201013052851.373029-2-shengfa@google.com>
Date:   Tue, 13 Oct 2020 13:03:13 -0700
In-Reply-To: <20201013052851.373029-2-shengfa@google.com> (Shengfa Lin's
        message of "Tue, 13 Oct 2020 05:28:50 +0000")
Message-ID: <xmqqk0vtki66.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 207FC1CE-0D8F-11EB-839A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

> Many places in Git record the timezone of actor when a
> timestamp is recorded, including the commiter and author
> timestamps in a commit object and the tagger timestamp in a tag
> object. Some people however prefer not to share where they
> actually are.
>
> They _could_ just say "export TZ=UTC" and be done with it,
> but the method would not easily allow them to pretend to be
> in the UTC timezone only with Git, while revealing their true
> timezone to other activities (e.g. sending e-emails?).
>
> Introduce --[no-]record-time-zone for commit command, which can be
> specified to disallow Git to record time zone. Timezone will be
> recorded by default.
>
> Note that this is a WIP and the test is failing.

And there is no outline of the design decision made so far, so it is
hard to give useful review comments.

It does not help that the patch is distracting by turning tabs to
spaces and breaking alingment X-<.

> diff --git a/builtin/am.c b/builtin/am.c
> index 2c7673f74e..059cc5fce7 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -884,7 +884,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
>  			if (tz > 0)
>  				tz2 = -tz2;
>  
> -			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_MODE(RFC2822)));
> +			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, NULL, DATE_MODE(RFC2822)));

For example, it appears that tweaking "show_date()" API function
seems to be a central part of the design, as there are so many
instances like this change in the patch.  If the proposed log
message mentioned, even briefly, what the extra parameter added to
the API function meant (especially what NULL means there) upfront,
then readers can coast the part that added NULL there, like these
ones, and concentrate on the parts of this patch that matter, which
presumably uses something more interesting than NULL instead.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1dfd799ec5..ee3ca2c7ac 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1547,7 +1547,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  				N_("ok to record an empty change")),
>  		OPT_HIDDEN_BOOL(0, "allow-empty-message", &allow_empty_message,
>  				N_("ok to record a change with an empty message")),
> -
> +                OPT_BOOL(0, "record-time-zone", &record_time_zone, N_("record user timezone")),

Our code indents with HT; get used to the style early and your
patches won't distract reviewers as much, leading to more quality
reviews and suggestions.

Likewise.  The record_time_zone global variable seems to play a
crucial role in this change, but without preparing readers by
mentioning where it is defined, what normal/default value it takes,
and who potentially touches it, in the proposed log message, it
makes reading the change harder than necessary.

A system-wide global like this is usually defined in environment.c,
by the way.  Look for say trust_executable_bit and mimic where it 
is defined and declared.

>  		OPT_END()
>  	};
>  
> @@ -1580,6 +1580,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> +
>  	if (verbose == -1)
>  		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
>  

Distraction.

> +static int negative_zero(int tz, int *sign)
> +{
> +        return !tz && sign && (*sign) == '-';
> +}
> +
> +static const char *tz_fmt(int tz, int *sign)
> +{
> +        if (!negative_zero(tz, sign))
> +                return " %+05d";
> +        else
> +                return " -%04d";
> +}
> +
> +
> +static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm, int tz, int *sign, struct tm *human_tm, int human_tz, int local)
>  {
>  	struct {
>  		unsigned int	year:1,
> @@ -277,10 +293,10 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
>  		strbuf_addf(buf, " %d", tm->tm_year + 1900);
>  
>  	if (!hide.tz)
> -		strbuf_addf(buf, " %+05d", tz);
> +                strbuf_addf(buf, tz_fmt(tz, sign), tz);
>  }
>  
> -const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
> +const char *show_date(timestamp_t time, int tz, int *signp, const struct date_mode *mode)

With its type, we can tell easily that sign is a pointer, so no need
for 'p' (we do not have modep, either, next door).  More important
is if 'sign' is a good name that conveys what the parameter (which
is almost always NULL) means.  Without any introductory text, it is
hard to tell and offer recommendations.

> @@ -826,17 +849,21 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
>  
>  /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
>     (i.e. English) day/month names, and it doesn't work correctly with %z. */
> -int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
> +int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset, int *zero_offset_negative_sign)
>  {
>  	struct tm tm;
>  	int tm_gmt;
>  	timestamp_t dummy_timestamp;
>  	int dummy_offset;
> +        int dummy_zero_offset_negative_sign;
> +        int negative_sign;
>  	if (!timestamp)
>  		timestamp = &dummy_timestamp;
>  	if (!offset)
>  		offset = &dummy_offset;

I see no need for the extra dummy_zero_offset_negative_sign variable.
I can guess this mimics "if (!offset) offset = &dummy_offset" without
much thought---a big difference is that after calling match_tz() to
fill *offset, the code needs to obtain the value match_tz() parsed
to decide if it needs to do the mktime() dance to guess the current
zone offset, and also needs to read *offset to adjust *timestamp
the function returns.

The zero_offset_negative_sign pointer that specifies the location to
optionally return a bit of info is *ONLY* used once at the very end
of the function, so 

> +        if (!zero_offset_negative_sign)
> +                zero_offset_negative_sign = &dummy_zero_offset_negative_sign;

there is absolutely no need for the dummy variable or this
assignment, especially since the patch adds negative_sign variable
that always exists, and ...

>  	memset(&tm, 0, sizeof(tm));
>  	tm.tm_year = -1;
> @@ -848,6 +875,7 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>  	tm.tm_sec = -1;
>  	*offset = -1;
>  	tm_gmt = 0;
> +        negative_sign = 0;
>  
>  	if (*date == '@' &&
>  	    !match_object_header_date(date + 1, timestamp, offset))
> @@ -864,9 +892,11 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>  			match = match_alpha(date, &tm, offset);
>  		else if (isdigit(c))
>  			match = match_digit(date, &tm, offset, &tm_gmt);
> -		else if ((c == '-' || c == '+') && isdigit(date[1]))
> +		else if ((c == '-' || c == '+') && isdigit(date[1])) {
>  			match = match_tz(date, offset);
> -
> +                        if (c == '-')
> +                                negative_sign = 1;
> +                }

... is usable.

>  		if (!match) {
>  			/* BAD CRAP */
>  			match = 1;
> @@ -895,6 +925,9 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
>  
>  	if (!tm_gmt)
>  		*timestamp -= *offset * 60;
> +
> +        *zero_offset_negative_sign = (!(*offset) && negative_sign);
> +

The only change needed for this optional extra bit return is to
make sure that the assignment happens only when it was requested by
the caller, i.e.

	if (zero_offset_negative_sign)
		*zero_offset_negative_sign = ...

Having said all that, quite honestly, I do not know if this is going
in the right direction.  Specifically, I do not offhand see why we
need such a huge surgery to date.c just to touch datestamp() and
date_string().

I may be totally off, partly due to lack of explanation of how the
patch attempts to achieve its goal, but wouldn't it be just the
matter of touching the single callsite of datestamp() in ident.c, so
that after it gets git_default_date string filled, null out the last
5 bytes in it with "-0000" if record_tz is off?

> @@ -996,15 +1030,16 @@ void parse_date_format(const char *format, struct date_mode *mode)
>  void datestamp(struct strbuf *out)
>  {
>  	time_t now;
> -	int offset;
> -	struct tm tm = { 0 };
> +	int offset = 0;
>  
> -	time(&now);
> +        time(&now);
> +        if (record_time_zone) {
> +          struct tm tm = { 0 };
> +          offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
> +          offset /= 60;
> +        }
>  
> -	offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
> -	offset /= 60;
> -
> -	date_string(now, offset, out);
> +	date_string(now, offset, !record_time_zone, out);
>  }
>  
>  /*
> @@ -1330,7 +1365,7 @@ timestamp_t approxidate_relative(const char *date)
>  	int offset;
>  	int errors = 0;
>  
> -	if (!parse_date_basic(date, &timestamp, &offset))
> +	if (!parse_date_basic(date, &timestamp, &offset, NULL))
>  		return timestamp;
>  
>  	get_time(&tv);
> @@ -1346,7 +1381,7 @@ timestamp_t approxidate_careful(const char *date, int *error_ret)
>  	if (!error_ret)
>  		error_ret = &dummy;
>  
> -	if (!parse_date_basic(date, &timestamp, &offset)) {
> +	if (!parse_date_basic(date, &timestamp, &offset, NULL)) {
>  		*error_ret = 0;
>  		return timestamp;
>  	}
> @@ -1371,3 +1406,4 @@ int date_overflows(timestamp_t t)
>  	sys = t;
>  	return t != sys || (t < 1) != (sys < 1);
>  }
> +
