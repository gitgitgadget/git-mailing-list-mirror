From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 05/19] mingw: prepare the TMPDIR environment variable for
 shell scripts
Date: Tue, 26 Jan 2016 15:34:43 +0100 (CET)
Message-ID: <909b0a41341813e8352a285501839a7b5e8fcec9.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4hw-0004XC-Rf
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966220AbcAZOev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:34:51 -0500
Received: from mout.gmx.net ([212.227.17.22]:57352 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966203AbcAZOer (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:47 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MhQju-1ajc061aaI-00McLk; Tue, 26 Jan 2016 15:34:44
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KE1yId0wi9+7LDVA+4T/gnKdrsfURwvcRxFiSYjZLvOvHVoxHuP
 TjhXjTOTfe8ZILMfpHm3l2CtaLUxitdFxebxoquI5WaDM5ArTmep/aFI6e2LHUGqwmLxBH4
 ffaVsVw+s8DbRut3GEL4j13BGpFDdPNql9R9Ufnf5PSaSYLUeL7HXYO7EXxtjFX6zE9jDO6
 VGGQ/hK3meMUyajeqaGPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Df2fcFTSF38=:1fCPS1ACJehYxk8ZNua3qh
 FW8bsWbOkVW/tQYZU19mQ69l29DX+xrXrzk8C0QrBWBCCevrOnEfUcj6KMQcfP++5xB5av9dT
 FJR8Az9IlTC6XheKpkalxA9Hj/BQifJW4U+4nGwtvkNfYbgSK3bJpvDAmJ+Nem+zN/doyBOuL
 tMufLXiG1uqvTaBcDUQEuZzIxmcLrCNEf0PXOypKq4Axu0UwGowrrty6N2upasIIoGxEqg34u
 bYXNc/soKLwAOFcAvaFvfG/Utltm1AJRNJInZbMjnSN3M4Dur2p1ydm2m4mGZvtDb/+ozQGTh
 bEDOtPsJ93WEUSuVD4u3Ve50kCmfX65FjGIaAT/FYgdk+Q4zni5Z49MCKFq0vN111k9XMQScM
 Ca5OoFMB88W7lKtZHXqBEHDZcL3fMYT0f7Hi/Z5iCGK7JPghkgynWebzua1scCzQUg+nlukB3
 ma7QW6Q0QzM2FBqJl/GqUrp/klYGMowUku5Rqrl6TfgJEOTxCXtkfIcIKXI+IB5G/orOfdkVf
 XQKHi3geffnbcUZUkXcfVeNfNkq1+p22aVoYj0rIh53DUz5zOLmFPoPlwiQXfcAAStftlzTeE
 JJCr/4F8G5gXszDuwE75XIDCRBDeIy9mAtNpbxvP4tGxWdglZejK9D4m5lZyaNyvWQpI7wC0V
 66Q8ZKkFeNqRtm6JBsSPBje51Q2rPXyTPmq9xwdlz89PjCU9ba1Cqy1UVwkpUGqhOk6qNunoW
 EBvBzIXGHKQ4FZ0TmZsd9I+xBZyBOdAYp8/vMN2VwBNBDD6hQ8qR6NQifaMmdxReWWoy1JkR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284819>

When shell scripts access a $TMPDIR variable containing backslashes,
they will be mistaken for escape characters. Let's not let that happen
by converting them to forward slashes.

This partially fixes t7800 with MSYS2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a12197e..ba6bdb5 100644
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
+	if (!tmp) {
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
