From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 15/15] refs.c: allow deleting refs with a broken sha1
Date: Tue, 21 Oct 2014 12:24:22 -0700
Message-ID: <1413919462-3458-16-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:31:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf9l-0003hd-KI
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbaJUTbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:31:42 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:63590 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932815AbaJUTbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:31:40 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so5891igi.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fTYHFibf5YFN3cYzjo/vGLItOS3BmPeWjlRApLWuaiQ=;
        b=pQJAi7EP1kfbjyvgD+R3GO2ozsy54jXWIFVyHniDiKqGuA4mW05h/UFZ2D2kYk9g6n
         klKHYuWk8LiJMxG3YiUwcS5aEYfN9vQ0hDsbGt7/RwTBIHa94OBo+OwmXhEJiXpZb7Be
         ySCxn/4I4VorNXTLgpyQd4BWlaaeAXpdIkt9JhKtcRgul6xsV6F9F0gBeU1FD4dCuUUm
         NHMSnwx/9dQB9UMFwC5SbMkizqE6jGMdFzxk+0p678YbFcRmm7IYimrpwdBW9JHBD/wv
         ibb226rIiqqBWBVQhMUhVhDQKsTTMvB21EDnoDxkNymaIgLqqki1RYMRLX6Zjsap7cK5
         yftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fTYHFibf5YFN3cYzjo/vGLItOS3BmPeWjlRApLWuaiQ=;
        b=OqAX2B/9pQlzg2D6WcU/uTaFvnEt8ZqBK6Az56AKR+b22oVbvmtGkjP8NX7kG2CW1f
         6IbqOFIhnCCrfsM0G6aRAsU9wzqYFOq8y7+3hYiK0OEO0duJ++mKO37RQKGIJ7z1eM2s
         UGpMMe/Aer/H4qQ2F8NgCBScK0iL6AliQTDxW6AJ6G8fr9j/Od0NbDyCQYVAPEBdjxX9
         AKruldX1CHoq3gDUdHqzZY/iOM/H6junjg48eufxjJWkz5VF0QfQflNPV8W+LzP4GXA5
         h7rluspY35RbIGExtxvLwdfGfXQU3srK0BKYpGeXU5fKwvKe+fSFMBC5cX+VABwyL1/W
         lsmQ==
X-Gm-Message-State: ALoCoQljoUgJXHXFSJUfWgm4qQ2G8x2PfzJ/v/YxBNLCzHQp2U9O1mpcsATEqwStmIr16tk8dCsQ
X-Received: by 10.182.130.162 with SMTP id of2mr24838209obb.33.1413919899857;
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si585968yhe.3.2014.10.21.12.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id mwdCwDe7.1; Tue, 21 Oct 2014 12:31:39 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BF9E3E12A8; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 8d75baa250c0f84cc438568cb53ef1a9dd3dfec9 upstream.

Add back support to make it possible to delete refs that have a broken
sha1.

Add new internal flags REF_ALLOW_BROKEN and RESOLVE_REF_ALLOW_BAD_SHA1
to pass intent from branch.c that we are willing to allow
resolve_ref_unsafe and lock_ref_sha1_basic to allow broken refs.
Since these refs can not actually be resolved to a sha1, they instead resolve
to null_sha1 when these flags are used.

For example, the ref:

   echo "Broken ref" > .git/refs/heads/foo-broken-1

can now be deleted using git branch -d foo-broken-1

Change-Id: I4e744d9e7d8b7e81dde5479965819117d03c98db
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c            | 5 +++--
 cache.h                     | 7 +++++++
 refs.c                      | 6 ++++++
 refs.h                      | 6 ++++--
 t/t1402-check-ref-format.sh | 8 ++++++++
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 3b79c50..04f57d4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -238,7 +238,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		target = resolve_ref_unsafe(name,
 					    RESOLVE_REF_READING
 					    | RESOLVE_REF_NO_RECURSE
-					    | RESOLVE_REF_ALLOW_BAD_NAME,
+					    | RESOLVE_REF_ALLOW_BAD_NAME
+					    | RESOLVE_REF_ALLOW_BAD_SHA1,
 					    sha1, &flags);
 		if (!target) {
 			error(remote_branch
@@ -255,7 +256,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF)) {
+		if (delete_ref(name, sha1, REF_NODEREF|REF_ALLOW_BROKEN)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/cache.h b/cache.h
index 99ed096..61e61af 100644
--- a/cache.h
+++ b/cache.h
@@ -1000,10 +1000,17 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * resolved. The function returns NULL for such ref names.
  * Caps and underscores refers to the special refs, such as HEAD,
  * FETCH_HEAD and friends, that all live outside of the refs/ directory.
+ *
+ * RESOLVE_REF_ALLOW_BAD_SHA1 when this flag is set and the ref contains
+ * an invalid sha1, resolve_ref_unsafe will clear the sha1 argument,
+ * set the REF_ISBROKEN flag and return the refname.
+ * This allows using resolve_ref_unsafe to check for existence of such
+ * broken refs.
  */
 #define RESOLVE_REF_READING 0x01
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
+#define RESOLVE_REF_ALLOW_BAD_SHA1 0x08
 extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
diff --git a/refs.c b/refs.c
index 5bd6d62..ae29d11 100644
--- a/refs.c
+++ b/refs.c
@@ -1584,6 +1584,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
 				if (flags)
 					*flags |= REF_ISBROKEN;
+				if (resolve_flags & RESOLVE_REF_ALLOW_BAD_SHA1) {
+					hashclr(sha1);
+					return refname;
+				}
 				errno = EINVAL;
 				return NULL;
 			}
@@ -2265,6 +2269,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		if (flags & REF_NODEREF)
 			resolve_flags |= RESOLVE_REF_NO_RECURSE;
 	}
+	if (flags & REF_ALLOW_BROKEN)
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_SHA1;
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_sha1, &type);
diff --git a/refs.h b/refs.h
index 721e21f..2e97f4f 100644
--- a/refs.h
+++ b/refs.h
@@ -185,11 +185,13 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  * REF_DELETING: tolerate broken refs
+ * REF_ALLOW_BROKEN: allow locking refs that are broken.
  *
  * Flags >= 0x100 are reserved for internal use.
  */
-#define REF_NODEREF	0x01
-#define REF_DELETING	0x02
+#define REF_NODEREF		0x01
+#define REF_DELETING		0x02
+#define REF_ALLOW_BROKEN	0x04
 
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index e5dc62e..a0aef69 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -197,4 +197,12 @@ invalid_ref_normalized 'heads///foo.lock'
 invalid_ref_normalized 'foo.lock/bar'
 invalid_ref_normalized 'foo.lock///bar'
 
+test_expect_success 'git branch -d can delete ref with broken sha1' '
+	echo "012brokensha1" > .git/refs/heads/brokensha1 &&
+	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
+	git branch -d brokensha1 &&
+	git branch >output &&
+	! grep -e "brokensha1" output
+'
+
 test_done
-- 
2.1.0.rc2.206.gedb03e5
