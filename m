From: David Turner <dturner@twopensource.com>
Subject: [PATCH 26/43] refs.c: move peel_object to the common code
Date: Wed,  2 Sep 2015 21:54:56 -0400
Message-ID: <1441245313-11907-27-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJlz-0006yC-45
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbbICB4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:56:07 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34992 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbbICB4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:56:01 -0400
Received: by qkcj187 with SMTP id j187so15701223qkc.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77ffq//sDdi5I+95JXCdRps5fGKKWnBwTd1zwKPbAxE=;
        b=c7RgCsjlgRRJ8gCZn5dYWtZiK50s7R8YxewmxDJHX798DNKjZN1U5RzExVG5eRIEUd
         UXQRXDUDT1HMcAQb3YlrgdGYsnRK+gAa9lRGFFczpd54xwxleMgn/zwvy++UU+OwuUQd
         mUSsGA4y+sBhDjYRQqmiyz8uqJrC31jvTBBpnh6wjI7SO00qvtqk0zWrkMvDnacEcdqc
         vjRjBy/9LQA7gwP5xJKZZ/nuHliMNSg+PTPkFlAegjVM4PmXSLOaABrd5mnXN6Wlcqbm
         cfho9j5+K4qkK3Z6/CNojew0lUkaZLLyRHAp2SuHthMz0P7TZEVHmu7kqvCI2YlVzj6y
         hGqw==
X-Gm-Message-State: ALoCoQlf1AWw8oAPDTtV0LjDQFn5XCE04ql/SDed8c6c4UPM32LIXSiQ+Lc6PJRNYkxz+9WSeTmy
X-Received: by 10.55.221.199 with SMTP id u68mr32611545qku.83.1441245361165;
        Wed, 02 Sep 2015 18:56:01 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.56.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:56:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277167>

This function does not contain any backend specific code so we
move it to the common code.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 53 -----------------------------------------------------
 refs.c          | 31 +++++++++++++++++++++++++++++++
 refs.h          | 27 +++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index bb208a5..657b58f 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1648,59 +1648,6 @@ static const char *files_resolve_ref_unsafe(const char *refname,
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
index fdd1b50..77aa51d 100644
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
index 049f2c7..0eab5e2 100644
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
2.0.4.315.gad8727a-twtrsrc
