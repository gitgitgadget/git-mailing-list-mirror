From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 18/39] commit_lock_file(): die() if called for unlocked lockfile object
Date: Fri, 26 Sep 2014 12:08:18 +0200
Message-ID: <1411726119-31598-19-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSaA-0002oT-HQ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527AbaIZKQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:16:55 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49188 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755865AbaIZKQw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:16:52 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Sep 2014 06:16:52 EDT
X-AuditID: 12074411-f79d86d000006a97-05-54253b500af1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 16.1D.27287.05B35245; Fri, 26 Sep 2014 06:09:20 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lM3013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:18 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42IRYndR1A2wVg0xuNHLZ9F1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd8bsrzwFnTwVF7b7NjC+4uxi5OSQ
	EDCRuLtyHyOELSZx4d56ti5GLg4hgcuMEtO/dDJCOJuYJNrubWMHqWIT0JVY1NPMBGKLCKhJ
	TGw7xAJSxCywmEliwqFNQO0cHMICURIdv+pAalgEVCX+71sBVs8r4Cpx5E4vE8Q2OYkNu/+D
	beYEijduvwZmCwm4SLSsn8wygZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK9
	1JTSTYyQQBTcwTjjpNwhRgEORiUe3hvrVEKEWBPLiitzDzFKcjApifJ+sVANEeJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTCe8cIKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV
	4eBQkuAtsgJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFRXwxMDJAUjxAe9tB
	2nmLCxJzgaIQracYdTnWdX7rZxJiycvPS5US5z1iCVQkAFKUUZoHtwKWdl4xigN9LMzrCzKK
	B5iy4Ca9AlrCBLRE6YgyyJKSRISUVANj76Nnc6tTz3wo8logWJnzoafdt3rvXt9i86T5fgax
	xsUbzb7mHjzvIn43fWl16KR5BxgWvbn1TvmsgEl4rKxe29pt/n5vz9u+zQoJ4HOb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257535>

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
index c14fca5..0f81e53 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -146,7 +146,8 @@ commit_lock_file::
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
