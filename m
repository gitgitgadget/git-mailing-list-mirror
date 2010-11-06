From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/8] path helpers: move git_mkstemp* to wrapper.c
Date: Sat, 6 Nov 2010 06:46:31 -0500
Message-ID: <20101106114631.GC27641@burratino>
References: <20101106113905.GA27405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEhEL-0002W9-5K
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab0KFLqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:46:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44181 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0KFLqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Nov 2010 07:46:39 -0400
Received: by iwn41 with SMTP id 41so1927724iwn.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=f9D/GGQsIBeaCY1q+SygKq5HNznHB4d+B/VP5H/oP6I=;
        b=NkFh5k5uGVOW0IpI66KeDTesf4FxMQaeaJGhLMxeVsPxlXcfIHhDvwNKVSDuNcqjso
         OAYakI30Lr+7Y9lSM4KQDEvh+7pcqwsXDCc+lL7lWQh6JYy5FuO08jBb+XWbiIYvbNcF
         zmlnR3kxtOXMABRqP/JURjKZiJwJ7EMx2HKpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P+Y0dXmOX/TZzGLk68UUDTHpUdCvZ+GOh39HhgH8/NMgwGgdgOziWXYisiMNFZaML+
         LJA/gDLMTzgifsAldE0bcMAF/hZ9lirtsxSIsZHHonvpJbSNqKfUrcPT0qOU4t8jJYFv
         l9KOFyYMealiYg9UmL/4Wc3UWSSNHZvLpqVjs=
Received: by 10.231.169.1 with SMTP id w1mr2528894iby.123.1289043998419;
        Sat, 06 Nov 2010 04:46:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i16sm816260ibl.0.2010.11.06.04.46.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 06 Nov 2010 04:46:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101106113905.GA27405@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160845>

git_mkstemp_mode and related functions do not require access to
specialized git machinery, unlike some other functions from
path.c (like set_shared_perm()).  Move them to wrapper.c where
the wrapper xmkstemp_mode is defined.

This eliminates a dependency of wrapper.o on environment.o via
path.o.  With typical linkers (e.g., gcc), that dependency makes
programs that use functions from wrapper.o and not environment.o
or path.o larger than they need to be.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 path.c    |  113 -------------------------------------------------------------
 wrapper.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/path.c b/path.c
index a2c9d1e..8951333 100644
--- a/path.c
+++ b/path.c
@@ -161,119 +161,6 @@ char *git_path_submodule(const char *path, const char *fmt, ...)
 	return cleanup_path(pathname);
 }
 
-/* git_mkstemp() - create tmp file honoring TMPDIR variable */
-int git_mkstemp(char *path, size_t len, const char *template)
-{
-	const char *tmp;
-	size_t n;
-
-	tmp = getenv("TMPDIR");
-	if (!tmp)
-		tmp = "/tmp";
-	n = snprintf(path, len, "%s/%s", tmp, template);
-	if (len <= n) {
-		errno = ENAMETOOLONG;
-		return -1;
-	}
-	return mkstemp(path);
-}
-
-/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable. */
-int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
-{
-	const char *tmp;
-	size_t n;
-
-	tmp = getenv("TMPDIR");
-	if (!tmp)
-		tmp = "/tmp";
-	n = snprintf(path, len, "%s/%s", tmp, template);
-	if (len <= n) {
-		errno = ENAMETOOLONG;
-		return -1;
-	}
-	return mkstemps(path, suffix_len);
-}
-
-/* Adapted from libiberty's mkstemp.c. */
-
-#undef TMP_MAX
-#define TMP_MAX 16384
-
-int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
-{
-	static const char letters[] =
-		"abcdefghijklmnopqrstuvwxyz"
-		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
-		"0123456789";
-	static const int num_letters = 62;
-	uint64_t value;
-	struct timeval tv;
-	char *template;
-	size_t len;
-	int fd, count;
-
-	len = strlen(pattern);
-
-	if (len < 6 + suffix_len) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	/*
-	 * Replace pattern's XXXXXX characters with randomness.
-	 * Try TMP_MAX different filenames.
-	 */
-	gettimeofday(&tv, NULL);
-	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
-	template = &pattern[len - 6 - suffix_len];
-	for (count = 0; count < TMP_MAX; ++count) {
-		uint64_t v = value;
-		/* Fill in the random bits. */
-		template[0] = letters[v % num_letters]; v /= num_letters;
-		template[1] = letters[v % num_letters]; v /= num_letters;
-		template[2] = letters[v % num_letters]; v /= num_letters;
-		template[3] = letters[v % num_letters]; v /= num_letters;
-		template[4] = letters[v % num_letters]; v /= num_letters;
-		template[5] = letters[v % num_letters]; v /= num_letters;
-
-		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
-		if (fd > 0)
-			return fd;
-		/*
-		 * Fatal error (EPERM, ENOSPC etc).
-		 * It doesn't make sense to loop.
-		 */
-		if (errno != EEXIST)
-			break;
-		/*
-		 * This is a random value.  It is only necessary that
-		 * the next TMP_MAX values generated by adding 7777 to
-		 * VALUE are different with (module 2^32).
-		 */
-		value += 7777;
-	}
-	/* We return the null string if we can't find a unique file name.  */
-	pattern[0] = '\0';
-	return -1;
-}
-
-int git_mkstemp_mode(char *pattern, int mode)
-{
-	/* mkstemp is just mkstemps with no suffix */
-	return git_mkstemps_mode(pattern, 0, mode);
-}
-
-int gitmkstemps(char *pattern, int suffix_len)
-{
-	return git_mkstemps_mode(pattern, suffix_len, 0600);
-}
-
 int validate_headref(const char *path)
 {
 	struct stat st;
diff --git a/wrapper.c b/wrapper.c
index e67b70a..b3efefb 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -204,6 +204,119 @@ int xmkstemp(char *template)
 	return fd;
 }
 
+/* git_mkstemp() - create tmp file honoring TMPDIR variable */
+int git_mkstemp(char *path, size_t len, const char *template)
+{
+	const char *tmp;
+	size_t n;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	return mkstemp(path);
+}
+
+/* git_mkstemps() - create tmp file with suffix honoring TMPDIR variable. */
+int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
+{
+	const char *tmp;
+	size_t n;
+
+	tmp = getenv("TMPDIR");
+	if (!tmp)
+		tmp = "/tmp";
+	n = snprintf(path, len, "%s/%s", tmp, template);
+	if (len <= n) {
+		errno = ENAMETOOLONG;
+		return -1;
+	}
+	return mkstemps(path, suffix_len);
+}
+
+/* Adapted from libiberty's mkstemp.c. */
+
+#undef TMP_MAX
+#define TMP_MAX 16384
+
+int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
+{
+	static const char letters[] =
+		"abcdefghijklmnopqrstuvwxyz"
+		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"0123456789";
+	static const int num_letters = 62;
+	uint64_t value;
+	struct timeval tv;
+	char *template;
+	size_t len;
+	int fd, count;
+
+	len = strlen(pattern);
+
+	if (len < 6 + suffix_len) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/*
+	 * Replace pattern's XXXXXX characters with randomness.
+	 * Try TMP_MAX different filenames.
+	 */
+	gettimeofday(&tv, NULL);
+	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
+	template = &pattern[len - 6 - suffix_len];
+	for (count = 0; count < TMP_MAX; ++count) {
+		uint64_t v = value;
+		/* Fill in the random bits. */
+		template[0] = letters[v % num_letters]; v /= num_letters;
+		template[1] = letters[v % num_letters]; v /= num_letters;
+		template[2] = letters[v % num_letters]; v /= num_letters;
+		template[3] = letters[v % num_letters]; v /= num_letters;
+		template[4] = letters[v % num_letters]; v /= num_letters;
+		template[5] = letters[v % num_letters]; v /= num_letters;
+
+		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
+		if (fd > 0)
+			return fd;
+		/*
+		 * Fatal error (EPERM, ENOSPC etc).
+		 * It doesn't make sense to loop.
+		 */
+		if (errno != EEXIST)
+			break;
+		/*
+		 * This is a random value.  It is only necessary that
+		 * the next TMP_MAX values generated by adding 7777 to
+		 * VALUE are different with (module 2^32).
+		 */
+		value += 7777;
+	}
+	/* We return the null string if we can't find a unique file name.  */
+	pattern[0] = '\0';
+	return -1;
+}
+
+int git_mkstemp_mode(char *pattern, int mode)
+{
+	/* mkstemp is just mkstemps with no suffix */
+	return git_mkstemps_mode(pattern, 0, mode);
+}
+
+int gitmkstemps(char *pattern, int suffix_len)
+{
+	return git_mkstemps_mode(pattern, suffix_len, 0600);
+}
+
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
-- 
1.7.2.3.557.gab647.dirty
