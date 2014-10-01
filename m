From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 07/38] lockfile: unlock file if lockfile permissions cannot be adjusted
Date: Wed,  1 Oct 2014 12:28:11 +0200
Message-ID: <1412159322-2622-8-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBe-0003OC-MC
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbaJAK3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:29:05 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:52435 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751428AbaJAK3E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:04 -0400
X-AuditID: 1207440d-f797f6d000000a4a-9f-542bd76e892b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 19.A3.02634.E67DB245; Wed,  1 Oct 2014 06:29:02 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk66026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:00 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1M27rh1iMKeL2aLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ozW88dYCnaxV+zes46tgfEHaxcj
	J4eEgInEigfrmCFsMYkL99azdTFycQgJXGaU+LhsAZRznEniW9sFRpAqNgFdiUU9zUwgtoiA
	msTEtkMsIEXMAouZJCYc2sQGkhAWiJLYfOs5UIKDg0VAVeLL7RqQMK+As8TrvjcsENvkJDbs
	/g82k1PARWL55WawuBBQzY47X5kmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJeb
	WaKXmlK6iRESjLw7GP+vkznEKMDBqMTDq5CgHSLEmlhWXJl7iFGSg0lJlHfRJaAQX1J+SmVG
	YnFGfFFpTmrxIUYJDmYlEd7sA0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKY
	rAwHh5IEL8M1oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGzEFwOjAyTFA7TX
	GaSdt7ggMRcoCtF6itGYo6XpbS8Tx7rOb/1MQix5+XmpUuK8oVeBSgVASjNK8+AWwdLQK0Zx
	oL+FeaVBBvIAUxjcvFdAq5iAViWvAVtVkoiQkmpgbHbnOGvrv0u/uIk1du7hUyWhebNT+SJ3
	//mQe+Azc+B0vuwQ/1kvHso4HWgMyXsQvSguw2SWNN8zpoTfzVwfbxX5+LE9yIhT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257737>

If the call to adjust_shared_perm() fails, lock_file returns -1, which
to the caller looks like any other failure to lock the file.  So in
this case, roll back the lockfile before returning so that the lock
file is deleted immediately and the lockfile object is left in a
predictable state (namely, unlocked).  Previously, the lockfile was
retained until process cleanup in this situation.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lockfile.c b/lockfile.c
index 3df1e83..d74de8d 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -153,6 +153,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			int save_errno = errno;
 			error("cannot fix permission bits on %s",
 			      lk->filename);
+			rollback_lock_file(lk);
 			errno = save_errno;
 			return -1;
 		}
-- 
2.1.0
