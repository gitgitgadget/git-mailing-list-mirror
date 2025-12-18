Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692381ACA
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766081611; cv=none; b=Gt5jENZb7zENuZhU1FnBE0HBXz5QgXUHth5Ow7J+pqXo4t4RD5qlNVQvhEGzNdUil7D0KjebUd3lNjbMETP0u0VMYsbm3Wnzgq+b3QOjm0tM1oIlz2U91GQe77T5BpnyfXtGPvKLKTLyZrTHVBPeLL9tnFeh+wUNsPxH7fOqcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766081611; c=relaxed/simple;
	bh=hIFwzd7gys8aSchb9yImG+eRm24S/NGFDD6FpGm5+IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmhANJjMW+LzGSFbH7KFQudY0yccyygVKJfpwlYaPqnOQAmEuN9ybPYP5VO+yDak6PzHmRBRqDuxNHZRv1C1wNnC04af/DPzcVYzJe8Sw1WFVSJ759UBqJj9nQnXE4rywljiL42FK8cKyfI57bjEmRId6JdIM1URsWOlhwUSuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dXJgl0W7czRpKW;
	Thu, 18 Dec 2025 19:13:23 +0100 (CET)
Message-ID: <8826825b-79ad-4700-aeb5-71e7847ca5dc@kdbg.org>
Date: Thu, 18 Dec 2025 19:13:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] mingw: implement `readlink()`
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
 <8fef8220f4d60b48358882fbc961c4604eab3abf.1765980535.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <8fef8220f4d60b48358882fbc961c4604eab3abf.1765980535.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> From: Karsten Blees <blees@dcon.de>
> 
> Implement `readlink()` by reading NTFS reparse points via the
> `read_reparse_point()` function that was introduced earlier to determine
> the length of symlink targets. Works for symlinks and directory
> junctions. If symlinks are disabled, fail with `ENOSYS`.

This last sentence is obsolete, I think, because I cannot see how the
patch achieves a failure with ENOSYS.

> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw-posix.h |  3 +--
>  compat/mingw.c       | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
> index 0939feff27..896aa976b1 100644
> --- a/compat/mingw-posix.h
> +++ b/compat/mingw-posix.h
> @@ -121,8 +121,6 @@ struct utsname {
>   * trivial stubs
>   */
>  
> -static inline int readlink(const char *path UNUSED, char *buf UNUSED, size_t bufsiz UNUSED)
> -{ errno = ENOSYS; return -1; }
>  static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
>  { errno = ENOSYS; return -1; }
>  static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
> @@ -197,6 +195,7 @@ int setitimer(int type, struct itimerval *in, struct itimerval *out);
>  int sigaction(int sig, struct sigaction *in, struct sigaction *out);
>  int link(const char *oldpath, const char *newpath);
>  int uname(struct utsname *buf);
> +int readlink(const char *path, char *buf, size_t bufsiz);
>  
>  /*
>   * replacements of existing functions
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 5d2a8c247c..b407a2ac07 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2698,6 +2698,30 @@ int link(const char *oldpath, const char *newpath)
>  	return 0;
>  }
>  
> +int readlink(const char *path, char *buf, size_t bufsiz)
> +{
> +	WCHAR wpath[MAX_PATH];
> +	char tmpbuf[MAX_PATH];
> +	int len;
> +	DWORD tag;
> +
> +	if (xutftowcs_path(wpath, path) < 0)
> +		return -1;
> +
> +	if (read_reparse_point(wpath, TRUE, tmpbuf, &len, &tag) < 0)
> +		return -1;
> +
> +	/*
> +	 * Adapt to strange readlink() API: Copy up to bufsiz *bytes*, potentially
> +	 * cutting off a UTF-8 sequence. Insufficient bufsize is *not* a failure
> +	 * condition. There is no conversion function that produces invalid UTF-8,
> +	 * so convert to a (hopefully large enough) temporary buffer, then memcpy
> +	 * the requested number of bytes (including '\0' for robustness).
> +	 */
> +	memcpy(buf, tmpbuf, min(bufsiz, len + 1));
> +	return min(bufsiz, len);
> +}
> +
>  pid_t waitpid(pid_t pid, int *status, int options)
>  {
>  	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,

-- Hannes

