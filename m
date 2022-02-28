Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719DFC433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiB1P1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbiB1P1t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:27:49 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A581182
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:27:10 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 656BE3F4827;
        Mon, 28 Feb 2022 10:27:09 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2EE293F482D;
        Mon, 28 Feb 2022 10:27:09 -0500 (EST)
Subject: Re: [PATCH 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b5fb21f5-4aa6-fa36-a8f6-abf82b543c1d@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 10:27:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/28/22 4:40 AM, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
> 
> The mingw_utime implementation in mingw.c does not support
> directories. This means that "test-tool chmtime" fails on Windows when
> targeting directories. This has previously been noted and sidestepped
> by Jeff Hostetler, in "t/helper/test-chmtime: skip directories
> on Windows" in the "Builtin FSMonitor Part 2" work.
> 
> It would make sense to backdate file and folder changes in untracked
> cache tests, to avoid needing to insert explicit delays/pauses in the
> tests.
> 
> Add support for directory date manipulation in mingw_utime by calling
> CreateFileW() explicitly to create the directory handle, and
> CloseHandle() to close it.
> 
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>   compat/mingw.c | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 03af369b2b9..2284ea90511 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -964,6 +964,8 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>   	int fh, rc;
>   	DWORD attrs;
>   	wchar_t wfilename[MAX_PATH];
> +	HANDLE osfilehandle;

I'd be more comfortable initializing this variable to
INVALID_HANDLE_VALUE.

> +
>   	if (xutftowcs_path(wfilename, file_name) < 0)
>   		return -1;
>   
> @@ -975,9 +977,26 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>   		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
>   	}
>   
> -	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> -		rc = -1;
> -		goto revert_attrs;
> +	if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
> +		fh = 0;

and here initializing fh = -1.

> +		osfilehandle = CreateFileW(wfilename,
> +					   0x100 /*FILE_WRITE_ATTRIBUTES*/,
> +					   0 /*FileShare.None*/,

Is there a reason that you're not using the #define's here?
I assume you ran into a header file problem or something, but
there are other symbols used nearby, so I'm not sure.

> +					   NULL,
> +					   OPEN_EXISTING,
> +					   FILE_FLAG_BACKUP_SEMANTICS,
> +					   NULL);
> +		if (osfilehandle == INVALID_HANDLE_VALUE) {
> +			errno = err_win_to_posix(GetLastError());
> +			rc = -1;
> +			goto revert_attrs;
> +		}
> +	} else {
> +		if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> +			rc = -1;
> +			goto revert_attrs;
> +		}
> +		osfilehandle = (HANDLE)_get_osfhandle(fh);
>   	}
>   
>   	if (times) {
> @@ -987,12 +1006,16 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>   		GetSystemTimeAsFileTime(&mft);
>   		aft = mft;
>   	}
> -	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
> +	if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {
>   		errno = EINVAL;
>   		rc = -1;
>   	} else
>   		rc = 0;
> -	close(fh);
> +
> +	if (fh)
> +		close(fh);
> +	else if (osfilehandle)
> +		CloseHandle(osfilehandle);

And then this becomes:

	if (fh != -1)
		close(fh)
	else if (osfilehandle != INVALID_HANDLE_VALUE)
		Closehandle(osfilehandle);

Which I think makes it more clear that we'll properly close the handle.

>   
>   revert_attrs:
>   	if (attrs != INVALID_FILE_ATTRIBUTES &&
> 

An alternative solution would be to replace the _wopen() with
a call to CreateFileW() without the backup flag for non-directories
and just convert the whole routine to use HANDLE's rather fd's.

Thanks
Jeff
