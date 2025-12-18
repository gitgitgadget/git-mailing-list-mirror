Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700333067B
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054691; cv=none; b=Xf1G2IEjaKHJvpB6XMa9Ei+XjEInDiCBIcfFMnmIkR4WjLFTuHkHJAXXOslad/KeMBK0YLq2kWzZVpXCcFJGS72K3rl1jLCnO4YC1O2zsoRQp6pujwZI3eN25+Esu3yOtZDoDFMlNOxv7t7rRCIG0Cfc+dgveDRfW5kqPg2XHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054691; c=relaxed/simple;
	bh=l+YkKLb3+eTB33FhwHhC+veRzYxXLhTlMy8qOxQKsFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtnCKgTBTKTnlhBDcLX6SRElI5N+oG+7toW7HpdUvCUchEH9Pu7QCL6HoIJyh2ERIppskgZqGRAkTrgD+MD6qY5+ytmfIWdqtBzJIs6QR/C0sejZ33IC+clptE03LHA7ogCDHiyoLuKs1dsAkIx5phJ735PRoBkdbZdFxrJp/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dX6k00BFPzRpKf;
	Thu, 18 Dec 2025 11:44:39 +0100 (CET)
Message-ID: <46b69027-90b4-439a-a14d-61d1bb739b7b@kdbg.org>
Date: Thu, 18 Dec 2025 11:44:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] mingw: implement `stat()` with symlink support
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,
 Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
 <c36848eda76742f7a7c203868a077b790301344f.1765980535.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <c36848eda76742f7a7c203868a077b790301344f.1765980535.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.12.25 um 15:08 schrieb Karsten Blees via GitGitGadget:
> From: Karsten Blees <blees@dcon.de>
> 
> With respect to symlinks, the current `mingw_stat()` implementation is
> almost identical to `mingw_lstat()`: except for the file type (`st_mode
> & S_IFMT`), it returns information about the link rather than the target.
> 
> Implement `mingw_stat()` by opening the file handle requesting minimal
> permissions, and then calling `GetFileInformationByHandle()` on it. This
> way, all links are resolved by the Windows file system layer.
> 
> If symlinks are disabled, use `mingw_lstat()` as before, but fail with
> `ELOOP` if a symlink would have to be resolved.

This last paragraph is disconnected from the patch text. I can't find a
use of ELOOP anywhere in the code that has something to do with the goal
of this patch. Is this a remnant from early times where symbolic links
were optional?

The patch text looks good.

> 
> Signed-off-by: Karsten Blees <blees@dcon.de>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index f5a0fe3325..59afd69686 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1026,9 +1026,26 @@ int mingw_lstat(const char *file_name, struct stat *buf)
>  {
>  	return do_lstat(0, file_name, buf);
>  }
> +
>  int mingw_stat(const char *file_name, struct stat *buf)
>  {
> -	return do_lstat(1, file_name, buf);
> +	wchar_t wfile_name[MAX_PATH];
> +	HANDLE hnd;
> +	int result;
> +
> +	/* open the file and let Windows resolve the links */
> +	if (xutftowcs_path(wfile_name, file_name) < 0)
> +		return -1;
> +	hnd = CreateFileW(wfile_name, 0,
> +			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
> +			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
> +	if (hnd == INVALID_HANDLE_VALUE) {
> +		errno = err_win_to_posix(GetLastError());
> +		return -1;
> +	}
> +	result = get_file_info_by_handle(hnd, buf);
> +	CloseHandle(hnd);
> +	return result;
>  }
>  
>  int mingw_fstat(int fd, struct stat *buf)

-- Hannes

