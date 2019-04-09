Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3948020248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDIP6F (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:58:05 -0400
Received: from siwi.pair.com ([209.68.5.199]:28377 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfDIP6F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:58:05 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2B5593F4114;
        Tue,  9 Apr 2019 11:58:03 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:995e:33b7:8498:9c41] (unknown [IPv6:2001:4898:8010:0:8294:33b7:8498:9c41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9DE2F3F4094;
        Tue,  9 Apr 2019 11:58:02 -0400 (EDT)
Subject: Re: [PATCH v2 4/7] trace2: use system config for default trace2
 settings
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        steadmon@google.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
 <20190403000032.GA190454@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a0c89d0d-669e-bf56-25d2-cbb09b012e70@jeffhostetler.com>
Date:   Tue, 9 Apr 2019 11:58:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403000032.GA190454@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/2/2019 8:00 PM, Jonathan Nieder wrote:
> Hi,
> 
> Jeff Hostetler via GitGitGadget wrote:
> 
>> Teach git to read the system config (usually "/etc/gitconfig") for
>> default Trace2 settings.  This allows system-wide Trace2 settings to
>> be installed and inherited to make it easier to manage a collection of
>> systems.
> 
> Yay!  Thanks for writing this, and sorry for the slow review.
> 
> [...]
>> Only the system config file is used.  Trace2 config values are ignored
>> in local, global, and other config files.  Likewise, the "-c" command
>> line arguments are ignored for Trace2 values.  These limits are for
>> performance reasons.
> 
> Can you say a bit more about this?  If I'm willing to pay the
> performance cost, is there a way for me to turn on respecting other
> config files?  What is that performance cost?

Several thoughts here.  Some are performance-related and some are
startup chicken-n-egg problems.  I tried to add trace2 to the code
base in the least disruptive way possible and hopefully with minimal
side-effects on existing behaviors.  And also minimum impact on overall
performance when not in use.

So, with that in mind:

[] Trace2 should be initialized as early as and lightly as possible
    so that timers are started and it can capture events from other
    startup activities.  And so that we can tell as early as possible
    if trace2 should NOT be enabled and short-cut those calls and not
    waste time collecting unnecessary data.

[] Trace2 is initialized by calls from common-main.c:main().  This
    happens before cmd_main() is called, so we are very early in the
    startup process and very few things have been initialized.  For
    example, I had to let git_resolve_executable_dir() run so that
    we could find the location of the system config, but that's about
    it.  We have not even initialized "the_repository" yet.

[] WRT "-c var=val", this is processed by git.c:handle_options() and
    called from git.c:cmd_main() and git.c:handle_alias().  So the "-c"
    args won't be respected until after that point.

    Adding trace2 initialization after that point is a bit of a mess.
    Teaching trace2 to scan the argv for "-c" is just duplicating effort.
    And moving the "-c" processing earlier in the startup, changes the
    behavior of the "git-*" commands (which don't currently recognize
    the "-c" option).

    So that's why I'm suggesting we not respect "-c" for this.

[] By initializing trace2 inside main() we guarantee that it will get
    started.  If we wait to initialize it until after handle_options()
    returns, we miss events for commands that it handles itself (such
    as "git --exec-path" where it just prints and exits or syntax errors
    where it directly calls usage() and exits).

[] WRT to per-repo config values:

    In common-main.c:main() we have not yet discovered the .git dir,
    so repo-local config files are questionable at a very early point
    in the process startup.  Again, it comes down to whether we wait
    for gitdir discovery (and whatever file system scanning, --gitdir,
    or -C processing is required) before deciding whether to start
    trace2 or not.

    Also, per-repo trace2 config settings aren't available at the time
    of the clone, so just relying on them will leave our telemetry
    incomplete.  It's better to have a system (or maybe a user) setting
    and not a per-repo setting.

    Longer term, with submodules and plans to support them in-proc rather
    than via sub-processes, I don't think there should be any expectation
    that trace2 settings would adapt during recursive operations.  So for
    example, a top-level command might see different trace2 settings than
    a command run inside a submodule.  If submodule operations become
    in-proc, then to maintain that expected behavior we'd need to have
    per-repo trace2 settings.  (Granted, not impossible, but by saying no
    to that now, we can eliminate a possible pain point in the future.)

[] i'll add more on this topic at the bottom of this note in response to
    your per-user and includes questions.


> [...]
>> --- a/Documentation/technical/api-trace2.txt
>> +++ b/Documentation/technical/api-trace2.txt
>> @@ -117,6 +117,37 @@ values are recognized.
>>   Socket type can be either `stream` or `dgram`.  If the socket type is
>>   omitted, Git will try both.
>>   
>> +== Trace2 Settings in System Config
>> +
>> +Trace2 also reads configuration information from the system config.
>> +This is intended to help adminstrators to gather system-wide Git
>> +performance data.
>> +
>> +Trace2 only reads the system configuration, it does not read global,
>> +local, worktree, or `-c` config settings.
> 
> An additional limitation is that this doesn't appear to support
> include.* directives.  Intended?

I didn't specifically intend to support or not-support include files
here.  Frankly, the complexity of the config code makes my eyes bleed.
I'll investigate adding it.


> 
> [...]
>> --- a/t/t0210-trace2-normal.sh
>> +++ b/t/t0210-trace2-normal.sh
> [...]
>> +MOCK=./mock_system_config
>> +
>> +test_expect_success 'setup mocked /etc/gitconfig' '
>> +	git config --file $MOCK trace2.normalTarget "$(pwd)/trace.normal" &&
>> +	git config --file $MOCK trace2.normalBrief 1
>> +'
>> +
>> +test_expect_success 'using mock, normal stream, return code 0' '
>> +	test_when_finished "rm trace.normal actual expect" &&
>> +	GIT_TEST_TR2_SYSTEM_CONFIG="$MOCK" test-tool trace2 001return 0 &&
> 
> Tests run with GIT_CONFIG_NOSYSTEM=1 to protect themselves from any
> system config the user has.

Thanks for the pointer.  I'll update the tr2_sysenv_load() to check
git_system_config() before trying to use the system config file.

> 
> So this would be easier to test if we can use user-level config for
> it.

I suppose.  I think it just moves the testing problem to a trick using
$HOME, right?  But it does get rid of that GIT_TEST_TR2_SYSTEM_CONFIG
symbol, so yeah a net win.  I'll investigate.  Thanks.


> [...]
>> --- /dev/null
>> +++ b/trace2/tr2_sysenv.c
>> @@ -0,0 +1,128 @@
>> +#include "cache.h"
>> +#include "config.h"
>> +#include "dir.h"
>> +#include "tr2_sysenv.h"
>> +
>> +/*
>> + * Each entry represents a trace2 setting.
>> + * See Documentation/technical/api-trace2.txt
>> + */
>> +struct tr2_sysenv_entry {
>> +	const char *env_var_name;
>> +	const char *git_config_name;
>> +
>> +	char *value;
>> +	unsigned int getenv_called : 1;
>> +};
>> +
>> +/*
>> + * This table must match "enum tr2_sysenv_variable" in tr2_sysenv.h.
> 
> Can we deduplicate to avoid the need to match?
> 
> Perhaps using C99 array initializers would help:
> 
> 	[TR2_SYSENV_CFG_PARAM] = { ... },

Cool.  I hadn't seen that syntax before.

> 
> [...]
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
> This duplicates functionality from config.c and misses some features
> along the way (e.g. support for include.*).
> 
> Would read_early_config work?  If we want a variant that doesn't
> discover_git_directory, we can change that function to handle it.
> 
> For our needs at Google, it would be very helpful to have support for
> include.* and reading settings from at least $HOME/.gitconfig in
> addition to /etc/gitconfig (even better if it supports per-repo config
> as well).  I believe it would simplify the code and tests, too.  If
> there's anything I can to help, please don't hesitate to ask.

read_early_config() might work, but it is pretty heavy and doesn't
address my above comments.

Perhaps a compromise would be to have it read just the system and
user config files (w/ includes turned on).  It shouldn't take too
much time and it shouldn't have the startup-order dependencies, I
think.

Thoughts??

> 
> Thanks,
> Jonathan
> 

Thanks,
Jeff
