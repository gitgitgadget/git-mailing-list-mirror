Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD8372B27
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616461; cv=none; b=V/8lVkMZUo2zGRZLDpmxzeQpYRQnOM6AB9yixJRI4XigtpJhpxz0OF0Y6acXcYFFbJwH57AsCteC/Agxf5XXB+nDncrFDFnmIm82IFkccbojkBuydhnHUYkRdEjSKiIAHT5nSMHuIOLYHhpTXMfx3Tx80qzKaWAQYRm3Z2vQ/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616461; c=relaxed/simple;
	bh=8xxj7OgU84oOuy4rXSsvheFaUkqbCnMflF/DF+Dhy+s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n8meAq7kEfx58CDH0Ow4nODH2ZgSwgruFABqT7KKi1gOvSJ7KenzpbIdu0NcIoOJuOJwUDf2X4kivf66eG4+lVmMIqDPvH22yh7puhr4QD4JGmCErebpEneEN0Io0MGZk+1I2Ckavoof7Y3FRGGq2rWC0tM/p0Z4gWrdoTcKi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=D0aT3jlI; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="D0aT3jlI"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4hlhP03jb2z8PbW
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 23:40:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=8xxj7OgU84oOuy4rXSsvheFaUkqbCnMflF/DF+Dhy+s=; b=D0aT
	3jlIiza2KLyQbYnFLn+T5ngGLC4apoC6VqICTLI2YUXLqY9YwXK68DWLxy8avlKJ
	FtGIwWmAWTGNxD0UiLdKUjUUpXdMZeHkojJ1SUMJDNI2R2RzSW28wT+Gd7CLfOvl
	1tecQbwTDPL3xlvlnqE8SW39VkJHAXEIFM7MWBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	DYe9Cqyn3GFrD2QqPir9L97DH9e4bGIgtp1A08KKXejmQpv4O7z9kvUx0i2qSvzu
	Y99PRS91hb0e3Hd+GxMqj4t5n0aRy9mK7sq1AL98q2kuSDCJc7UetsXAqGXu+GK/
	MyVhRv4L7Usv9vRDcf90S7SNcgJLyEHyHFzFyLuGVN4=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:e6eb:b4e:c1f3:5477])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4hlhP039QQz8PbS
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 23:40:52 -0400 (EDT)
Date: Wed, 16 Sep 2026 23:40:51 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
Message-ID: <aqthQ3u4eW1wHCn7@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Enable Git to resolve its own binary location using getexecpath().

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 Makefile         |  7 +++++++
 config.mak.uname |  3 +++
 exec-cmd.c       | 24 ++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Makefile b/Makefile
index d4b775953d..9e3d37b5b4 100644
--- a/Makefile
+++ b/Makefile
@@ -378,6 +378,9 @@ include shared.mak
 # Perl scripts to use a modified entry point header allowing them to resolve
 # support files at runtime.
 #
+# When using RUNTIME_PREFIX, define HAVE_GETEXECPATH if your platform supports
+# the getexecpath() function.
+#
 # When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your platform
 # supports the KERN_PROC BSD sysctl function.
 #
@@ -2356,6 +2359,10 @@ endif
 
 ifdef RUNTIME_PREFIX
 
+        ifdef HAVE_GETEXECPATH
+		BASIC_CFLAGS += -DHAVE_GETEXECPATH
+        endif
+
         ifdef HAVE_BSD_KERN_PROC_SYSCTL
 		BASIC_CFLAGS += -DHAVE_BSD_KERN_PROC_SYSCTL
         endif
diff --git a/config.mak.uname b/config.mak.uname
index e28870434d..270aff1772 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -343,6 +343,9 @@ ifeq ($(uname_S),OpenBSD)
 	CSPRNG_METHOD = arc4random
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 8 && echo 1),1)
+		HAVE_GETEXECPATH = YesPlease
+	endif
 endif
 ifeq ($(uname_S),MirBSD)
 	NO_STRCASESTR = YesPlease
diff --git a/exec-cmd.c b/exec-cmd.c
index 507e67d528..5251da4229 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -129,6 +129,26 @@ static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
 }
 #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
 
+#ifdef HAVE_GETEXECPATH
+/*
+ * Resolves the executable path using getexecpath(3).
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_getexecpath(struct strbuf *buf)
+{
+	char path[PATH_MAX];
+	if (getexecpath(path, sizeof(path)) == 0) {
+		trace_printf(
+			"trace: resolved executable path from getexecpath: %s\n",
+			path);
+		strbuf_addstr(buf, path);
+		return 0;
+	}
+	return -1;
+}
+#endif /* HAVE_GETEXECPATH */
+
 #ifdef HAVE_NS_GET_EXECUTABLE_PATH
 /*
  * Resolves the executable path by querying Darwin application stack.
@@ -209,6 +229,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
 	 * after the first successful method.
 	 */
 	if (
+#ifdef HAVE_GETEXECPATH
+		git_get_exec_path_getexecpath(buf) &&
+#endif /* HAVE_GETEXECPATH */
+
 #ifdef HAVE_BSD_KERN_PROC_SYSCTL
 		git_get_exec_path_bsd_sysctl(buf) &&
 #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
-- 
2.55.0

