From: David Turner <dturner@twopensource.com>
Subject: [PATCH 23/24] refs: move resolve_ref_unsafe into common code
Date: Thu,  7 Apr 2016 15:03:10 -0400
Message-ID: <1460055791-23313-24-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:04:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFEC-0007fu-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbcDGTDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:51 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33698 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbcDGTDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:48 -0400
Received: by mail-qk0-f169.google.com with SMTP id k135so31094093qke.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XzZow4g6thUT8R9ccU4ypmS3SMMdXJFi03GEtTHG9U8=;
        b=C7qd1JcedJouw4e4RandI7nRmObK3mTx1+1jVtrrhBsDG+d++nThb59A6+LWvLOapw
         EFzoeEezegh52fYgNpKeASC3Im0LKoSWdOfH4DVrzlTkQHmmX3/6xDrsT2LI0gTXSbpR
         lm13Cwgs74NG+axqBPCmL6npw/f3kk6EiWwwMp83Agdf8VEIoz39SbokGBOgzgfmO0eu
         bnmvHDx0iK9ImZ8ygjWpkwoFTX0MMwrVGZ6ekmlULVRQx9ZRd3N2S30/PWNvJNJ+QnrR
         r3K8dpas5k8lJ1JWfePDPZVeUcLEkBk4ubfBSl2H4WTHfDwZPHtcNc5dkB2g4O/ySfWb
         QIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XzZow4g6thUT8R9ccU4ypmS3SMMdXJFi03GEtTHG9U8=;
        b=czr0r+EkIC0vr+OciY1mlQiuUw7RO+rjG7qdvbyLWOd6W/Sj0euCmYp/gjQ6LIabFz
         jFClzZlqA6UG2DPvirwh8tAx+s3cAh8Hnt+ChhSDEwncaWGV7jdbCFnnYciYXw3Vltq4
         YptvJvpMIUkRMkZlC/ef12RUGfoXOZ7gEo/3boyWqXoXgaW/MmWjCaCtn+P3eXrx9VQm
         w5JhUynmNCSyBCFah4lCHjBD6pYKbrVAjxDUWariVVqpf0Gr8jBv/9nN5c0bsAW5+CYQ
         wCpfOhrkVJZU286FvhvhQDXIrNxOjIjKlosrxUIdgxFeCN5LZutgMb9Rcb/NhSQ5b5mE
         2qKA==
X-Gm-Message-State: AD7BkJJ7bUzcpHcI0Uo/WFFR4YtjzsqxG4xFlOVNRnWwC5RGmc4H3AT62ISdSTVd57ocBg==
X-Received: by 10.55.42.147 with SMTP id q19mr2143312qkq.99.1460055826282;
        Thu, 07 Apr 2016 12:03:46 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:45 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290966>

Now that resolve_ref_unsafe's only interaction with the backend is
through read_raw_ref, we can move it into the common code. Later,
we'll replace read_raw_ref with a backend function.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 82 ++--------------------------------------------------
 refs/refs-internal.h |  6 ++++
 3 files changed, 83 insertions(+), 79 deletions(-)

diff --git a/refs.c b/refs.c
index f0feff7..87dc82f 100644
--- a/refs.c
+++ b/refs.c
@@ -1155,3 +1155,77 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(NULL, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
+
+/* This function needs to return a meaningful errno on failure */
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	static struct strbuf sb_refname = STRBUF_INIT;
+	int unused_flags;
+	int symref_count;
+
+	if (!flags)
+		flags = &unused_flags;
+
+	*flags = 0;
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+		    !refname_is_safe(refname)) {
+			errno = EINVAL;
+			return NULL;
+		}
+
+		/*
+		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * missing refs and refs that were present but invalid,
+		 * to complain about the latter to stderr.
+		 *
+		 * We don't know whether the ref exists, so don't set
+		 * REF_ISBROKEN yet.
+		 */
+		*flags |= REF_BAD_NAME;
+	}
+
+	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
+		unsigned int read_flags = 0;
+
+		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
+			*flags |= read_flags;
+			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
+				return NULL;
+			hashclr(sha1);
+			if (*flags & REF_BAD_NAME)
+				*flags |= REF_ISBROKEN;
+			return refname;
+		}
+
+		*flags |= read_flags;
+
+		if (!(read_flags & REF_ISSYMREF)) {
+			if (*flags & REF_BAD_NAME) {
+				hashclr(sha1);
+				*flags |= REF_ISBROKEN;
+			}
+			return refname;
+		}
+
+		refname = sb_refname.buf;
+		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
+			hashclr(sha1);
+			return refname;
+		}
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+			    !refname_is_safe(refname)) {
+				errno = EINVAL;
+				return NULL;
+			}
+
+			*flags |= REF_ISBROKEN | REF_BAD_NAME;
+		}
+	}
+
+	errno = ELOOP;
+	return NULL;
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a15986c..71848ab 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1269,8 +1269,6 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
-/* We allow "recursive" symbolic refs. Only within reason, though */
-#define MAXDEPTH 5
 #define MAXREFLEN (1024)
 
 /*
@@ -1300,7 +1298,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	char buffer[128], *p;
 	char *path;
 
-	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
+	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
 	path = *refs->name
 		? git_pathdup_submodule(refs->name, "%s", refname)
@@ -1420,8 +1418,8 @@ static int resolve_missing_loose_ref(const char *refname,
  * - in all other cases, symref will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, unsigned int *flags)
+int read_raw_ref(const char *refname, unsigned char *sha1,
+		 struct strbuf *symref, unsigned int *flags)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
@@ -1538,80 +1536,6 @@ out:
 	return ret;
 }
 
-/* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
-{
-	static struct strbuf sb_refname = STRBUF_INIT;
-	int unused_flags;
-	int symref_count;
-
-	if (!flags)
-		flags = &unused_flags;
-
-	*flags = 0;
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-		    !refname_is_safe(refname)) {
-			errno = EINVAL;
-			return NULL;
-		}
-
-		/*
-		 * dwim_ref() uses REF_ISBROKEN to distinguish between
-		 * missing refs and refs that were present but invalid,
-		 * to complain about the latter to stderr.
-		 *
-		 * We don't know whether the ref exists, so don't set
-		 * REF_ISBROKEN yet.
-		 */
-		*flags |= REF_BAD_NAME;
-	}
-
-	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
-		unsigned int read_flags = 0;
-
-		if (read_raw_ref(refname, sha1, &sb_refname, &read_flags)) {
-			*flags |= read_flags;
-			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
-				return NULL;
-			hashclr(sha1);
-			if (*flags & REF_BAD_NAME)
-				*flags |= REF_ISBROKEN;
-			return refname;
-		}
-
-		*flags |= read_flags;
-
-		if (!(read_flags & REF_ISSYMREF)) {
-			if (*flags & REF_BAD_NAME) {
-				hashclr(sha1);
-				*flags |= REF_ISBROKEN;
-			}
-			return refname;
-		}
-
-		refname = sb_refname.buf;
-		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-			hashclr(sha1);
-			return refname;
-		}
-		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(refname)) {
-				errno = EINVAL;
-				return NULL;
-			}
-
-			*flags |= REF_ISBROKEN | REF_BAD_NAME;
-		}
-	}
-
-	errno = ELOOP;
-	return NULL;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 92aae80..3a4f634 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -197,6 +197,8 @@ const char *find_descendant_ref(const char *dirname,
 
 int rename_ref_available(const char *oldname, const char *newname);
 
+/* We allow "recursive" symbolic refs. Only within reason, though */
+#define SYMREF_MAXDEPTH 5
 
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
@@ -206,4 +208,8 @@ int rename_ref_available(const char *oldname, const char *newname);
  */
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
+
+int read_raw_ref(const char *refname, unsigned char *sha1,
+		 struct strbuf *symref, unsigned int *flags);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
