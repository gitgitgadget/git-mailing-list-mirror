From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 22/32] git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
Date: Sat,  6 Sep 2014 09:50:36 +0200
Message-ID: <1409989846-22401-23-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:59:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAuZ-0005Mq-Iq
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbaIFH7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:59:51 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64346 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751408AbaIFH7u (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:59:50 -0400
X-AuditID: 12074412-f792e6d000005517-78-540abd3dbe76
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 60.9E.21783.D3DBA045; Sat,  6 Sep 2014 03:52:29 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHL006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:28 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqGu7lyvEYM4nJYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujJ5G1oIVXBWNLzkbGNs4uhg5OSQETCTmXulghLDFJC7cW8/WxcjF
	ISRwmVFi6eFXrBDOMSaJptd7mUCq2AR0JRb1NDOBJEQE2hgldl3czAqSYBZIkeh43g02Slgg
	XuLv4w1gDSwCqhKftxxjBrF5BVwlPn9+ywaxTk5iw+7/YPWcQPHpTZ1gtpCAi0T7yX6mCYy8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmKEhJnQDsb1J+UOMQpwMCrx
	8BY4cIUIsSaWFVfmHmKU5GBSEuXNWw4U4kvKT6nMSCzOiC8qzUktPsQowcGsJMLbMRkox5uS
	WFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkweuyB6hRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhQZ8cXA2ABJ8QDtZQVp5y0uSMwFikK0nmLU5VjX+a2fSYgl
	Lz8vVUqclwmkSACkKKM0D24FLKm8YhQH+liYVwykigeYkOAmvQJawgS0xDydE2RJSSJCSqqB
	sfeT2ddGvVdqYTuMvGKr5nP4Lbv65PdbiVnv5n6Nz/217abTCgEJluxLqhHJLi0THsztWbzQ
	ev2/eyyOM1z1thsbT7pvZfr27N07m2rUF27zr1xYl6Juq86i0u6e++ya6u1Nh6NO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256578>

After commit_lock_file() is called, then the lock_file object is
necessarily either committed or rolled back.  So there is no need to
call rollback_lock_file() again in either of these cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 config.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index a191328..24f0abb 100644
--- a/config.c
+++ b/config.c
@@ -1964,17 +1964,17 @@ int git_config_set_multivar_in_file(const char *config_filename,
 	if (commit_lock_file(lock) < 0) {
 		error("could not commit config file %s", config_filename);
 		ret = CONFIG_NO_WRITE;
-		goto out_free;
-	}
+	} else
+		ret = 0;
 
 	/*
-	 * lock is committed, so don't try to roll it back below.
-	 * NOTE: Since lockfile.c keeps a linked list of all created
-	 * lock_file structures, it isn't safe to free(lock).  It's
-	 * better to just leave it hanging around.
+	 * lock is committed or rolled back now, so there is no need
+	 * to roll it back below.  NOTE: Since lockfile.c keeps a
+	 * linked list of all created lock_file structures, it isn't
+	 * safe to free(lock).  We have to just leave it hanging
+	 * around.
 	 */
 	lock = NULL;
-	ret = 0;
 
 	/* Invalidate the config cache */
 	git_config_clear();
-- 
2.1.0
