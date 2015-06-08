From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 4/9] parse-options: add parse_opt_merge_filter()
Date: Mon, 08 Jun 2015 12:20:30 -0700
Message-ID: <xmqqvbey9fcx.fsf@gitster.dls.corp.google.com>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:20:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22bA-0002cc-P2
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbbFHTUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:20:36 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37147 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbbFHTUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:20:35 -0400
Received: by igbsb11 with SMTP id sb11so41674igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=k1yr1f0L7Asjd2aEIfTlPmejbehRqmP7quRR4CN5+v0=;
        b=pa1mkBPl3B6mqVUI2Gl/QUI+pJXSfkpAUOhiSKzuQeURixaCPINPBWfSc3fGt9rcZP
         JkbhB5VYvC4Kweagqrc4PaUVEiDk6GpuiDyrIgMin8eu/0eBQ3eu+R2Mcf9yQyM4pjFK
         Qy347hatVWDborVdZlw3UaY9r2Xy4fcpUXWJqR8fur0JHQbBMQGDRf9bOgsfO87sUgkV
         SytTS0k+K/kMuHIaHO1NFRBa+ObOvjKV0O8o7/PrvNigLF/eC0wWTCone1kL5zcxLkoF
         /OpNGdsVyWKO2vxK0mQBzl4vaVQTptHYFPDy2aiO0cbBlasnHfKB736q2la0PiCY2fT6
         cIqQ==
X-Received: by 10.43.178.195 with SMTP id ox3mr25906647icc.10.1433791234976;
        Mon, 08 Jun 2015 12:20:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id 17sm2331687ioq.39.2015.06.08.12.20.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 12:20:34 -0700 (PDT)
In-Reply-To: <1433621052-5588-4-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271114>

Karthik Nayak <karthik.188@gmail.com> writes:

> +int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
> +{
> +	struct ref_filter *rf = opt->value;
> +	unsigned char sha1[20];
> +
> +	rf->merge = opt->long_name[0] == 'n'
> +		? REF_FILTER_MERGED_OMIT
> +		: REF_FILTER_MERGED_INCLUDE;
> +
> +	if (!arg)
> +		arg = "HEAD";
> +	if (get_sha1(arg, sha1))
> +		die(_("malformed object name %s"), arg);
> +
> +	rf->merge_commit = lookup_commit_reference_gently(sha1, 0);
> +	if (!rf->merge_commit)
> +		return opterror(opt, "must point to a commit", 0);
> +
> +	return 0;
> +}

Again, this smells too specific to live as a part of parse-options
infrastructure.  If we want to have two helper callbacks, one that
gives the results in an sha1-array (because there is no guarantee
that you want only commits) and in a commit-list, I am fine with
having parse_opt_object_name() and parse_opt_with_commit().  Perhaps
rename the latter which was named too specifically to something more
sensible (e.g. parse_opt_commit_object_name()) and use it from the
caller you wanted to use parse_opt_merge_filter()?  The caller, if
it is not prepared to see more than one commits specified, may have
to check if (!list || !list->next) { die("I want one and only one") }
or something, though.

Having it in ref-filter.h as parse_opt_merge_filter() is fine,
though.  After all, you would be sharing it with for-each-ref,
branch and tag and nobody else anyway.

> diff --git a/parse-options.h b/parse-options.h
> index 3ae16a1..7bcf0f3 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -221,6 +221,7 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
>  extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
>  extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
>  extern int parse_opt_points_at(const struct option *, const char *, int);
> +extern int parse_opt_merge_filter(const struct option *, const char *, int);
>  extern int parse_opt_with_commit(const struct option *, const char *, int);
>  extern int parse_opt_tertiary(const struct option *, const char *, int);
>  extern int parse_opt_string_list(const struct option *, const char *, int);
> @@ -243,5 +244,15 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
>  	OPT_COLOR_FLAG(0, "color", (var), (h))
>  #define OPT_COLUMN(s, l, v, h) \
>  	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
> +#define OPT_NO_MERGED(filter, h) \
> +	{ OPTION_CALLBACK, 0, "no-merged", (filter), N_("commit"), (h), \
> +	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
> +	  parse_opt_merge_filter, (intptr_t) "HEAD" \
> +	}
> +#define OPT_MERGED(filter, h) \
> +	{ OPTION_CALLBACK, 0, "merged", (filter), N_("commit"), (h), \
> +	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
> +	  parse_opt_merge_filter, (intptr_t) "HEAD" \
> +	}

Likewise.
