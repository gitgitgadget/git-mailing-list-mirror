From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/6] git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
Date: Sat, 20 Feb 2010 00:21:55 +0100
Message-ID: <1266621718-4879-3-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 20 00:23:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NicBq-00072o-BE
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 00:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab0BSXXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 18:23:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41536 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755993Ab0BSXXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 18:23:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1JNJvb3018193
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 20 Feb 2010 00:19:57 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NicAk-0001DJ-7N; Sat, 20 Feb 2010 00:22:10 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NicAk-0001HQ-60; Sat, 20 Feb 2010 00:22:10 +0100
X-Mailer: git-send-email 1.7.0.rc2.92.gb6a04
In-Reply-To: <vpq7hq8stjt.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 20 Feb 2010 00:19:57 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140498>

gitmkstemps emulates the behavior of mkstemps, which is usually used
to create files in a shared directory like /tmp/, hence, it creates
files with permission 0600. But we use it also to create pack files,
which do not need this protection.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 cache.h   |    4 ++++
 path.c    |   16 ++++++++++++++--
 wrapper.c |   10 ++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..0319637 100644
--- a/cache.h
+++ b/cache.h
@@ -641,6 +641,10 @@ int git_mkstemp(char *path, size_t n, const char *template);
 
 int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
 
+/* set default permissions by passing mode arguments to open(2) */
+int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
+int git_mkstemp_mode(char *pattern, int mode);
+
 /*
  * NOTE NOTE NOTE!!
  *
diff --git a/path.c b/path.c
index 60f5b78..005b836 100644
--- a/path.c
+++ b/path.c
@@ -162,7 +162,7 @@ int git_mkstemps(char *path, size_t len, const char *template, int suffix_len)
 #undef TMP_MAX
 #define TMP_MAX 16384
 
-int gitmkstemps(char *pattern, int suffix_len)
+int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 {
 	static const char letters[] =
 		"abcdefghijklmnopqrstuvwxyz"
@@ -204,7 +204,7 @@ int gitmkstemps(char *pattern, int suffix_len)
 		template[4] = letters[v % num_letters]; v /= num_letters;
 		template[5] = letters[v % num_letters]; v /= num_letters;
 
-		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, 0600);
+		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd > 0)
 			return fd;
 		/*
@@ -226,6 +226,17 @@ int gitmkstemps(char *pattern, int suffix_len)
 	return -1;
 }
 
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
 int validate_headref(const char *path)
 {
 	struct stat st;
@@ -718,3 +729,4 @@ int daemon_avoid_alias(const char *p)
 		}
 	}
 }
+
diff --git a/wrapper.c b/wrapper.c
index 0e3e20a..673762f 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -204,6 +204,16 @@ int xmkstemp(char *template)
 	return fd;
 }
 
+int xmkstemp_mode(char *template, int mode)
+{
+	int fd;
+
+	fd = git_mkstemp_mode(template, mode);
+	if (fd < 0)
+		die_errno("Unable to create temporary file");
+	return fd;
+}
+
 /*
  * zlib wrappers to make sure we don't silently miss errors
  * at init time.
-- 
1.7.0.rc2.92.gb6a04
