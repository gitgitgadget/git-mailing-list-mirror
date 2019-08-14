Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5861F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 15:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNPyG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 11:54:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56066 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNPyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 11:54:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B39B71779CC;
        Wed, 14 Aug 2019 11:54:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=leJjP60Xq9GS
        PXu9t1k3C3nyjzE=; b=eC+96bf4Ny4PZSq2Rf5y78nZ5gf0aebolegNgtJT5sTp
        bDSjqKD1uC88JZUfzNmmX00xkT9saC8ouT/ai/8tLuRuxDJu58YS8Jzr1WZyS00b
        F/hvyEP/uudAiDcd6BOWflYYpzd6XtRQiqiSDu6pGvMLwU+QBs4pkk6llkiK6UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R238LN
        Rb+2JZv4Ev2r86q3UEepCUXdVibwHSm2lBP4McyWVf2BlBPYFDDn0jywlVr9inSS
        noQk9cafocCBbkrNDItL0nDdICa1z9fePzBHeTK2qMI4Iy/o3LqqR6owGyVvC+9C
        HNAsUptq281eh1jJRX/Qqu9U9ppRgCQCepJx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8B651779CB;
        Wed, 14 Aug 2019 11:54:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E9541779CA;
        Wed, 14 Aug 2019 11:54:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, git@vger.kernel.org,
        peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
References: <20190812213448.2649-1-palmer@sifive.com>
        <20190812213448.2649-6-palmer@sifive.com>
        <20190814083245.GP20404@szeder.dev>
Date:   Wed, 14 Aug 2019 08:54:01 -0700
In-Reply-To: <20190814083245.GP20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 14 Aug 2019 10:32:45 +0200")
Message-ID: <xmqqy2zv68va.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCFBB00A-BEAB-11E9-AF12-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Mon, Aug 12, 2019 at 02:34:48PM -0700, Palmer Dabbelt wrote:
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 67d001f3f78b..41498e9efb3b 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -114,6 +114,20 @@ static int git_fetch_config(const char *k, const =
char *v, void *cb)
>>  	return git_default_config(k, v, cb);
>>  }
>> =20
>> +static int parse_jobs_arg(const struct option *opt, const char *arg, =
int unset)
>> +{
>> +	int jobs;
>> +
>> +	jobs =3D atoi(arg);
>> +	if (jobs < 1)
>> +		die(_("There must be a positive number of jobs"));
>> +
>> +	max_children_for_submodules =3D jobs;
>> +	max_children_for_fetch =3D jobs;
>> +
>> +	return 0;
>> +}
>> +
>>  static int parse_refmap_arg(const struct option *opt, const char *arg=
, int unset)
>>  {
>>  	BUG_ON_OPT_NEG(unset);
>> @@ -142,12 +156,13 @@ static struct option builtin_fetch_options[] =3D=
 {
>>  		    N_("fetch all tags and associated objects"), TAGS_SET),
>>  	OPT_SET_INT('n', NULL, &tags,
>>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
>> -	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
>> +	{ OPTION_CALLBACK, 'j', "jobs", NULL, N_("jobs"),
>> +		    N_("number of parallel tasks to run while fetching"),
>> +		    PARSE_OPT_OPTARG, &parse_jobs_arg },
>
> These changes result segmentation faults in the tests '--quiet
> propagates to parallel submodules' and 'fetching submodules respects
> parallel settings' in 't5526-fetch-submodules.sh'.
>
> If the number of jobs is specified as '-j 2' or '--jobs 7', i.e. as an
> unstuck argument of the option, as opposed to '-j2' or '--jobs=3D7',
> then 'arg' in the parse_jobs_arg() callback is NULL, which then causes
> the segfault somewhere inside that atoi() call.

True. =20

An easier and more readable way would be to set another "nr-jobs"
variable using plain vanilla OPT_INTEGER() and override the other
two with it when they are not set after parse_options() returns, I
guess.
