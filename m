From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 17/38] commit_lock_file(): die() if called for unlocked lockfile object
Date: Wed,  1 Oct 2014 12:28:21 +0200
Message-ID: <1412159322-2622-18-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHA1-0002cy-3c
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbaJAK3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:23 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58232 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579AbaJAK3T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:19 -0400
X-AuditID: 1207440e-f79da6d0000002fc-b5-542bd77e1b64
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 84.F9.00764.E77DB245; Wed,  1 Oct 2014 06:29:18 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6G026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:17 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1K27rh1i0HDfxqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyPq2ezFXTyVLR/3MTUwPiKs4uR
	g0NCwETizhPXLkZOIFNM4sK99WxdjFwcQgKXGSXmd69ggnCOM0n0NW5gBaliE9CVWNTTzARi
	iwioSUxsO8QCUsQssJhJYsKhTWwgCWGBKImN106xgNgsAqoSM45MAYvzCrhIHDv7gxVinZzE
	ht3/GUFsTqD48svNYPVCAs4SO+58ZZrAyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6x
	Xm5miV5qSukmRkgw8u1gbF8vc4hRgINRiYdXIUE7RIg1say4MvcQoyQHk5Io76JLQCG+pPyU
	yozE4oz4otKc1OJDjBIczEoivNkHgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQlehmtAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGg2IgvBkYHSIoH
	aK8zSDtvcUFiLlAUovUUoy7Hus5v/UxCLHn5ealS4ryZIEUCIEUZpXlwK2Cp5xWjONDHwrzS
	IFU8wLQFN+kV0BImoCXJa8CWlCQipKQaGAMnMU36IN+ys6jhWKGJs0/2nQ+qDG1fizuPmvyV
	8XmxdXVegm4QY6SIp0TNxLJi73Nhi5d8Wr6Nl+uwjhF/+vXKpDK1V/9zFyzMjXjq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257707>

It was previously a bug to call commit_lock_file() with a lock_file
object that was not active (an illegal access would happen within the
function).  It was presumably never done, but this would be an easy
programming error to overlook.  So before continuing, do a consistency
check that the lock_file object really is locked.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 3 ++-
 lockfile.c                               | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index 99830f3..6538610 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -147,7 +147,8 @@ commit_lock_file::
 	`hold_lock_file_for_append`, close the file descriptor and
 	rename the lockfile to its final destination. Return 0 upon
 	success or a negative value on failure to `close(2)` or
-	`rename(2)`.
+	`rename(2)`. It is a bug to call `commit_lock_file()` for a
+	`lock_file` object that is not currently locked.
 
 rollback_lock_file::
 
diff --git a/lockfile.c b/lockfile.c
index e148227..c897dd8 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -301,6 +301,9 @@ int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
 
+	if (!lk->filename[0])
+		die("BUG: attempt to commit unlocked object");
+
 	if (close_lock_file(lk))
 		return -1;
 
-- 
2.1.0
