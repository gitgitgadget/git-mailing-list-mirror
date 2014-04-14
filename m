From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 18/25] struct lock_file: declare some fields volatile
Date: Mon, 14 Apr 2014 15:54:48 +0200
Message-ID: <1397483695-10888-19-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:55:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhMU-0000ez-2h
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbaDNNzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:55:43 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55519 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755213AbaDNNzi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:38 -0400
X-AuditID: 1207440f-f79326d000003c9f-61-534be8d9656b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.65.15519.9D8EB435; Mon, 14 Apr 2014 09:55:37 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09I010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:35 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHvzhXewwbdtChZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGe82nCZtWCrUEX/vmfsDYyt/F2M
	nBwSAiYS//ccYIKwxSQu3FvP1sXIxSEkcJlRYnfDUkaQhJDASSaJx1crQWw2AV2JRT3NYA0i
	AmoSE9sOsYA0MAu0M0kc2tELlhAW8JCY03qJGcRmEVCVaH61HWgqBwevgKvEmR3SEMvkJE4e
	m8wKEuYECi/8kAWxykXi7pcprBMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s
	0UtNKd3ECAlE/h2MXetlDjEKcDAq8fB2zPEOFmJNLCuuzD3EKMnBpCTKm3EDKMSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmE13UrUI43JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYr
	w8GhJMFrDIw4IcGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQXMQXAyMDJMUDtDfp
	Ocje4oLEXKAoROspRkUpcd4SkIQASCKjNA9uLCy9vGIUB/pSmFcCZDsPMDXBdb8CGswENJil
	HWxwSSJCSqqBka9b0PGCrOnuwBPxnsrMb9om/2NpyNQ50xs0Lyj5/e/HKcK6TycseBq3u4B1
	g5NW9bETPif4p1XxXbiqvXTiUZmuU+Ibf/DvbPikwSTO2yNvrniXseiPfEbMIYUp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246230>

The function remove_lock_file_on_signal() is used as a signal handler.
It is not realistic to make the signal handler conform strictly to the
C standard, which is very restrictive about what a signal handler is
allowed to do.  But let's increase the likelihood that it will work:

The lock_file_list global variable and several fields from struct
lock_file are used by the signal handler.  Declare those values
"volatile" to increase the chance that the signal handler will see a
valid object state.

Suggested-by: Johannes Sixt <j.sixt@viscovery.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h    | 6 +++---
 lockfile.c | 2 +-
 refs.c     | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index b7af173..9019c7d 100644
--- a/cache.h
+++ b/cache.h
@@ -538,10 +538,10 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
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
index 50a0541..fce53f1 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -69,7 +69,7 @@
  * See Documentation/api-lockfile.txt for more information.
  */
 
-static struct lock_file *lock_file_list;
+static struct lock_file *volatile lock_file_list;
 static const char *alternate_index_output;
 
 static void remove_lock_file(void)
diff --git a/refs.c b/refs.c
index cb2f825..db8057c 100644
--- a/refs.c
+++ b/refs.c
@@ -2213,15 +2213,16 @@ int commit_packed_refs(void)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
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
 	if (commit_lock_file(packed_ref_cache->lock))
 		error = -1;
 	packed_ref_cache->lock = NULL;
-- 
1.9.1
