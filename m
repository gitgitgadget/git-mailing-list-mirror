From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 05/20] mingw: prepare the TMPDIR environment variable for
 shell scripts
Date: Wed, 27 Jan 2016 17:19:25 +0100 (CET)
Message-ID: <99caadcf6af5619988792b47b50d70b691d355c3.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSok-00026R-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700AbcA0QTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:60336 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476AbcA0QTc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:32 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfVzj-1aj1hk0mVP-00P6PY; Wed, 27 Jan 2016 17:19:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:etLd4AP2QbZMFwlDusTKYoQi+le0s8OBB0H8AWZdYgb96cBBn2z
 qGnjyaAuE+ez1jACR3Z3MKbR7umlQDOxOrOgeGhqn3+C62ofQsMw52k8E30NDaC55qd4jeb
 rNs89nzScwkG/Rncjcu+3/cHMd7MqtRoEaQZTUHrJAJhfvvEpVmaNb43zxXA9YtpAtr/4OJ
 kp6ceiI/uZB5R49JpdXoQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EFFQyS5GU3I=:fAhHgHEo+TdtjF4nrsd8xp
 2aaa4tabQ5ZMxyfz5aVI/UkxTM74a3XInbD/EAvxYTcAlgNQ7v+7EfS84TmgWOLkMlVBIZfh0
 U/Tk3sfXSJXHn8eLIN/irHJxPznVD0XIw6K4b8jQBd5x5kTKBmnDMvX/YtVNrLKok4qlxwZdd
 jh14B8gU7T1M8dd0Z2A6GSOvfL7P4jwfCYkHFEhhq8Z/0RmPT6RtZR5WdkWt7EZxYqIVNEVox
 RTnMK5LTU4nehFQ8nzZL2dDDpCkEWfqDIjeLxRjkKi6ZpJGbuxj5o8NwqOoBIHI/sIf0W2XBl
 n0ueLgyNOn1uvvPQZSaxpTW9L7O8upSdAHq5KEPNaH0MzDTh32dA8m5MnrYz+Ck9TgbIaV6Xc
 TO5qIvtqbN5/A+mvP83pBa2z+2KlrSHDaZY84nc/C8AA5JEI+/0yrv4KRzQZmWQySm6/zyUvb
 YvzsacfldUBOgVjcg0/wCetCgNSBuHYPMDZHHEFknwS4btEel0Q0XykIzId9l2etyRjPgPQRw
 Xf2AIQdvVDULFfCHtKhXBbOZVFxkOmEKcT/ohTgOYTwtCnRBSesvDFgnbUjaNW52+jjg6XWy3
 1BsrTpr8kfAT7Xa+SLwHqtYB7xYX5fhlhRSwuY+lukYRwtnsrlWKpY8/SXg8AtntFoP/dLhFR
 ralrZaIpHsttALnyNa0umqdagezZhlpYmzpotXYnYkwaiMCKNiDsjjl9nEpHLIT7ndMaw6KPm
 yKLjSpyTpsUkZ1FuXuEivVJGX72PI1C0KPmoMZOY0hlIjxi1KkwyOsFYVoFaqmz71bbthAGs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284924>

When shell scripts access a $TMPDIR variable containing backslashes,
they will be mistaken for escape characters. Let's not let that happen
by converting them to forward slashes.

This partially fixes t7800 with MSYS2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8d52c73..ba5cb1c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2049,13 +2049,28 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 
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
