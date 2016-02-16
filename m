From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/20] lock_ref_sha1_basic(): use raceproof_create_file()
Date: Tue, 16 Feb 2016 14:22:17 +0100
Message-ID: <77c2b6f72b55943a0097d81196f520a7fe890310.1455626201.git.mhagger@alum.mit.edu>
References: <cover.1455626201.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Karl Moskowski <kmoskowski@me.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjo-0004ZA-MA
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbcBPNa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 08:30:26 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64169 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351AbcBPNaX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2016 08:30:23 -0500
X-AuditID: 1207440d-6a3ff7000000068f-17-56c322acb44f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 75.B2.01679.CA223C65; Tue, 16 Feb 2016 08:22:52 -0500 (EST)
Received: from michael.fritz.box (p548D6919.dip0.t-ipconnect.de [84.141.105.25])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1GDMfOQ028717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Feb 2016 08:22:50 -0500
X-Mailer: git-send-email 2.7.0
In-Reply-To: <cover.1455626201.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLtG6XCYwZY3shbzN51gtOi60s1k
	0dB7hdniw9pDbBa9k3tZLW6vmM9s8aOlh9mB3ePv+w9MHk+3T2H2eHG+wuNZ7x5Gj4uXlD0W
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8aVXY+ZCraIVzxu2c7SwNgo3MXIySEhYCLx49hy
	pi5GLg4hga2MEnuXfGSGcE4wSZw/soEVpIpNQFdiUU8zE4gtIqAmMbHtEAtIEbPAI0aJrv3b
	GUESwgKeEnd+XgKzWQRUJY5f3ArWwCsQJbHk7W82iHVyEi0/doMN5RSwkDjZ0ssCYgsJmEvc
	+bKHaQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIUHGu4Px/zqZ
	Q4wCHIxKPLwcHofChFgTy4orcw8xSnIwKYny8nAfDhPiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wvvvFVA5b0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCt0MRaKhgUWp6
	akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KArii4FxAJLiAdqbBtLOW1yQmAsUhWg9xago
	Jc7rApIQAElklObBjYWljleM4kBfCvMeB6niAaYduO5XQIOZgAbnXAJ5qLgkESEl1cC4gGPe
	wuWML3i7kqZlPb0arlq6xeheTzCLhe9Sj9OMr05d/cjy9lj/vW7J7osemvlzz5c8XOO92ueH
	2EGLfrHtamtvzyn4crX4xNbJ/xcs+BRVd/xaibaczsID/6ZdLTq+qU7+krpQjrmP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286401>

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
