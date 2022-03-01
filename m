Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09A4C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 16:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiCAQe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiCAQe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 11:34:56 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DA713FB1
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 08:34:14 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 33F953F413E;
        Tue,  1 Mar 2022 11:34:14 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E5F733F4090;
        Tue,  1 Mar 2022 11:34:13 -0500 (EST)
Subject: Re: [PATCH v2 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tao Klerks <tao@klerks.biz>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
 <7cdef0ad5fb6fc1a16ee1cee27b9dec0300c8c1d.1646127910.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <37f66fae-911a-62f1-4711-c9f6c7794911@jeffhostetler.com>
Date:   Tue, 1 Mar 2022 11:34:13 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7cdef0ad5fb6fc1a16ee1cee27b9dec0300c8c1d.1646127910.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/1/22 4:45 AM, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
> 
> The mingw_utime implementation in mingw.c does not support
> directories. This means that "test-tool chmtime" fails on Windows when
> targeting directories. This has previously been noted and sidestepped
> temporarily by Jeff Hostetler, in "t/helper/test-chmtime: skip
> directories on Windows" in the "Builtin FSMonitor Part 2" work, but
> not yet fixed.
> 
> It would make sense to backdate file and folder changes in untracked
> cache tests, to avoid needing to insert explicit delays/pauses in the
> tests.
> 
> Add support for directory date manipulation in mingw_utime by
> replacing the file-oriented _wopen() call with the
> directory-supporting CreateFileW() windows API explicitly.
> 
> Signed-off-by: Tao Klerks <tao@klerks.biz>
> ---
>   compat/mingw.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 03af369b2b9..11c43ad2dfb 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -961,9 +961,11 @@ static inline void time_t_to_filetime(time_t t, FILETIME *ft)
>   int mingw_utime (const char *file_name, const struct utimbuf *times)
>   {
>   	FILETIME mft, aft;
> -	int fh, rc;
> +	int rc;
>   	DWORD attrs;
>   	wchar_t wfilename[MAX_PATH];
> +	HANDLE osfilehandle;
> +
>   	if (xutftowcs_path(wfilename, file_name) < 0)
>   		return -1;
>   
> @@ -975,7 +977,16 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>   		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
>   	}
>   
> -	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> +	osfilehandle = CreateFileW(wfilename,
> +				   0x100 /*FILE_WRITE_ATTRIBUTES*/,

https://docs.microsoft.com/en-us/windows/win32/fileio/file-access-rights-constants

indicates that FILE_WRITE_ATTRIBUTES is defined in <WinNT.h> which
we get from <windows.h> which was included by "win32.h", so it should
already be present.

> +				   0 /*FileShare.None*/,
> +				   NULL,
> +				   OPEN_EXISTING,
> +				   attrs & FILE_ATTRIBUTE_DIRECTORY ?
> +					FILE_FLAG_BACKUP_SEMANTICS : 0,

There is a weird error case here.  If the GetFileAttributesW() call
at the top fails, it returns INVALID_FILE_ATTRIBUTES (aka -1).  So
the (attrs & ...) here expression is questionable.

I'm not sure that there is a best way to handle the earlier failure
(other than returning an error at the top), but we do try to limp
along (for some reason).

So maybe make this something like:

     (attrs != INVALID_FILE_ATTRIBUTES &&
      (attrs & FILE_ATTRIBUTE_DIRECTORY)) ?
         FILE_FLAG_BACKUP_SEMANTICS : 0


> +				   NULL);
> +	if (osfilehandle == INVALID_HANDLE_VALUE) {
> +		errno = err_win_to_posix(GetLastError());
>   		rc = -1;
>   		goto revert_attrs;
>   	}
> @@ -987,12 +998,14 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
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
> +	if (osfilehandle != INVALID_HANDLE_VALUE)
> +		CloseHandle(osfilehandle);
>   
>   revert_attrs:
>   	if (attrs != INVALID_FILE_ATTRIBUTES &&
> 
