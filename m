From: Peter Krefting <peter@softwolves.pp.se>
Subject: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 09:47:22 +0100 (CET)
Message-ID: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 10:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le4lj-0005d8-Lu
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 10:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbZCBJrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 04:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbZCBJrg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 04:47:36 -0500
Received: from smtp.getmail.no ([84.208.20.33]:58585 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269AbZCBJrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 04:47:35 -0500
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2009 04:47:35 EST
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFV0070LF37JV00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 09:47:31 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV003KNF2ZUI30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 09:47:23 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFV007VOF2Y0QE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 09:47:22 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id AABA62FC03; Mon,
 02 Mar 2009 09:47:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id A7FFA2FC02	for <git@vger.kernel.org>; Mon,
 02 Mar 2009 09:47:22 +0100 (CET)
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111924>

When opening a file through open() or fopen(), the path passed is
UTF-8 encoded. To handle this on Windows, we need to convert the
path string to UTF-16 and use the Unicode-based interface.
---
Windows does support file names using arbitrary Unicode characters, you just 
need to use its wchar_t interfaces instead of the char ones (the char ones 
just gets converted into wchar_t on the API level anyway, for the same 
reasons). This is the beginnings of support for UTF-8 file names on Git on 
Windows.

Since there is no real file system abstraction beyond using stdio (AFAIK), I 
need to hack it by replacing fopen (and open). Probably opendir/readdir as 
well (might be trickier), and possibly even hack around main() to parse the 
wchar_t command-line instead of the char copy.

This will lose all chances of Windows 9x compatibility, but I don't know if 
there are any attempts of supporting it anyway?

Please note that MultiByteToWideChar() will reject any invalid UTF-8 
strings, perhaps it should just fall back to a regular open()/fopen() in 
that case?

No Signed-Off line since this is unfinished, just presenting rough sketches 
of an idea.

  compat/mingw.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
  compat/mingw.h |    3 ++
  2 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e25cb4f..8b19b80 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -9,13 +9,30 @@ int mingw_open (const char *filename, int oflags, ...)
  {
  	va_list args;
  	unsigned mode;
+	wchar_t *unicode_filename;
+	int unicode_filename_len;
  	va_start(args, oflags);
  	mode = va_arg(args, int);
  	va_end(args);

  	if (!strcmp(filename, "/dev/null"))
  		filename = "nul";
-	int fd = open(filename, oflags, mode);
+
+	unicode_filename_len = MultiByteToWideChar(CP_UTF8, 0, filename, -1, NULL, 0);
+	if (0 == unicode_filename_len) {
+		errno = EINVAL;
+		return -1;
+	};
+
+	unicode_filename = xmalloc(unicode_filename_len * sizeof (wchar_t));
+	if (NULL == unicode_filename) {
+		errno = ENOMEM;
+		return -1;
+	}
+	MultiByteToWideChar(CP_UTF8, 0, filename, -1, unicode_filename, unicode_filename_len);
+	int fd = _wopen(unicode_filename, oflags, mode);
+	free(unicode_filename);
+
  	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
  		DWORD attrs = GetFileAttributes(filename);
  		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
@@ -24,6 +41,47 @@ int mingw_open (const char *filename, int oflags, ...)
  	return fd;
  }

+FILE *mingw_fopen (const char *filename, const char *mode)
+{
+	wchar_t *unicode_filename, *unicode_mode;
+	int unicode_filename_len, unicode_mode_len;
+	FILE *fh;
+
+	unicode_filename_len = MultiByteToWideChar(CP_UTF8, 0, filename, -1, NULL, 0);
+	if (0 == unicode_filename_len) {
+		errno = EINVAL;
+		return NULL;
+	};
+
+	unicode_filename = xmalloc(unicode_filename_len * sizeof (wchar_t));
+	if (NULL == unicode_filename) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	MultiByteToWideChar(CP_UTF8, 0, filename, -1, unicode_filename, unicode_filename_len);
+
+	unicode_mode_len = MultiByteToWideChar(CP_UTF8, 0, mode, -1, NULL, 0);
+	if (0 == unicode_mode_len) {
+		free(unicode_filename);
+		errno = EINVAL;
+		return NULL;
+	};
+
+	unicode_mode = xmalloc(unicode_mode_len * sizeof (wchar_t));
+	if (NULL == unicode_mode) {
+		free(unicode_mode);
+		errno = ENOMEM;
+		return NULL;
+	}
+	MultiByteToWideChar(CP_UTF8, 0, mode, -1, unicode_mode, unicode_mode_len);
+
+	fh = _wfopen(unicode_filename, unicode_mode);
+	free(unicode_filename);
+	free(unicode_mode);
+
+	return fh;
+}
+
  static inline time_t filetime_to_time_t(const FILETIME *ft)
  {
  	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
diff --git a/compat/mingw.h b/compat/mingw.h
index 4f275cb..235df0a 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -142,6 +142,9 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out);
  int mingw_open (const char *filename, int oflags, ...);
  #define open mingw_open

+FILE *mingw_fopen (const char *filename, const char *mode);
+#define fopen mingw_fopen
+
  char *mingw_getcwd(char *pointer, int len);
  #define getcwd mingw_getcwd

-- 
1.6.0.2.1172.ga5ed0
