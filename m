From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 23:48:02 +0400
Message-ID: <20080923194802.GQ21650@dpotapov.dyndns.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <200809232103.09133.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Sep 23 21:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiDsy-0001Nc-ET
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 21:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbYIWTsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 15:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbYIWTsL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 15:48:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:18647 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYIWTsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 15:48:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1831005fgg.17
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IgY6Q1jMjcPmDLewAp1DYhOtqfLVpYQaZyyj787Erwc=;
        b=sFjogf+Y62LUAcSVu0XtUuIZAejn1kUJQc9bHRqS7NwP16+qwE+Asvt39cVKga0/7q
         +FnLa7Lkvnxavm0o8+HHlfzAJpkg3rMNT+ZKKmFat1tdOnWdNQ7JY6wEtpT5MyhJd7hW
         Q6NLBQ2VAkpldRDw9hCh1gs5ThffvCrym9vf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BM74CeZ+BEahW//7X84oIwbKX8HhOGC36R6HHCoEVdhpMTooticgJCMbj+ePXRFFen
         iFd2wwZauAXOGKK5Jc5GhseeoUbFdf2iaYktg0pV8yY9QBqtla17+67v21MBdirjSoHu
         cZjmkgXdgS3YMQPvMRiMa1wi8hzZNbLKQtAZk=
Received: by 10.86.62.3 with SMTP id k3mr6579974fga.1.1222199287235;
        Tue, 23 Sep 2008 12:48:07 -0700 (PDT)
Received: from localhost (ppp85-140-170-49.pppoe.mtu-net.ru [85.140.170.49])
        by mx.google.com with ESMTPS id 4sm9691799fge.8.2008.09.23.12.48.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Sep 2008 12:48:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809232103.09133.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96586>

On Tue, Sep 23, 2008 at 09:03:08PM +0200, Johannes Sixt wrote:
> On Dienstag, 23. September 2008, Dmitry Potapov wrote:
> > +static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
> > +{ 
> > +	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
> > +	winTime -= 116444736000000000LL; /* Windows to Unix  Epoch conversion */
> > +	ts->tv_sec = (time_t)(winTime/10000000); /* 100-nanosecond interval to seconds */
> > +	ts->tv_nsec = (long)(winTime - ts->tv_sec) * 100; /* nanoseconds */ +}
> 
> +	ts->tv_nsec = (long)(winTime - ts->tv_sec*10000000LL) * 100;

Thanks.... What was I thought about when wrote this....

> 
> > +static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
> > +{ 
> > +	WIN32_FILE_ATTRIBUTE_DATA fdata;
> > +
> > +	if (file_name[0] == '/')
> > +		return cygstat (file_name, buf);
> 
> You should do this in the caller; it would make this function's
> semantics much clearer.

IMHO, the semantic of this function is clear: do_stat performs stat/lstat
using Windows API with falling back on Cygwin implementation in those
rare cases that it cannot handle correctly. Absolute path is just one of
those cases. So, I am not sure what you win by moving this two lines out.


> > +	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
> > +		int fMode = S_IREAD;
> > +		/*
> > +		 * If the system attribute is set and it is not a directory then
> > +		 * it could be a symbol link created in the nowinsymlinks mode.
> > +		 * Normally, Cygwin works in the winsymlinks mode, so this situation
> > +		 * is very unlikely. For the sake of simplicity of our code, let's
> > +		 * Cygwin to handle it.
> > +		 */
> > +		if ((fdata.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM) &&
> > +		    !(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
> > +			return cygstat (file_name, buf);

This is specific to cygwin.

> > +
> > +		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
> > +			fMode |= S_IFDIR;
> > +		else
> > +			fMode |= S_IFREG;
> > +		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
> > +			fMode |= S_IWRITE;

These lines the same as mingw

> > +
> > +		/* st_dev, st_rdev are not used by Git */
> > +		buf->st_dev = buf->st_rdev = 0;

I set this to 0, while MinGW Git uses _getdrive(). I have no idea why
it does so. Git does not use this field, and if it did, adding the
_current_ drive number is useless at best when we are trying to
determine whether the file is changed or not.

> > +		/* it is difficult to obtain the inode number on Windows,
> > +		 * so let's set it to zero as MinGW Git does. */
> > +		buf->st_ino = 0;
> > +		buf->st_mode = fMode;
> > +		buf->st_nlink = 1;
> > +		buf->st_uid = buf->st_gid = 0;

This is the same as for MinGW

> > +#ifdef __CYGWIN_USE_BIG_TYPES__
> > +		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
> > +			fdata.nFileSizeLow;
> > +#else
> > +		buf->st_size = (off_t)fdata.nFileSizeLow;
> > +#endif
> > +		buf->st_blocks = size_to_blocks(buf->st_size);
> > +		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
> > +		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
> > +		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);

This is different: using 64-bit version for st_size, st_blocks does not
exist in MinGW, and finally filetime_to_timespec instead of filetime_to_time_t,
as well as the name of fields is different (st_ctim instead of st_ctime, etc).

> > +		errno = 0;
> > +		return 0;
> > +	}
> > +
> > +	switch (GetLastError()) {
> > +	case ERROR_ACCESS_DENIED:
> > +	case ERROR_SHARING_VIOLATION:
> > +	case ERROR_LOCK_VIOLATION:
> > +	case ERROR_SHARING_BUFFER_EXCEEDED:
> > +		errno = EACCES;
> > +		break;
> > +	case ERROR_BUFFER_OVERFLOW:
> > +		errno = ENAMETOOLONG;
> > +		break;
> > +	case ERROR_NOT_ENOUGH_MEMORY:
> > +		errno = ENOMEM;
> > +		break;
> > +	default:
> > +		/* In the winsymlinks mode (which is the default), Cygwin
> > +		 * emulates symbol links using Windows shortcut files. These
> > +		 * files are formed by adding .lnk extension. So, if we have
> > +		 * not found the specified file name, it could be that it is
> > +		 * a symbol link. Let's Cygwin to deal with that.
> > +		 */
> > +		return cygstat (file_name, buf);
> > +	}

This is the same as in MinGW, except the default case, where MinGW
returns error immediately while this version calls the fallback
function.


> > +	return -1;
> 
> You do duplicate a lot of code here. Any chances to factor out the
> common parts?

I don't see much common code here. Initialization of 5 variables where
four of them are just constants? Perhaps, the biggest common part here
is conversion of dwFileAttributes to st_mode, but it is still 5 lines of
trivial code.

Dmitry
