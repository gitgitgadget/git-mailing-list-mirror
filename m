From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 21/26] refs.c: move peel_object to the common code
Date: Thu, 15 Oct 2015 15:46:45 -0400
Message-ID: <1444938410-2345-22-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoV6-00074w-SH
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbbJOTrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:33 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33832 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbbJOTrb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:31 -0400
Received: by qgez77 with SMTP id z77so81134618qge.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRxItehXh6tZO6OBqNe0tXxHmYGFVG4exqvJ1VcvCok=;
        b=kkow9rHizQ2xjHi9cA9eBQXPIenE9QLFOpo5SJk427y6eNy8E0Gepi5d4LPZFifU+V
         EMlMyNYXxo6hU7+AS2d1ZFPwCX1DO2Cqy9FtfPCPmyMeXpSIfqGlSMcIY3MK7/oa5DA2
         3msKYG/TMx1sReb9Y1Zr1XGaHcEHxuDODWgi7I0T71zQ8TfTz1gOepdSLbgxDQVDDYDh
         YOe1uGcD1Tvv6FkMhn4T3FUNnh1PsJB6GpO6LvVgVM+F2FOqr5ko8Y+kVL/s/04ORmwh
         AnkZ8MwbL49jIsPctr5dx4jCBb8A9q4K2UQ0PGB9EQgOrFORo3NYe1YKFArGM8+Jnnoo
         h1yg==
X-Gm-Message-State: ALoCoQmpIqzrrI8/8q6DLVEK9wPMy9gH16YgJDjxpoz6jtMO4yNCSza7FLE9xE9/H5VCkAfRWtwn
X-Received: by 10.140.201.78 with SMTP id w75mr14394555qha.86.1444938450531;
        Thu, 15 Oct 2015 12:47:30 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279691>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 53 -----------------------------------------------------
 refs.c          | 23 +++++++++++++++++++++++
 refs.h          | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 53 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 4b6bf29..ef600d8 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1600,59 +1600,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-enum peel_status {
-	/* object was peeled successfully: */
-	PEEL_PEELED = 0,
-
-	/*
-	 * object cannot be peeled because the named object (or an
-	 * object referred to by a tag in the peel chain), does not
-	 * exist.
-	 */
-	PEEL_INVALID = -1,
-
-	/* object cannot be peeled because it is not a tag: */
-	PEEL_NON_TAG = -2,
-
-	/* ref_entry contains no peeled value because it is a symref: */
-	PEEL_IS_SYMREF = -3,
-
-	/*
-	 * ref_entry cannot be peeled because it is broken (i.e., the
-	 * symbolic reference cannot even be resolved to an object
-	 * name):
-	 */
-	PEEL_BROKEN = -4
-};
-
-/*
- * Peel the named object; i.e., if the object is a tag, resolve the
- * tag recursively until a non-tag is found.  If successful, store the
- * result to sha1 and return PEEL_PEELED.  If the object is not a tag
- * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
- * and leave sha1 unchanged.
- */
-static enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
-{
-	struct object *o = lookup_unknown_object(name);
-
-	if (o->type == OBJ_NONE) {
-		int type = sha1_object_info(name, NULL);
-		if (type < 0 || !object_as_type(o, type, 0))
-			return PEEL_INVALID;
-	}
-
-	if (o->type != OBJ_TAG)
-		return PEEL_NON_TAG;
-
-	o = deref_tag_noverify(o);
-	if (!o)
-		return PEEL_INVALID;
-
-	hashcpy(sha1, o->sha1);
-	return PEEL_PEELED;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
diff --git a/refs.c b/refs.c
index 16280d5..e7f6c77 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,8 @@
 #include "cache.h"
 #include "refs.h"
 #include "lockfile.h"
+#include "object.h"
+#include "tag.h"
 
 static int is_per_worktree_ref(const char *refname)
 {
@@ -995,3 +997,24 @@ int refname_is_safe(const char *refname)
 	}
 	return 1;
 }
+
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1)
+{
+	struct object *o = lookup_unknown_object(name);
+
+	if (o->type == OBJ_NONE) {
+		int type = sha1_object_info(name, NULL);
+		if (type < 0 || !object_as_type(o, type, 0))
+			return PEEL_INVALID;
+	}
+
+	if (o->type != OBJ_TAG)
+		return PEEL_NON_TAG;
+
+	o = deref_tag_noverify(o);
+	if (!o)
+		return PEEL_INVALID;
+
+	hashcpy(sha1, o->sha1);
+	return PEEL_PEELED;
+}
diff --git a/refs.h b/refs.h
index fc0611d..3fb480b 100644
--- a/refs.h
+++ b/refs.h
@@ -76,6 +76,40 @@ extern int is_branch(const char *refname);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
+enum peel_status {
+	/* object was peeled successfully: */
+	PEEL_PEELED = 0,
+
+	/*
+	 * object cannot be peeled because the named object (or an
+	 * object referred to by a tag in the peel chain), does not
+	 * exist.
+	 */
+	PEEL_INVALID = -1,
+
+	/* object cannot be peeled because it is not a tag: */
+	PEEL_NON_TAG = -2,
+
+	/* ref_entry contains no peeled value because it is a symref: */
+	PEEL_IS_SYMREF = -3,
+
+	/*
+	 * ref_entry cannot be peeled because it is broken (i.e., the
+	 * symbolic reference cannot even be resolved to an object
+	 * name):
+	 */
+	PEEL_BROKEN = -4
+};
+
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave sha1 unchanged.
+ */
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
+
 /**
  * Resolve refname in the nested "gitlink" repository that is located
  * at path.  If the resolution is successful, return 0 and set sha1 to
-- 
2.4.2.644.g97b850b-twtrsrc
