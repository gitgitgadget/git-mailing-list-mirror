Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E63C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6413764DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352912AbhCDAXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:17 -0500
Received: from siwi.pair.com ([209.68.5.199]:64488 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448595AbhCCP0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 10:26:35 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0CFE03F40B7;
        Wed,  3 Mar 2021 10:25:39 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id CCEC33F4098;
        Wed,  3 Mar 2021 10:25:38 -0500 (EST)
Subject: Re: [PATCH v4 12/12] t0052: add simple-ipc tests and
 t/helper/test-simple-ipc tool
To:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <09568a6500dde4a592a994b661a7beec23af32b4.1613598529.git.gitgitgadget@gmail.com>
 <YD4JAvK0epzm9b2y@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3ad0d153-0f02-341e-1828-688b82a91ecf@jeffhostetler.com>
Date:   Wed, 3 Mar 2021 10:25:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YD4JAvK0epzm9b2y@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/2/21 4:44 AM, Jeff King wrote:
> On Wed, Feb 17, 2021 at 09:48:48PM +0000, Jeff Hostetler via GitGitGadget wrote:
> 
>> Create t/helper/test-simple-ipc test tool to exercise the "simple-ipc"
>> functions.
> 
> BTW, one oddity I noticed in this (because of my -Wunused-parameters
> branch):
> 
>> +#ifndef GIT_WINDOWS_NATIVE
>> +/*
>> + * This is adapted from `daemonize()`.  Use `fork()` to directly create and
>> + * run the daemon in a child process.
>> + */
>> +static int spawn_server(const char *path,
>> +			const struct ipc_server_opts *opts,
>> +			pid_t *pid)
>> +{
>> +	*pid = fork();
>> +
>> +	switch (*pid) {
>> +	case 0:
>> +		if (setsid() == -1)
>> +			error_errno(_("setsid failed"));
>> +		close(0);
>> +		close(1);
>> +		close(2);
>> +		sanitize_stdfds();
>> +
>> +		return ipc_server_run(path, opts, test_app_cb, (void*)&my_app_data);
>> +
>> +	case -1:
>> +		return error_errno(_("could not spawn daemon in the background"));
>> +
>> +	default:
>> +		return 0;
>> +	}
>> +}
> 
> In the non-Windows version, we spawn a server using the "path" parameter
> we got from the caller.
> 
> But in the Windows version:
> 
>> +#else
>> +/*
>> + * Conceptually like `daemonize()` but different because Windows does not
>> + * have `fork(2)`.  Spawn a normal Windows child process but without the
>> + * limitations of `start_command()` and `finish_command()`.
>> + */
>> +static int spawn_server(const char *path,
>> +			const struct ipc_server_opts *opts,
>> +			pid_t *pid)
>> +{
>> +	char test_tool_exe[MAX_PATH];
>> +	struct strvec args = STRVEC_INIT;
>> +	int in, out;
>> +
>> +	GetModuleFileNameA(NULL, test_tool_exe, MAX_PATH);
>> +
>> +	in = open("/dev/null", O_RDONLY);
>> +	out = open("/dev/null", O_WRONLY);
>> +
>> +	strvec_push(&args, test_tool_exe);
>> +	strvec_push(&args, "simple-ipc");
>> +	strvec_push(&args, "run-daemon");
>> +	strvec_pushf(&args, "--threads=%d", opts->nr_threads);
>> +
>> +	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
>> +	close(in);
>> +	close(out);
>> +
>> +	strvec_clear(&args);
>> +
>> +	if (*pid < 0)
>> +		return error(_("could not spawn daemon in the background"));
>> +
>> +	return 0;
>> +}
>> +#endif
> 
> We ignore the "path" parameter entirely. Should we be passing it along
> as an option to the child process? I think it doesn't really matter at
> this point because both the parent and child processes will use the
> hard-coded string "ipc-test", but it seems like something the test
> script might want to be able to specify.
> 
> -Peff
> 

Yeah, since it was a test helper I hesitated to add a command line
arg to pass it to the child process (when all callers were right here
and using the same default value).  However it would be good to do so
in case we want to write more complicated tests.

Jeff
