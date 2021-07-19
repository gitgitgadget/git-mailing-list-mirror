Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750A3C63793
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D5E61186
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 23:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354597AbhGSWWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:22:08 -0400
Received: from siwi.pair.com ([209.68.5.199]:34369 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358313AbhGSUQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 16:16:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1755D3F40F4;
        Mon, 19 Jul 2021 16:56:46 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A8E833F40B7;
        Mon, 19 Jul 2021 16:56:45 -0400 (EDT)
Subject: Re: [PATCH v3 08/34] fsmonitor--daemon: add a built-in fsmonitor
 daemon
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f88db92d4259d1c29827e97e957daf6eda39c551.1625150864.git.gitgitgadget@gmail.com>
 <871r8hd5ew.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <91cd5dfa-d325-7eb3-e948-c075269781a5@jeffhostetler.com>
Date:   Mon, 19 Jul 2021 16:56:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <871r8hd5ew.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 6:36 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
> A general comment on this series (including previous patches). We've
> usually tried to bend over backwards in git's codebase not to have big
> ifdef blocks, so we compile most code the same everywhere. We waste a
> bit of object code, but that's fine.
> 
> See 9c897c5c2ad (pack-objects: remove #ifdef NO_PTHREADS, 2018-11-03)
> for a good exmaple of bad code being turned to good.
> 
> E.g. in this case:
> 
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +
>> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>> +{
>> +	const char *subcmd;
>> +
>> +	struct option options[] = {
>> +		OPT_END()
>> +	};
>> +
>> +	if (argc < 2)
>> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
>> +
>> +	if (argc == 2 && !strcmp(argv[1], "-h"))
>> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
>> +
>> +	git_config(git_default_config, NULL);
>> +
>> +	subcmd = argv[1];
>> +	argv--;
>> +	argc++;
>> +
>> +	argc = parse_options(argc, argv, prefix, options,
>> +			     builtin_fsmonitor__daemon_usage, 0);
>> +
>> +	die(_("Unhandled subcommand '%s'"), subcmd);
>> +}
>> +
>> +#else
>> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>> +{
>> +	struct option options[] = {
>> +		OPT_END()
>> +	};
>> +
>> +	if (argc == 2 && !strcmp(argv[1], "-h"))
>> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
>> +
>> +	die(_("fsmonitor--daemon not supported on this platform"));
>> +}
>> +#endif
> 
> This whole thing could really just be a
> -DHAVE_FSMONITOR_DAEMON_BACKEND=1 or -DHAVE_FSMONITOR_DAEMON_BACKEND=0
> somewhere (depending), and then somewhere in the middle of the first
> function:
> 
> 	if (!HAVE_FSMONITOR_DAEMON_BACKEND)
> 	    	die(_("fsmonitor--daemon not supported on this platform"));
> 

This whole file will be filled up with ~1500 lines of static functions
that only make sense when the daemon is supported and that make calls
to platform-specific backends.

I suppose we could stub in an empty backend (something like that in
11/34 and 12/34) and hack in all stuff in the makefile to link to it
in the unsupported case, but that seems like a lot of effort just to
avoid an ifdef here.

I mean, the intent of the #else block is quite clear and we're not
fooling the reader with a large source file of code that will never
be used on their platform.

We could consider splitting this source file into a supported and
unsupported version and have the makefile select the right .c file.
We'd have to move the usage and stuff to a shared header and etc.
That would eliminate the ifdef, but it would break the convention of
the source filename matching the command name.

I'm not sure it's worth the bother TBH.

Jeff
