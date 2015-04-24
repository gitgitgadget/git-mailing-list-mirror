From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] write_ref_to_lockfile(): new function, extracted from write_ref_sha1()
Date: Fri, 24 Apr 2015 13:35:45 +0200
Message-ID: <1429875349-29736-2-git-send-email-mhagger@alum.mit.edu>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 13:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylbtz-0004FB-OR
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 13:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbbDXLgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 07:36:01 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56412 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755038AbbDXLgA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2015 07:36:00 -0400
X-AuditID: 12074412-f79e46d0000036b4-2b-553a2a9f2d72
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 22.DF.14004.F9A2A355; Fri, 24 Apr 2015 07:35:59 -0400 (EDT)
Received: from michael.fritz.box (p4FC973EF.dip0.t-ipconnect.de [79.201.115.239])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3OBZt8X008846
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 24 Apr 2015 07:35:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqDtfyyrUYPdKBYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ/xZdIq94BF3xaQlHxgbGLdwdjFyckgImEj82n6BDcIWk7hwbz2QzcUhJHCZUWLivWdQ
	zkkmiY8TV7KAVLEJ6Eos6mlm6mLk4BAR8JJom1kMEmYWSJHoeN7NCGILC0RLfG0+DFbOIqAq
	cfbSbnYQm1fAReLwhu1Qy+Qkzh//yQxicwq4SvQv/whWLwRUs2bTB/YJjLwLGBlWMcol5pTm
	6uYmZuYUpybrFicn5uWlFuma6eVmluilppRuYoQElNAOxvUn5Q4xCnAwKvHwzphjGSrEmlhW
	XJl7iFGSg0lJlLdTyipUiC8pP6UyI7E4I76oNCe1+BCjBAezkghvohBQjjclsbIqtSgfJiXN
	waIkzvtzsbqfkEB6YklqdmpqQWoRTFaGg0NJgpdbE6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4
	NS8ltSixtCQjHhQZ8cXA2ABJ8QDttQFp5y0uSMwFikK0nmJUlBLn9QFJCIAkMkrz4MbC0sQr
	RnGgL4V500CqeIApBq77FdBgJqDBM5dagAwuSURISTUwzuXIfNbnWuplU/cumU9sq72E+cp7
	mxfkve+b832p/+lm7ctvE8N3rrbrXs395uXuE+XFk01OiM2csFc+rfoYq6Ds/9V1/7rn93a+
	2L7Ai/2+8pbAxh0XAywWmjP2yJxImRGkcWeHnc35/cev2D4SyzvuWdBRMnd+iJBX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267731>

This is the first step towards separating the checking and writing of
the new reference value to committing the change.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 4f495bd..72dae21 100644
--- a/refs.c
+++ b/refs.c
@@ -3017,11 +3017,10 @@ int is_branch(const char *refname)
 }
 
 /*
- * Write sha1 into the ref specified by the lock. Make sure that errno
- * is sane on error.
+ * Write sha1 into the open lockfile, then close the lockfile. On
+ * errors, rollback the lockfile and set errno to reflect the problem.
  */
-static int write_ref_sha1(struct ref_lock *lock,
-	const unsigned char *sha1, const char *logmsg)
+static int write_ref_to_lockfile(struct ref_lock *lock, const unsigned char *sha1)
 {
 	static char term = '\n';
 	struct object *o;
@@ -3050,6 +3049,19 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = save_errno;
 		return -1;
 	}
+	return 0;
+}
+
+/*
+ * Write sha1 into the ref specified by the lock. Make sure that errno
+ * is sane on error.
+ */
+static int write_ref_sha1(struct ref_lock *lock,
+	const unsigned char *sha1, const char *logmsg)
+{
+	if (write_ref_to_lockfile(lock, sha1))
+		return -1;
+
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-- 
2.1.4
