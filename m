Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF30301022
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083906; cv=none; b=fkOoIYKdhMBekKjIVhVmKbRZQ/2ujNnwDI/UkE+EaxgFI1Ou1vWE19VTSpUZMt6VWlleNWkuJahVewZqLVn8gTA/Eq+/AC3osm+xdnWVPDkc4psH/tL5FuM+G05OsasYJoOwS0PbcXaQMaIUiv8cNYtm8407+h1YRsN0TH9YhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083906; c=relaxed/simple;
	bh=LRyn26vyostg+F8tOloSj6mnPAf4DURbR7ihHq+acl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoIvLSyNIlOJ3zHU05aM1fVANvbHnu/fwX08YdXZ2NZCOGqHp4Jqam2QK8/xC1x9lQSzCNzNq4ulI7Z0I1m7PHf0NHuHYvmcnE+xFYvGs+pjALPQhFsOPu1VNQgOy99LrZ6+PYrXYjNE4s3M35qI/lBd9s/3+e1oTXEIHytHmpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4dXKWx2GRszRpKW;
	Thu, 18 Dec 2025 19:51:41 +0100 (CET)
Message-ID: <19030791-dafa-4a63-985b-9cdf423bfd1b@kdbg.org>
Date: Thu, 18 Dec 2025 19:51:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Support symbolic links on Windows
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.12.25 um 15:08 schrieb Johannes Schindelin via GitGitGadget:
> This finally upstreams Git for Windows' support for Windows' branch of
> symbolic links, which has been maturing since 2015. It is based off of
> js/prep-symlink-windows.
> 
> Bill Zissimopoulos (1):
>   mingw: compute the correct size for symlinks in `mingw_lstat()`
> 
> Johannes Schindelin (3):
>   mingw: try to create symlinks without elevated permissions
>   mingw: emulate `stat()` a little more faithfully
>   mingw: special-case index entries for symlinks with buggy size
> 
> Karsten Blees (14):
>   mingw: don't call `GetFileAttributes()` twice in `mingw_lstat()`
>   mingw: implement `stat()` with symlink support
>   mingw: drop the separate `do_lstat()` function
>   mingw: let `mingw_lstat()` error early upon problems with reparse
>     points
>   mingw: teach dirent about symlinks
>   mingw: factor out the retry logic
>   mingw: change default of `core.symlinks` to false
>   mingw: add symlink-specific error codes
>   mingw: handle symlinks to directories in `mingw_unlink()`
>   mingw: support renaming symlinks
>   mingw: allow `mingw_chdir()` to change to symlink-resolved directories
>   mingw: implement `readlink()`
>   mingw: implement basic `symlink()` functionality (file symlinks only)
>   mingw: add support for symlinks to directories
> 
>  compat/mingw-posix.h  |   6 +-
>  compat/mingw.c        | 635 ++++++++++++++++++++++++++++++++----------
>  compat/win32.h        |   6 +-
>  compat/win32/dirent.c |   5 +-
>  read-cache.c          |  11 +
>  5 files changed, 507 insertions(+), 156 deletions(-)
> 
> 
> base-commit: 6f6fe02f5fe587ec9788f8a5a34281949d7b2ca1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2018%2Fdscho%2Fsymlinks-next-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2018/dscho/symlinks-next-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2018

I've reviewed this series and had a few comments on some of them.

All others look good, with one caveat though: symbolic links on Windows
aren't exactly an itch of mine, and I'm unfamiliar with the
corresponding API. That said, I didn't spot anything unusual at a
superficial level.

I notice that Karsten's emails bounce. Would it be appropriate to
redirect authorship and sign-off to the other email that is registered
in .mailmap?

-- Hannes

