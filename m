Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739904685
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730035426; cv=none; b=iMboGYbhMZgoYomhI+mD9Qsm10YMnm4SDXWmeFh2bXCogi13DFC/4cOlf4taaeBn8FpdkLnpP8ee5vPSzBUSXrzsJmGRk6mQwhM2ytoicIlpwILtFDgKRr8pWMFpm/LB8ZfIMzrWAsqkYxJiUcRlVOCJAPi2LKYhhdmsXX3bmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730035426; c=relaxed/simple;
	bh=Smn1eEFyBZdwvCAn4WiWn8DW8HvcQv/fschcDHz6J6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSOS8DB5Q71TjzMFgl7K8l0uvqOiQ9Vu2Nqv1Os6FQsEdlZSG9Owg7PLtr1a4WXpnO2eEQy0ZMHMbWZBw6zoWyn8WcjufMg7QvRYbsfdJT+DhyU5K5F2iPwq90vu/JCRwih6ruTxSuD+gX7kY3cnO4bQX0XKAEEGx01p32hEooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Xbxzx4cfTz5tvB
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 14:23:41 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Xbxzj52RYzRnlK;
	Sun, 27 Oct 2024 14:23:28 +0100 (CET)
Message-ID: <542b306a-523d-424b-bc9f-c63bb7040beb@kdbg.org>
Date: Sun, 27 Oct 2024 14:23:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] compat/mingw: support POSIX semantics for atomic
 renames
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1729695349.git.ps@pks.im> <cover.1729770140.git.ps@pks.im>
 <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <ee1e92e593e35f3888e3e47b6f603c04a1652ec6.1729770140.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
> By default, Windows restricts access to files when those files have been
> opened by another process. As explained in the preceding commits, these
> restrictions can be loosened such that reads, writes and/or deletes of
> files with open handles _are_ allowed.
> 
> While we set up those sharing flags in most relevant code paths now, we
> still don't properly handle POSIX-style atomic renames in case the
> target path is open. This is failure demonstrated by t0610, where one of
> our tests spawns concurrent writes in a reftable-enabled repository and
> expects all of them to succeed. This test fails most of the time because
> the process that has acquired the "tables.list" lock is unable to rename
> it into place while other processes are busy reading that file.
> 
> Windows 10 has introduced the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag
> that allows us to fix this usecase [1]. When set, it is possible to
> rename a file over a preexisting file even when the target file still
> has handles open. Those handles must have been opened with the
> `FILE_SHARE_DELETE` flag, which we have ensured in the preceding
> commits.
> > Careful readers might have noticed that [1] does not mention the above
> flag, but instead mentions `FILE_RENAME_POSIX_SEMANTICS`. This flag is
> not for use with `SetFileInformationByHandle()` though, which is what we
> use. And while the `FILE_RENAME_FLAG_POSIX_SEMANTICS` flag exists, it is
> not documented on [2] or anywhere else as far as I can tell.

The Windows 10 SDK defines FILE_RENAME_FLAG_REPLACE_IF_EXISTS and
FILE_RENAME_FLAG_POSIX_SEMANTICS for SetFileInformationByHandle(). That
the documentation lacks "_FLAG_" in the names must be an error in the
documentation.

I found the mention of FILE_RENAME_POSIX_SEMANTICS quite distracting,
because it is a flag to be used with CreateFileW() and basically only
has to do with case-sensitivity, but nothing with POSIX semantics of
renaming.

> 
> Unfortunately, we still support Windows systems older than Windows 10
> that do not yet have this new flag. Our `_WIN32_WINNT` SDK version still
> targets 0x0600, which is Windows Vista and later. And even though that
> Windows version is out-of-support, bumping the SDK version all the way
> to 0x0A00, which is Windows 10 and later, is not an option as it would
> make it impossible to compile on Windows 8.1, which is still supported.
> Instead, we have to manually declare the relevant infrastructure to make
> this feature available and have fallback logic in place in case we run
> on a Windows version that does not yet have this flag.
> 
> On another note: `mingw_rename()` has a retry loop that is used in case
> deleting a file failed because it's still open in another process. One
> might be pressed to not use this loop anymore when we can use POSIX
> semantics. But unfortunately, we have to keep it around due to our
> dependence on the `FILE_SHARE_DELETE` flag. While we know to set that
> sharing flag now, other applications may not do so and may thus still
> cause sharing violations when we try to rename a file.
> 
> This fixes concurrent writes in the reftable backend as demonstrated in
> t0610, but may also end up fixing other usecases where Git wants to
> perform renames.
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/ntifs/ns-ntifs-_file_rename_information
> [2]: https://learn.microsoft.com/en-us/windows/win32/api/winbase/ns-winbase-file_rename_info
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c             | 87 ++++++++++++++++++++++++++++++++++++--
>  t/t0610-reftable-basics.sh |  8 ++--
>  2 files changed, 88 insertions(+), 7 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 6c75fe36b15..22c005a4533 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2209,10 +2209,16 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
>  #undef rename
>  int mingw_rename(const char *pold, const char *pnew)
>  {
> +	static int supports_file_rename_info_ex = 1;
>  	DWORD attrs, gle;
>  	int tries = 0;
>  	wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
> -	if (xutftowcs_path(wpold, pold) < 0 || xutftowcs_path(wpnew, pnew) < 0)
> +	int wpnew_len;
> +
> +	if (xutftowcs_path(wpold, pold) < 0)
> +		return -1;
> +	wpnew_len = xutftowcs_path(wpnew, pnew);
> +	if (wpnew_len < 0)
>  		return -1;
>  
>  	/*
> @@ -2223,11 +2229,84 @@ int mingw_rename(const char *pold, const char *pnew)
>  		return 0;
>  	if (errno != EEXIST)
>  		return -1;
> +
>  repeat:
> -	if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
> -		return 0;
> +	if (supports_file_rename_info_ex) {
> +		/*
> +		 * Our minimum required Windows version is still set to Windows
> +		 * Vista. We thus have to declare required infrastructure for
> +		 * FileRenameInfoEx ourselves until we bump _WIN32_WINNT to
> +		 * 0x0A00. Furthermore, we have to handle cases where the
> +		 * FileRenameInfoEx call isn't supported yet.
> +		 */
> +#define FILE_RENAME_FLAG_REPLACE_IF_EXISTS                  0x00000001
> +#define FILE_RENAME_FLAG_POSIX_SEMANTICS                    0x00000002
> +		FILE_INFO_BY_HANDLE_CLASS FileRenameInfoEx = 22;
> +		struct {
> +			/*
> +			 * This is usually an unnamed union, but that is not
> +			 * part of ISO C99. We thus inline the field, as we
> +			 * really only care for the Flags field anyway.
> +			 */
> +			DWORD Flags;
> +			HANDLE RootDirectory;
> +			DWORD FileNameLength;
> +			/*
> +			 * The actual structure is defined with a single-character
> +			 * flex array so that the structure has to be allocated on
> +			 * the heap. As we declare this structure ourselves though
> +			 * we can avoid the allocation and define FileName to have
> +			 * MAX_PATH bytes.
> +			 */
> +			WCHAR FileName[MAX_PATH];
> +		} rename_info = { 0 };

Good.

> +		HANDLE old_handle = INVALID_HANDLE_VALUE;
> +		BOOL success;
> +
> +		old_handle = CreateFileW(wpold, DELETE,
> +					 FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> +					 NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
> +		if (old_handle == INVALID_HANDLE_VALUE) {
> +			errno = err_win_to_posix(GetLastError());
> +			return -1;
> +		}
> +
> +		rename_info.Flags = FILE_RENAME_FLAG_REPLACE_IF_EXISTS |
> +				    FILE_RENAME_FLAG_POSIX_SEMANTICS;
> +		rename_info.FileNameLength = wpnew_len * sizeof(WCHAR);

Size is in bytes, not in characters, and without the NUL. Good. I read
one comment on SO, which said that this value is ignored...

> +		memcpy(rename_info.FileName, wpnew, wpnew_len * sizeof(WCHAR));

... which makes it all the more important that this path is
NUL-terminated. Yet, this does not copy the NUL. We are still good,
because the buffer is zero-initialized and xutftowcs_path() ensures that
wpnew_len is at most MAX_PATH-1.

> +
> +		success = SetFileInformationByHandle(old_handle, FileRenameInfoEx,
> +						     &rename_info, sizeof(rename_info));
> +		gle = GetLastError();
> +		CloseHandle(old_handle);
> +		if (success)
> +			return 0;
> +
> +		/*
> +		 * When we see ERROR_INVALID_PARAMETER we can assume that the
> +		 * current system doesn't support FileRenameInfoEx. Keep us
> +		 * from using it in future calls and retry.
> +		 */
> +		if (gle == ERROR_INVALID_PARAMETER) {
> +			supports_file_rename_info_ex = 0;
> +			goto repeat;
> +		}
> +
> +		/*
> +		 * In theory, we shouldn't get ERROR_ACCESS_DENIED because we
> +		 * always open files with FILE_SHARE_DELETE But in practice we
> +		 * cannot assume that Git is the only one accessing files, and
> +		 * other applications may not set FILE_SHARE_DELETE. So we have
> +		 * to retry.
> +		 */

Good thinking!

> +	} else {
> +		if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
> +			return 0;
> +		gle = GetLastError();
> +	}
> +
>  	/* TODO: translate more errors */
> -	gle = GetLastError();
>  	if (gle == ERROR_ACCESS_DENIED &&
>  	    (attrs = GetFileAttributesW(wpnew)) != INVALID_FILE_ATTRIBUTES) {
>  		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index babec7993e3..eaf6fab6d29 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -450,10 +450,12 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
>  	)
>  '
>  
> -# This test fails most of the time on Windows systems. The root cause is
> +# This test fails most of the time on Cygwin systems. The root cause is
>  # that Windows does not allow us to rename the "tables.list.lock" file into
> -# place when "tables.list" is open for reading by a concurrent process.
> -test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
> +# place when "tables.list" is open for reading by a concurrent process. We have
> +# worked around that in our MinGW-based rename emulation, but the Cygwin
> +# emulation seems to be insufficient.
> +test_expect_success !CYGWIN 'ref transaction: many concurrent writers' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
>  	(

The general structure of the patch makes a lot of sense!

-- Hannes

