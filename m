From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 06/39] rollback_lock_file(): set fd to -1
Date: Fri, 26 Sep 2014 12:08:06 +0200
Message-ID: <1411726119-31598-7-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:10:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSUG-000599-41
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329AbaIZKKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:10:46 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53323 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755357AbaIZKJB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:01 -0400
X-AuditID: 1207440e-f79da6d0000002fc-23-54253b3c383f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 89.49.00764.C3B35245; Fri, 26 Sep 2014 06:09:00 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLp013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:59 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1LWxVg0xWLTb0qLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozfx68zFvxjq2g6doipgfEmaxcj
	J4eEgInEocc9TBC2mMSFe+vZuhi5OIQELjNKLDy9DcrZxCTxuuMoG0gVm4CuxKKeZrAOEQE1
	iYlth1hAipgFFjNJTDi0CaxIWMBG4uLzRWBFLAKqEt8ungBbxyvgInFpPUSNhICcxIbd/xlB
	bE4BV4nG7dfAbCGgmpb1k1kmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrJebWaKX
	mlK6iRESjnw7GNvXyxxiFOBgVOLhvbFOJUSINbGsuDL3EKMkB5OSKO8XC9UQIb6k/JTKjMTi
	jPii0pzU4kOMEhzMSiK8d4yAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZ
	Dg4lCd4iK6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFB0xBcD4wMkxQO01wOk
	nbe4IDEXKArReorRmKOl6W0vE8e6zm/9TEIsefl5qVLivEcsgUoFQEozSvPgFsES0StGcaC/
	hXl9QQbyAJMY3LxXQKuYgFYpHVEGWVWSiJCSamCcEvz2bE5Zl4DpE1H/Oq9vk6//DvsvmPHs
	1r+Kz7ZvzTda/nzmoDU5+cbni5d9BO9pn3/JrWygkTPvoEPeQi6bqxf+/AlW2WbV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257527>

When rolling back the lockfile, call close_lock_file() so that the
lock_file's fd field gets set back to -1. This keeps the lock_file
object in a valid state, which is important because these objects are
allowed to be reused. It also makes it unnecessary to check whether
the file has already been closed, because close_lock_file() takes care
of that.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index e55149a..3df1e83 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -279,8 +279,7 @@ void rollback_lock_file(struct lock_file *lk)
 	if (!lk->filename[0])
 		return;
 
-	if (lk->fd >= 0)
-		close(lk->fd);
+	close_lock_file(lk);
 	unlink_or_warn(lk->filename);
 	lk->filename[0] = 0;
 }
-- 
2.1.0
