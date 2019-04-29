Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B821F453
	for <e@80x24.org>; Mon, 29 Apr 2019 19:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfD2TDW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 15:03:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:15172 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbfD2TDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 15:03:21 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 923263F4024;
        Mon, 29 Apr 2019 15:03:20 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:6436:1a0f:5a09:117b] (unknown [IPv6:2001:4898:8010:0:4d6c:1a0f:5a09:117b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 06C803F4019;
        Mon, 29 Apr 2019 15:03:19 -0400 (EDT)
Subject: Re: [PATCH v4 06/10] trace2: use system/global config for default
 trace2 settings
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, steadmon@google.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
 <pull.169.v4.git.gitgitgadget@gmail.com>
 <550cad618923c6e5aa1bd5f901f2968791d7566b.1555360780.git.gitgitgadget@gmail.com>
 <20190427134316.GE8695@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <465993c8-0eb2-d9fa-5d22-b8b584b3de15@jeffhostetler.com>
Date:   Mon, 29 Apr 2019 15:03:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427134316.GE8695@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/2019 9:43 AM, SZEDER Gábor wrote:
> On Mon, Apr 15, 2019 at 01:39:47PM -0700, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach git to read the system and global config files for
>> default Trace2 settings.  This allows system-wide Trace2 settings to
>> be installed and inherited to make it easier to manage a collection of
>> systems.
>>
>> The original GIT_TR2* environment variables are loaded afterwards and
>> can be used to override the system settings.
>>
>> Only the system and global config files are used.  Repo and worktree
>> local config files are ignored.  Likewise, the "-c" command line
>> arguments are also ignored.  These limits are for performance reasons.
>>
>> (1) For users not using Trace2, there should be minimal overhead to
>> detect that Trace2 is not enabled.  In particular, Trace2 should not
>> allocate lots of otherwise unused data strucutres.
>>
>> (2) For accurate performance measurements, Trace2 should be initialized
>> as early in the git process as possible, and before most of the normal
>> git process initialization (which involves discovering the .git directory
>> and reading a hierarchy of config files).
> 
> Reading the configuration that early causes unexpected and undesired
> behavior change:
> 
>    $ sudo chmod a-rwx /usr/local/etc/gitconfig
>    $ ./BUILDS/v2.21.0/bin/git
>    usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
>    <... snip rest of usage ...>
>    $ strace ./BUILDS/v2.21.0/bin/git 2>&1 |grep config -c
>    0
>    $ ./git
>    fatal: unable to access '/usr/local/etc/gitconfig': Permission denied
>    $ ./git --version
>    fatal: unable to access '/usr/local/etc/gitconfig': Permission denied
> 
> I think at least 'git', 'git --help', and 'git --version' should Just
> Work, no matter what.
> 
> 
> This breaks the 32 bit Linux build job on Travis CI, because:
> 
>    - In the 32 bit Docker image we change UID from root to regular user
>      while preserving the environment, including $HOME.
>      
>    - Since $HOME is the default build prefix, Git will look for the
>      system-wide configuration under '/root/etc/gitconfig', which fails
>      as a regular user.
> 
>    - Our test harness checks early (i.e. earlier than setting
>      GIT_CONFIG_NOSYSTEM=1) whether Git has been built successfully by
>      attempting to run '$GIT_BUILD_DIR}/git', which fails because of
>      the inaccessible system-wide config file, and in turn the harness
>      assumes that Git hasn't been built and aborts.
> 
>    https://travis-ci.org/git/git/jobs/524403682#L1258
> 

It appears that config.c:do_git_config_sequence() passes flags = 0
to access_or_die() rather than ACCESS_EACCES_OK as it does for the
other scopes.  This causes the fatal error, rather than ignoring the
problem.

Reasons for this were discussed in:
     4698c8feb1 config: allow inaccessible configuration under $HOME

I'll push a fix shortly.

Thanks
Jeff
