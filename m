Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2F3148C9
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766079883; cv=none; b=CAQRO4Wh3cXmsvft6hZS+CKFXNYCgrL5eq/UArNtLPQQ8sf0DGx3Tk6FO7IJXI3XO/7xL1nQPOMdqwKX+tYN34gBV7JQLxUZ3c0nQIdEE/aaQDTNW4KOwuOtybofZl2LkpolWTVwBuqt6nlpRsLzdntNZz5dGkxQ8I564Dw3+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766079883; c=relaxed/simple;
	bh=su5aLEk0LCAkIIonWEtB7uxgrx92Ut2kihtppIylJzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVSpfjxNqOwqoGMTzHbqgOihVv/vjeOsp2b2sePpKQlYrMtnsR7TIicD9on1Wg79oEsm6pShxGRfPiAnP/i8GUT4+/q0+afZJ2xTj9AZuNzKL/XZz4Q7yuCGWdlFl/9eLtIQ7cUy2w7rYs4sm8TJpWuqVID/UzuqtIinGdh3QIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dXJ2Z0zFjzRnmP;
	Thu, 18 Dec 2025 18:44:38 +0100 (CET)
Message-ID: <02fa15af-5a57-4557-b016-fd14b9107c6e@kdbg.org>
Date: Thu, 18 Dec 2025 18:44:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] mingw: support renaming symlinks
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
 <5cb3b10500339fec403b84e30721e4f6a68e42f6.1765980535.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <5cb3b10500339fec403b84e30721e4f6a68e42f6.1765980535.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> From: Karsten Blees <blees@dcon.de>
> 
> Older MSVCRT's `_wrename()` function cannot rename symlinks over
> existing files: it returns success without doing anything. Newer
> MSVCR*.dll versions probably do not share this problem: according to CRT
> sources, they just call `MoveFileEx()` with the `MOVEFILE_COPY_ALLOWED`
> flag.
> 
> Avoid the `_wrename()` call, and go with directly calling
> `MoveFileEx()`, with proper error handling of course.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index b1cc30d0f1..55f0bb478e 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2275,7 +2275,7 @@ int mingw_accept(int sockfd1, struct sockaddr *sa, socklen_t *sz)
>  int mingw_rename(const char *pold, const char *pnew)
>  {
>  	static int supports_file_rename_info_ex = 1;
> -	DWORD attrs, gle;
> +	DWORD attrs = INVALID_FILE_ATTRIBUTES, gle;
>  	int tries = 0;
>  	wchar_t wpold[MAX_PATH], wpnew[MAX_PATH];
>  	int wpnew_len;
> @@ -2286,15 +2286,6 @@ int mingw_rename(const char *pold, const char *pnew)
>  	if (wpnew_len < 0)
>  		return -1;
>  
> -	/*
> -	 * Try native rename() first to get errno right.
> -	 * It is based on MoveFile(), which cannot overwrite existing files.
> -	 */
> -	if (!_wrename(wpold, wpnew))
> -		return 0;
> -	if (errno != EEXIST)
> -		return -1;
> -
>  repeat:
>  	if (supports_file_rename_info_ex) {
>  		/*
> @@ -2370,13 +2361,22 @@ repeat:
>  		 * to retry.
>  		 */
>  	} else {
> -		if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
> +		if (MoveFileExW(wpold, wpnew,
> +				MOVEFILE_REPLACE_EXISTING | MOVEFILE_COPY_ALLOWED))
>  			return 0;
>  		gle = GetLastError();
>  	}
>  
> -	/* TODO: translate more errors */
> -	if (gle == ERROR_ACCESS_DENIED &&
> +	/* revert file attributes on failure */
> +	if (attrs != INVALID_FILE_ATTRIBUTES)
> +		SetFileAttributesW(wpnew, attrs);
> +
> +	if (!is_file_in_use_error(gle)) {
> +		errno = err_win_to_posix(gle);
> +		return -1;
> +	}
> +
> +	if (attrs == INVALID_FILE_ATTRIBUTES &&
>  	    (attrs = GetFileAttributesW(wpnew)) != INVALID_FILE_ATTRIBUTES) {
>  		if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
>  			DWORD attrsold = GetFileAttributesW(wpold);
> @@ -2388,16 +2388,10 @@ repeat:
>  			return -1;
>  		}
>  		if ((attrs & FILE_ATTRIBUTE_READONLY) &&
> -		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY)) {
> -			if (MoveFileExW(wpold, wpnew, MOVEFILE_REPLACE_EXISTING))
> -				return 0;
> -			gle = GetLastError();
> -			/* revert file attributes on failure */
> -			SetFileAttributesW(wpnew, attrs);
> -		}
> +		    SetFileAttributesW(wpnew, attrs & ~FILE_ATTRIBUTE_READONLY))
> +			goto repeat;
>  	}
> -	if (gle == ERROR_ACCESS_DENIED &&
> -	       retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
> +	if (retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
>  		       "Should I try again?", pold, pnew))
>  		goto repeat;
>  

The logic in this function is incredibly convoluted. It does look
somewhat reasonable, at least on the non-error path, but whether the
variable attr is changed and reset as needed after 'goto repeat' and the
various failure modes, I cannot tell. I give up and trust that this code
has been battle-tested during the past decade and works as desired.

-- Hannes

