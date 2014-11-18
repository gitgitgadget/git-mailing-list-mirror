From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 14/14] refs.c: allow deleting refs with a broken sha1
Date: Mon, 17 Nov 2014 17:35:50 -0800
Message-ID: <1416274550-2827-15-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiT-0000KX-2c
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbaKRBgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:19 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33730 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbaKRBgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:13 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so3167453igb.9
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UfpynLTGt1WwviwSLLKYiAoMvEhHiildsD/gz+HtCvk=;
        b=DOBID8pl0UY5gRHueCUTWPZKww3wuWE9uSkPtSbElU1GupeYfDUsZCYglEjYMxDFk9
         HVR6RcZ/iUmsxR5HchjN1KFMnbZBlc06XXY4WJJvMZzCz/aGAzahKraLk1UGBA1nx7nN
         zJYGMZIy6FPzLXty6O0YaLHIGGxeBhSJrUwS7MeftvfBhLe4QEM7FhCMp8FzVt9o82Uv
         fxUuWDKVzzwNjER9y6F5ZufPU0DB0+Hi+Bgi16R6Q/MtQvCwYdSA9URVMy0xJhGSEQeS
         Cpr7KU8gbJAV1B7z84YS2xvzWNYEF95ToGyFzNCIIHkWuq9lhi/Wbs9AAu/vegs3fHi5
         Ap1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UfpynLTGt1WwviwSLLKYiAoMvEhHiildsD/gz+HtCvk=;
        b=KjduZrSGGVm4QzlLWv//7vyJ6Z86m0mRdpwF3RNCOtaimhXEi8kXnm7d//iHOJUW4k
         Uyg2uhBn8AxQPrr1aEuXwqeb5Q/3LPx5mjXFUHM8Xmras+KwjMVP6xR5VD3/VywAOcg8
         p6xOeIdNTLqHm/BC5qQOoyQ/ji7rbMi4GuZKgKGuPCSyVAUHO4aMZ1lUc9I9vntUt/vB
         PAZdShd/scOs2rf7dB2FgWFwTq5Y6iXYmdJa0WEpM0aDhzhawZ+doIwxZrw9/T10O7sO
         xdLbPbkU71hwA7Jcr+RTJJPLyV9xfWVJYckTwwvsG7eNJZss9X0FU6gl4Y8NJv1Jc0zM
         gGBQ==
X-Gm-Message-State: ALoCoQlVaRJkuUYenI0lI5kcuM2hyOPAka3r0s2n5r/UuVffKrGoALz6yWSqFg4P9kLyp4XqIpda
X-Received: by 10.42.129.140 with SMTP id q12mr5545918ics.68.1416274572378;
        Mon, 17 Nov 2014 17:36:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id q17sm13493975ioe.21.2014.11.17.17.36.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:11 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

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

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
index b318888..d75af6c 100644
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
2.2.0.rc2.5.gf7b9fb2
