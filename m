From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/4] git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
Date: Fri, 19 Feb 2010 17:33:26 +0100
Message-ID: <1266597207-32036-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 17:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiVqJ-00076O-E7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 17:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab0BSQgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 11:36:35 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37868 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab0BSQge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 11:36:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o1JGVR2X005307
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 19 Feb 2010 17:31:28 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0006F5-HR; Fri, 19 Feb 2010 17:33:38 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NiVnO-0008Lh-GP; Fri, 19 Feb 2010 17:33:38 +0100
X-Mailer: git-send-email 1.7.0.rc2.4.gc602c4
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 19 Feb 2010 17:31:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o1JGVR2X005307
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1267201888.38875@53VnZXcJWexFN/62jzSPyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140461>

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
1.7.0.rc2.4.gc602c4
