From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 27/38] commit_lock_file(): use a strbuf to manage temporary space
Date: Wed,  1 Oct 2014 12:28:31 +0200
Message-ID: <1412159322-2622-28-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:29:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHAF-0002kF-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbaJAK3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47500 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751720AbaJAK3g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:36 -0400
X-AuditID: 1207440c-f79036d000005e77-64-542bd78f3c38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 10.68.24183.F87DB245; Wed,  1 Oct 2014 06:29:35 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6Q026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:34 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1O2/rh1isOG0tUXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bk9uy+wFSzhrNg1fyVzA+M59i5G
	Tg4JAROJ1wt+M0PYYhIX7q1nA7GFBC4zSkyZ59rFyAVkH2eS2DhzM1gRm4CuxKKeZiYQW0RA
	TWJi2yEWkCJmgcVMEhMObQLrFhYIkZi1fiUjiM0ioCqxc+UNsDivgIvEykk9jBDb5CQ27P4P
	ZnMCxZdfbmaB2OwssePOV6YJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluil
	ppRuYoQEI88Oxm/rZA4xCnAwKvHwKiRohwixJpYVV+YeYpTkYFIS5V10CSjEl5SfUpmRWJwR
	X1Sak1p8iFGCg1lJhDf7AFCONyWxsiq1KB8mJc3BoiTOq7pE3U9IID2xJDU7NbUgtQgmK8PB
	oSTBO+UaUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDbii4HRAZLiAdq7E6Sd
	t7ggMRcoCtF6ilGXY13nt34mIZa8/LxUKXHeTJAiAZCijNI8uBWw1POKURzoY2HeCyBVPMC0
	BTfpFdASJqAlyWvAlpQkIqSkGhhzZdfLvtvsFFDxpeD0poUOz4/+VZn2UM96WtAScd7I6Npt
	1xeovzpZavPkJF/TJI5qrg+79aZo370vsDPgTr7gnkajy/+nZ+2eHTlP4/7fM0vn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257714>

Avoid relying on the filename length restrictions that are currently
checked by lock_file().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 89043f5..1dd118f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -319,7 +319,8 @@ int reopen_lock_file(struct lock_file *lk)
 
 int commit_lock_file(struct lock_file *lk)
 {
-	char result_file[PATH_MAX];
+	static struct strbuf result_file = STRBUF_INIT;
+	int err;
 
 	if (!lk->active)
 		die("BUG: attempt to commit unlocked object");
@@ -327,11 +328,12 @@ int commit_lock_file(struct lock_file *lk)
 	if (close_lock_file(lk))
 		return -1;
 
-	strcpy(result_file, lk->filename);
 	/* remove ".lock": */
-	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
-
-	if (rename(lk->filename, result_file)) {
+	strbuf_add(&result_file, lk->filename,
+		   strlen(lk->filename) - LOCK_SUFFIX_LEN);
+	err = rename(lk->filename, result_file.buf);
+	strbuf_reset(&result_file);
+	if (err) {
 		int save_errno = errno;
 		rollback_lock_file(lk);
 		errno = save_errno;
-- 
2.1.0
