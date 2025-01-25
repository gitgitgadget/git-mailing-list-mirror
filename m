Received: from mailout03.t-online.de (mailout03.t-online.de [194.25.134.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB901D9A5D
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737795084; cv=none; b=Q+dObxp7AEei+YCfDAPiR/v7/m5J9smvMXDXtBccevQfVWE/LWl+l4lPQ0SXiXjvm5S2hGQEGCXThpcqTJrRKbH1yZajlvMIU9jUkBOPw9v3vcc1NXYDjzf/kr/ffWvCzcFIXr+2kZwptgie4RaxiQ1TL1dT7a6i2A8G1s1/Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737795084; c=relaxed/simple;
	bh=X3Pqti1MTfhDu1Ja1iuPO5bNqqeHCW/wNByT3dm8fEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pXHtd9HCYnzxRwb4TMr5HQ1JQ5/lRcLKyahw8zAJGhiDBiA7/Ze8NoFBKd+hE+WbhAQ8hBcHtDZvc6ijZWWFzVbyeCkg10Dklv2HDzRqvG9fpWVKsTBbLHxaX/h5d+tTL4Jm0M5puFebsSX2CYPuzBCUqrDiGHv3b/X09J8SXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout03.t-online.de (Postfix) with SMTP id 41CD98EE;
	Sat, 25 Jan 2025 09:45:24 +0100 (CET)
Received: from [192.168.178.52] ([77.20.184.84]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tbbn8-0YpR4K0; Sat, 25 Jan 2025 09:45:24 +0100
Message-ID: <08d7e79e-3a59-4163-be2b-97f0238142aa@t-online.de>
Date: Sat, 25 Jan 2025 09:45:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p) fails
 on Windows
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
From: Christian Reich <Zottelbart@t-online.de>
In-Reply-To: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1737794724-977FD9D3-688A0E9A/10/3626336762 SUSPECT URL
X-TOI-MSGID: a1edd0f9-f7cb-4097-b91e-cb970b91adec

Greetings Patrick,

thx you for the patch. I build an own version of git for windows with 
this patch and it works as expected! *thumbsup*

But I see merge conflicts in git for windows main-branch:

1. mingw_unlink looks different in windows-master in compare to the diff:

https://github.com/git-for-windows/git/blob/main/compat/mingw.c#L551

2. in mingw_rename is another call of mingw_unlink:

https://github.com/git-for-windows/git/blob/main/compat/mingw.c#L2974

So I don't know how the patch would find it way to the windows version.

Thank you for your effort.

Christian

Am 25.01.2025 um 06:41 schrieb Patrick Steinhardt:
> Unlinking a file may fail on Windows systems when the file is still held
> open by another process. This is incompatible with POSIX semantics and
> by extension with Git's assumed semantics when unlinking files, which
> is that files can be unlinked regardless of whether they are still open
> or not. To counteract this incompatibility, we have some custom error
> handling in the `mingw_unlink()` wrapper that first retries the deletion
> with some delay, and then asks the user whether we should continue to
> retry.
>
> While this logic might be sensible in many callsites throughout Git, it
> is less when used in the reftable library. We only use unlink(3) there
> to delete tables which aren't referenced anymore, and the code is very
> aware of the limitations on Windows. As such, all calls to unlink(3p)
> don't perform any error checking at all and are fine with the call
> failing.
>
> Instead, the library provides the `reftable_stack_clean()` function,
> which Git knows to execute in git-pack-refs(1) after compacting a stack.
> The effect of this function is that all stale tables will eventually get
> deleted once they aren't kept open anymore.
>
> So while we're fine with unlink(3p) failing, the Windows-emulation of
> that function will still perform several sleeps and ultimately end up
> asking the user:
>
>      $ git pack-refs
>      Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
>      Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
>      Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref' failed. Should I try again? (y/n) n
>
> It even asks multiple times, which is doubly annoying and puzzling to
> the user:
>
>    1. It asks when trying to delete the old file after having written the
>       compacted stack.
>
>    2. It asks when reloading the stack, where it will try to unlink
>       now-unreferenced tables.
>
>    3. It asks when calling `reftable_stack_clean()`, where it will try to
>       unlink now-stale tables.
>
> Fix the issue by making it possible to disable this behaviour with a
> preprocessor define. As "git-compat-util.h" is only included from
> "system.h", and given that "system.h" is only ever included by headers
> and code that are internal to the reftable library, we can set that
> macro in this header without impacting anything else but the reftable
> library.
>
> Reported-by: Christian Reich <Zottelbart@t-online.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> This patch fixes the issue reported in [1].
>
> Thanks!
>
> Patrick
>
> [1]: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
> ---
>   compat/mingw.c    | 5 ++++-
>   compat/mingw.h    | 8 ++++++--
>   reftable/system.h | 1 +
>   3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 1d5b211b54..0e4b6a70a4 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -302,7 +302,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
>   	return wbuf;
>   }
>   
> -int mingw_unlink(const char *pathname)
> +int mingw_unlink(const char *pathname, int handle_in_use_error)
>   {
>   	int ret, tries = 0;
>   	wchar_t wpathname[MAX_PATH];
> @@ -317,6 +317,9 @@ int mingw_unlink(const char *pathname)
>   	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
>   		if (!is_file_in_use_error(GetLastError()))
>   			break;
> +		if (!handle_in_use_error)
> +			return ret;
> +
>   		/*
>   		 * We assume that some other process had the source or
>   		 * destination file open at the wrong moment and retry.
> diff --git a/compat/mingw.h b/compat/mingw.h
> index ebfb8ba423..a555af8d54 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -224,8 +224,12 @@ int uname(struct utsname *buf);
>    * replacements of existing functions
>    */
>   
> -int mingw_unlink(const char *pathname);
> -#define unlink mingw_unlink
> +int mingw_unlink(const char *pathname, int handle_in_use_error);
> +#ifdef MINGW_DONT_HANDLE_IN_USE_ERROR
> +# define unlink(path) mingw_unlink(path, 0)
> +#else
> +# define unlink(path) mingw_unlink(path, 1)
> +#endif
>   
>   int mingw_rmdir(const char *path);
>   #define rmdir mingw_rmdir
> diff --git a/reftable/system.h b/reftable/system.h
> index 5274eca1d0..fe94bf205b 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -13,6 +13,7 @@ license that can be found in the LICENSE file or at
>   
>   #define DISABLE_SIGN_COMPARE_WARNINGS
>   
> +#define MINGW_DONT_HANDLE_IN_USE_ERROR
>   #include "git-compat-util.h"
>   
>   /*
>
> ---
> base-commit: 4e746b1a31f9f0036032b6f94279cf16fb363203
> change-id: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7
>
