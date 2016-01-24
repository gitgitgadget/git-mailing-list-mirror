From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 07/19] mingw: let lstat() fail with errno == ENOTDIR when
 appropriate
Date: Sun, 24 Jan 2016 16:44:37 +0100 (CET)
Message-ID: <d723c85ea89699e9fe4c0535881bf48758adab5d.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqM-00010S-GO
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbcAXPon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:44:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:62871 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbcAXPol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:44:41 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MQ33z-1aSZmA2cIl-005FTn; Sun, 24 Jan 2016 16:44:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:VQkSfb1+yCjBgGefNSUg/16xjDTEnKeG7wAHDvmGSMDBd4vV2zH
 xncyUIkRWnTtyA2Am43xcRJx4V7749E92BaBwMWXU1CSVldeHVPfzyDujPOho1MqlwRZyES
 1o1Vjc2LzCXmMLYT+tsMHNWbnY9l7eOlYS5f9ax1vwwSQKe+OgugHqCEJQVJ/48CUK+AAf2
 8YN9/XSg9D3ozWYRNyufA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8rqoiX8XpCg=:fuQVUP1stv2wpkWqSZ34sA
 0PB+iBiqLMJkItEZpkmmnb3bBPnT7ewAbdU0onJxHdWX2Spu9CWrDQYhHGoNZq2nKoOWgRgex
 80I7gorG1z3B1cgs6EAhW1pHoferJDwyaq7IcHbocFBGGo0oXvZAidqx0LFtk+jff4cxJee4i
 kPqUH+wTzsI8yXGrdmAH8ZYHXprgPAla+yNv7o5/R99tiQmavHUxU8fd2LTQQboMC2mpjnYyU
 YvdiqBGbwC5sI+Af3l2g7EDKNjWUvkp/r/iSsnMawLDmFPjnKK5hdxhTSsRLpUm+e0Y0O6F7K
 uDkJVLMYVt3qeahP4DfNLo0liMxX8JTr0jNjOArllELmYKVG5RqpMOTN+f3f0MUXVu1Ktb9aP
 jeVqq2j2Y4mc9ZkOeGCOVWYiCA9tHSm80m3EbO/9UJ1s8IgkR+HtCP7n+Lv/qOOGf79a8K6Us
 rdJQpCGUwVtsyK/rfGvA4Kqqz99JcthF9g1535MPGO/sF4zAfTGuYNYDHFDuiOjMoOvjZ7MAd
 cwiUL20mdNxEnvWdPJ/XJHPYXpuF0+ezr+wMH64PD1GMrLjaDZDhryyb0RYvmGQky8gZ+Wpnh
 r2teykDXp1L8dl+NcUdVwsMuE2KMv91Mm5TbLJlRwgzGHbURp6dwqCuimiHHHKTLTcfQ3Y/tw
 SeoqNaF8o93mQ5xvygrmNNsbFsd5bUF76MSl6hFR2cGPqrCXF0CEJ2vMp2dQutXRI2GbE1Xgp
 U86gXd/IH3oR7Q3ca4bDc4QFGFbgF+zTg6h0l4kYTqoVV9pzROatYuHErv6s6FmYhkICcqpe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284671>

POSIX semantics requires lstat() to fail with ENOTDIR when "[a]
component of the path prefix names an existing file that is neither a
directory nor a symbolic link to a directory".

See http://pubs.opengroup.org/onlinepubs/9699919799/functions/lstat.html

This behavior is expected by t1404-update-ref-df-conflicts now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e4839b9..9e60335 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -454,6 +454,39 @@ static inline time_t filetime_to_time_t(const FILETIME *ft)
 	return (time_t)(filetime_to_hnsec(ft) / 10000000);
 }
 
+/**
+ * Verifies that safe_create_leading_directories() would succeed.
+ */
+static int has_valid_directory_prefix(wchar_t *wfilename)
+{
+	int n = wcslen(wfilename);
+
+	while (n > 0) {
+		wchar_t c = wfilename[--n];
+		DWORD attributes;
+
+		if (!is_dir_sep(c))
+			continue;
+
+		wfilename[n] = L'\0';
+		attributes = GetFileAttributesW(wfilename);
+		wfilename[n] = c;
+		if (attributes == FILE_ATTRIBUTE_DIRECTORY ||
+				attributes == FILE_ATTRIBUTE_DEVICE)
+			return 1;
+		if (attributes == INVALID_FILE_ATTRIBUTES)
+			switch (GetLastError()) {
+			case ERROR_PATH_NOT_FOUND:
+				continue;
+			case ERROR_FILE_NOT_FOUND:
+				/* This implies parent directory exists. */
+				return 1;
+			}
+		return 0;
+	}
+	return 1;
+}
+
 /* We keep the do_lstat code in a separate function to avoid recursion.
  * When a path ends with a slash, the stat will fail with ENOENT. In
  * this case, we strip the trailing slashes and stat again.
@@ -514,6 +547,12 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
 	case ERROR_NOT_ENOUGH_MEMORY:
 		errno = ENOMEM;
 		break;
+	case ERROR_PATH_NOT_FOUND:
+		if (!has_valid_directory_prefix(wfilename)) {
+			errno = ENOTDIR;
+			break;
+		}
+		/* fallthru */
 	default:
 		errno = ENOENT;
 		break;
-- 
2.7.0.windows.1.7.g55a05c8
