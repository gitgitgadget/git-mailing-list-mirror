From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/20] lock_ref_sha1_basic(): use raceproof_create_file()
Date: Thu, 25 Feb 2016 14:16:03 +0100
Message-ID: <1843ade32d9eb444205778a28e65fb93f69d3444.1456405698.git.mhagger@alum.mit.edu>
References: <cover.1456405698.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 14:16:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvmb-0003c4-GW
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 14:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760282AbcBYNQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 08:16:37 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:52843 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759164AbcBYNQg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 08:16:36 -0500
X-AuditID: 1207440f-db3ff70000007e44-ed-56cefeb47cb8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B0.9C.32324.4BEFEC65; Thu, 25 Feb 2016 08:16:36 -0500 (EST)
Received: from michael.fritz.box (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PDGPri024973
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 08:16:34 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1456405698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvl37kwgztXBC3mbzrBaNF1pZvJ
	oqH3CrPFh7WH2Cx6J/eyWtxeMZ/Z4kdLD7MDu8ff9x+YPJ5un8Ls8eJ8hcez3j2MHhcvKXss
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owrux4zFWwRr3jcsp2lgbFRuIuRk0NCwESi7dEN
	ti5GLg4hga2MEh/PnGCBcE4wSdz4/pgdpIpNQFdiUU8zE4gtIqAmMbHtEFgRs8AjRomu/dsZ
	QRLCAj4SbTO6gRo4OFgEVCWu9bqBhHkFoiQetn5hgtgmJ9HyYzcriM0pYCFx8eR0ZhBbSMBc
	YtWNPewTGHkWMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJMf4djF3r
	ZQ4xCnAwKvHwMvw8GybEmlhWXJl7iFGSg0lJlHfP83NhQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR4V/wFyvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHg3gTQKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IgvhgYBSApHqC9uWB7iwsSc4GiEK2nGBWl
	xHmNQBICIImM0jy4sbDE8YpRHOhLYd5XIFU8wKQD1/0KaDAT0OCZG8AGlyQipKQaGFlmn9q2
	Z1lryT3jX9vr3x+VS7f5ecStrO1Cb8DNXayhP41dPWMquCMMZbPFr2Uf2T49yPu21+LpDIZL
	C2IbhTdunRPzNvLcVaX3K9v/a51b5Vm4dEbnrfndH2ODX57b4VItISrn/GXef4vp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287367>

Instead of coding the retry loop inline, use raceproof_create_file() to
make lock acquisition safe against directory creation/deletion races.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b569762..a549942 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1889,6 +1889,19 @@ static int remove_empty_directories(struct strbuf *path)
 	return remove_dir_recursively(path, REMOVE_DIR_EMPTY_ONLY);
 }
 
+struct create_reflock_data {
+	struct lock_file *lk;
+	int lflags;
+};
+
+static int create_reflock(const char *path, void *cb)
+{
+	struct create_reflock_data *data = cb;
+
+	return hold_lock_file_for_update(data->lk, path, data->lflags) < 0
+		? -1 : 0;
+}
+
 /*
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
@@ -1906,10 +1919,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	struct ref_lock *lock;
 	int last_errno = 0;
 	int type;
-	int lflags = 0;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 	int resolve_flags = 0;
-	int attempts_remaining = 3;
+	struct create_reflock_data create_reflock_data = {NULL, 0};
 
 	assert(err);
 
@@ -1921,7 +1933,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 	if (flags & REF_NODEREF) {
 		resolve_flags |= RESOLVE_REF_NO_RECURSE;
-		lflags |= LOCK_NO_DEREF;
+		create_reflock_data.lflags |= LOCK_NO_DEREF;
 	}
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
@@ -1980,35 +1992,14 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock->orig_ref_name = xstrdup(orig_refname);
 	strbuf_git_path(&ref_file, "%s", refname);
 
- retry:
-	switch (safe_create_leading_directories_const(ref_file.buf)) {
-	case SCLD_OK:
-		break; /* success */
-	case SCLD_VANISHED:
-		if (--attempts_remaining > 0)
-			goto retry;
-		/* fall through */
-	default:
+	create_reflock_data.lk = lock->lk;
+
+	if (raceproof_create_file(ref_file.buf, create_reflock, &create_reflock_data)) {
 		last_errno = errno;
-		strbuf_addf(err, "unable to create directory for %s",
-			    ref_file.buf);
+		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
 
-	if (hold_lock_file_for_update(lock->lk, ref_file.buf, lflags) < 0) {
-		last_errno = errno;
-		if (errno == ENOENT && --attempts_remaining > 0)
-			/*
-			 * Maybe somebody just deleted one of the
-			 * directories leading to ref_file.  Try
-			 * again:
-			 */
-			goto retry;
-		else {
-			unable_to_lock_message(ref_file.buf, errno, err);
-			goto error_return;
-		}
-	}
 	if (verify_lock(lock, old_sha1, mustexist, err)) {
 		last_errno = errno;
 		goto error_return;
-- 
2.7.0
