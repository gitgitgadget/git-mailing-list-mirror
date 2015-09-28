From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Fix "inside work tree" detection on case-insensitive
 filesystems
Date: Mon, 28 Sep 2015 18:12:18 +0200
Organization: gmx
Message-ID: <ac9733a6b922572ec10f09f89e07cde37ba43f13.1443456630.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 18:12:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zgb2U-0000wH-J2
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 18:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933922AbbI1QM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 12:12:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:62765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933850AbbI1QMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 12:12:25 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Ma1pn-1ZxIwW0spT-00LodS; Mon, 28 Sep 2015 18:12:19
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:PpQl5NGttMDuWvLcv1jljs+qI8hK5tLPVVnORoDyCt5AEN4JAfa
 YBr6TYOL3Xc/mSjCsbBoW5HIXDt8EhJyNoRThrQjRJO9ke2kGm9QGDEEU25uVLzvIehydFh
 NkANnpOxfbszyOJEgnAjJUPxSKdeOnDsQIEefgJe0Vx0vk6EHFn6GZCKjvL17QcJf8RPEm7
 uJqtBR7HBPWslbHCuKlGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t+gWngx0fpE=:XODM2SqtMkEPNtXPX7frlS
 3+Jpd6Kgqhcwbk7xIr2hy9wzC9GLica//x7ipboBE0m4pBnasnyxzd9qAXv1ACh21av2GaKsf
 6NxS2M6eDUvHULJnrigvbeCMOMOSoI3Rj29MmrTfnJU+FW442zI2rRsMzxAQWTK1TUGaUnRCV
 XkLPmRBZXct96XPgEmtl62Zk93mb9qh7Uh0FFdJizB2wuCY2vWDu8b1mAOaP+OEQYRqYJWUoy
 I7haq7OliMeVyMLAXvLMaoWcM8okKMOkmttqN4Nk8+61LWE+ePpa6SBYo5XmBb2mKrtEVRZxv
 6q8UML7JFdVO8JQG+XT7HJc3ZwChfy8EmVI/irqJTU3OeLlgBhv3pf2yFe6dS+z8Ah7Wr7bb9
 EJkXtYfDaEPu6fZ/F6PbQMhr8DfXZfdfSI6BNrGY7EnHQb6WJ7CEZIC6pE9decjteV9yWqC69
 r4pRmn8SipRXb89FPM9yjxkMMAd3Zqp0u3xCxj2RP5KVkG8Zd++nFXw6/Gz4MNdV/NW89J4pa
 F4erZE9MLAfTckgsVDxbrb3TmZpMOaHvTVVroWwoOkBxS8Ibbbx+sCST5Mxi+4lwxZqiTroZU
 YR3QtX90vCkBw0DsGRRTg9zjuv1WX+U+PU3EB7pcq3TIwcv/Xd4lgdwSr5cqw/0JT3sfFGOKU
 oZFQRHctWgYSgtpk/Z5pgum5LOdC7zrZ4Jj+3zpXzppjYx4lTmAJJwbDDuFY6/YArw3uo6tgh
 AS7Vpacb46si1KRuaUbhzr+2+FaISRybdwl+9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278729>

Git has a config variable to indicate that it is operating on a file
system that is case-insensitive: core.ignoreCase. But the
`dir_inside_of()` function did not respect that. As a result, if Git's
idea of the current working directory disagreed in its upper/lower case
with the `GIT_WORK_TREE` variable (e.g. `C:\test` vs `c:\test`) the
user would be greeted by the error message

	fatal: git-am cannot be used without a working tree.

when trying to run a rebase.

This fixes https://github.com/git-for-windows/git/issues/402 (reported by
Daniel Harding).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index b90484a..fba938b 100644
--- a/dir.c
+++ b/dir.c
@@ -2107,6 +2107,15 @@ int file_exists(const char *f)
 	return lstat(f, &sb) == 0;
 }
 
+static int cmp_icase(char a, char b)
+{
+	if (a == b)
+		return 0;
+	if (ignore_case)
+		return toupper(a) - toupper(b);
+	return a - b;
+}
+
 /*
  * Given two normalized paths (a trailing slash is ok), if subdir is
  * outside dir, return -1.  Otherwise return the offset in subdir that
@@ -2118,7 +2127,7 @@ int dir_inside_of(const char *subdir, const char *dir)
 
 	assert(dir && subdir && *dir && *subdir);
 
-	while (*dir && *subdir && *dir == *subdir) {
+	while (*dir && *subdir && !cmp_icase(*dir, *subdir)) {
 		dir++;
 		subdir++;
 		offset++;
-- 
2.5.3.windows.1.3.gc322723
