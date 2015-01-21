From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] refs.c: write to a lock file only once
Date: Wed, 21 Jan 2015 15:23:44 -0800
Message-ID: <1421882625-916-6-git-send-email-sbeller@google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:24:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4d3-0000SX-DB
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbbAUXYC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:24:02 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:62406 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbbAUXXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:53 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so17078130igd.4
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sW701MQZyTq6NVxxZUF6T5QpLx0qYJNMG+8wuaevd4I=;
        b=WwTCuxoljSrigOmJIt6DipyCFLit+lCL1tF1ZYgynMMWHU+GvErVuLpscDc7AvQD8e
         /YjR2JptDzdIBCsypQti1v1jE9e8j7vn18zpe9LwJ6WL4ut37KhAlNWwrRsO0PVG8t++
         6HssWchvFBLG6YO/FV0/xgZhcJEqvgfq2H3WDMeFQaN4pMJTRwwhNH08NcmkBqdahnXA
         XgkaLbs9rw9QC7cSEMZNK3Ve8Xl8yKHKDrhoCb5vp+g8WJUJ9RHJSWYus+DLakVBiHH9
         /U9Hi0/vET+TxGX1/Ny1WrhgnhQIZ808CooW9RVyxdEhiHjVNoWZDwoDPTja/QC23TU3
         FMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sW701MQZyTq6NVxxZUF6T5QpLx0qYJNMG+8wuaevd4I=;
        b=e9DPl7oAoUsLRnMzxwLpI5eucND+eb0sGPoVQj8Zz5kU8KnB1QC6fNTPrnk23h679O
         CGzsbDmK+fLwxcZiBL5PuXgVxnnGqJJrz0RT0mmXLpslKaq8LAL/mL+kIZuWboCcUKtC
         ULN4FkIHOd1UZkyJLdd4FxykJ+6ySGDmV1QuZit7FAKlwwb5QpjmzHE2y8l1Ct99iBrh
         nSSXvWMe1S7zV1sPCAK6V3tT/34CeRq26ub1z46SmQoLB5rK1eNJD6qGlG3kkmMlU/UK
         v+4TupeE72r+lYJXtvrSBfW6P36+u0A7zB87GX4/FNSAyL0n9fx9350HejcpP5fk9kd5
         WRTA==
X-Gm-Message-State: ALoCoQl2nj3JgjkeUZbPY8dKsedJHteFmKOXlRvfvUMz6FEAADMpF7KqXCojLeiy9PYAdT100aPH
X-Received: by 10.43.12.198 with SMTP id pj6mr8987774icb.14.1421882632924;
        Wed, 21 Jan 2015 15:23:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id mi3sm683993igb.13.2015.01.21.15.23.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:52 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262779>

Instead of having to call write_in_full_to_lock_file twice get a formatted
string such that we only need to invoke writing to the lock file once.

This is helpful for the next patch when we only open the file descriptors
as needed. The lock file API has a reopen_lock_file which currently
doesn't open for appending.

No functional changes intended.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 311599b..0161667 100644
--- a/refs.c
+++ b/refs.c
@@ -3078,8 +3078,8 @@ static ssize_t write_in_full_to_lockfile(struct lock_file *lock,
 static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
-	static char term = '\n';
 	struct object *o;
+	const char *sha1_lf;
 
 	if (!lock) {
 		errno = EINVAL;
@@ -3104,8 +3104,9 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = EINVAL;
 		return -1;
 	}
-	if (write_in_full_to_lockfile(lock->lk, sha1_to_hex(sha1), 40) != 40 ||
-	    write_in_full_to_lockfile(lock->lk, &term, 1) != 1 ||
+
+	sha1_lf = xstrfmt("%s\n",  sha1_to_hex(sha1));
+	if (write_in_full_to_lockfile(lock->lk, sha1_lf, 41) != 41 ||
 	    close_ref(lock) < 0) {
 		int save_errno = errno;
 		error("Couldn't write %s", lock->lk->filename.buf);
@@ -3113,6 +3114,7 @@ static int write_ref_sha1(struct ref_lock *lock,
 		errno = save_errno;
 		return -1;
 	}
+	free((void*)sha1_lf);
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
@@ -4081,13 +4083,13 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	(*cleanup_fn)(cb.policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
+		const char *sha1_lf = xstrfmt("%s\n",
+					      sha1_to_hex(cb.last_kept_sha1));
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			(write_in_full_to_lockfile(lock->lk,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
-			 write_in_full_to_lockfile(lock->lk, "\n", 1) != 1 ||
+			(write_in_full_to_lockfile(lock->lk, sha1_lf, 41) != 41 ||
 			 close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
 					lock->lk->filename.buf);
@@ -4098,6 +4100,7 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
 			status |= error("couldn't set %s", lock->ref_name);
 		}
+		free((void*)sha1_lf);
 	}
 	free(log_file);
 	unlock_ref(lock);
-- 
2.2.1.62.g3f15098
