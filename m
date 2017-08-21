Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00FE1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 11:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbdHULvo (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 07:51:44 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51130 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750967AbdHULvn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Aug 2017 07:51:43 -0400
X-AuditID: 12074414-555ff70000000ac3-99-599ac94e83c6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.6D.02755.E49CA995; Mon, 21 Aug 2017 07:51:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC004.dip0.t-ipconnect.de [87.188.192.4])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7LBpdtH020930
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 21 Aug 2017 07:51:41 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] Retry acquiring reference locks for 100ms
Date:   Mon, 21 Aug 2017 13:51:34 +0200
Message-Id: <030b6bb22973df429ddbb64a079b9cdc1fbcb1b7.1503313472.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsUixO6iqOt3clakwatDGhZdV7qZLBp6rzBb
        3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKC6blNSczLLUIn27BK6Mb509LAX/
        tCsWf5zC2sB4XrmLkYNDQsBE4v4E7S5GLg4hgR1MEvO3TGSGcE4wSWz7MJWpi5GTg01AV2JR
        TzOYLSKgJjGx7RALiM0skCLR8bybEcQWFrCSePlxEiuIzSKgKnF75luwGl6BKIndeyeC1UgI
        yEvsarvIOoGRawEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MEK+L7GA8
        clLuEKMAB6MSD69B0axIIdbEsuLK3EOMkhxMSqK8G1KBQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
        lUR4D+4ByvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfAePgHUKFiU
        mp5akZaZU4KQZuLgBBnOAzS8HaSGt7ggMbc4Mx0if4pRUUqcl+s4UEIAJJFRmgfXC4vKV4zi
        QK8I87qBtPMAIxqu+xXQYCagwYat00AGlyQipKQaGLmMRZuymW3W6l6135GRJZZ4IP4Yn0OA
        9PrQSVaFDv2u2zec2FLYsuXzIhfPh7qLi6ctdeGJ63htK1Oz9ZbehJV7rHlOvG09JHL//tId
        cce8ha+zGS5b+rLudeXECywPE/WT/8zjn9mU6q+iPT1p23OG+dYbCgKllJ35TlwPmyeyabfr
        5jJRHyWW4oxEQy3mouJEAPGCDvelAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The philosophy of reference locking has been, "if another process is
changing a reference, then whatever I'm trying to do to it will
probably fail anyway because my old-SHA-1 value is probably no longer
current". But this argument falls down if the other process has locked
the reference to do something that doesn't actually change the value
of the reference, such as `pack-refs` or `reflog expire`. There
actually *is* a decent chance that a planned reference update will
still be able to go through after the other process has released the
lock.

So when trying to lock an individual reference (e.g., when creating
"refs/heads/master.lock"), if it is already locked, then retry the
lock acquisition for approximately 100 ms before giving up. This
should eliminate some unnecessary lock conflicts without wasting a lot
of time.

Add a configuration setting, `core.filesRefLockTimeout`, to allow this
setting to be tweaked.

Note: the function `get_files_ref_lock_timeout_ms()` cannot be private
to the files backend because it is also used by `write_pseudoref()`
and `delete_pseudoref()`, which are defined in `refs.c` so that they
can be used by other reference backends.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This patch applies to master, but (perhaps surprisingly) doesn't
conflict with the mh/packed-ref-store changes. It can also be obtained
from my Git fork [1] as branch "ref-lock-retry".

Michael

[1] https://github.com/mhagger/git

 Documentation/config.txt |  6 ++++++
 refs.c                   | 24 +++++++++++++++++++++---
 refs/files-backend.c     |  8 ++++++--
 refs/refs-internal.h     |  6 ++++++
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab6..2c04b9dfb4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -776,6 +776,12 @@ core.commentChar::
 If set to "auto", `git-commit` would select a character that is not
 the beginning character of any line in existing commit messages.
 
+core.filesRefLockTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	lock an individual reference. Value 0 means not to retry at
+	all; -1 means to try indefinitely. Default is 100 (i.e.,
+	retry for 100ms).
+
 core.packedRefsTimeout::
 	The length of time, in milliseconds, to retry when trying to
 	lock the `packed-refs` file. Value 0 means not to retry at
diff --git a/refs.c b/refs.c
index fe4c59aa8b..29dbb9b610 100644
--- a/refs.c
+++ b/refs.c
@@ -561,6 +561,21 @@ enum ref_type ref_type(const char *refname)
        return REF_TYPE_NORMAL;
 }
 
+long get_files_ref_lock_timeout_ms(void)
+{
+	static int configured = 0;
+
+	/* The default timeout is 100 ms: */
+	static int timeout_ms = 100;
+
+	if (!configured) {
+		git_config_get_int("core.filesreflocktimeout", &timeout_ms);
+		configured = 1;
+	}
+
+	return timeout_ms;
+}
+
 static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 			   const unsigned char *old_sha1, struct strbuf *err)
 {
@@ -573,7 +588,9 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
 
 	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update_timeout(&lock, filename,
+					       LOCK_DIE_ON_ERROR,
+					       get_files_ref_lock_timeout_ms());
 	if (fd < 0) {
 		strbuf_addf(err, "could not open '%s' for writing: %s",
 			    filename, strerror(errno));
@@ -616,8 +633,9 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
 		int fd;
 		unsigned char actual_old_sha1[20];
 
-		fd = hold_lock_file_for_update(&lock, filename,
-					       LOCK_DIE_ON_ERROR);
+		fd = hold_lock_file_for_update_timeout(
+				&lock, filename, LOCK_DIE_ON_ERROR,
+				get_files_ref_lock_timeout_ms());
 		if (fd < 0)
 			die_errno(_("Could not open '%s' for writing"), filename);
 		if (read_ref(pseudoref, actual_old_sha1))
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0404f2c233..d611e0f7d7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -855,7 +855,9 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	if (!lock->lk)
 		lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	if (hold_lock_file_for_update(lock->lk, ref_file.buf, LOCK_NO_DEREF) < 0) {
+	if (hold_lock_file_for_update_timeout(
+			    lock->lk, ref_file.buf, LOCK_NO_DEREF,
+			    get_files_ref_lock_timeout_ms()) < 0) {
 		if (errno == ENOENT && --attempts_remaining > 0) {
 			/*
 			 * Maybe somebody just deleted one of the
@@ -1181,7 +1183,9 @@ static int create_reflock(const char *path, void *cb)
 {
 	struct lock_file *lk = cb;
 
-	return hold_lock_file_for_update(lk, path, LOCK_NO_DEREF) < 0 ? -1 : 0;
+	return hold_lock_file_for_update_timeout(
+			lk, path, LOCK_NO_DEREF,
+			get_files_ref_lock_timeout_ms()) < 0 ? -1 : 0;
 }
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 192f9f85c9..9977fea98b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -61,6 +61,12 @@
  */
 #define REF_DELETED_LOOSE 0x200
 
+/*
+ * Return the length of time to retry acquiring a loose reference lock
+ * before giving up, in milliseconds:
+ */
+long get_files_ref_lock_timeout_ms(void);
+
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
-- 
2.11.0

