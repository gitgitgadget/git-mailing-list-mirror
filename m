Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2171F462
	for <e@80x24.org>; Tue, 11 Jun 2019 20:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406498AbfFKUWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 16:22:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:14584 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406240AbfFKUWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 16:22:35 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 065E23F4852;
        Tue, 11 Jun 2019 16:22:34 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:fdf7:bf2d:a8f:7a8e] (unknown [IPv6:2001:4898:a800:1012:af2b:bf2d:a8f:7a8e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 742663F4855;
        Tue, 11 Jun 2019 16:22:33 -0400 (EDT)
Subject: Re: cgit and global configuration
To:     Christian Hesse <mail@eworm.de>, Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20190611170401.15d43623@leda>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1cdb3444-fb39-66a4-fb27-01e1617e538a@jeffhostetler.com>
Date:   Tue, 11 Jun 2019 16:22:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611170401.15d43623@leda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/11/2019 11:04 AM, Christian Hesse wrote:
> Dear Jeff, dear Junio,
> 
> for cgit we use the static git library built into the executable. This used
> to work well, but breaks with latest release v2.22.0: Our code unsets HOME
> and XDG_CONFIG_HOME to mitigate loading arbitrary configuration.
> We have tests that use strace to check for access to directories given by
> environment variables.
> 
> With the new trace2 code in place at least tracing configuration is loaded
> before cmd_main() kicks in. This happens in trace2_initialize_fl() ->
> tr2_sysenv_load() -> read_very_early_config(). The offending commit is
> bce9db6d ("trace2: use system/global config for default trace2 settings") [0].
> 
> I had thought about adding a new option to struct config_options and making
> xdg_config_home() and expand_user_path() conditional in
> do_git_config_sequence() when called from read_very_early_config(). However
> this breaks the test suite as ptrace2 tests with global configuration depend
> on HOME being set to a trash directory. Any hint about how to properly solve
> this?
> Or can we be sure configuration read at this point can not do any harm and
> updating out tests is sufficient? I guess no as file paths can be specified.
> 
> [0] https://github.com/git/git/commit/bce9db6de97c95882a7c46836bb6cc90acf0fef0
> 

I'm not sure I fully understand the problem here, so let me
ask a few questions.

If you're using the static git library (by that I assume you
mean libgit.a) and the call to trace2_initialize_fl() is in
main() in common-main.c, how it is getting called?  Don't you
have your own main()?

     Looking at your source in `https://git.zx2c4.com/cgit/tree/cgit.c`
     it looks like you're defining a cmd_main() and using the rest of
     Git's Makefile, so I'm guessing you're getting common-main.c too.

I'm curious why a call to read_very_early_config() before cmd_main()
causes problems.

     Again, in `https://git.zx2c4.com/cgit/tree/cgit.c` I found
     the code in prepare_repo_env() where you unset the various
     HOME variables.  And that is called during your cmd_main()
     sequence.  That would explain why my read_very_early_config()
     causes you problems that a call to read_early_config() inside
     your cmd_main() does not.

     I'm not sure I understand the reasons for the unsets and the
     need for the strace guards, but that is not my business, so
     I'll just trust that you have your reasons.  And I have to
     assume that you have security concerns that supersede the
     need to do any tracing or advanced logging.

Adding a new bit to `struct config_options` doesn't really help
because you don't know when (or even have an opportunity) to set
it.  You've abdicated main() to common code and so your application
doesn't start until cmd_main() is called.

     And you can't really have an environment or config variable
     to say to ignore mine, because they'd be just as vulnerable.

     I'm not sure what you meant by a `ptrace2` test -- unless
     that is just a typo and that you meant the t/t021*.sh tests.
     And yes, these tests do test the global config setting.

As for going forward, I see 3 options:

[1] update your tests to allow this.  (I didn't dig thru your
     tests to see how extensive this might be.)

[2] define your own version of common-main.c and link with it
     instead of git/common-main.c and delete the calls to trace2_*()
     in it.

[3] define your own version of common-main.c and then call your
     prepare_repo_env() prior to trace2_initialize().

Granted, I've only spent 15 minutes looking at your code, so
I may be mistaken about several things, but I think those are
your options.

Hope this helps,
Jeff
