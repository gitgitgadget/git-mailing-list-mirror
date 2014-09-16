From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 24/35] struct lock_file: declare some fields volatile
Date: Tue, 16 Sep 2014 21:33:45 +0200
Message-ID: <1410896036-12750-25-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:43:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyer-0004Hr-9p
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237AbaIPTmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:37 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:50614 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755188AbaIPTmX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:23 -0400
X-AuditID: 12074412-f792e6d000005517-3a-541890dc02b1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.45.21783.CD098145; Tue, 16 Sep 2014 15:34:52 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcS001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:51 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHtngkSIwcJtUhZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cd8XmeZMFy0Yqbf4+xNzAuFOxi5OSQEDCRuL3xDSOE
	LSZx4d56ti5GLg4hgcuMEpdOLmWEcE4wSTz99Basik1AV2JRTzMTSEJEoI1RYtfFzawgDrNA
	N6PE+xOngTIcHMICHhJfJmaBNLAIqEpM/riQHcTmFXCVWHD3CNQ6OYkNu/8zgpRzAsW/7isA
	MYUEXCQO3vWbwMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGumV5uZoleakrpJkZI0Ant
	YFx/Uu4QowAHoxIPr8cj8RAh1sSy4srcQ4ySHExKorz/uiVChPiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nw/vAFyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfDe7Adq
	FCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFRXwxMDJAUjxAez+CtPMWFyTmAkUh
	Wk8x6nKs6/zWzyTEkpeflyolzmsDUiQAUpRRmge3ApZiXjGKA30szPsOpIoHmJ7gJr0CWsIE
	tORsjxjIkpJEhJRUA+MB0UVbc3g/XWKTLikPv1DczH7l23zGdf7P+Hk/PvrBes3U4d8kW5Pf
	7wRFNzJH6AeYKJYYMpX5S9m7Oh3n3H3j5q6EopAvPhw1kjPlvp4821YlNPXf25d3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257181>

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
index a367220..f251acd 100644
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
index 55fbb41..a09b4a3 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -70,7 +70,7 @@
  * See Documentation/api-lockfile.txt for more information.
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
