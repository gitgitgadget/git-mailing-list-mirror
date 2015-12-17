From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] mingw: emulate write(2) that fails with a EPIPE
Date: Thu, 17 Dec 2015 18:08:15 +0100 (CET)
Message-ID: <ca357ac83a9990d6c88b637b76c6cc7f30d3f7be.1450372051.git.johannes.schindelin@gmx.de>
References: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 18:08:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9c2W-0000TD-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 18:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbbLQRIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 12:08:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:55597 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbbLQRIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 12:08:24 -0500
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEo4s-1Zy2X43k2U-00Fx4K; Thu, 17 Dec 2015 18:08:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <01da36219c18373f8507e19035e141d7e56b2d18.1450267413.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:M7ZKeDvnOfgPnuaj7WHuUWcfCBFUSdf2FjXDljiLMnNGZa8uOyb
 z4rUDpphvuR7kjpMWALPraU2tCnNufjpWzAe11k9dK8J5T2V6xD4CtPS571IU7qTyOOl/s0
 /uAPKX1HKKTh3BAlbwJH6lR2k96PQUjw7hsPJ+bggKbxbYk0oD7RrM/xvAMXF/NCst7waeP
 PgUYUAG5Kr7klSy8B+zgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iNiA5p6Zu70=:hXIdHZjDFSj1PzG3DDl6Q+
 KWOEqGs/BW5iKRaL87emrsBvp2YYG2BHWZeRs5klMRn4yDq+ofHy8E/F1t0Dlk+5YwqLF9bLk
 /AEuYk6ClY/2/Yhgd/4lGxSkMtyPM5zes+IVPqGrLD6378qYJ/WFiuBvjoGtjdyUw6pqDC6th
 c/yuEvtQN0x8aBLXbQqtVRPzzpyucGxo5lIcxUnvjtu0tNAP11VaEEcYmWcvZrkkXTNSb/Yhk
 5td4Ys3HrdKD85QuF+JRUpEjm+kv2xEI48RVtOeAB/D27d5xhKGTXhhdWWe9VkhFo1L+4MWbd
 67D0OwVfxDPQqG76fenrULJda2bAozDXHgP4Z4GJ0DQljAb66Ko0jVqWmSBWne0vDf54uYI4F
 RYL5cYztz4LJRjCeDrxXsJKK2VAak8zHHHUb780fefeoos80D8nqbkatWG4Ne+Y1R1Jz4xUWo
 QsGMBTeO7TYtkrcniQ4eHhqbkzPEEqLUkojKIrecu6dh0oaew5NZAbYCHBPGU0HMF6Eh1oLLI
 WQ2FeFdaIgGLwTp10tJR7CiJQQDnRwNyie2beuMyoucDz8aG65dKNqbvm6MtyY2P2VDTuGSTw
 EUyUBLbW0OsnxmtPYYHoY0yNMLRl5D4Glp30fQBxLgNkqDyvQHILr484MEAgq0xEN6cJTqdt7
 9XsbggxUkW+zGk/I0uB8Q9QFBsRTzSZNSlX3ZRFafms4JmKv71oPlmkuMnlRXz2ul8qX5ruGq
 EamVGBnOMz9vupqHv6AktuvCEpfp/KVSeOl0siVIUUNuvpXRk0gd3N6e7ypGkDh+8fD/2CUl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282660>

On Windows, when writing to a pipe fails, errno is always
EINVAL. However, Git expects it to be EPIPE.

According to the documentation, there are two cases in which write()
triggers EINVAL: the buffer is NULL, or the length is odd but the mode
is 16-bit Unicode (the broken pipe is not mentioned as possible cause).
Git never sets the file mode to anything but binary, therefore we know
that errno should actually be EPIPE if it is EINVAL and the buffer is
not NULL.

See https://msdn.microsoft.com/en-us/library/1570wh78.aspx for more
details.

This works around t5571.11 failing with v2.6.4 on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 17 +++++++++++++++++
 compat/mingw.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 90bdb1e..5edea29 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -394,6 +394,23 @@ int mingw_fflush(FILE *stream)
 	return ret;
 }
 
+#undef write
+ssize_t mingw_write(int fd, const void *buf, size_t len)
+{
+	ssize_t result = write(fd, buf, len);
+
+	if (result < 0 && errno == EINVAL && buf) {
+		/* check if fd is a pipe */
+		HANDLE h = (HANDLE) _get_osfhandle(fd);
+		if (GetFileType(h) == FILE_TYPE_PIPE)
+			errno = EPIPE;
+		else
+			errno = EINVAL;
+	}
+
+	return result;
+}
+
 int mingw_access(const char *filename, int mode)
 {
 	wchar_t wfilename[MAX_PATH];
diff --git a/compat/mingw.h b/compat/mingw.h
index 738865c..57ca477 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -210,6 +210,9 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
 int mingw_fflush(FILE *stream);
 #define fflush mingw_fflush
 
+ssize_t mingw_write(int fd, const void *buf, size_t len);
+#define write mingw_write
+
 int mingw_access(const char *filename, int mode);
 #undef access
 #define access mingw_access
Interdiff vs v1:

diff --git a/compat/mingw.c b/compat/mingw.c
index 90bdb1e..5edea29 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -394,6 +394,23 @@ int mingw_fflush(FILE *stream)
 	return ret;
 }
 
+#undef write
+ssize_t mingw_write(int fd, const void *buf, size_t len)
+{
+	ssize_t result = write(fd, buf, len);
+
+	if (result < 0 && errno == EINVAL && buf) {
+		/* check if fd is a pipe */
+		HANDLE h = (HANDLE) _get_osfhandle(fd);
+		if (GetFileType(h) == FILE_TYPE_PIPE)
+			errno = EPIPE;
+		else
+			errno = EINVAL;
+	}
+
+	return result;
+}
+
 int mingw_access(const char *filename, int mode)
 {
 	wchar_t wfilename[MAX_PATH];
diff --git a/compat/mingw.h b/compat/mingw.h
index 2aca347..57ca477 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -210,22 +210,7 @@ FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
 int mingw_fflush(FILE *stream);
 #define fflush mingw_fflush
 
-static inline ssize_t mingw_write(int fd, const void *buf, size_t len)
-{
-	ssize_t result = write(fd, buf, len);
-
-	if (result < 0 && errno == EINVAL && buf) {
-		/* check if fd is a pipe */
-		HANDLE h = (HANDLE) _get_osfhandle(fd);
-		if (GetFileType(h) == FILE_TYPE_PIPE)
-			errno = EPIPE;
-		else
-			errno = EINVAL;
-	}
-
-	return result;
-}
-
+ssize_t mingw_write(int fd, const void *buf, size_t len);
 #define write mingw_write
 
 int mingw_access(const char *filename, int mode);

-- 
2.6.3.windows.1.300.g1c25e49
