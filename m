From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 26/43] refs.c: move peel_object to the common code
Date: Mon, 28 Sep 2015 18:02:01 -0400
Message-ID: <1443477738-32023-27-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggX6-00025S-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbbI1WEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:04:23 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:35008 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbbI1WDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:24 -0400
Received: by qgt47 with SMTP id 47so133559506qgt.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gf0BPg+IrLKOwglaRFWVXFIxp6maEuGYZybdghi0OvA=;
        b=Bh0Pc1oHSbYU+qngfVqXV5qGEnc2QY+PNc0ZwTwkzpe9BN6oFpMzJzd7tJBZQTtu0x
         yoFyqJPQmePijd9yv9SCKvaNs6AiBVk2bMg1g7yvir3ZqHA8Z62JtQc/Eq74hd30gR3O
         jFiSGqUFYjgrpMYAfjj56khaAIc2BVSiCw40JMCwid8t2/nODnIQe/N0elQ7EUmL7bC+
         71MrWnziqZpUjiG7KP/7piPWaF2Hl4XoKxxvN/u35sn5Oivb8tUz8dmlVx+SvtjuN1C0
         gDzdV+SnJRtFj+Eh6T8JMfEGa6L1fJVXh4Cbkn7kt7nkqzatVHyQj4ElCZe7JbBUKi++
         ihmg==
X-Gm-Message-State: ALoCoQnx3adkS83JP1EdbeYH/zNOsU+SLZhAlhbSV6Id8hL+DZC+xKrnv2n9vUgokYmZph5/8IFB
X-Received: by 10.140.82.163 with SMTP id h32mr24870602qgd.29.1443477803231;
        Mon, 28 Sep 2015 15:03:23 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278782>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 53 -----------------------------------------------------
 refs.c          | 31 +++++++++++++++++++++++++++++++
 refs.h          | 27 +++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 8898e86..5971526 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1651,59 +1651,6 @@ static const char *files_resolve_ref_unsafe(const char *refname,
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
index db650b6..d13b854 100644
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
@@ -951,6 +954,34 @@ int refname_is_safe(const char *refname)
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
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index c224f0e..60a98cf 100644
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
