From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/4] mingw: remove use of _getdrive() from lstat/fstat
Date: Sat, 27 Sep 2008 12:39:45 +0400
Message-ID: <20080927083945.GZ21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Marcus Griep <marcus@griep.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 10:41:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjVML-0003Yx-3O
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 10:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYI0Ijw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 04:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbYI0Ijw
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 04:39:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:25311 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYI0Ijv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 04:39:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so874068fgg.17
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=4mnFcFnjow7oZ9AdE/H4Tvw7dMIRvqNOndvtH1xqpaI=;
        b=ubV30y4Iclk1e1q9EDhn/nGWJTcZpD24XfsxkltdRV/6of3+G6ey5Pld4fYlyGQT1O
         QwlY68LyKb/9MB1hxYO9w5SRHnOu38CF7fwCDC9ZLxGSp6Zh/gzaSVNVSwL6nAEf/SCJ
         1z+b54xcpRSPvOQNoxxAQnTqcdDtgg5B0Ge/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=TJwt97yysrnBW2YPfzFhTMCtO6AbvE4Nk5PvDk9Babr44hdaUIFTMfSDLyhvP1wa5I
         H0oI0JRBMGXrl0b2neLjTwTg/D2KEz4BoE5jF9PGX17UWrlMfUjiGdH+y3nG+fJluVxh
         nDAaIPrQkywBSDknIbiytOORSu6p8fYAAzqH0=
Received: by 10.86.95.20 with SMTP id s20mr2055720fgb.65.1222504789906;
        Sat, 27 Sep 2008 01:39:49 -0700 (PDT)
Received: from localhost ( [85.141.151.122])
        by mx.google.com with ESMTPS id e20sm4864434fga.1.2008.09.27.01.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 01:39:48 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96905>

The field device is not used by Git, and putting the number of the
current device is meaningless anyway.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 compat/mingw.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ccfa2a0..a2b8cd7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -31,7 +31,6 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
 	return (time_t)winTime;
 }
 
-extern int _getdrive( void );
 /* We keep the do_lstat code in a separate function to avoid recursion.
  * When a path ends with a slash, the stat will fail with ENOENT. In
  * this case, we strip the trailing slashes and stat again.
@@ -55,7 +54,7 @@ static int do_lstat(const char *file_name, struct stat *buf)
 		buf->st_nlink = 1;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
+		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
@@ -145,7 +144,7 @@ int mingw_fstat(int fd, struct stat *buf)
 		buf->st_nlink = 1;
 		buf->st_mode = fMode;
 		buf->st_size = fdata.nFileSizeLow; /* Can't use nFileSizeHigh, since it's not a stat64 */
-		buf->st_dev = buf->st_rdev = (_getdrive() - 1);
+		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
-- 
1.6.0.2.237.g0297e5
