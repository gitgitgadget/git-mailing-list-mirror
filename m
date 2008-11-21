From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: Re: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 10:57:26 +0200
Message-ID: <gg5t5s$qc8$1@ger.gmane.org>
References: <loom.20081121T024302-370@post.gmane.org> <49266A59.4010404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 09:59:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3Rqu-0005RU-8j
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 09:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYKUI5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 03:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbYKUI5o
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 03:57:44 -0500
Received: from main.gmane.org ([80.91.229.2]:53518 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbYKUI5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 03:57:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L3Rpc-00081F-4W
	for git@vger.kernel.org; Fri, 21 Nov 2008 08:57:40 +0000
Received: from fly.lviv.inobject.com ([217.65.240.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 08:57:40 +0000
Received: from vvavrychuk by fly.lviv.inobject.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 08:57:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fly.lviv.inobject.com
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <49266A59.4010404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101502>

Hello Johannes,

Thank you for your comments. It's my first patch on git so please be kind:)
At the weekend I hope I will find time to work on this.

 > Vasyl Vavrychuk schrieb:
 >
 >> Here is simple and restricted implementation of mmap using
 >> CreateFileMapping, MapViewOfFile.
 >>
 > Thanks. Sign-off?
Will be.

 > Did you notice any differences with this? Or is this change just
 > because-we-can?
Not yet.

 > It doesn't pass the test suite, for example t5301-sliding-window.sh
 > fails.
I will investigate.

 >
 >> --- a/compat/mingw.c
 >> +++ b/compat/mingw.c
 >> @@ -994,3 +994,30 @@ void mingw_open_html(const char *unixpath)
 >> printf("Launching default browser to display HTML ...\n");
 >> ShellExecute(NULL, "open", htmlpath, NULL, "\\", 0);
 >> }
 >> +
 >> +void *mingw_mmap(void *start, size_t length, int prot, int flags,
 >> int fd,
 >> off_t offset)
 >> +{
 >> +	HANDLE handle;
 >> +
 >> +	if (start != NULL || !(flags & MAP_PRIVATE))
 >> +		die("Invalid usage of mingw_mmap");
 > I tend to use this idiom:
 >
 > return errno = EINVAL,
 > error("Invalid usage of mingw_mmap");
Interesting.

 >> +	if (offset % getpagesize() != 0)
 >> +		die("Offset does not match the memory allocation granularity");
 > This is dangerous. Because on MinGW getpagesize() is hard-coded to
 > 0x1000. getpagesize() does not consult GetSystemInfo(). Just skip the
 > check; MapViewOfFile() will report the error later anyway. Or better
 > carefully compute a suitable offset and adjust the length accordingly.
I haven't known about hardcoded getpagesize(). Ajusting will be good but 
it will not solve problem with hardcoded
getpagesize(). Maybe write own getpagesize() based on GetSystemInfo()?

 >
 >> +
 >> +	handle = CreateFileMapping((HANDLE)_get_osfhandle(fd), NULL,
 >> PAGE_WRITECOPY,
 >> +			0, 0, NULL);
 >> +
 >> +	if (handle != NULL) {
 >> +		start = MapViewOfFile(handle, FILE_MAP_COPY, 0, offset,
 >> length);
 >> +		CloseHandle(handle);
 >> +	}
 >> +
 >> +	return start;
 > Upon failure you should return MAP_FAILED, not NULL.
OK

 >> --- a/git-compat-util.h
 >> +++ b/git-compat-util.h
 >> @@ -175,10 +175,12 @@ static inline const char *skip_prefix(const
 >> char *str,
 >> const char *prefix)
 >> #define MAP_FAILED ((void*)-1)
 >> #endif
 >> +#ifndef __MINGW32__
 >> #define mmap git_mmap
 >> #define munmap git_munmap
 >> extern void *git_mmap(void *start, size_t length, int prot, int
 >> flags, int fd,
 >> off_t offset);
 >> extern int git_munmap(void *start, size_t length);
 >> +#endif
 >> /* This value must be multiple of (pagesize * 2) */ #define
 >> DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)
 >>
 > This is inside #ifdef NO_MMAP ... #else section. Isn't that a bit
 > strange? I.e. we say NO_MMAP, but then we do have mmap() now?
 >
Agree
