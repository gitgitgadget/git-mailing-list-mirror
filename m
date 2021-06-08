Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A362C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AC561027
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFHGvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:51:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:48650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFHGvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:51:19 -0400
Received: (qmail 28363 invoked by uid 109); 8 Jun 2021 06:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 06:49:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7139 invoked by uid 111); 8 Jun 2021 06:49:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 02:49:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 02:49:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtins + test helpers: use return instead of exit() in
 cmd_*
Message-ID: <YL8S9jDmrtdKr5N+@coredump.intra.peff.net>
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 01:12:48PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change various cmd_* functions to use "return" instead of exit() to
> indicate an exit code. On Solaris with SunCC the compiler legitimately
> complains about these, since we'll e.g. skip the cleanup (e.g. closing
> fd's, erroring if we can't) in git.c's run_builtin() when we exit()
> directly like this.

Each of these cases looks like a simple and obvious conversion, and I
certainly don't mind us doing it.

But I do wonder what SunCC is complaining about exactly. Calling exit()
means you don't have to worry about cleanup anymore. Does the compiler
not have any notion of NORETURN or equivalent? If so, I'd expect many
more complaints in general that we probably _won't_ want to silence,
because it will be awkward to do so.

> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 89334b77fb..6a9242a803 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *prefix,
>  		"GIT_PAGER=", "GIT_EXTERNAL_DIFF=git-difftool--helper", NULL,
>  		NULL
>  	};
> -	int ret = 0, i;
> +	int i;
>  
>  	if (prompt > 0)
>  		env[2] = "GIT_DIFFTOOL_PROMPT=true";
> @@ -686,8 +686,7 @@ static int run_file_diff(int prompt, const char *prefix,
>  	strvec_push(&args, "diff");
>  	for (i = 0; i < argc; i++)
>  		strvec_push(&args, argv[i]);
> -	ret = run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
> -	exit(ret);
> +	return run_command_v_opt_cd_env(args.v, RUN_GIT_CMD, prefix, env);
>  }

This one I'm not surprised that a compiler would complain about. The
function returns an int, but there are no return paths from the
function (and hence the caller doing "return run_diff_files()" likewise
could not ever return there. Which is not quite what you said it
complained about above, hence my curiosity. :)

-Peff
