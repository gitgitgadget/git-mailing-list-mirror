Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C596F20248
	for <e@80x24.org>; Thu, 28 Mar 2019 18:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfC1SuL (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 14:50:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:41087 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfC1SuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 14:50:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 177323F400C;
        Thu, 28 Mar 2019 14:50:10 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:7c88:9548:6197:9e61] (unknown [IPv6:2001:4898:8010:0:65be:9548:6197:9e61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8B56B3F4000;
        Thu, 28 Mar 2019 14:50:09 -0400 (EDT)
Subject: Re: [PATCH 4/4] trace2: use system config for default trace2 settings
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <7e0d4e20fbb3abbc787bc216d2c4bd8c18860aed.1553779851.git.gitgitgadget@gmail.com>
 <87wokj9ic1.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f09d1d23-865f-fc35-250b-141a4d049029@jeffhostetler.com>
Date:   Thu, 28 Mar 2019 14:50:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87wokj9ic1.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/28/2019 10:36 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 28 2019, Jeff Hostetler via GitGitGadget wrote:
> 
> Thanks for working on this!
> 
> Haven't given this any deep testing. Just some observations:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach git to read the system config (usually "/etc/gitconfig") for
>> default Trace2 settings.  This allows system-wide Trace2 settings to
>> be installed and inherited to make it easier to manage a collection of
>> systems.
[...]

>> diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
>> new file mode 100644
>> index 0000000000..656613e371
>> --- /dev/null
[...]

>> +/* clang-format off */
>> +static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
>> +	{ "GIT_TR2_CONFIG_PARAMS",   "trace2.configparams"     },
>> +
>> +	{ "GIT_TR2_DST_DEBUG",       "trace2.destinationdebug" },
>> +
>> +	{ "GIT_TR2",                 "trace2.normaltarget"     },
>> +	{ "GIT_TR2_BRIEF",           "trace2.normalbrief"      },
>> +
>> +	{ "GIT_TR2_EVENT",           "trace2.eventtarget"      },
>> +	{ "GIT_TR2_EVENT_BRIEF",     "trace2.eventbrief"       },
>> +	{ "GIT_TR2_EVENT_NESTING",   "trace2.eventnesting"     },
>> +
>> +	{ "GIT_TR2_PERF",            "trace2.perftarget"       },
>> +	{ "GIT_TR2_PERF_BRIEF",      "trace2.perfbrief"        },
>> +};
>> +/* clang-format on */
>> +
>> +static int tr2_sysenv_cb(const char *key, const char *value, void *d)
>> +{
>> +	int k;
>> +
> 
> I added:
> 
> 	if (!starts_with(key, "trace2."))
> 		return 0;
> 
> Here, and everything works as expected. I think that's a good
> idea. Makes this O(n) over N config keys instead of O(n*x) where x = num
> entries in tr2_sysenv_settings.

Good idea.  Thanks!

> 
>> +	for (k = 0; k < ARRAY_SIZE(tr2_sysenv_settings); k++) {
>> +		if (!strcmp(key, tr2_sysenv_settings[k].git_config_name)) {
>> +			free(tr2_sysenv_settings[k].value);
>> +			tr2_sysenv_settings[k].value = xstrdup(value);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Load Trace2 settings from the system config (usually "/etc/gitconfig"
>> + * unless we were built with a runtime-prefix).  These are intended to
>> + * define the default values for Trace2 as requested by the administrator.
>> + */
>> +void tr2_sysenv_load(void)
>> +{
>> +	const char *system_config_pathname;
>> +	const char *test_pathname;
>> +
>> +	system_config_pathname = git_etc_gitconfig();
>> +
>> +	test_pathname = getenv("GIT_TEST_TR2_SYSTEM_CONFIG");
>> +	if (test_pathname) {
>> +		if (!*test_pathname || !strcmp(test_pathname, "0"))
>> +			return; /* disable use of system config */
>> +
>> +		/* mock it with given test file */
>> +		system_config_pathname = test_pathname;
>> +	}
>> +
>> +	if (file_exists(system_config_pathname))
>> +		git_config_from_file(tr2_sysenv_cb, system_config_pathname,
>> +				     NULL);
> 
> Maybe this isn't worth it, but this "file_exists" thing is something we
> could abstract in the config machinery (or maybe passing via
> "config_options" makes more sense):
[...]

This is a good idea, but I think I'll save this for a future effort
rather than add it to the current patch series.  It just seems outside
of my scope right now and adds to the footprint of this series.

[...]
>>
>> -	nesting = getenv(TR2_ENVVAR_EVENT_NESTING);
>> +	nesting = tr2_sysenv_get(TR2_SYSENV_EVENT_NESTING);
>>   	if (nesting && ((want_nesting = atoi(nesting)) > 0))
>>   		tr2env_event_nesting_wanted = want_nesting;
>>
>> -	brief = getenv(TR2_ENVVAR_EVENT_BRIEF);
>> +	brief = tr2_sysenv_get(TR2_SYSENV_EVENT_BRIEF);
>>   	if (brief && ((want_brief = atoi(brief)) > 0))
>>   		tr2env_event_brief = want_brief;
> 
> A lot of this pre-dates this patch, but I wonder if the whole of trace2
> couldn't make more use of config.c's bool parsing for things like
> these. Maybe by having a "cfg_type" enum & parsed_value void* in
> tr2_sysenv_entry?

I converted the "brief" instances in the normal and perf targets to
use git_parse_maybe_bool() already, but I missed this one.

The nesting one above is actually an integer value rather than a bool.
I'll rename the variables in the re-roll to clarify that.


[...]
>> -	brief = getenv(TR2_ENVVAR_NORMAL_BRIEF);
>> +	brief = tr2_sysenv_get(TR2_SYSENV_NORMAL_BRIEF);
>>   	if (brief && *brief &&
>>   	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
>>   		tr2env_normal_brief = want_brief;
[...]
>> -	brief = getenv(TR2_ENVVAR_PERF_BRIEF);
>> +	brief = tr2_sysenv_get(TR2_SYSENV_PERF_BRIEF);
>>   	if (brief && *brief &&
>>   	    ((want_brief = git_parse_maybe_bool(brief)) != -1))
>>   		tr2env_perf_brief = want_brief;


Thanks for the review.
I'll push up another version shortly.

Jeff
