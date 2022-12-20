Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451AC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 07:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLTHWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 02:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiLTHWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 02:22:04 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862CB2AC1
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 23:22:02 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Nbp1324Jqz5tlD;
        Tue, 20 Dec 2022 08:21:59 +0100 (CET)
Message-ID: <2c0c8ead-3942-6c44-b854-5980cff55755@kdbg.org>
Date:   Tue, 20 Dec 2022 08:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] win32: explicitly set errno to enoent if err is not
 error_directory
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1402.git.git.1671465108414.gitgitgadget@gmail.com>
 <pull.1402.v2.git.git.1671466826159.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1402.v2.git.git.1671466826159.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.12.22 um 17:20 schrieb Rose via GitGitGadget:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> At this point, the only two possible errors are
> ERROR_DIRECTORY or ERROR_BAD_PATHNAME.
> 
> This code clarifies this and also saves a call to
> err_win_to_posix.
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---

> diff --git a/compat/win32/dirent.c b/compat/win32/dirent.c
> index 52420ec7d4d..8f94a5ab6db 100644
> --- a/compat/win32/dirent.c
> +++ b/compat/win32/dirent.c
> @@ -34,13 +34,13 @@ DIR *opendir(const char *name)
>  	if (len && !is_dir_sep(pattern[len - 1]))
>  		pattern[len++] = '/';
>  	pattern[len++] = '*';
> -	pattern[len] = 0;
> +	pattern[len] = '\0';
>  
>  	/* open find handle */
>  	h = FindFirstFileW(pattern, &fdata);
>  	if (h == INVALID_HANDLE_VALUE) {
>  		DWORD err = GetLastError();
> -		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : err_win_to_posix(err);
> +		errno = (err == ERROR_DIRECTORY) ? ENOTDIR : ENOENT;

This change does not look correct. The documentation of
FindFirstFileW()[*] does not give any guarantees that ERROR_DIRECTORY
and ERROR_BAD_PATHNAME are the only possible error values. It is
certainly not unthinkable that a hardware error is reported as
ERROR_IO_DEVICE and should be translated to EIO.

[*]
https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-findfirstfilew

-- Hannes

