From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Add compat/fopen.c which returns NULL on attempt to open
 directory
Date: Fri, 08 Feb 2008 20:32:47 -0600
Message-ID: <47AD10CF.1040207@nrlssc.navy.mil>
References: <47ACFFD9.2030705@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNfXU-0006s6-VQ
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 03:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756718AbYBICd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 21:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756637AbYBICd1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 21:33:27 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49681 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754864AbYBICd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 21:33:26 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m192Wljl016555;
	Fri, 8 Feb 2008 20:32:48 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Feb 2008 20:32:47 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <47ACFFD9.2030705@nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Feb 2008 02:32:47.0790 (UTC) FILETIME=[0F00BCE0:01C86AC4]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--10.218800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTcwMDMwMC03MDM3?=
	=?us-ascii?B?ODgtNzAzODA3LTcxMDk4OS03MDAxNjAtNzA3OTA5LTcwMzUyOS0x?=
	=?us-ascii?B?ODgwMTktNzAyMDIwLTcwNTExMS0xMjE1MjMtNzAwMTk0LTcwMTQ1?=
	=?us-ascii?B?NS0xMjE2MjQtNzAyNzkxLTcwNDQyNS03MDA5NzEtNzAwMzI0LTcw?=
	=?us-ascii?B?NDc0Ny03MDEyOTYtNzAwMjY0LTE4ODE5OC0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73184>

Some systems do not fail as expected when fread et al. are called on
a directory stream. Replace fopen on such systems which will fail
when the supplied path is a directory.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile          |    7 +++++++
 compat/fopen.c    |   26 ++++++++++++++++++++++++++
 git-compat-util.h |    5 +++++
 3 files changed, 38 insertions(+), 0 deletions(-)
 create mode 100644 compat/fopen.c

diff --git a/Makefile b/Makefile
index 92341c4..debfc23 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,9 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+# Define FREAD_READS_DIRECTORIES if your are on a system which succeeds
+# when attempting to read from an fopen'ed directory.
+#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies MOZILLA_SHA1.
 #
@@ -618,6 +621,10 @@ endif
 ifdef NO_C99_FORMAT
 	BASIC_CFLAGS += -DNO_C99_FORMAT
 endif
+ifdef FREAD_READS_DIRECTORIES
+	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
+	COMPAT_OBJS += compat/fopen.o
+endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
 endif
diff --git a/compat/fopen.c b/compat/fopen.c
new file mode 100644
index 0000000..ccb9e89
--- /dev/null
+++ b/compat/fopen.c
@@ -0,0 +1,26 @@
+#include "../git-compat-util.h"
+#undef fopen
+FILE *git_fopen(const char *path, const char *mode)
+{
+	FILE *fp;
+	struct stat st;
+
+	if (mode[0] == 'w' || mode[0] == 'a')
+		return fopen(path, mode);
+
+	if (!(fp = fopen(path, mode)))
+		return NULL;
+
+	if (fstat(fileno(fp), &st)) {
+		fclose(fp);
+		return NULL;
+	}
+
+	if (S_ISDIR(st.st_mode)) {
+		fclose(fp);
+		errno = EISDIR;
+		return NULL;
+	}
+
+	return fp;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 4df90cb..46d5e93 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -204,6 +204,11 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
                 const void *needle, size_t needlelen);
 #endif
 
+#ifdef FREAD_READS_DIRECTORIES
+#define fopen(a,b) git_fopen(a,b)
+extern FILE *git_fopen(const char*, const char*);
+#endif
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
-- 
1.5.4.26.g5ef4da
