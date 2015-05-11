From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/2] lockfile: allow file locking to be retried with a timeout
Date: Mon, 11 May 2015 12:35:25 +0200
Message-ID: <1431340526-24288-2-git-send-email-mhagger@alum.mit.edu>
References: <1431340526-24288-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 12:35:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrl3x-0006qH-M1
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 12:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbbEKKft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 06:35:49 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:49263 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753112AbbEKKfp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 06:35:45 -0400
X-AuditID: 12074413-f79f26d0000030e7-1b-555085f532aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.50.12519.5F580555; Mon, 11 May 2015 06:35:33 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BAZTPE021833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 06:35:32 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431340526-24288-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqPu1NSDU4M5yC4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFps3t7M4sHn8ff+ByWPBplKPh6+62D2e9e5h9Lh4Sdnj8ya5ALYo
	bpukxJKy4Mz0PH27BO6Mm6/nshfs1Kh4/bqPpYHxgEIXIyeHhICJxLnHD9ggbDGJC/fWA9lc
	HEIClxkl5i7bCeUcZ5LY0vOCEaSKTUBXYlFPMxOILSKgJjGx7RALSBGzwHpGiWPXpoMlhAUC
	Jabu/grWwCKgKnF/whWwOK+Ai8TT3U1MEOvkJM4f/8kMYnMKuEq8+dcLZgsB1bTcXMs+gZF3
	ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQQBPewbjrpNwhRgEORiUe
	XoML/qFCrIllxZW5hxglOZiURHnbqgJChfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwcjYC5XhT
	EiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxxLUCNgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aDoiC8GxgdIigdoL3sryN7igsRcoChE6ylGRSlx3hUgcwVA
	EhmleXBjYenjFaM40JfCEFU8wNQD1/0KaDAT0GDHOLDBJYkIKakGxpkTf9tpNH0J81sWYX+l
	SNzdd/kRwTwdqbWGVcXb/07d6MM6UVVN7O91mftTTmwRmqy69CpDmFX4jr7+WP7PeW+71i94
	sNlUpT6OUf+4Wpem2u63TtYnLS9xhc+P/MLFKPaOb/kW7XttdacYDouVFH4RXra2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268767>

Currently, there is only one attempt to lock a file. If it fails, the
whole operation fails.

But it might sometimes be advantageous to try acquiring a file lock a
few times before giving up. So add a new function,
hold_lock_file_for_update_timeout(), that allows a timeout to be
specified. Make hold_lock_file_for_update() a thin wrapper around the
new function.

If timeout_ms is positive, then retry for at least that many
milliseconds to acquire the lock. On each failed attempt, use select()
to wait for a backoff time that increases quadratically (capped at 1
second) and has a random component to prevent two processes from
getting synchronized. If timeout_ms is negative, retry indefinitely.

In a moment we will switch to using the new function when locking
packed-refs.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Notes (discussion):
    It would be easy to also add a hold_lock_file_for_append_timeout(),
    but I can't yet think of an application for it.

 lockfile.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 lockfile.h | 16 +++++++++++--
 2 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 9889277..30e65e9 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -157,6 +157,80 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
+static int sleep_microseconds(long us)
+{
+	struct timeval tv;
+	tv.tv_sec = 0;
+	tv.tv_usec = us;
+	return select(0, NULL, NULL, NULL, &tv);
+}
+
+/*
+ * Constants defining the gaps between attempts to lock a file. The
+ * first backoff period is approximately INITIAL_BACKOFF_MS
+ * milliseconds. The longest backoff period is approximately
+ * (BACKOFF_MAX_MULTIPLIER * INITIAL_BACKOFF_MS) milliseconds.
+ */
+#define INITIAL_BACKOFF_MS 1L
+#define BACKOFF_MAX_MULTIPLIER 1000
+
+/*
+ * Try locking path, retrying with quadratic backoff for at least
+ * timeout_ms milliseconds. If timeout_ms is 0, try locking the file
+ * exactly once. If timeout_ms is -1, try indefinitely.
+ */
+static int lock_file_timeout(struct lock_file *lk, const char *path,
+			     int flags, long timeout_ms)
+{
+	int n = 1;
+	int multiplier = 1;
+	long remaining_us = 0;
+	static int random_initialized = 0;
+
+	if (timeout_ms == 0)
+		return lock_file(lk, path, flags);
+
+	if (!random_initialized) {
+		srandom((unsigned int)getpid());
+		random_initialized = 1;
+	}
+
+	if (timeout_ms > 0) {
+		/* avoid overflow */
+		if (timeout_ms <= LONG_MAX / 1000)
+			remaining_us = timeout_ms * 1000;
+		else
+			remaining_us = LONG_MAX;
+	}
+
+	while (1) {
+		long backoff_ms, wait_us;
+		int fd;
+
+		fd = lock_file(lk, path, flags);
+
+		if (fd >= 0)
+			return fd; /* success */
+		else if (errno != EEXIST)
+			return -1; /* failure other than lock held */
+		else if (timeout_ms > 0 && remaining_us <= 0)
+			return -1; /* failure due to timeout */
+
+		backoff_ms = multiplier * INITIAL_BACKOFF_MS;
+		/* back off for between 0.75*backoff_ms and 1.25*backoff_ms */
+		wait_us = (750 + random() % 500) * backoff_ms;
+		sleep_microseconds(wait_us);
+		remaining_us -= wait_us;
+
+		/* Recursion: (n+1)^2 = n^2 + 2n + 1 */
+		multiplier += 2*n + 1;
+		if (multiplier > BACKOFF_MAX_MULTIPLIER)
+			multiplier = BACKOFF_MAX_MULTIPLIER;
+		else
+			n++;
+	}
+}
+
 void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 {
 	if (err == EEXIST) {
@@ -179,9 +253,10 @@ NORETURN void unable_to_lock_die(const char *path, int err)
 }
 
 /* This should return a meaningful errno on failure */
-int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
+int hold_lock_file_for_update_timeout(struct lock_file *lk, const char *path,
+				      int flags, long timeout_ms)
 {
-	int fd = lock_file(lk, path, flags);
+	int fd = lock_file_timeout(lk, path, flags, timeout_ms);
 	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
 		unable_to_lock_die(path, errno);
 	return fd;
diff --git a/lockfile.h b/lockfile.h
index cd2ec95..b4abc61 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -74,8 +74,20 @@ struct lock_file {
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_die(const char *path, int err);
-extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
-extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
+extern int hold_lock_file_for_update_timeout(
+		struct lock_file *lk, const char *path,
+		int flags, long timeout_ms);
+
+static inline int hold_lock_file_for_update(
+		struct lock_file *lk, const char *path,
+		int flags)
+{
+	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
+}
+
+extern int hold_lock_file_for_append(struct lock_file *lk, const char *path,
+				     int flags);
+
 extern FILE *fdopen_lock_file(struct lock_file *, const char *mode);
 extern char *get_locked_file_path(struct lock_file *);
 extern int commit_lock_file_to(struct lock_file *, const char *path);
-- 
2.1.4
