From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 1/1] index-pack: Disable threading on cygwin
Date: Tue, 26 Jun 2012 19:19:32 +0100
Message-ID: <4FE9FD34.5020406@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjb32-0007f7-BL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab2FZTDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:03:31 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:34540 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159Ab2FZTD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 15:03:29 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Sjb2t-0005U0-c7; Tue, 26 Jun 2012 19:03:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200670>

From: Junio C Hamano <gitster@pobox.com>

The Cygwin implementation of pread() is not thread-safe since, just
like the emulation provided by compat/pread.c, it uses a sequence of
seek-read-seek calls. In order to avoid failues due to thread-safety
issues, commit b038a61 disables threading when NO_PREAD is defined.
(ie when using the emulation code in compat/pread.c).

We introduce a new build variable, NO_THREAD_SAFE_PREAD, which allows
use to disable the threaded index-pack code on cygwin, in addition to
the above NO_PREAD case.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I made some small changes to your patch:

   - renamed FAKE_PREAD_NOT_THREAD_SAFE to NO_THREAD_SAFE_PREAD
   - when NO_PREAD, set NO_THREAD_SAFE_PREAD in the Makefile, rather
     than in git-compat-util.h
   - set NO_THREAD_SAFE_PREAD in the non-conditional part of the
     cygwin config section (ie not just versions before 1.7.x)

I can only test this by using it (all relevant tests pass with or without
this patch, after all), so I have installed it for day-to-day use. I don't
anticipate any problems, but I guess this patch has not actually been
tested yet ... :-D

HTH

ATB,
Ramsay Jones

 Makefile             | 8 ++++++++
 builtin/index-pack.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 4592f1f..67d761e 100644
--- a/Makefile
+++ b/Makefile
@@ -158,6 +158,9 @@ all::
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
+# Define NO_THREAD_SAFE_PREAD if your pread() implementation is not
+# thread-safe. (e.g. compat/pread.c or cygwin)
+#
 # Define NO_FAST_WORKING_DIRECTORY if accessing objects in pack files is
 # generally faster on your platform than accessing the working directory.
 #
@@ -1051,6 +1054,7 @@ ifeq ($(uname_O),Cygwin)
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
 	endif
+	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
@@ -1659,6 +1663,10 @@ endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
+	NO_THREAD_SAFE_PREAD = YesPlease
+endif
+ifdef NO_THREAD_SAFE_PREAD
+	BASIC_CFLAGS += -DNO_THREAD_SAFE_PREAD
 endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dc2cfe6..4705478 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -39,8 +39,8 @@ struct base_data {
 	int ofs_first, ofs_last;
 };
 
-#if !defined(NO_PTHREADS) && defined(NO_PREAD)
-/* NO_PREAD uses compat/pread.c, which is not thread-safe. Disable threading. */
+#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
+/* pread() emulation is not thread-safe. Disable threading. */
 #define NO_PTHREADS
 #endif
 
-- 
1.7.11.1.gef8c760
