From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/3] mmap(win32): avoid copy-on-write when it is
 unnecessary
Date: Tue, 26 Apr 2016 20:53:23 +0200
Message-ID: <571FB923.9040808@kdbg.org>
References: <cover.1461335463.git.johannes.schindelin@gmx.de>
 <3e2a45e60e2905f52f962604cf19a0e5e39b9b1b.1461335463.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sven Strickroth <email@cs-ware.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:53:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av876-0007aB-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbcDZSx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:53:28 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:18027 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbcDZSx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:53:27 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qvXKw2YHqz5tlB;
	Tue, 26 Apr 2016 20:53:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A6DD8524D;
	Tue, 26 Apr 2016 20:53:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <3e2a45e60e2905f52f962604cf19a0e5e39b9b1b.1461335463.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292646>

Am 22.04.2016 um 16:31 schrieb Johannes Schindelin:
> Often we are mmap()ing read-only. In those cases, it is wasteful to map in
> copy-on-write mode. Even worse: it can cause errors where we run out of
> space in the page file.
>
> So let's be extra careful to map files in read-only mode whenever
> possible.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   compat/win32mmap.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/compat/win32mmap.c b/compat/win32mmap.c
> index 3a39f0f..b836169 100644
> --- a/compat/win32mmap.c
> +++ b/compat/win32mmap.c
> @@ -22,14 +22,15 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
>   		die("Invalid usage of mmap when built with USE_WIN32_MMAP");
>
>   	hmap = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
> -		PAGE_WRITECOPY, 0, 0, NULL);
> +		prot == PROT_READ ? PAGE_READONLY : PAGE_WRITECOPY, 0, 0, NULL);

As long as we use this implementation with MAP_PRIVATE, PAGE_WRITECOPY 
is the right setting. Should we insert a check for MAP_PRIVATE to catch 
unexpected use-cases (think of the index-helper daemon effort)?

>
>   	if (!hmap) {
>   		errno = EINVAL;
>   		return MAP_FAILED;
>   	}
>
> -	temp = MapViewOfFileEx(hmap, FILE_MAP_COPY, h, l, length, start);
> +	temp = MapViewOfFileEx(hmap, prot == PROT_READ ?
> +			FILE_MAP_READ : FILE_MAP_COPY, h, l, length, start);

Same here: FILE_MAP_COPY is the right choice for MAP_SHARED mmaps.

>
>   	if (!CloseHandle(hmap))
>   		warning("unable to close file mapping handle");
>

Except for these mental notes, I've no comments on this series. Looks good.

-- Hannes
