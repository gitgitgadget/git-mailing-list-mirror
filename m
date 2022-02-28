Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818FCC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 22:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiB1WBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiB1WBF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 17:01:05 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4231443D8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 14:00:24 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6292F10914B;
        Mon, 28 Feb 2022 17:00:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6HNjEfrJCSydsWlHzTLj7iByca3dDfIa/5F66c
        4VGr4=; b=C0ohfYaJDnOkIpLuGMiqJIk0mOBnomIwWyOK9b8a6i5OUW0EobVGPv
        34/17Af+PhzukapKb+bYL8ulCumRoNH2pbwas61fH99wP5hIPPUOFWqlq1DnbjMh
        l7HBgHhWugNL3k2eqlAp4jQfpM1TsbDMLTkegFhNL04KdSLfF8C6A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B030109148;
        Mon, 28 Feb 2022 17:00:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6205C109147;
        Mon, 28 Feb 2022 17:00:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH 1/2] t/helper/test-chmtime: update mingw to support
 chmtime on directories
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
        <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 14:00:18 -0800
In-Reply-To: <76b6216281e3463821e650495f3090c677905f73.1646041236.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Mon, 28 Feb 2022 09:40:35
        +0000")
Message-ID: <xmqqfso2zm6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1A8B03A-98E1-11EC-9E58-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Tao Klerks <tao@klerks.biz>
>
> The mingw_utime implementation in mingw.c does not support
> directories. This means that "test-tool chmtime" fails on Windows when
> targeting directories. This has previously been noted and sidestepped
> by Jeff Hostetler, in "t/helper/test-chmtime: skip directories
> on Windows" in the "Builtin FSMonitor Part 2" work.

I was expecting that this will be applicable _before_ FSMonitor Part
2 and later.  This mention would probably belong to the comment
after three-dashes?

> It would make sense to backdate file and folder changes in untracked
> cache tests, to avoid needing to insert explicit delays/pauses in the
> tests.
>
> Add support for directory date manipulation in mingw_utime by calling
> CreateFileW() explicitly to create the directory handle, and
> CloseHandle() to close it.

OK.

> @@ -964,6 +964,8 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>  	int fh, rc;
>  	DWORD attrs;
>  	wchar_t wfilename[MAX_PATH];
> +	HANDLE osfilehandle;

The variable is not initialized here, but that is perfectly OK.
We'll set it in both branches for directories and files.

>  	if (xutftowcs_path(wfilename, file_name) < 0)
>  		return -1;
>  
> @@ -975,9 +977,26 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>  		SetFileAttributesW(wfilename, attrs & ~FILE_ATTRIBUTE_READONLY);
>  	}
>  
> -	if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> -		rc = -1;
> -		goto revert_attrs;
> +	if (attrs & FILE_ATTRIBUTE_DIRECTORY) {

Excellent.  We can reuse existing attrs without any extra calls to
introduce the new codepath to deal with directories.

> +		fh = 0;

This should be

		fh = -1;

instead.  More on this later.

> +		osfilehandle = CreateFileW(wfilename,
> +					   0x100 /*FILE_WRITE_ATTRIBUTES*/,
> +					   0 /*FileShare.None*/,
> +					   NULL,
> +					   OPEN_EXISTING,
> +					   FILE_FLAG_BACKUP_SEMANTICS,
> +					   NULL);
> +		if (osfilehandle == INVALID_HANDLE_VALUE) {
> +			errno = err_win_to_posix(GetLastError());
> +			rc = -1;
> +			goto revert_attrs;
> +		}

Upon an error, we'll jump to revert_attrs but otherwise, we will
have a valid osfilehandle (which presumably is not NULL).

> +	} else {
> +		if ((fh = _wopen(wfilename, O_RDWR | O_BINARY)) < 0) {
> +			rc = -1;
> +			goto revert_attrs;
> +		}
> +		osfilehandle = (HANDLE)_get_osfhandle(fh);

This side is the same as before.  This code assumes that, as long as
_wopen() gives us a usable fh, _get_osfhandle(fh) would always give
us a valid handle.  This assumption should be safe, as the original
code has been relying on it anyway.

> @@ -987,12 +1006,16 @@ int mingw_utime (const char *file_name, const struct utimbuf *times)
>  		GetSystemTimeAsFileTime(&mft);
>  		aft = mft;
>  	}
> -	if (!SetFileTime((HANDLE)_get_osfhandle(fh), NULL, &aft, &mft)) {
> +	if (!SetFileTime(osfilehandle, NULL, &aft, &mft)) {

And we use the osfilehandle we obtained, either from the code that
is identical to the original for files or from the new code for
directories.  Good.

>  		errno = EINVAL;
>  		rc = -1;
>  	} else
>  		rc = 0;
> -	close(fh);
> +
> +	if (fh)
> +		close(fh);
> +	else if (osfilehandle)
> +		CloseHandle(osfilehandle);

In the context of "git" process, I do not think we would ever close
FD#0, so it may be safe to assume that _wopen() above will never
yield FD#0, so this is not quite wrong per-se, but to be
future-proof, it would be even safer to instead do:

	if (0 <= fh)
		close(fh);
	else if (osfilehandle)
		CloseHandle(osfilehandle);

here.  That is consistent with the error checking done where
_wopen() was called to obtain it above, i.e.

	if ((fh = _wopen(...)) < 0)
		... error ...

>  revert_attrs:
>  	if (attrs != INVALID_FILE_ATTRIBUTES &&
