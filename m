From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 05/19] mingw: prepare the TMPDIR environment variable for
 shell scripts
Date: Sun, 24 Jan 2016 16:43:37 +0100 (CET)
Message-ID: <80795bee09974f4bec6bda75fe9cb17a4326bed1.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMpl-0000eT-FT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbcAXPoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:44:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:58610 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbcAXPnn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:43:43 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LmfKJ-1ZorHt2yqB-00aB16; Sun, 24 Jan 2016 16:43:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:TekTcDHzCnVGcXiuc66eDCtBgTKaICc9d0/246bkTNLWi8TDIDU
 yHAy7PLAuHLNVzA+zdei/Wupkm4DkvrDoednlXeWOzCTu1H9rtITGAfF9GRULLSeG+ec920
 qCa8TEVUhVXRF/m0iMV4BLJRxsn7t6Y4quAhE6C+JBMhEz0owfA0NwYMUvVxl98mrJmjgG0
 lOu3edHXEkHxsjIp9Xyeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lhSOWQNe86E=:/XHQWA2u/yY9RXY2ZcBw6R
 /tvXfwYrzUUu8MRlCAI1pwqrr5cBZz+rLf0K0h5MPqU32PyNFycvOuCU0R/EJmtqz6VpS4elh
 XkD/G22f1nkp1iamfswlYkG3NZNat1YvOncIQdV2PwL4wqW8jwmxfqS9XGzuskCpyofhoiFXY
 jusR5FTstN5HNqo7Wt5y2Rf5L0c66I6qc5HOLS2+ngJ7YczfphNQLA+0Ew58t4uqJ3Hrg/j3Y
 53z1k9B5tJ9OXka5Jw/VtkL1KiC69T1+1ZootLKaC4wXJwpC2hsLF2mf+okO0aCcS/EHpT13w
 MPqrUilsBFcNrkuYwZak+HcPDj6cD/2ZOFjujtA9eICdZBjrqzzHh8cT7ywck70NVoJAb85wr
 9aE5LREvlNNVV0k9dgEAQ8VehaRhUrgYfOq8XvqMdjof0mK0kWE7LLtlCW23f0E/VM6NvItSV
 zJWvrQtjxnYaT+XQskQsHbR9YcYFVY2wZIEJeIw82/Ezl/vaCoTCvGYebx9WdULUB4b91DQuB
 1jmDvWgmU0qSJFAA5TKencYhnVw0yvGE4hRrvWHJNeuepU16UIvDg9YcZKcFMSrjus275mZZB
 3d7gVQ+7zhi/R7OHp5M+QEpQe49cLE22j7W3/AVJkFLExo5KUMw3wthNXkmEJzj2siXhwr8Dq
 IUcrU1IY3zy+PZfpUjZDXj2Qy8W+ZXH5e4kzMYTngIDueR1ULRRQq6aJsy8kXVjK5f8gOFv3S
 LC36ooGzyEOk2Kkxj8EtCl4GhWJaT4rzdjsi0ClQHXAQTy7bFDnGq8GmTKHHwPjDE2pkj/dB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284669>

When shell scripts access a $TMPDIR variable containing backslashes,
they will be mistaken for escape characters. Let's not let that happen
by converting them to forward slashes.

This partially fixes t7800 with MSYS2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a12197e..db92f5d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2042,13 +2042,28 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 
 static void setup_windows_environment()
 {
+	char *tmp = getenv("TMPDIR");
+
 	/* on Windows it is TMP and TEMP */
-	if (!getenv("TMPDIR")) {
-		const char *tmp = getenv("TMP");
-		if (!tmp)
+	if (tmp) {
+		if (!(tmp = getenv("TMP")))
 			tmp = getenv("TEMP");
-		if (tmp)
+		if (tmp) {
 			setenv("TMPDIR", tmp, 1);
+			tmp = getenv("TMPDIR");
+		}
+	}
+
+	if (tmp) {
+		/*
+		 * Convert all dir separators to forward slashes,
+		 * to help shell commands called from the Git
+		 * executable (by not mistaking the dir separators
+		 * for escape characters).
+		 */
+		for (; *tmp; tmp++)
+			if (*tmp == '\\')
+				*tmp = '/';
 	}
 
 	/* simulate TERM to enable auto-color (see color.c) */
-- 
2.7.0.windows.1.7.g55a05c8
