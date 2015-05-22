From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] verify_lock(): return 0/-1 rather than struct ref_lock *
Date: Sat, 23 May 2015 01:34:53 +0200
Message-ID: <1432337697-29161-2-git-send-email-mhagger@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:35:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwTR-0003SR-6f
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757594AbbEVXfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:35:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50777 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328AbbEVXfN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 19:35:13 -0400
X-AuditID: 12074412-f79066d000000bc5-03-555fbd29f6db
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.D4.03013.92DBF555; Fri, 22 May 2015 19:35:05 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MNZ2Ps007402
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 19:35:04 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqKu5Nz7UYMlqeYuuK91MFg29V5gt
	bq+Yz2yxeXM7iwOLx9/3H5g8Fmwq9bh4Sdnj8ya5AJYobpukxJKy4Mz0PH27BO6MFaffMRdc
	EaiYP8u+gXExbxcjJ4eEgInEkzcrmCFsMYkL99azdTFycQgJXGaUaO7ZzAThnGCSmHVvBhNI
	FZuArsSinmYwW0RATWJi2yEWEJtZIFdiw75TQHEODmEBX4mlf+pBwiwCqhKLvz0DK+EVcJFY
	sOo9C8QyOYnzx3+CLeYUcJW4vbQPbKQQUE3v9m8sExh5FzAyrGKUS8wpzdXNTczMKU5N1i1O
	TszLSy3SNdPLzSzRS00p3cQICR2hHYzrT8odYhTgYFTi4e04HBcqxJpYVlyZe4hRkoNJSZR3
	1Yr4UCG+pPyUyozE4oz4otKc1OJDjBIczEoivGc3A+V4UxIrq1KL8mFS0hwsSuK8Pxer+wkJ
	pCeWpGanphakFsFkZTg4lCR4l+0GahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
	xUV8MTAyQFI8QHurQdp5iwsSc4GiEK2nGBWlxHk3gSQEQBIZpXlwY2EJ4RWjONCXwrzHQap4
	gMkErvsV0GAmoMGrJsSCDC5JREhJNTDOXyk4aYLXX57zJxz37ZLvFS3cE6t7Tq9W3HqukvmH
	zR3nvgZcFa9OqrHZ6ndB/LdQ87unsaZ6dfPP1Nr11T9RuX37WEtBrfGGclkv3zdc30zurCsp
	eywW4yLgyt0yQ3378uVNl3NN9B/ECZsm8hswzZdkUJ+ZnnrtRM2jrc3Rz+ecNtNv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269772>

Its return value wasn't conveying any extra information, but it made
the reader wonder whether the ref_lock that it returned might be
different than the one that was passed to it. So change the function
to the traditional "return 0 on success or a negative value on error".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 97043fd..4432bc9 100644
--- a/refs.c
+++ b/refs.c
@@ -2195,9 +2195,14 @@ static void unlock_ref(struct ref_lock *lock)
 	free(lock);
 }
 
-/* This function should make sure errno is meaningful on error */
-static struct ref_lock *verify_lock(struct ref_lock *lock,
-	const unsigned char *old_sha1, int mustexist)
+/*
+ * Verify that the reference locked by lock has the value old_sha1.
+ * Fail if the reference doesn't exist and mustexist is set. Return 0
+ * on success or a negative value on error. This function should make
+ * sure errno is meaningful on error.
+ */
+static int verify_lock(struct ref_lock *lock,
+		       const unsigned char *old_sha1, int mustexist)
 {
 	if (read_ref_full(lock->ref_name,
 			  mustexist ? RESOLVE_REF_READING : 0,
@@ -2206,16 +2211,16 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
 		errno = save_errno;
-		return NULL;
+		return -1;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
 		errno = EBUSY;
-		return NULL;
+		return -1;
 	}
-	return lock;
+	return 0;
 }
 
 static int remove_empty_directories(const char *file)
@@ -2445,7 +2450,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 	}
-	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
+	if (old_sha1 && verify_lock(lock, old_sha1, mustexist))
+		return NULL;
+	return lock;
 
  error_return:
 	unlock_ref(lock);
-- 
2.1.4
