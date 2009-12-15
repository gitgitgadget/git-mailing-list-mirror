From: Tarmigan <tarmigan+git@gmail.com>
Subject: Git on QNX
Date: Tue, 15 Dec 2009 13:23:37 -0800
Message-ID: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mkraai@beckman.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 15 22:24:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKesI-0002E0-02
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 22:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbZLOVX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 16:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760755AbZLOVX7
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 16:23:59 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:57927 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759905AbZLOVX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 16:23:57 -0500
Received: by pxi4 with SMTP id 4so204998pxi.33
        for <git@vger.kernel.org>; Tue, 15 Dec 2009 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=iTmgGQC7ePpr49lDBtwb6g4mv0UcOib+6ZsMxDDI8Qw=;
        b=L6SFzNqoets/mNlXrJb0tEJEg/020fIHCyeHrEM/c8U+Oj3hdlwDYmasBFwMERXlyo
         bE0Xm9L95nAhDUc682M8g614Xfl5jrhBCbe4pzdBLPpTIuqrtf21D3k2wkooYHqqm6Ci
         rAWTdOL+xWuH4SHsxgL88RxWrdGGbg7VtTelc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        b=Aa03smajm2Hmy0+QaPqg32zQZmiLqrIg6tSjTcpjVwCVIvRK0Bc6A92V4X8YGj6eI0
         dQC59jWG2hn9LWkP/rU37eYBpun7khcxrOTaPxqbg4ATLMCOcep2oFTiXGn3VL+71oF7
         yeB06FfOvR+eIyFP+W37BsSIHg62eNQfpIp0w=
Received: by 10.143.21.36 with SMTP id y36mr45746wfi.211.1260912237098; Tue, 
	15 Dec 2009 13:23:57 -0800 (PST)
X-Google-Sender-Auth: d46b92e0c3963470
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135300>

Is anyone running git on QNX?

I have compiled and installed it (see config below) but it is failing
a number of the tests.  I suspect that many of the later failures are
related to the earlier ones, so I think the earlier ones are probably
more interesting.  Am I missing some makefile options?

Despite the test failures, I have been running the binaries
successfully for a couple days.  I'm not planning on using git on QNX
very heavily or for very long, but as long as I'm on QNX I figured I
try to get git to work on it.

Here's the tests that are currently failing:
	t0000.42  absolute path works as expected
	t0006.14  parse date (2008-02-14 20:30:45)
	t1002-read-tree-m-u-2way.sh lots of failures
	t1100.4 compare commit
	t1400.22,27,38,41
	t1410.8 reflog delete
	t2300.4,5 cd-to-toplevel
	t3200.5,30 branch (maybe same as date in t0006.14?)
	t3900.10,18 NO_ICONV?
	t3901 NO_ICONV?
	t4013-diff-various.sh lots of failures
	t4201.3 shortlog encoding (NO_ICONV?)
	t5000.13 tar tree validate file modification time
	t5100-mailinfo.sh
	t5510-fetch.sh

I got impatient after about t5600 because QNX in a virtual machine is
very slow.  If anyone else wants to try it, you can download a QNX
.iso, get a free 30-day evaluation license and install and run in a
virtual machine.

I have started to look into t0000.42 a little.  The symlinks seem to
get setup properly but make_absolute_path gives incorrect results:
# ls -l second/other
lrwxrwxrwx 1 root root 8 Dec 15 12:27 second/other -> ../first
# ../../test-path-utils make_absolute_path third/../second/other/.git/syml
/root/git/t/trash directory.t0000-basic/second/other/.git/syml
# ../../test-path-utils make_absolute_path second/other/.git/syml
/root/git/t/trash directory.t0000-basic/second/other/.git/syml
# ../../test-path-utils make_absolute_path second/other
/root/git/t/trash directory.t0000-basic/second/first   <---- THIS LOOKS WRONG
# ../../test-path-utils make_absolute_path second/other/
/root/git/t/trash directory.t0000-basic/second/first   <---- THIS LOOKS WRONG
# ../../test-path-utils make_absolute_path second/other/.git
../.git <---- THIS LOOKS WRONG

If anyone has any ideas or interest in the other failing tests, I can
provide more specific information.

Here's the diff that I applied to make git compile (cut-n-paste +
gmail warning) and it's on top of 9a424b27.  I would like to properly
submit some bits of it once the tests are passing.

Thanks,
Tarmigan

--------

diff --git a/Makefile b/Makefile
index 4a1e5bc..ca78dcd 100644
--- a/Makefile
+++ b/Makefile
@@ -934,6 +934,30 @@ ifeq ($(uname_S),HP-UX)
 	NO_SYS_SELECT_H = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 endif
+ifeq ($(uname_S),QNX)
+	NO_OPENSSL=YesPlease
+	NO_CURL=YesPlease
+	NEEDS_SOCKET=YesPlease
+	NO_D_TYPE_IN_DIRENT=YesPlease
+	NO_STRCASESTR=YesPlease
+	NO_MEMMEM = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	#NO_ICONV=YesPlease
+	OLD_ICONV=UnfortunatelyYes
+	NEEDS_LIBICONV=yes
+	ICONVDIR=/opt
+	NO_R_TO_GCC_LINKER=UnfortunatelyYes
+	NO_DEFLATE_BOUND=yes
+	FREAD_READS_DIRECTORIES=UnfortunatelyYes
+	NO_PTHREADS=UnfortunatelyYes
+	NO_MMAP=YesPlease
+	NO_NSEC=YesPlease
+	PERL_PATH=/opt/bin/perl
+	#NO_HSTRERROR = YesPlease
+	#NO_SYS_SELECT_H = YesPlease
+endif
 ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 8ed4a6f..5cbc16c 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -778,7 +778,7 @@ static int fetch_pack_config(const char *var,
const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }

-static struct lock_file lock;
+static struct lock_file lockfile;

 static void fetch_pack_setup(void)
 {
@@ -958,14 +958,14 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			  )
 			die("shallow file was changed during fetch");

-		fd = hold_lock_file_for_update(&lock, shallow,
+		fd = hold_lock_file_for_update(&lockfile, shallow,
 					       LOCK_DIE_ON_ERROR);
 		if (!write_shallow_commits(&sb, 0)
 		 || write_in_full(fd, sb.buf, sb.len) != sb.len) {
 			unlink_or_warn(shallow);
-			rollback_lock_file(&lock);
+			rollback_lock_file(&lockfile);
 		} else {
-			commit_lock_file(&lock);
+			commit_lock_file(&lockfile);
 		}
 		strbuf_release(&sb);
 	}
diff --git a/git-compat-util.h b/git-compat-util.h
index 5c59687..857e938 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -42,6 +42,11 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)

+#if defined(__QNX__)
+#define getpagesize() sysconf(_SC_PAGESIZE)
+#define SA_RESTART 0
+#endif
+
 #if defined(__sun__)
  /*
   * On Solaris, when _XOPEN_EXTENDED is set, its header file
@@ -55,7 +60,7 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__)  &&
!defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi)
+#elif !defined(__APPLE__) && !defined(__FreeBSD__)  &&
!defined(__USLC__) && !defined(_M_UNIX) && !defined(sgi) &&
!defined(__QNX__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
needs 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
@@ -79,6 +84,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
+#include <strings.h>
 #include <errno.h>
 #include <limits.h>
 #include <sys/param.h>
