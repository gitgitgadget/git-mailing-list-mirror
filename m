Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CAE1FF5EB
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962267; cv=none; b=OOFvBHYOhZ/jv0qCl9wvP6d+Pp28HnN0iXCY/tJst7JKH5LaK2O7+iLuA0+6NyNEn04Ia7Do+KnxtJh32LuRrU9CznIkCFyFdpxIULjZFle9w5LwprTOnARkwcAoUPJEu4iWXXKB+LIep8EUgDmdtlEuHfUhHuSfIIdfaTWQnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962267; c=relaxed/simple;
	bh=iBiQQax1mhWhCN700e9TIOkOjEUsgUBDCVPLMiohAsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTQgVr5jvYlTb7XsNjechma/wRz4V8AvZ3abS05+WS6NWfsj6X2+u3mvlJIYPC/7m+AaPL2od1e7ZsNs4Xy8Kwc+g9BSS9sQskSfpIz4yUOO6NwvnUmHdXkSkH7ic9MSywzAhsMnc6MwdzS83WpFhwkm4NKCHKL6AKfhUMPLZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
	by mailout10.t-online.de (Postfix) with SMTP id B50AFF88;
	Fri, 14 Mar 2025 15:18:57 +0100 (CET)
Received: from [192.168.178.52] ([77.20.184.84]) by fwd71.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tt5sF-2Tw5Tc0; Fri, 14 Mar 2025 15:18:57 +0100
Message-ID: <de954c02-8711-43e9-8f4c-259718034497@t-online.de>
Date: Fri, 14 Mar 2025 15:18:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Johannes Sixt <j6t@kdbg.org>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>
From: Christian Reich <Zottelbart@t-online.de>
In-Reply-To: <20250206-b4-pks-reftable-win32-in-use-errors-v2-1-56985a4f6186@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1741961937-E0FF7594-A5ECDE95/10/3626336762 SUSPECT URL
X-TOI-MSGID: fd66fee9-9ebe-40d3-a28d-de67ba02eca6

Greetings,

the patch didn't find the way in next git version.

But there is a change in git for windows, which prevents multiple asks 
the same questions:

https://github.com/git-for-windows/git/commit/dba1473162b4319a0a2c7f74ab48ed4a826f7ac7

The other option to prevent the asks, is to set GIT_ASK_YESNO but the 
sleeps slow down the process.

Best Regards

Christian

Am 06.02.2025 um 08:53 schrieb Patrick Steinhardt:
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
> Changes in v2:
>    - Rebased the patch on top of ps/reftable-sans-compat-util at
>      3f172f1391 (Makefile: skip reftable library for Coccinelle,
>      2025-02-03). This is done to fix a semantic merge conflict.
>    - Link to v1: https://lore.kernel.org/r/20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
> ---
>   compat/mingw/compat-util.c | 5 ++++-
>   compat/mingw/posix.h       | 8 ++++++--
>   reftable/system.h          | 1 +
>   3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/compat/mingw/compat-util.c b/compat/mingw/compat-util.c
> index 1d5b211b54..0e4b6a70a4 100644
> --- a/compat/mingw/compat-util.c
> +++ b/compat/mingw/compat-util.c
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
> diff --git a/compat/mingw/posix.h b/compat/mingw/posix.h
> index 8dddfa818d..88e0cf9292 100644
> --- a/compat/mingw/posix.h
> +++ b/compat/mingw/posix.h
> @@ -201,8 +201,12 @@ int uname(struct utsname *buf);
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
> index dccdf11f76..1492bf6d70 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
>   
>   /* This header glues the reftable library to the rest of Git */
>   
> +#define MINGW_DONT_HANDLE_IN_USE_ERROR
>   #include "../compat/posix.h"
>   #include <zlib.h>
>   
>
> ---
> base-commit: 0fb5c2116049c665c6550d7e0419971a277af345
> change-id: 20250124-b4-pks-reftable-win32-in-use-errors-969494f2fdf7
>
