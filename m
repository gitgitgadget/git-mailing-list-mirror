Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37AF209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 06:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdIFGZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 02:25:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:42121 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750858AbdIFGZI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 02:25:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF833AD1A;
        Wed,  6 Sep 2017 06:25:07 +0000 (UTC)
Subject: Re: [PATCHv2] pull: honor submodule.recurse config option
To:     Junio C Hamano <gitster@pobox.com>,
        Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     git@vger.kernel.org
References: <40ecf559-0348-b838-72f7-0ad7746a7072@morey-chaisemartin.com>
 <xmqqvakwaan2.fsf@gitster.mtv.corp.google.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <c3842980-22ef-5a8c-2895-90c48a97ed71@suse.de>
Date:   Wed, 6 Sep 2017 08:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqvakwaan2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 06/09/2017 à 03:17, Junio C Hamano a écrit :
> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>
>> "git pull" supports a --recurse-submodules option but does not parse the
>> submodule.recurse configuration item to set the default for that option.
>> Meanwhile "git fetch" does support submodule.recurse, producing
>> confusing behavior: when submodule.recurse is enabled, "git pull"
>> recursively fetches submodules but does not update them after fetch.
>>
>> Handle submodule.recurse in "git pull" to fix this.
>>
>> Reported-by: Magnus Homann <magnus@homann.se>
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>
>> Changes since v1:
>>  * Cleanup commit message
>>  * Add test
>>  * Remove extra var in code and fallthrough to git_default_config
>>
>>  builtin/pull.c            |  4 ++++
>>  t/t5572-pull-submodule.sh | 10 ++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 7fe281414..ce8ccb15b 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -325,6 +325,10 @@ static int git_pull_config(const char *var, const char *value, void *cb)
>>  	if (!strcmp(var, "rebase.autostash")) {
>>  		config_autostash = git_config_bool(var, value);
>>  		return 0;
>> +	} else if (!strcmp(var, "submodule.recurse")) {
>> +		recurse_submodules = git_config_bool(var, value) ?
>> +			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
>> +		return 0;
>>  	}
>>  	return git_default_config(var, value, cb);
>>  }
> If I am reading the existing code correctly, things happen in
> cmd_pull() in this order:
>
>  - recurse_submodules is a file-scope static that is initialized to
>    RECURSE_SUBMODULES_DEFAULT
>
>  - pull_options[] is given to parse_options() so that
>    submodule-config.c::option_fetch_parse_recurse_submodules() can
>    read "--recurse-submodules=<value>" from the command line to
>    update recurse_submodules.
>
>  - git_pull_config() is given to git_config() so that settings in
>    the configuration files are read.
>
> Care must be taken to make sure that values given from the command
> line is never overriden by the default value specified in the
> configuration system because the order of the second and third items
> in the above are backwards from the usual flow.  This patch does not
> seem to have any such provision.
>
> Existing handling of "--autostash" vs "rebase.autostash" solves this
> issue by having opt_autostash and config_autostash as two separate
> variables, so I suspect that something similar to it must be there,
> at least, for this new configuration.
>
> If we want to keep the current code structure, that is.  I do not
> recall if we did not notice the fact that the order of options and
> config parsing is backwards and unknowingly worked it around with
> two variables when we added the rebase.autostash thing, or we knew
> the order was unusual but there was a good reason to keep that
> unusual order (iow, if we simply swapped the order of
> parse_options() and git_config() calls, there are things that will
> break).  
>
> If it is not the latter, perhaps we may want to flip the order of
> config parsing and option parsing around?  That will allow us to fix
> the handling of autostash thing to use only one variable, and also
> fix your patch to do the right thing.

I see what you mean.
It looks like switching the code around works but I think there still needs to be 2variables for autstash for this piece of code:

    if (!opt_rebase && opt_autostash != -1)
        die(_("--[no-]autostash option is only valid with --rebase."));

The config option should not cause git pull to die when not using --rebase, the CLI option should.

>> diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
>> index 077eb07e1..1b3a3f445 100755
>> --- a/t/t5572-pull-submodule.sh
>> +++ b/t/t5572-pull-submodule.sh
>> @@ -65,6 +65,16 @@ test_expect_success 'recursive pull updates working tree' '
>>  	test_path_is_file super/sub/merge_strategy.t
>>  '
>>  
>> +test_expect_success "submodule.recurse option triggers recursive pull" '
>> +	test_commit -C child merge_strategy_2 &&
>> +	git -C parent submodule update --remote &&
>> +	git -C parent add sub &&
>> +	git -C parent commit -m "update submodule" &&
>> +
>> +	git -C super -c submodule.recurse pull --no-rebase &&
>> +	test_path_is_file super/sub/merge_strategy_2.t
>> +'
> This new test does not test interactions with submodule.recurse
> configuration and --recurse-submodules=<value> from the command
> line.  It would be necessary to add tests to cover the permutations
> in addition to the basic test we see above.

Will fix

Thanks

Nicolas
