From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 21:03:08 +0200
Message-ID: <200809232103.09133.johannes.sixt@telecom.at>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 21:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiDBV-00078Y-UI
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 21:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYIWTDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 15:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbYIWTDP
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 15:03:15 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:36230 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbYIWTDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 15:03:14 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 3803A13A2C4;
	Tue, 23 Sep 2008 21:03:10 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E76811D223;
	Tue, 23 Sep 2008 21:03:09 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080923140144.GN21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96583>

On Dienstag, 23. September 2008, Dmitry Potapov wrote:
> +static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
> +{ 
> +	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
> +	winTime -= 116444736000000000LL; /* Windows to Unix  Epoch conversion */
> +	ts->tv_sec = (time_t)(winTime/10000000); /* 100-nanosecond interval to seconds */
> +	ts->tv_nsec = (long)(winTime - ts->tv_sec) * 100; /* nanoseconds */ +}

+	ts->tv_nsec = (long)(winTime - ts->tv_sec*10000000LL) * 100;

> +static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
> +{ 
> +	WIN32_FILE_ATTRIBUTE_DATA fdata;
> +
> +	if (file_name[0] == '/')
> +		return cygstat (file_name, buf);

You should do this in the caller; it would make this function's
semantics much clearer.

> +
> +	if (GetFileAttributesExA(file_name, GetFileExInfoStandard, &fdata)) {
> +		int fMode = S_IREAD;
> +		/*
> +		 * If the system attribute is set and it is not a directory then
> +		 * it could be a symbol link created in the nowinsymlinks mode.
> +		 * Normally, Cygwin works in the winsymlinks mode, so this situation
> +		 * is very unlikely. For the sake of simplicity of our code, let's
> +		 * Cygwin to handle it.
> +		 */
> +		if ((fdata.dwFileAttributes & FILE_ATTRIBUTE_SYSTEM) &&
> +		    !(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
> +			return cygstat (file_name, buf);
> +
> +		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
> +			fMode |= S_IFDIR;
> +		else
> +			fMode |= S_IFREG;
> +		if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
> +			fMode |= S_IWRITE;
> +
> +		/* st_dev, st_rdev are not used by Git */
> +		buf->st_dev = buf->st_rdev = 0;
> +		/* it is difficult to obtain the inode number on Windows,
> +		 * so let's set it to zero as MinGW Git does. */
> +		buf->st_ino = 0;
> +		buf->st_mode = fMode;
> +		buf->st_nlink = 1;
> +		buf->st_uid = buf->st_gid = 0;
> +#ifdef __CYGWIN_USE_BIG_TYPES__
> +		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
> +			fdata.nFileSizeLow;
> +#else
> +		buf->st_size = (off_t)fdata.nFileSizeLow;
> +#endif
> +		buf->st_blocks = size_to_blocks(buf->st_size);
> +		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
> +		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
> +		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
> +		errno = 0;
> +		return 0;
> +	}
> +
> +	switch (GetLastError()) {
> +	case ERROR_ACCESS_DENIED:
> +	case ERROR_SHARING_VIOLATION:
> +	case ERROR_LOCK_VIOLATION:
> +	case ERROR_SHARING_BUFFER_EXCEEDED:
> +		errno = EACCES;
> +		break;
> +	case ERROR_BUFFER_OVERFLOW:
> +		errno = ENAMETOOLONG;
> +		break;
> +	case ERROR_NOT_ENOUGH_MEMORY:
> +		errno = ENOMEM;
> +		break;
> +	default:
> +		/* In the winsymlinks mode (which is the default), Cygwin
> +		 * emulates symbol links using Windows shortcut files. These
> +		 * files are formed by adding .lnk extension. So, if we have
> +		 * not found the specified file name, it could be that it is
> +		 * a symbol link. Let's Cygwin to deal with that.
> +		 */
> +		return cygstat (file_name, buf);
> +	}
> +	return -1;

You do duplicate a lot of code here. Any chances to factor out the
common parts? Start with platform specific function
filetime_to_stat_time() that is your filetime_to_timespec() on Cygwin,
but filetime_to_time_t() (which needs modification) on MinGW.

-- Hannes
