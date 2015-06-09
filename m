From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 4/9] parse-options: add parse_opt_merge_filter()
Date: Tue, 09 Jun 2015 18:06:38 +0530
Message-ID: <5576DDD6.3020205@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-4-git-send-email-karthik.188@gmail.com> <xmqqvbey9fcx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2ImP-0004bD-A4
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 14:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933508AbbFIMgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 08:36:51 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34550 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933480AbbFIMgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 08:36:45 -0400
Received: by payr10 with SMTP id r10so13176810pay.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=f05SOGgMwvaA+foBL7JTGtRAIHwWfFbToUZyP+SJ8RY=;
        b=otcdDwEOgzAjdLptKOC3NvxZ9t/cuuuBY93/nud/8oyBLqAzzTW09lltth6DbdGfCg
         z1WOpuYnrZ4j+TUYkD5f31MsKo2ogseqyxZsXihO5atHPJCg0ZNXP8p+3ABBK0nqEkh3
         autUZnycKYLUzcUujS3vp4gavlIC7jaqv+yHtnD/s6J6NZsz6OXfA1zh53UWNFIaGWs2
         Td6emANAWgErNFrPibaoQ63+qtqZ1arKr+GagtcwU27fu8lnmOaQMNnvzPgs46ffjAkr
         rx/nH31cjAm9APmkDRtVQWc9q6gEK5gZNTSEpI+tItcjF3evzxcrzdojeKrkn/9ntm6R
         Xb9g==
X-Received: by 10.68.192.34 with SMTP id hd2mr38324439pbc.5.1433853404897;
        Tue, 09 Jun 2015 05:36:44 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ud3sm5577898pbc.10.2015.06.09.05.36.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 05:36:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqvbey9fcx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271171>

On 06/09/2015 12:50 AM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
>> +{
>> +	struct ref_filter *rf = opt->value;
>> +	unsigned char sha1[20];
>> +
>> +	rf->merge = opt->long_name[0] == 'n'
>> +		? REF_FILTER_MERGED_OMIT
>> +		: REF_FILTER_MERGED_INCLUDE;
>> +
>> +	if (!arg)
>> +		arg = "HEAD";
>> +	if (get_sha1(arg, sha1))
>> +		die(_("malformed object name %s"), arg);
>> +
>> +	rf->merge_commit = lookup_commit_reference_gently(sha1, 0);
>> +	if (!rf->merge_commit)
>> +		return opterror(opt, "must point to a commit", 0);
>> +
>> +	return 0;
>> +}
>
> Again, this smells too specific to live as a part of parse-options
> infrastructure.  If we want to have two helper callbacks, one that
> gives the results in an sha1-array (because there is no guarantee
> that you want only commits) and in a commit-list, I am fine with
> having parse_opt_object_name() and parse_opt_with_commit().  Perhaps
> rename the latter which was named too specifically to something more
> sensible (e.g. parse_opt_commit_object_name()) and use it from the
> caller you wanted to use parse_opt_merge_filter()?  The caller, if
> it is not prepared to see more than one commits specified, may have
> to check if (!list || !list->next) { die("I want one and only one") }
> or something, though.
>
> Having it in ref-filter.h as parse_opt_merge_filter() is fine,
> though.  After all, you would be sharing it with for-each-ref,
> branch and tag and nobody else anyway.
 >

I guess it's better left in ref-filter.h. We could like you said make
it depend on parse_opt_with_commit() but that again means we need to 
check if more than one commits are specified. So I think it would be 
better to have it in ref-filter.h
>
>> diff --git a/parse-options.h b/parse-options.h
>> index 3ae16a1..7bcf0f3 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -221,6 +221,7 @@ extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
>>   extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
>>   extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
>>   extern int parse_opt_points_at(const struct option *, const char *, int);
>> +extern int parse_opt_merge_filter(const struct option *, const char *, int);
>>   extern int parse_opt_with_commit(const struct option *, const char *, int);
>>   extern int parse_opt_tertiary(const struct option *, const char *, int);
>>   extern int parse_opt_string_list(const struct option *, const char *, int);
>> @@ -243,5 +244,15 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
>>   	OPT_COLOR_FLAG(0, "color", (var), (h))
>>   #define OPT_COLUMN(s, l, v, h) \
>>   	{ OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
>> +#define OPT_NO_MERGED(filter, h) \
>> +	{ OPTION_CALLBACK, 0, "no-merged", (filter), N_("commit"), (h), \
>> +	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
>> +	  parse_opt_merge_filter, (intptr_t) "HEAD" \
>> +	}
>> +#define OPT_MERGED(filter, h) \
>> +	{ OPTION_CALLBACK, 0, "merged", (filter), N_("commit"), (h), \
>> +	  PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
>> +	  parse_opt_merge_filter, (intptr_t) "HEAD" \
>> +	}
>
> Likewise.
>

This too would be better off in ref-filter.h

-- 
Regards,
Karthik
