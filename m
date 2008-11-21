From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 08:59:21 +0100
Message-ID: <49266A59.4010404@viscovery.net>
References: <loom.20081121T024302-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vasyl Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 09:00:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3QwY-0006PF-Nv
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 09:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYKUH7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 02:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYKUH7b
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 02:59:31 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16741 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYKUH7a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 02:59:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L3QvB-00021s-BT; Fri, 21 Nov 2008 08:59:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2480BAFCC; Fri, 21 Nov 2008 08:59:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <loom.20081121T024302-370@post.gmane.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Vasyl Vavrychuk schrieb: > Here is simple and restricted implementation
	of mmap using CreateFileMapping, > MapViewOfFile. Thanks. Sign-off? Did you
	notice any differences with this? Or is this change just because-we-can?
	[...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101500>

Vasyl Vavrychuk schrieb:
> Here is simple and restricted implementation of mmap using CreateFileMapping, 
> MapViewOfFile.

Thanks. Sign-off?

Did you notice any differences with this? Or is this change just
because-we-can?

It doesn't pass the test suite, for example t5301-sliding-window.sh fails.

> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -994,3 +994,30 @@ void mingw_open_html(const char *unixpath)
>  	printf("Launching default browser to display HTML ...\n");
>  	ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
>  }
> +
> +void *mingw_mmap(void *start, size_t length, int prot, int flags, int fd, 
> off_t offset)
> +{
> +	HANDLE handle;
> +
> +	if (start != NULL || !(flags & MAP_PRIVATE))
> +		die("Invalid usage of mingw_mmap");

I tend to use this idiom:

		return errno = EINVAL,
			 error("Invalid usage of mingw_mmap");

> +	if (offset % getpagesize() != 0)
> +		die("Offset does not match the memory allocation granularity");

This is dangerous. Because on MinGW getpagesize() is hard-coded to 0x1000.
getpagesize() does not consult GetSystemInfo(). Just skip the check;
MapViewOfFile() will report the error later anyway. Or better carefully
compute a suitable offset and adjust the length accordingly.

> +
> +	handle = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL, 
> PAGE_WRITECOPY,
> +			0, 0, NULL);
> +
> +	if (handle != NULL) {
> +		start = MapViewOfFile(handle, FILE_MAP_COPY, 0, offset, 
> length);
> +		CloseHandle(handle);
> +	}
> +
> +	return start;

Upon failure you should return MAP_FAILED, not NULL.

> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -175,10 +175,12 @@ static inline const char *skip_prefix(const char *str, 
> const char *prefix)
>  #define MAP_FAILED ((void*)-1)
>  #endif
>  
> +#ifndef __MINGW32__
>  #define mmap git_mmap
>  #define munmap git_munmap
>  extern void *git_mmap(void *start, size_t length, int prot, int flags, int fd, 
> off_t offset);
>  extern int git_munmap(void *start, size_t length);
> +#endif
>  
>  /* This value must be multiple of (pagesize * 2) */
>  #define DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)

This is inside #ifdef NO_MMAP ... #else section. Isn't that a bit strange?
I.e. we say NO_MMAP, but then we do have mmap() now?

-- Hannes
