From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 19/38] commit_lock_file(): rollback lock file on failure to rename
Date: Wed,  1 Oct 2014 12:28:23 +0200
Message-ID: <1412159322-2622-20-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBK-0003EM-P0
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbaJAKaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:30:46 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:47487 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751602AbaJAK3X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:23 -0400
X-AuditID: 1207440c-f79036d000005e77-52-542bd782665a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.58.24183.287DB245; Wed,  1 Oct 2014 06:29:22 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6I026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:20 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1G26rh1i0HJf1KLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7oyPPdMZC86yVdz88Y2lgXEZaxcj
	J4eEgInEvZbbLBC2mMSFe+vZuhi5OIQELjNKXH18hRnCOc4k8X/Ha2aQKjYBXYlFPc1MILaI
	gJrExLZDLCBFzAKLmSQmHNoE1M7BISwQKnHtiSJIDYuAqsSDNe/BtvEKuEjcevgcarOcxIbd
	/xlBbE6g+PLLzWBXCAk4S+y485VpAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5
	mSV6qSmlmxghwcizg/HbOplDjAIcjEo8vAoJ2iFCrIllxZW5hxglOZiURHkXXQIK8SXlp1Rm
	JBZnxBeV5qQWH2KU4GBWEuHNPgCU401JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2C
	ycpwcChJ8DJcA2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VGfDEwOkBSPEB7
	nUHaeYsLEnOBohCtpxiNOVqa3vYycazr/NbPJMSSl5+XKiXOG3oVqFQApDSjNA9uESwNvWIU
	B/pbmDccZCAPMIXBzXsFtIoJaFXyGrBVJYkIKakGxujZT4JNTr6c4fRZV6/BbFt/tn2F4GHO
	9c8VvdvY5ZZoerUyTVy4q+n0tUUJTmVhL/1/8wff3FP0a+HioD3n/3GHhKZcOal7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257730>

If rename() fails, call rollback_lock_file() to delete the lock file
(in case it is still present) and reset the filename field to the
empty string so that the lockfile object is left in a valid state.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lockfile.c b/lockfile.c
index 1d18c67..728ce49 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -318,8 +318,13 @@ int commit_lock_file(struct lock_file *lk)
 	/* remove ".lock": */
 	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
 
-	if (rename(lk->filename, result_file))
+	if (rename(lk->filename, result_file)) {
+		int save_errno = errno;
+		rollback_lock_file(lk);
+		errno = save_errno;
 		return -1;
+	}
+
 	lk->filename[0] = 0;
 	return 0;
 }
-- 
2.1.0
