From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 07/20] mingw: let lstat() fail with errno == ENOTDIR when
 appropriate
Date: Wed, 27 Jan 2016 17:19:33 +0100 (CET)
Message-ID: <4a4f5b608e1782fd5b65f005921527c54074e792.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSp5-0002OW-68
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933879AbcA0QTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:49427 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933395AbcA0QTq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LjIel-1Zoq9R0Vjj-00dUOT; Wed, 27 Jan 2016 17:19:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:RITgi36Nx32ruiDvJIh9yQY4MNQ4f2ng/D7FIwS4NRDhvBWMNvb
 Fpj/sAWH8gZGkmfAdVxNcZqkkTCOFIk9jdDBjqAoswYB/y/GY/lZ7cDcT6lMZuwABgX2Xz0
 yV87BlFNtJDFHNtyoBbHkH0pFbxtR4HOnpC5n1JEzWKV3gbgDAOktrY7s7fmOnny5xesfNn
 75CcKviyyDiI38UZYtwcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s0oRJab6gX4=:Z2cAqkq6rdiB/sbqwDJGRi
 DOW2iQgNLwYih9Qj5WdM51wrTNOl8WuDdkPG8rninsgkaInVmKkyZ7OC/1jg9qmnqhEyqh1w0
 dZkFOutTomWz2OzdUQ0l49GU4rlT5BXzESz75JEfvaJYf4ezX2V7DTkdA37IPXIJPX5Fs7Stq
 HYl0gkE+ghaDD4Tat+I85Urwgj6wET1aJg5M9TMVWb/lBFwj8YsU9s/7W9wWas2aV6SoR18Dq
 i/iVm3KE2/YEEkHRl+1SZ4/TCnTr7BcgEcR/WlaQR6sMbNBi/EQVhUxOtysedssPlCVw2VhAB
 Llnc1R9gZREtqn+9kyxlJuyWkB3GneI9rt/4ZeAIPEzL2rvWkEwKCKY0Dl5XIdl2pCb0WsTEF
 cW3H68V+EcKkF4UVrTCghzeP7J4t+E/YZzaCzvfQgsj5XC8DXPKnq7JU+dXWr9xXXZAWm0keD
 tVCP2HQ3uZEFZ8hnap2laysR6YYc3J7cPIn3zoyRXaXBiTFcKj93ouy9AWsyrN3uc/DYNF6zq
 EWLSHA0OjwzGAbdtDcCvcVULqAZrT1ROiJxCDop7yJAFviMB4kBneHh5lYeoDmY0T6ExZByVO
 Gd4g7qZkuhvMZD4VMqO62UHSEYyHDwr7rwIVhusmJywn5y33faj0co/aXqGRqPhhYiX8goicm
 L6CE3D3y5Ls4BidzEMqS0k2KwZUSEg9DyNoHyTUfupPWUG/6lembcRPQZvBBBAgV6p25OsURN
 wJM5BpTvbnWIc0mnoE7B/E8he8Yk05S833k5EUlT0pPjEaBf5Wioglf1DBSvmBpoPEZpijor 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284929>

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
index f37f8d5..fbe69b8 100644
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
