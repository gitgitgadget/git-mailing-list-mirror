Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489D1C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 23:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D34A20880
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 23:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfK2XCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 18:02:51 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:44489 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfK2XCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 18:02:51 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47Pqm84dJdz5tlB;
        Sat, 30 Nov 2019 00:02:48 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2CCE91BFA;
        Sat, 30 Nov 2019 00:02:48 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: do set `errno` correctly when trying to
 restrict handle inheritance
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
 <685360f735e35e837bc9ef684cbde33564c81666.1575063876.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <52f2fe39-6a71-a327-8aea-ba757b7eec18@kdbg.org>
Date:   Sat, 30 Nov 2019 00:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <685360f735e35e837bc9ef684cbde33564c81666.1575063876.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.19 um 22:44 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In 9a780a384de (mingw: spawned processes need to inherit only standard
> handles, 2019-11-22), we taught the Windows-specific part to restrict
> which file handles are passed on to the spawned processes.
> 
> Since this logic seemed to be a bit fragile across Windows versions (we
> _still_ support Windows Vista in Git for Windows, for example), a
> fall-back was added to try spawning the process again, this time without
> restricting which file handles are to be inherited by the spawned
> process.
> 
> In the common case (i.e. when the process could not be spawned for
> reasons _other_ than the file handle inheritance), the fall-back attempt
> would still fail, of course.
> 
> Crucially, one thing we missed in that code path was to set `errno`
> appropriately.
> 
> This should have been caught by t0061.2 which expected `errno` to be
> `ENOENT` after trying to start a process for a non-existing executable,
> but `errno` was set to `ENOENT` prior to the `CreateProcessW()` call:
> while looking for the config settings for trace2, Git tries to access
> `xdg_config` and `user_config` via `access_or_die()`, and as neither of
> those config files exists when running the test case (because in Git's
> test suite, `HOME` points to the test directory), the `errno` has the
> expected value, but for the wrong reasons.
> 
> Let's fix that by making sure that `errno` is set correctly.
> 
> It would be nice if we could somehow fix t0061 to make sure that this
> does not regress again. One approach that seemed like it should work,
> but did not, was to set `errno` to 0 in the test helper that is used by
> t0061.2.
> 
> However, when `mingw_spawnvpe()` wants to see whether the file in
> question is a script, it calls `parse_interpreter()`, which in turn
> tries to `open()` the file.0/compat/mingw.c#L1134. Obviously,

Copy-and-paste garbage?

> this call fails, and sets `errno` to `ENOENT`, deep inside the call
> chain started from that test helper.
> 
> Instead, we force re-set `errno` at the beginning of the function
> `mingw_spawnve_fd()`, which _should_ be safe given that callers of that
> function will want to look at `errno` if -1 was returned. And if that
> `errno` is 0 ("No error"), regression tests like t0061.2 will kick in.
> 
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 2b6eca2f56..bb4eb4211a 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1423,6 +1423,9 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
>  	const char *(*quote_arg)(const char *arg) =
>  		is_msys2_sh(*argv) ? quote_arg_msys2 : quote_arg_msvc;
>  
> +	/* Make sure to override previous errors, if any */
> +	errno = 0;
> +
>  	if (restrict_handle_inheritance < 0)
>  		restrict_handle_inheritance = core_restrict_inherited_handles;
>  	/*
> @@ -1580,8 +1583,8 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **deltaen
>  		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
>  				     TRUE, flags, wenvblk, dir ? wdir : NULL,
>  				     &si.StartupInfo, &pi);
> +		errno = err_win_to_posix(GetLastError());

I think this should be protected by 'if (!ret)' because
err_win_to_posix() does not handle ERROR_SUCCESS and turns it into
ENOSYS. It's not that bad because in the case of success we do not
guarantee any value of errno anyway.

>  		if (ret && buf.len) {
> -			errno = err_win_to_posix(GetLastError());
>  			warning("failed to restrict file handles (%ld)\n\n%s",
>  				err, buf.buf);
>  		}
> 

That said, this fixes the failure.

-- Hannes
