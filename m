From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 27/44] refs.c: move peel_object to the common code
Date: Mon, 12 Oct 2015 17:51:48 -0400
Message-ID: <1444686725-27660-29-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:53:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll2W-0005hH-0H
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbJLVxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:53:47 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35556 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbJLVwo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:44 -0400
Received: by qgt47 with SMTP id 47so129534439qgt.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTEy39QsOg8DuR4I1ZKLXACPvKJFXpTb9yJAFOSXy8E=;
        b=mg7RcTgWR3VUV/SNazQTggxB30UECAzggu9aXxZUJGOD39ZVoEf6y9GR9GmARiQvLa
         Fz/Ir2q3n8c52YEawDsdD/rs/kQxcqNFYvkSB2nru72Rq7j1fL8y2f29jkJVBRnQQzvU
         td6kgVm7Fp7Pjmf/IvfxohL4Plg9T+rb+ncSdr8p1KD+6hX8avGQGi+rijUkHJNxpjbC
         Drhyo/Zi9Wza/5v+l2FFic8Pae99lcHuRl+fcULzBHMrEEBYixoojVZUiED7S6CT8SkB
         3DsjfSrZ3CNqwFi+dO7LXyj+wz1GM3y+jVlXSRMpn8uztpZSlyjBFcxq2c6t2eEhfSIW
         9ulA==
X-Gm-Message-State: ALoCoQkotZYB6XvvuysBlrtBuTR2xEReWlxaY9XBBxUHJMm+EgFZi9qfCAn43keNKyCtuImDXBwx
X-Received: by 10.140.108.102 with SMTP id i93mr34830390qgf.27.1444686763523;
        Mon, 12 Oct 2015 14:52:43 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:42 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279449>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 53 -----------------------------------------------------
 refs.c          | 31 +++++++++++++++++++++++++++++++
 refs.h          | 27 +++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 830b5a1..bf2fd7a 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1604,59 +1604,6 @@ static const char *files_resolve_ref_unsafe(const char *refname,
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
index bd8c71b..99b31f6 100644
--- a/refs.c
+++ b/refs.c
@@ -4,6 +4,9 @@
 #include "cache.h"
 #include "refs.h"
 #include "lockfile.h"
+#include "object.h"
+#include "tag.h"
+
 /*
  * We always have a files backend and it is the default.
  */
@@ -1059,6 +1062,34 @@ int refname_is_safe(const char *refname)
 	return 1;
 }
 
+/*
+ * Peel the named object; i.e., if the object is a tag, resolve the
+ * tag recursively until a non-tag is found.  If successful, store the
+ * result to sha1 and return PEEL_PEELED.  If the object is not a tag
+ * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
+ * and leave sha1 unchanged.
+ */
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
+
 /* backend functions */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
diff --git a/refs.h b/refs.h
index 3da5d09..636f959 100644
--- a/refs.h
+++ b/refs.h
@@ -76,6 +76,33 @@ extern int is_branch(const char *refname);
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
+enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
+
 /**
  * Resolve refname in the nested "gitlink" repository that is located
  * at path.  If the resolution is successful, return 0 and set sha1 to
-- 
2.4.2.644.g97b850b-twtrsrc
