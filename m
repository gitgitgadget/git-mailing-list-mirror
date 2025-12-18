Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10D1DFF0
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054931; cv=none; b=O1HcWoaYe6QWkDsuQ7bIsQs/v4Aos3Rf8+P/sdrefw/jrHwcL0hP6GWkaWHh5Eo15rqhLuVvy1WP6KP4vPQ0NcouTkCrCTqZfUzcR4SbTPMe43SCy9gsVHy2UXe1cMdcL9n0D7z70IqRnfqxHanX8q61Z7sgqg0iwBBtDDU22fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054931; c=relaxed/simple;
	bh=BjnP8mgPmuu4MM+/ygtqvXB+yynVZCVfzFd+eonyDn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbDaQMcU370/XsELUzxQRaMrE7zwNCgpdbt4CwDePQNtu7lWreQ5wehC4Y1c36nmMf6y8mLpjDi8qRYmP6IqP7t6KLHtncN5nYLSuY/wyJnEFgVziGemXf9GZ30vdBgbh/fwNExbCQVqryfDTETXMcCRn8s2SaYM9Kzm9ue8tCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dX6ph5vnKzRnlJ;
	Thu, 18 Dec 2025 11:48:44 +0100 (CET)
Message-ID: <52d0ef24-ae21-400c-836b-aa43dd5899d2@kdbg.org>
Date: Thu, 18 Dec 2025 11:48:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] mingw: drop the separate `do_lstat()` function
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,
 Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
 <aa0ca80bbb00ec53f359c79719b95bcc141ac85c.1765980535.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <aa0ca80bbb00ec53f359c79719b95bcc141ac85c.1765980535.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> From: Karsten Blees <blees@dcon.de>
> 
> With the new `mingw_stat()` implementation, `do_lstat()` is only called
> from `mingw_lstat()` (with the function parameter `follow == 0`). Remove
> the extra function and the old `mingw_stat()`-specific (`follow == 1`)
> logic.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 59afd69686..ec6c2801d3 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -917,14 +917,7 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
>  	return 1;
>  }
>  
> -/* We keep the do_lstat code in a separate function to avoid recursion.
> - * When a path ends with a slash, the stat will fail with ENOENT. In
> - * this case, we strip the trailing slashes and stat again.
> - *
> - * If follow is true then act like stat() and report on the link
> - * target. Otherwise report on the link itself.
> - */
> -static int do_lstat(int follow, const char *file_name, struct stat *buf)
> +int mingw_lstat(const char *file_name, struct stat *buf)

Oh, here goes the entire function including the comment. Fine, then.
Disregard my comment on 01/18.

>  {
>  	WIN32_FILE_ATTRIBUTE_DATA fdata;
>  	wchar_t wfilename[MAX_PATH];
> @@ -958,13 +951,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
>  			if (handle != INVALID_HANDLE_VALUE) {
>  				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
>  						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
> -					if (follow) {
> -						char buffer[MAXIMUM_REPARSE_DATA_BUFFER_SIZE];
> -						buf->st_size = readlink(file_name, buffer, MAXIMUM_REPARSE_DATA_BUFFER_SIZE);
> -					} else {
> -						buf->st_mode = S_IFLNK;
> -					}
> -					buf->st_mode |= S_IREAD;
> +					buf->st_mode = S_IFLNK | S_IREAD;
>  					if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
>  						buf->st_mode |= S_IWRITE;
>  				}
> @@ -1022,11 +1009,6 @@ static int get_file_info_by_handle(HANDLE hnd, struct stat *buf)
>  	return 0;
>  }
>  
> -int mingw_lstat(const char *file_name, struct stat *buf)
> -{
> -	return do_lstat(0, file_name, buf);
> -}
> -
>  int mingw_stat(const char *file_name, struct stat *buf)
>  {
>  	wchar_t wfile_name[MAX_PATH];

An obviously correct rewrite.

-- Hannes

