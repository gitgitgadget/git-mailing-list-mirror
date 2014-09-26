From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 25/39] struct lock_file: declare some fields volatile
Date: Fri, 26 Sep 2014 12:08:25 +0200
Message-ID: <1411726119-31598-26-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:17:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSaO-00032m-UO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbaIZKRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:17:05 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:47270 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755865AbaIZKRB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:17:01 -0400
X-AuditID: 1207440d-f797f6d000000a4a-e1-54253b5b89f5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8F.5E.02634.B5B35245; Fri, 26 Sep 2014 06:09:31 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lMA013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:29 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1I22Vg0xeDRJ0KLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ow/K2ewFDSJVvz73MrUwPhLoIuR
	k0NCwETiwuGnrBC2mMSFe+vZuhi5OIQELjNKbJjfzArhbGKSaHsynQmkik1AV2JRTzOYLSKg
	JjGx7RALSBGzwGImiQmHNgG1c3AIC3hILDikC1LDIqAq8ePVB0YQm1fAVWLjh1ZGiG1yEht2
	/wezOYHijduvgdlCAi4SLesns0xg5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzez
	RC81pXQTIyQYeXcw/l8nc4hRgINRiYf3xjqVECHWxLLiytxDjJIcTEqivF8sVEOE+JLyUyoz
	Eosz4otKc1KLDzFKcDArifDeMQLK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeC9aAjUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC9
	XFYge4sLEnOBohCtpxh1OdZ1futnEmLJy89LlRLnPQKyQwCkKKM0D24FLPW8YhQH+liY9wZI
	FQ8wbcFNegW0hAloidIRZZAlJYkIKakGRoGV7CLGN0U9NBL47n34ceFtSW+RvfBK1SdPhA7M
	aT7iOZFR90kf09ne0z/9Ljy10fB55h51YvkZli6HnuPRc2++TUhzWL7I/828KnuX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257539>

The function remove_lock_file_on_signal() is used as a signal handler.
It is not realistic to make the signal handler conform strictly to the
C standard, which is very restrictive about what a signal handler is
allowed to do.  But let's increase the likelihood that it will work:

The lock_file_list global variable and several fields from struct
lock_file are used by the signal handler.  Declare those values
"volatile" to (1) force the main process to write the values to RAM
promptly, and (2) prevent updates to these fields from being reordered
in a way that leaves an opportunity for a jump to the signal handler
while the object is in an inconsistent state.

We don't mark the filename field volatile because that would prevent
the use of strcpy(), and it is anyway unlikely that a compiler
re-orders a strcpy() call across other expressions.  So in practice it
should be possible to get away without "volatile" in the "filename"
case.

Suggested-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    | 6 +++---
 lockfile.c | 2 +-
 refs.c     | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 81c70c7..0e55bbe 100644
--- a/cache.h
+++ b/cache.h
@@ -575,10 +575,10 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
 #define LOCK_SUFFIX_LEN 5
 
 struct lock_file {
-	struct lock_file *next;
+	struct lock_file *volatile next;
 	volatile sig_atomic_t active;
-	int fd;
-	pid_t owner;
+	volatile int fd;
+	volatile pid_t owner;
 	char on_list;
 	char filename[PATH_MAX];
 };
diff --git a/lockfile.c b/lockfile.c
index d35ac44..89043f5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -55,7 +55,7 @@
  *     on_list is set.
  */
 
-static struct lock_file *lock_file_list;
+static struct lock_file *volatile lock_file_list;
 
 static void remove_lock_file(void)
 {
diff --git a/refs.c b/refs.c
index 4f313bc..9971ac5 100644
--- a/refs.c
+++ b/refs.c
@@ -2259,15 +2259,16 @@ int commit_packed_refs(void)
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
 	int save_errno = 0;
+	int fd;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
 	write_or_die(packed_ref_cache->lock->fd,
 		     PACKED_REFS_HEADER, strlen(PACKED_REFS_HEADER));
 
+	fd = packed_ref_cache->lock->fd;
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
-				 0, write_packed_entry_fn,
-				 &packed_ref_cache->lock->fd);
+				 0, write_packed_entry_fn, &fd);
 	if (commit_lock_file(packed_ref_cache->lock)) {
 		save_errno = errno;
 		error = -1;
-- 
2.1.0
