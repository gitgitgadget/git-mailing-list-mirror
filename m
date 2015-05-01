From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] lockfile: allow file locking to be retried with a timeout
Date: Fri,  1 May 2015 16:52:56 +0200
Message-ID: <1430491977-25817-2-git-send-email-mhagger@alum.mit.edu>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 16:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCJe-0002uO-GR
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 16:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbbEAOxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 10:53:18 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43801 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753817AbbEAOxR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 10:53:17 -0400
X-AuditID: 1207440e-f79bc6d000000c43-82-554393539513
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id EF.A6.03139.35393455; Fri,  1 May 2015 10:53:07 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41Er33b011249
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 10:53:06 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqBs82TnU4P9uNYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ9x8PZe9YKdGxevXfSwNjAcUuhg5OSQETCQ2rDvLBmGLSVy4tx7I5uIQErjMKPHy8n92
	kISQwAkmifs9kSA2m4CuxKKeZiYQW0RATWJi2yEWkAZmgQ5GiQvLt4E1CAv4SVy5vpMZxGYR
	UJW4d2g9C4jNK+AisbX3JSvENjmJ88d/gtVwCrhKHOz4zAqxzEXi5dGNLBMYeRcwMqxilEvM
	Kc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAkpvh2M7etlDjEKcDAq8fBynHQKFWJN
	LCuuzD3EKMnBpCTK21bnHCrEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPfpBKAcb0piZVVqUT5M
	SpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCd99EoEbBotT01Iq0zJwShDQTByfIcC4p
	keLUvJTUosTSkox4UGzEFwOjAyTFA7TXdBLI3uKCxFygKETrKUZFKXFeeZCEAEgiozQPbiws
	UbxiFAf6UphXDaSKB5hk4LpfAQ1mAhp8/pYDyOCSRISUVANj8vlZS94XXeG5/st7dkYt/79J
	kctnT/kewht1bpFKQHn3UpfXZw8Knn1bviSYfVVgG9tKff8K1ieq+pVL99ysfSTJYdTJduDm
	F8an3hkaWXd/HPg29eydw5mdV21PBXzeril/d7O8+UGDtnzL59a7HR3WvDy/5+5C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268139>

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
