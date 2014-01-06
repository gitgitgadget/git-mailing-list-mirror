From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/17] lock_ref_sha1_basic(): if locking fails with ENOENT, retry
Date: Mon,  6 Jan 2014 14:45:29 +0100
Message-ID: <1389015935-21936-12-git-send-email-mhagger@alum.mit.edu>
References: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 14:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0AVr-00065n-Cw
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 14:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbaAFNqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 08:46:31 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45655 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754557AbaAFNq3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jan 2014 08:46:29 -0500
X-AuditID: 1207440f-b7f306d000006d99-2a-52cab3b46d31
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id C0.E2.28057.4B3BAC25; Mon,  6 Jan 2014 08:46:28 -0500 (EST)
Received: from michael.fritz.box (p57A25457.dip0.t-ipconnect.de [87.162.84.87])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s06DjfPC021935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jan 2014 08:46:26 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389015935-21936-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqLtl86kgg9mfeSy6rnQzWTT0XmG2
	eHtzCaPF7RXzmS12T1vA5sDq8ff9ByaPnbPusntcvKTs8XjiCVaPz5vkAlijuG2SEkvKgjPT
	8/TtErgzdrYuYC5YyFXx5ddz9gbGSRxdjJwcEgImEt8ebmWBsMUkLtxbzwZiCwlcZpRYNN0O
	wj7GJHFnHx+IzSagK7Gop5kJxBYRUJOY2HYIqJeLg1lgMaNE17RvjCAJYYEQiU035oEVsQio
	SnQ+6wJbwCvgKrHm7Tz2LkYOoGUKEquvC4GEOYHC06YdhtrrIrHm0COWCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEBBT/Dsau9TKHGAU4GJV4eD2fnQwSYk0s
	K67MPcQoycGkJMrLufpUkBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXq4FQDnelMTKqtSifJiU
	NAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvIjByhASLUtNTK9Iyc0oQ0kwcnCCCC2QD
	D9CGK5tANhQXJOYWZ6ZDFJ1iVJQS5xUEmSAAksgozYMbAIv9V4ziQP8I8+qAVPEA0wZc9yug
	wUxAg0PjwAaXJCKkpBoYNW6LeZRsUONYeMAs/wjbm8PTTglO+L3q8a+PpkuuuJuV9kVs3lEs
	cOH6Hc/nJUfEFDT/7wvxtJm3/ZycnUTtqrwnhXu/qV5Tucl37XT0S/FXOle37zwkY6iW/EZQ
	L6X8McNf9miDJOGJH8Tv8TGf4gy93nGrvu146oU63+m9Ecl77l+sXyX+UomlOCPR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239998>

If hold_lock_file_for_update() fails with errno==ENOENT, it might be
because somebody else (for example, a pack-refs process) has just
deleted one of the lockfile's ancestor directories.  So if this
condition is detected, try again (up to 3 times).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6eb8a02..8a3d3ea 100644
--- a/refs.c
+++ b/refs.c
@@ -2081,7 +2081,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	lflags = LOCK_DIE_ON_ERROR;
+	lflags = 0;
 	if (flags & REF_NODEREF) {
 		refname = orig_refname;
 		lflags |= LOCK_NODEREF;
@@ -2109,6 +2109,17 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	}
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
+	if (lock->lock_fd < 0) {
+		if (errno == ENOENT && --attempts > 0)
+			/*
+			 * Maybe somebody just deleted one of the
+			 * directories leading to ref_file.  Try
+			 * again:
+			 */
+			goto retry;
+		else
+			unable_to_lock_index_die(ref_file, errno);
+	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
  error_return:
-- 
1.8.5.2
