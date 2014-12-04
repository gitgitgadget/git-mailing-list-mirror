From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/13] refs.c: allow deleting refs with a broken sha1
Date: Thu,  4 Dec 2014 00:29:23 -0800
Message-ID: <1417681763-32334-14-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:30:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnV-0005oD-JM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbaLDI3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:54 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63448 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbaLDI3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:51 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so14262119igb.5
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WygANwinyN0AT5nPTu2aSjGLfqawkpgwAjL2XE6umUs=;
        b=LfzHESUYcOit9KSqJNXzDmRCDwqjDhSQqSzrtSPobYCrE1UpDxVIPbvK2JJtobwOQR
         4oK9pBO/7nABprfka3ddiI3fSM85ukChJuTziqh0sOa4AKQGMw6k4hIMPSJfjcTUuTcC
         dsbwquJj6A0HU4agYiYgWkSCjpiVe2UWmTwXvsq5W3Y81zW89fiuXdY8v6ni7ZSqigT4
         hstqkTU+5zMspgU+Ruc1JUotKWjwNvVjZ9i19zpBGF+Miy9EGc8HrZlXCfnvDoQFD6RB
         u/8iVA7ilCtYQLaGdnyFBkJifg4KPx9XMOH7YB6345JwECM4CNC9Xatv85r0+WWux1IT
         7X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WygANwinyN0AT5nPTu2aSjGLfqawkpgwAjL2XE6umUs=;
        b=kJpt4PjNZSe/73Gv/OcND0OFCEcYbG3TnyFHqDI9VXcZDP7V75D7Gr4mKmMiI10C/d
         +BJSBpw561Jv6XomOQFN+JVYfHslO70wNCjyJcaAiBwnMjq3t2M8fFILuK80il6JyCYp
         i5S+Tof7tI4GSqIEgW7iKk4+KB8k40cbp0M75N0J4g60Js3F0seJ4kf5cfUeyhKBLthh
         zIfl/BWGt8hs4pF4vbVvKDa1HzwKF0Mq8dp1wZw82N1UzSOmHELESLlbCd8rn+gaC8Vv
         JKmd6TDLTYbTg6kckGymjx4m2TjlzOLzJweyHvGFzDYtJymPRXS9KlyHg7cg1C9vB5rf
         4guA==
X-Gm-Message-State: ALoCoQmB1Eo3XBwJ9cmozr+2wLidC8Ub7v2O/YhmmMhbGiA1qb6Hw+bdNZjBQlyuzkAjoNnIV9pr
X-Received: by 10.50.50.165 with SMTP id d5mr61367398igo.16.1417681790535;
        Thu, 04 Dec 2014 00:29:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id f4sm6513361igg.7.2014.12.04.00.29.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:50 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260740>

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
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/branch.c  | 5 +++--
 cache.h           | 7 +++++++
 refs.c            | 6 ++++++
 refs.h            | 6 ++++--
 t/t3200-branch.sh | 8 ++++++++
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
index 2942227..759536c 100644
--- a/refs.c
+++ b/refs.c
@@ -1587,6 +1587,10 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned
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
@@ -2268,6 +2272,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		if (flags & REF_NODEREF)
 			resolve_flags |= RESOLVE_REF_NO_RECURSE;
 	}
+	if (flags & REF_ALLOW_BROKEN)
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_SHA1;
 
 	refname = resolve_ref_unsafe(refname, resolve_flags,
 				     lock->old_sha1, &type);
diff --git a/refs.h b/refs.h
index cfc8d90..735f59f 100644
--- a/refs.h
+++ b/refs.h
@@ -176,11 +176,13 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
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
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 432921b..fa7d7bd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -163,6 +163,14 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
+test_expect_failure 'git branch -d can delete ref with broken sha1' '
+	echo "pointing nowhere" >.git/refs/heads/brokensha1 &&
+	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
+	git branch -d brokensha1 &&
+	git branch >output &&
+	! grep brokensha1 output
+'
+
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expected <<\EOF &&
-- 
2.2.0
