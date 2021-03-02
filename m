Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF7C433E6
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901BF64F20
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578551AbhCBPZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:25:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:49342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1577593AbhCBJpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 04:45:19 -0500
Received: (qmail 10191 invoked by uid 109); 2 Mar 2021 09:44:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Mar 2021 09:44:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11423 invoked by uid 111); 2 Mar 2021 09:44:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Mar 2021 04:44:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Mar 2021 04:44:34 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 12/12] t0052: add simple-ipc tests and
 t/helper/test-simple-ipc tool
Message-ID: <YD4JAvK0epzm9b2y@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <09568a6500dde4a592a994b661a7beec23af32b4.1613598529.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09568a6500dde4a592a994b661a7beec23af32b4.1613598529.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 09:48:48PM +0000, Jeff Hostetler via GitGitGadget wrote:

> Create t/helper/test-simple-ipc test tool to exercise the "simple-ipc"
> functions.

BTW, one oddity I noticed in this (because of my -Wunused-parameters
branch):

> +#ifndef GIT_WINDOWS_NATIVE
> +/*
> + * This is adapted from `daemonize()`.  Use `fork()` to directly create and
> + * run the daemon in a child process.
> + */
> +static int spawn_server(const char *path,
> +			const struct ipc_server_opts *opts,
> +			pid_t *pid)
> +{
> +	*pid = fork();
> +
> +	switch (*pid) {
> +	case 0:
> +		if (setsid() == -1)
> +			error_errno(_("setsid failed"));
> +		close(0);
> +		close(1);
> +		close(2);
> +		sanitize_stdfds();
> +
> +		return ipc_server_run(path, opts, test_app_cb, (void*)&my_app_data);
> +
> +	case -1:
> +		return error_errno(_("could not spawn daemon in the background"));
> +
> +	default:
> +		return 0;
> +	}
> +}

In the non-Windows version, we spawn a server using the "path" parameter
we got from the caller.

But in the Windows version:

> +#else
> +/*
> + * Conceptually like `daemonize()` but different because Windows does not
> + * have `fork(2)`.  Spawn a normal Windows child process but without the
> + * limitations of `start_command()` and `finish_command()`.
> + */
> +static int spawn_server(const char *path,
> +			const struct ipc_server_opts *opts,
> +			pid_t *pid)
> +{
> +	char test_tool_exe[MAX_PATH];
> +	struct strvec args = STRVEC_INIT;
> +	int in, out;
> +
> +	GetModuleFileNameA(NULL, test_tool_exe, MAX_PATH);
> +
> +	in = open("/dev/null", O_RDONLY);
> +	out = open("/dev/null", O_WRONLY);
> +
> +	strvec_push(&args, test_tool_exe);
> +	strvec_push(&args, "simple-ipc");
> +	strvec_push(&args, "run-daemon");
> +	strvec_pushf(&args, "--threads=%d", opts->nr_threads);
> +
> +	*pid = mingw_spawnvpe(args.v[0], args.v, NULL, NULL, in, out, out);
> +	close(in);
> +	close(out);
> +
> +	strvec_clear(&args);
> +
> +	if (*pid < 0)
> +		return error(_("could not spawn daemon in the background"));
> +
> +	return 0;
> +}
> +#endif

We ignore the "path" parameter entirely. Should we be passing it along
as an option to the child process? I think it doesn't really matter at
this point because both the parent and child processes will use the
hard-coded string "ipc-test", but it seems like something the test
script might want to be able to specify.

-Peff
