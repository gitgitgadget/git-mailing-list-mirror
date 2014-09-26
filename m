From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 08/39] hold_lock_file_for_append(): release lock on errors
Date: Fri, 26 Sep 2014 12:08:08 +0200
Message-ID: <1411726119-31598-9-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:16:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSZT-00026V-UX
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756497AbaIZKQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:08 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49185 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756494AbaIZKQH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:07 -0400
X-AuditID: 12074411-f79d86d000006a97-ed-54253b40df74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id A3.1D.27287.04B35245; Fri, 26 Sep 2014 06:09:04 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLr013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:02 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1HWwVg0xWLWJx6LrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oz13y8yFexlr1j6q429gfELaxcj
	J4eEgInE5YX7GSFsMYkL99azdTFycQgJXGaUuPKmgR3C2cQkcbLhFhtIFZuArsSinmYmEFtE
	QE1iYtshFpAiZoHFTBITDm0CKxIW8JV4fLeTBcRmEVCV+HPtANgKXgEXiSVvTjFBrJOT2LD7
	P1icU8BVonH7NTBbCKimZf1klgmMvAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrq5WaW
	6KWmlG5ihISj4A7GGSflDjEKcDAq8fDeWKcSIsSaWFZcmXuIUZKDSUmU94uFaogQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd47RkA53pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKY
	rAwHh5IEb5EVUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDrii4HxAZLiAdrb
	DtLOW1yQmAsUhWg9xWjM0dL0tpeJY13nt34mIZa8/LxUKXHeI5ZApQIgpRmleXCLYInoFaM4
	0N/CvL4gA3mASQxu3iugVUxAq5SOKIOsKklESEk1MGZ8llqrt23fA5cbz/ReyoTxaG49pXnh
	xA55m8aD6l6/2hysblx5Enjf7dWF2Xd7KtVDL+2wP2S9/IrBt/Z5R2eILC1fvpjj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257529>

If there is an error copying the old contents to the lockfile, roll
back the lockfile before exiting so that the lockfile is not held
until process cleanup.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index d74de8d..f4ce79b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -219,13 +219,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 		if (errno != ENOENT) {
 			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
-			close(fd);
+			rollback_lock_file(lk);
 			return error("cannot open '%s' for copying", path);
 		}
 	} else if (copy_fd(orig_fd, fd)) {
 		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
-		close(fd);
+		rollback_lock_file(lk);
 		return -1;
 	}
 	return fd;
-- 
2.1.0
