From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 24/32] struct lock_file: declare some fields volatile
Date: Sat,  6 Sep 2014 09:50:38 +0200
Message-ID: <1409989846-22401-25-git-send-email-mhagger@alum.mit.edu>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAnY-0000OH-58
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbaIFHwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 03:52:35 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55673 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863AbaIFHwc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:52:32 -0400
X-AuditID: 1207440e-f79da6d0000002fc-85-540abd400e96
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.BD.00764.04DBA045; Sat,  6 Sep 2014 03:52:32 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFHN006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:52:31 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsUixO6iqOuwlyvE4Pt6cYuuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFp0dXxkd2Dz+vv/A5PHwVRe7x7PePYweFy8pe3zeJOdx+9k2lgC2
	KG6bpMSSsuDM9Dx9uwTujIaPggXLRSvunVjD1MC4ULCLkZNDQsBE4t+WCUwQtpjEhXvr2boY
	uTiEBC4zSpw/8p4VJCEkcIxJ4sd3fxCbTUBXYlFPMxNIkYhAG6PEroubwYqYBVIkOp53M4LY
	wgIeEr1rpjKD2CwCqhJXJnWxgdi8Aq4S/R+PskJsk5PYsPs/WD0nUHx6UycjxDIXifaT/UwT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgJM74djO3rZQ4xCnAw
	KvHwFjpwhQixJpYVV+YeYpTkYFIS5c1bDhTiS8pPqcxILM6ILyrNSS0+xCjBwawkwtsxGSjH
	m5JYWZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgddkD1ChYlJqeWpGWmVOC
	kGbi4AQZziUlUpyal5JalFhakhEPioz4YmBsgKR4gPaygrTzFhck5gJFIVpPMepyrOv81s8k
	xJKXn5cqJc7LBFIkAFKUUZoHtwKWVF4xigN9LMwrBlLFA0xIcJNeAS1hAlpins4JsqQkESEl
	1cCobKSexikSwie4sc6m5UMjZ8uBFeG/RZuvP88Scdr+s/zivA39LC8X/o385bv+V8ajTb7p
	QW/5uebkzflmcdBRZlWki8cRp9x7z43/H/5xqe5ZV8OViPt89ek9RgvO79A/MmvW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256558>

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
index e739482..f7ad1b5 100644
--- a/cache.h
+++ b/cache.h
@@ -574,10 +574,10 @@ extern int refresh_index(struct index_state *, unsigned int flags, const struct
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
index 920585d..f51f73f 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -65,7 +65,7 @@
  * See Documentation/api-lockfile.txt for more information.
  */
 
-static struct lock_file *lock_file_list;
+static struct lock_file *volatile lock_file_list;
 
 static void remove_lock_file(void)
 {
diff --git a/refs.c b/refs.c
index 21b0da3..f076f2d 100644
--- a/refs.c
+++ b/refs.c
@@ -2260,15 +2260,16 @@ int commit_packed_refs(void)
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
