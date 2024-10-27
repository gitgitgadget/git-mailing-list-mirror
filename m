Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7714685
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730035074; cv=none; b=UnYeavpdWeRckJPDV0mpUT4z2zlcB2MS/hjfeckaBHX9VbEZYKRSm4s2HSVp1H9gUzvpAhJXihrTPdsHdoKT/DorqC4HgHV/F3Zdcc4JDgaxXWuwgJfejcEXw8+EG0U8oehaqxzTmbYZgJ0FSF0ED0ApV3YBjZFujCOY1D+BM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730035074; c=relaxed/simple;
	bh=PFcIJeOBnq2646QNFNsC1Bg19mQMUvgxtjlue10q8pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFEMXC/O39dYH23W3kQxlHn+EWNdNCrR985EdZD/sqnYjNziVd3h6+xJGcHw2/Yfmb2s0PpUbeDfBW7EusCYC5PGQsxp/6/h2MERe9nQE5Cb5YQrxXvpbUIGdHruAXAj7flAUa/U7MALbDALFkdR+M/BC9ByhP8lw1orES2n0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Xbxs94kNjz5tlB
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 14:17:49 +0100 (CET)
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Xbxry0jN2zRpKk;
	Sun, 27 Oct 2024 14:17:37 +0100 (CET)
Message-ID: <a769d5a6-0d0f-4df4-b581-539d00aacbc9@kdbg.org>
Date: Sun, 27 Oct 2024 14:17:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] compat/mingw: allow deletion of most opened files
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
References: <cover.1729695349.git.ps@pks.im> <cover.1729770140.git.ps@pks.im>
 <c308eafbbb5a7c853b8126750c4c44a8b8635192.1729770140.git.ps@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <c308eafbbb5a7c853b8126750c4c44a8b8635192.1729770140.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.10.24 um 13:46 schrieb Patrick Steinhardt:
> On Windows, we emulate open(3p) via `mingw_open()`. This function
> implements handling of some platform-specific quirks that are required
> to make it behave as closely as possible like open(3p) would, but for
> most cases we just call the Windows-specific `_wopen()` function.
> 
> This function has a major downside though: it does not allow us to
> specify the sharing mode. While there is `_wsopen()` that allows us to
> pass sharing flags, those sharing flags are not the same `FILE_SHARE_*`
> flags as `CreateFileW()` accepts. Instead, `_wsopen()` only allows
> concurrent read- and write-access, but does not allow for concurrent
> deletions. Unfortunately though, we have to allow concurrent deletions
> if we want to have POSIX-style atomic renames on top of an existing file
> that has open file handles.
> 
> Implement a new function that emulates open(3p) for existing files via
> `CreateFileW()` such that we can set the required sharing flags.
> 
> While we have the same issue when calling open(3p) with `O_CREAT`,
> implementing that mode would be more complex due to the required
> permission handling. Furthermore, atomic updates via renames typically
> write to exclusive lockfile and then perform the rename, and thus we
> don't have to handle the case where the locked path has been created
> with `O_CREATE`. So while it would be nice to have proper POSIX
> semantics in all paths, we instead aim for a minimum viable fix here.

Agreed!

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index e326c6fcd2d..6c75fe36b15 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -532,6 +532,62 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
>  	return fd;
>  }
>  
> +/*
> + * Ideally, we'd use `_wopen()` to implement this functionality so that we
> + * don't have to reimplement it, but unfortunately we do not have tight control
> + * over the share mode there. And while `_wsopen()` and friends exist that give
> + * us _some_ control over the share mode, this family of functions doesn't give
> + * us the ability to enable FILE_SHARE_DELETE, either. But this is a strict
> + * requirement for us though so that we can unlink or rename over files that
> + * are held open by another process.
> + *
> + * We are thus forced to implement our own emulation of `open()`. To make our
> + * life simpler we only implement basic support for this, namely opening
> + * existing files for reading and/or writing. This means that newly created
> + * files won't have their sharing mode set up correctly, but for now I couldn't
> + * find any case where this matters. We may have to revisit that in the future
> + * though based on our needs.
> + */
> +static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
> +{
> +	SECURITY_ATTRIBUTES security_attributes = {
> +		.nLength = sizeof(security_attributes),
> +		.bInheritHandle = !(oflags & O_NOINHERIT),
> +	};
> +	HANDLE handle;
> +	int access;

I would have made this variable DWORD or unsigned instead of plain int,
because it receives a bit pattern and would match the parameter type of
CreateFileW() better; but no big deal.

> +	int fd;
> +
> +	/* We only support basic flags. */
> +	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
> +		errno = ENOSYS;
> +		return -1;
> +	}
> +
> +	if (oflags & O_RDWR)
> +		access = GENERIC_READ | GENERIC_WRITE;
> +	else if (oflags & O_WRONLY)
> +		access = GENERIC_WRITE;
> +	else
> +		access = GENERIC_READ;

O_RDWR, O_WRONLY and O_RDONLY are not flags, but values occupying two
bits of oflags. This must be:

	if ((oflags & O_ACCMODE) == O_RDWR)
		access = GENERIC_READ | GENERIC_WRITE;
	else if ((oflags & O_ACCMODE) == O_WRONLY)
		access = GENERIC_WRITE;
	else
		access = GENERIC_READ;

or similar.

> +
> +	handle = CreateFileW(filename, access,
> +			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> +			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
> +	if (handle == INVALID_HANDLE_VALUE) {
> +		DWORD err = GetLastError();
> +		if (err == ERROR_INVALID_PARAMETER)
> +			err = ERROR_PATH_NOT_FOUND;

First I wondered what this is about, but then noticed that it is just
copied from the mingw_open_append() implementation catering to some
bogus network filesystems. Good.

> +		errno = err_win_to_posix(err);
> +		return -1;
> +	}
> +
> +	fd = _open_osfhandle((intptr_t)handle, oflags | O_BINARY);
> +	if (fd < 0)
> +		CloseHandle(handle);
> +	return fd;
> +}
> +
>  /*
>   * Does the pathname map to the local named pipe filesystem?
>   * That is, does it have a "//./pipe/" prefix?
> @@ -567,6 +623,8 @@ int mingw_open (const char *filename, int oflags, ...)
>  
>  	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
>  		open_fn = mingw_open_append;
> +	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
> +		open_fn = mingw_open_existing;
>  	else
>  		open_fn = _wopen;
>  

Makes sense!

-- Hannes

