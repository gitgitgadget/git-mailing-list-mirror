From: Holger Eitzenberger <holger@my-eitzenberger.de>
Subject: [PATCH 1/1] git: add git_mkstemp()
Date: Thu, 04 Aug 2005 22:43:03 +0200
Message-ID: <42F27DD7.2080301@my-eitzenberger.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090307020402080505000708"
X-From: git-owner@vger.kernel.org Fri Aug 05 01:11:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0oqU-00029d-Lu
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 01:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVHDUrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVHDUon
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 16:44:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:48347 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262667AbVHDUnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 16:43:04 -0400
Received: from p54A3A6FD.dip0.t-ipconnect.de [84.163.166.253] (helo=[192.168.11.11])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwpI-1E0mYR0V97-000229; Thu, 04 Aug 2005 22:43:03 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050715)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090307020402080505000708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the following snippet adds git_mkstemp() to libgit (path.c).

/holger

--------------090307020402080505000708
Content-Type: text/x-patch;
 name="git_add_git_mkstemp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git_add_git_mkstemp.patch"

add git_mkstemp() to libgit

---
commit 1a1f2cb5c27ed26e6ef8dd34209e561bdf256c22
tree 868b67b55978394d288ac4f2ca8edcbbad4355bd
parent 10833f5e7d0da63ca976607864282d41b5faff1b
author Holger Eitzenberger <holger@my-eitzenberger.de> Thu, 04 Aug 2005 22:28:32 +0200
committer Holger Eitzenberger <holger@elmo.intranet.astaro.de> Thu, 04 Aug 2005 22:28:32 +0200

 cache.h |    3 +++
 path.c  |   26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -174,7 +174,10 @@ extern char *mkpath(const char *fmt, ...
 extern char *git_path(const char *fmt, ...);
 extern char *sha1_file_name(const unsigned char *sha1);
 
+int git_mkstemp(char *path, size_t n, const char *template);
+
 int safe_create_leading_directories(char *path);
+char *safe_strncpy(char *, const char *, size_t);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
diff --git a/path.c b/path.c
--- a/path.c
+++ b/path.c
@@ -58,3 +58,29 @@ char *git_path(const char *fmt, ...)
 		return bad_path;
 	return cleanup_path(pathname);
 }
+
+
+/* git_mkstemp() - create tmp file honoring TMPDIR variable */
+int git_mkstemp(char *path, size_t len, const char *template)
+{
+	char *env, *pch = path;
+
+	if ((env = getenv("TMPDIR")) == NULL) {
+		strcpy(pch, "/tmp/");
+		len -= 5;
+	} else
+		len -= snprintf(pch, len, "%s/", env);
+
+	safe_strncpy(pch, template, len);
+
+	return mkstemp(path);
+}
+
+
+char *safe_strncpy(char *dest, const char *src, size_t n)
+{
+	strncpy(dest, src, n);
+	dest[n - 1] = '\0';
+
+	return dest;
+}

--------------090307020402080505000708--
