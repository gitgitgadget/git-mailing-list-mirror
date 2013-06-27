From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Thu, 27 Jun 2013 23:58:31 +0100
Message-ID: <51CCC397.3060705@ramsay1.demon.co.uk>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C6BC4B.9030905@web.de> <51C8BF2C.2050203@ramsay1.demon.co.uk> <7vy59y4w3r.fsf@alter.siamese.dyndns.org> <51C94425.7050006@alum.mit.edu> <51CB610C.7050501@ramsay1.demon.co.uk> <20130626223552.GA12785@sigill.intra.peff.net> <20130626224336.GA22486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, mlevedahl@gmail.com,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 01:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsLVf-0003Ow-JX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 01:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab3F0XVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 19:21:45 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:51623 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753707Ab3F0XVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 19:21:44 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 28263A0C081;
	Fri, 28 Jun 2013 00:21:43 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 8BEB4A0C07F;
	Fri, 28 Jun 2013 00:21:41 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Fri, 28 Jun 2013 00:21:39 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130626224336.GA22486@sigill.intra.peff.net>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229166>

Jeff King wrote:
> On Wed, Jun 26, 2013 at 06:35:52PM -0400, Jeff King wrote:
> 
>> I am curious how often Cygwin gives us the false positive. If it is
>> every time, then the check is not doing much good at all. Is it possible
>> for you to instrument stat_validity_check to report how often it does or
>> does not do anything useful?
> 
> Maybe like this:
> 
> diff --git a/read-cache.c b/read-cache.c
> index d5201f9..19dcb69 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1958,6 +1958,14 @@ void stat_validity_clear(struct stat_validity *sv)
>  	sv->sd = NULL;
>  }
>  
> +static int unchanged;
> +static int attempts;
> +static void print_stats(void)
> +{
> +	fprintf(stderr, "stat data was unchanged %d/%d\n",
> +		unchanged, attempts);
> +}
> +
>  int stat_validity_check(struct stat_validity *sv, const char *path)
>  {
>  	struct stat st;
> @@ -1966,7 +1974,16 @@ int stat_validity_check(struct stat_validity *sv, const char *path)
>  		return sv->sd == NULL;
>  	if (!sv->sd)
>  		return 0;
> -	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
> +	if (!S_ISREG(st.st_mode))
> +		return 0;
> +	if (!attempts++)
> +		atexit(print_stats);
> +	if (!match_stat_data(sv->sd, &st)) {
> +		unchanged++;
> +		return 1;
> +	}
> +	else
> +		return 0;
>  }
>  
>  void stat_validity_update(struct stat_validity *sv, int fd)
> 
> Running "t3211 -v", I see things like:
> 
>   stat data was unchanged 3/3
>   stat data was unchanged 20/20
>   stat data was unchanged 2/2
>   Deleted branch yadda (was d1ff1c9).
>   stat data was unchanged 8/8
>   ok 8 - peeled refs survive deletion of packed ref
> 
> I am curious if you will see 0/20 or 19/20 there on Cygwin.

Ah, no ... the problem is not as subtle as this! :-D

I'm sorry if I failed to mention that I already had a patch
to solve the problem, but that I *don't* want to submit it,
since it is ugly and just serves to spread the madness! ;-)

This is why I tried the "cygwin: Remove the Win32 l/stat()
functions" patch first; I think this is the correct approach
to fixing this problem (and similar *future* problems).

However, since that is no longer an option, on performance
grounds, I have other ideas I want to try. (see later email)

The "schizophrenic stat" functions have caused many subtle
problems, but this is not one of them; a brick to the head
would be more subtle. The problem is caused by the "stat
validity" code using both fstat() and stat() on the same
file. Note that there is no Win32 implementation of the
fstat() function.

So, a solution to the problem would be to provide just such
an implementation. The patch to do so is given below, just
for illustration purposes.

This fixes the failures to t3210, t3211 and t5500. However, I
have not run the full test suite. This may cause some further
*subtle* problems (just grep for fstat and consider what may
go wrong; I have not done that), especially when you consider
that cygwin has the UNRELIABLE_FSTAT build variable set.

HTH

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] cygwin: Add an Win32 fstat implementation

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/cygwin.c | 41 +++++++++++++++++++++++++++++++++++++++++
 compat/cygwin.h |  3 +++
 2 files changed, 44 insertions(+)

diff --git a/compat/cygwin.c b/compat/cygwin.c
index 91ce5d4..d59c9fb 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -4,6 +4,7 @@
 #include <sys/errno.h>
 #include "win32.h"
 #include "../git-compat-util.h"
+#include <io.h>
 #include "../cache.h" /* to read configuration */
 
 /*
@@ -100,6 +101,38 @@ static int cygwin_stat(const char *path, struct stat *buf)
 	return do_stat(path, buf, stat);
 }
 
+static int cygwin_fstat(int fd, struct stat *buf)
+{
+	HANDLE fh = (HANDLE)get_osfhandle(fd);
+	BY_HANDLE_FILE_INFORMATION fdata;
+
+	if (fh == INVALID_HANDLE_VALUE) {
+		errno = EBADF;
+		return -1;
+	}
+	if (GetFileType(fh) != FILE_TYPE_DISK)
+		return (fstat)(fd, buf);
+	if (GetFileInformationByHandle(fh, &fdata)) {
+		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
+		buf->st_ino = 0;
+		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
+		buf->st_nlink = 1;
+		buf->st_uid = buf->st_gid = 0;
+#ifdef __CYGWIN_USE_BIG_TYPES__
+		buf->st_size = ((_off64_t)fdata.nFileSizeHigh << 32) +
+			fdata.nFileSizeLow;
+#else
+		buf->st_size = (off_t)fdata.nFileSizeLow;
+#endif
+		buf->st_blocks = size_to_blocks(buf->st_size);
+		filetime_to_timespec(&fdata.ftLastAccessTime, &buf->st_atim);
+		filetime_to_timespec(&fdata.ftLastWriteTime, &buf->st_mtim);
+		filetime_to_timespec(&fdata.ftCreationTime, &buf->st_ctim);
+		return 0;
+	}
+	errno = EBADF;
+	return -1;
+}
 
 /*
  * At start up, we are trying to determine whether Win32 API or cygwin stat
@@ -133,9 +166,11 @@ static int init_stat(void)
 		if (!core_filemode && native_stat) {
 			cygwin_stat_fn = cygwin_stat;
 			cygwin_lstat_fn = cygwin_lstat;
+			cygwin_fstat_fn = cygwin_fstat;
 		} else {
 			cygwin_stat_fn = stat;
 			cygwin_lstat_fn = lstat;
+			cygwin_fstat_fn = fstat;
 		}
 		return 0;
 	}
@@ -152,6 +187,12 @@ static int cygwin_lstat_stub(const char *file_name, struct stat *buf)
 	return (init_stat() ? lstat : *cygwin_lstat_fn)(file_name, buf);
 }
 
+static int cygwin_fstat_stub(int fd, struct stat *buf)
+{
+	return (init_stat() ? fstat : *cygwin_fstat_fn)(fd, buf);
+}
+
 stat_fn_t cygwin_stat_fn = cygwin_stat_stub;
 stat_fn_t cygwin_lstat_fn = cygwin_lstat_stub;
+fstat_fn_t cygwin_fstat_fn = cygwin_fstat_stub;
 
diff --git a/compat/cygwin.h b/compat/cygwin.h
index c04965a..f3ca3d2 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -2,8 +2,10 @@
 #include <sys/stat.h>
 
 typedef int (*stat_fn_t)(const char*, struct stat*);
+typedef int (*fstat_fn_t)(int, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
+extern fstat_fn_t cygwin_fstat_fn;
 int cygwin_get_st_mode_bits(const char *path, int *mode);
 
 #define get_st_mode_bits(p,m) cygwin_get_st_mode_bits((p),(m))
@@ -11,4 +13,5 @@ int cygwin_get_st_mode_bits(const char *path, int *mode);
 /* cygwin.c needs the original lstat() */
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+#define fstat(fd, buf) (*cygwin_fstat_fn)(fd, buf)
 #endif
-- 
1.8.3
