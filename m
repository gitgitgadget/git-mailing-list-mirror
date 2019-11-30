Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15523C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0E42084E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 19:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfK3TUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:20:16 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:6885 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfK3TUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 14:20:16 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 47QLmr0Zs3z5tlB;
        Sat, 30 Nov 2019 20:20:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B008F2093;
        Sat, 30 Nov 2019 20:20:11 +0100 (CET)
Subject: Re: [PATCH v2 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.480.git.1575063876.gitgitgadget@gmail.com>
 <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7a88a80d-76db-3ca5-c5e1-134b82b5bcbf@kdbg.org>
Date:   Sat, 30 Nov 2019 20:20:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.19 um 11:36 schrieb Johannes Schindelin via GitGitGadget:
> Johannes "Hannes" Sixt pointed out that this patch series (which already
> made it to next) introduces a problem: when falling back to spawning the
> process without restricting the file handles, errno is not set accurately.
> 
> Sadly, the regression test failure observed by Hannes did not show up over
> here, nor in the PR builds (or, for that matter, the literally hundreds of
> CI builds that patch series underwent as part of Git for Windows' master 
> branch). The cause was that errno is set to the expected ENOENT by another 
> part of the code, too, that happens right before the calls to 
> CreateProcessW(): the test whether a given path refers to a script that
> needs to be executed via an interpreter (such as sh.exe) obviously needs to
> open the file, and that obviously fails, setting errno = ENOENT!
> 
> I have currently no idea what function call could be responsible for
> re-setting errno to the reported ERANGE... But at least over here, when I
> partially apply this patch, the part that sets errno = 0;, t0061.2 fails for
> me, too.
> 
> Changes since v1:
> 
>  * A copy/edit fail in the commit message was fixed.
>  * We now assign errno only when the call to CreateProcessW() failed.
>  * For good measure, we teach the err_win_to_posix() function to translate 
>    ERROR_SUCCESS into the errno value 0.

This series fixes the observed failure. The changes look good. Thank you
for the quick turn-around.

Tested-by: Johannes Sixt <j6t@kdbg.org>

> 
> Johannes Schindelin (2):
>   mingw: do set `errno` correctly when trying to restrict handle
>     inheritance
>   mingw: translate ERROR_SUCCESS to errno = 0
> 
>  compat/mingw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> 
> base-commit: ac33519ddfa818f420b4ef5a09b4a7b3ac8adeb8
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-480%2Fdscho%2Fmingw-inherit-only-std-handles-set-errno-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-480/dscho/mingw-inherit-only-std-handles-set-errno-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/480
> 
> Range-diff vs v1:
> 
>  1:  685360f735 ! 1:  280b6d08a4 mingw: do set `errno` correctly when trying to restrict handle inheritance
>      @@ -28,7 +28,10 @@
>           test suite, `HOME` points to the test directory), the `errno` has the
>           expected value, but for the wrong reasons.
>       
>      -    Let's fix that by making sure that `errno` is set correctly.
>      +    Let's fix that by making sure that `errno` is set correctly. It even
>      +    appears that `errno` was set in the _wrong_ case previously:
>      +    `CreateProcessW()` returns non-zero upon success, but `errno` was set
>      +    only in the non-zero case.
>       
>           It would be nice if we could somehow fix t0061 to make sure that this
>           does not regress again. One approach that seemed like it should work,
>      @@ -37,9 +40,8 @@
>       
>           However, when `mingw_spawnvpe()` wants to see whether the file in
>           question is a script, it calls `parse_interpreter()`, which in turn
>      -    tries to `open()` the file.0/compat/mingw.c#L1134. Obviously,
>      -    this call fails, and sets `errno` to `ENOENT`, deep inside the call
>      -    chain started from that test helper.
>      +    tries to `open()` the file. Obviously, this call fails, and sets `errno`
>      +    to `ENOENT`, deep inside the call chain started from that test helper.
>       
>           Instead, we force re-set `errno` at the beginning of the function
>           `mingw_spawnve_fd()`, which _should_ be safe given that callers of that
>      @@ -66,9 +68,10 @@
>        		ret = CreateProcessW(*wcmd ? wcmd : NULL, wargs, NULL, NULL,
>        				     TRUE, flags, wenvblk, dir ? wdir : NULL,
>        				     &si.StartupInfo, &pi);
>      -+		errno = err_win_to_posix(GetLastError());
>      - 		if (ret && buf.len) {
>      --			errno = err_win_to_posix(GetLastError());
>      +-		if (ret && buf.len) {
>      ++		if (!ret)
>      + 			errno = err_win_to_posix(GetLastError());
>      ++		if (ret && buf.len) {
>        			warning("failed to restrict file handles (%ld)\n\n%s",
>        				err, buf.buf);
>        		}
>  -:  ---------- > 2:  c3dea00fb1 mingw: translate ERROR_SUCCESS to errno = 0
> 

-- Hannes
