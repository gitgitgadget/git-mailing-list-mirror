From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 07/19] mingw: let lstat() fail with errno == ENOTDIR when
 appropriate
Date: Tue, 26 Jan 2016 15:34:52 +0100 (CET)
Message-ID: <f71e8b4ea2fbd1d4f28423d7ebab5f396c1db068.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4hy-0004XC-0e
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966283AbcAZOe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:34:59 -0500
Received: from mout.gmx.net ([212.227.17.20]:56317 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966135AbcAZOez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MPppG-1aRwas3TZy-0052SH; Tue, 26 Jan 2016 15:34:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mImFiaOy+Ms9KnHrkVDzJf86brd1sewH5ofmdPSezQ10Cc7ZF39
 PFZGHao1hBpna3YF1etpMuPtpK+E9HGNtkMC7bSH9Ixb0SmT1iYo0DdLiJ3k9yohIcMKpYR
 AXmIMZQSqkQ5YX8zn2oUuO0VRFRbWEOsUaacUbzrNxsOKsMbUkJ1o8L4nb9C2u6Jtu+9bMW
 ii9AtFJSu7cUGx/Dg/Zkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kFIbENr9r8s=:zoUYSmh8hAtetTFQeDvOl0
 SdIGj8/vbqNWDktMZeZyOdQUDWWVqaaddeobsprzosDjJK5Dw39YMaDNRT+O5XaKQEAnbuSeD
 zwHGh3EnpgL+IxxrbGsfFZdY/FXkhv3ODOaNHItiYe9R8rat+UvBoy7iEkdTX26PVRVFUAYoF
 a9qmi9ig4XV+nmiOZFyebxR6LyhvXfEu2i7u3kJ6Syt0us10yt8kbldjV2IHv0rILICP9uEG0
 GJ91H8w/a0AL99nQMrHxqhxBme8f0eIQGzSD8METIV1z97fCUgTRcOhfr4xAV1OVXiUhlsWzP
 48HhNXliDUMt4gg+UZVNdbV9Wqd85iRNHHHFniZ6M2QAF3nag2QpsJTZGCtFexcD3uCLt2bh+
 ejMeL1ilkXTRfsSzcJCvLMhzG7fOg16TjzJKiMFl5tGrxz+ZkRJAG1AeUl6c2X2nSYXQSeMTr
 r4Gu4y/dsnzCk8uO2tFOtpvYlXvA0npVUlsZwgE5/48Plz6ak/VifPczc6iWsP+3qH9AhWZnA
 9mFA+mcvToAtYPReYNWnDNgfN52IEZ94/6aivxmUtPuqLzIB7gPEwK8qlio6JcfOmZFQP/BxL
 /owDcPYXALaw+wgEOkFQ0cq6PVeKN8i7wrm1/oOJa8UQ7LjtSe1uadh2p8KxMWkPGaPAgoL2q
 OcXx2kWppmycRNKAHWew93GultcNuQVxbg8n+rpKybAd40CiDUerG+YgiqiYe9jBsD5JV+P4A
 3UL9wXCMxgL7l/Y5PBIigkty+aN4Ayvnr2U5rw8GhXmr4rVjkJ01mU8OnMK4rqfDsX3VhU3g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284820>

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
index 11b905d..f7acb7f 100644
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
