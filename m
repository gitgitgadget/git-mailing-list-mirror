From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Sun, 28 Sep 2008 11:50:45 +0200
Message-ID: <20080928095045.GA3746@blimp.localhost>
References: <20080927084349.GC21650@dpotapov.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Marcus Griep <marcus@griep.us>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 28 11:52:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjswa-0004Ey-O6
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 11:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYI1Juu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 05:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYI1Juu
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 05:50:50 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:64918 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYI1Jut (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 05:50:49 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE82oCQ=
Received: from tigra.home (Fab19.f.strato-dslnet.de [195.4.171.25])
	by post.webmailer.de (fruni mo62) (RZmta 17.8)
	with ESMTP id v05c7ck8S8XcxY ; Sun, 28 Sep 2008 11:50:45 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 936CB277AE;
	Sun, 28 Sep 2008 11:50:45 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 5743A36D1E; Sun, 28 Sep 2008 11:50:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080927084349.GC21650@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96949>

Dmitry Potapov, Sat, Sep 27, 2008 10:43:49 +0200:
> Despite all efforts to make the fast implementation as robust as possible,
> it may not work well for some very rare situations. I am aware only one
> situation: use Cygwin mount to bind unrelated paths inside repository
> together.  Therefore, the core.cygwinnativestat configuration option is
> provided, which controls whether native or Cygwin version of stat is used.

cygwin.tryWindowsState? (I think cygwin has to get its own section)

> +static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
> +{
> +	WIN32_FILE_ATTRIBUTE_DATA fdata;
> +
> +	if (file_name[0] == '/')
> +		return cygstat (file_name, buf);
> +
> +	if (!(errno = get_file_attr(file_name, &fdata))) {
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

formatting: space after function name.

> +
> +		/* fill out the stat structure */
> +		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
> +		buf->st_ino = 0;
> +		buf->st_mode = file_attr_to_st_mode (fdata.dwFileAttributes);
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
> +		return 0;
> +	} else if (errno == ENOENT) {
> +		/*
> +		 * In the winsymlinks mode (which is the default), Cygwin
> +		 * emulates symbol links using Windows shortcut files. These
> +		 * files are formed by adding .lnk extension. So, if we have
> +		 * not found the specified file name, it could be that it is
> +		 * a symbol link. Let's Cygwin to deal with that.
> +		 */
> +		return cygstat (file_name, buf);
> +	}
> +	return -1;
> +}

I like it and will be keeping in my tree. Thanks!
