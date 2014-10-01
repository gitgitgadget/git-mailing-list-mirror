From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 05/38] rollback_lock_file(): exit early if lock is not active
Date: Wed,  1 Oct 2014 12:28:09 +0200
Message-ID: <1412159322-2622-6-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBX-0003Kl-DO
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbaJAK3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:07 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52435 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399AbaJAK3D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:03 -0400
X-AuditID: 1207440d-f797f6d000000a4a-9a-542bd76a3fbc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 88.A3.02634.A67DB245; Wed,  1 Oct 2014 06:28:58 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk64026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:28:57 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1M26rh1i0HxT1aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyrXScZC1azVXx58525gXE6axcj
	B4eEgInEgWUqXYycQKaYxIV769m6GLk4hAQuM0os33CEHcI5ziSx6dYHdpAqNgFdiUU9zUwg
	toiAmsTEtkMsIEXMAouZJCYc2sQGkhAWCJA4OOEhWBGLgKrEhx33GUFsXgFniTWz17FBrJOT
	2LD7P1icU8BFYvnlZhYQWwioZsedr0wTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI1
	0svNLNFLTSndxAgJRt4djP/XyRxiFOBgVOLhVUjQDhFiTSwrrsw9xCjJwaQkyrvoElCILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCG/2AaAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampB
	ahFMVoaDQ0mCl+EaUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDbii4HRAZLi
	AdrrDNLOW1yQmAsUhWg9xWjM0dL0tpeJY13nt34mIZa8/LxUKXHe0KtApQIgpRmleXCLYGno
	FaM40N/CvNIgA3mAKQxu3iugVUxAq5LXgK0qSURISTUwJrqHVDzb8qeuoE64RST9mRqHpK6x
	HfNElfsnJnKlL7gT/ODahJkyh49duTrj1lO3s3uYz7pOdZuem6J7R9P9qHeLU1n9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257733>

Eliminate a layer of nesting.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 5330d6a..e55149a 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -276,10 +276,11 @@ int hold_locked_index(struct lock_file *lk, int die_on_error)
 
 void rollback_lock_file(struct lock_file *lk)
 {
-	if (lk->filename[0]) {
-		if (lk->fd >= 0)
-			close(lk->fd);
-		unlink_or_warn(lk->filename);
-		lk->filename[0] = 0;
-	}
+	if (!lk->filename[0])
+		return;
+
+	if (lk->fd >= 0)
+		close(lk->fd);
+	unlink_or_warn(lk->filename);
+	lk->filename[0] = 0;
 }
-- 
2.1.0
