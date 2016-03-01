From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 05/33] refs: move resolve_ref_unsafe into common code
Date: Mon, 29 Feb 2016 19:52:38 -0500
Message-ID: <1456793586-22082-6-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZI-0006xI-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbcCAAxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:33 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36053 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbcCAAxb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:31 -0500
Received: by mail-qg0-f46.google.com with SMTP id u110so1409745qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3rVctSeQirupZpWSYJHGz0z2uSVizp8x+1+ZyXiShc=;
        b=itP2V64qvqIeOoc7QhLMylIkEtB1PQZ6rENkCQ3FmrcRbgQZUpQOrrXKWQpKDo8HEK
         XUAuhHfrP/XtVaJS3fBngH6Df12nYVBuCW+NkzZWBY4Cyvds6c0NRWiUBUXu9Q2gDAGA
         L9SPdlUeu+PFF+CCJrDnMh8hf4Np2XUxgIRD+j0CcK6kKWTDwd7uyvwrCdMNiIe/enc+
         h995XMtmtf1J3XVTOmejftlOZB+ZLbVAstGXvlCBvd+zpMr76/3C6QyzcmhRmF4djXzF
         exnPBSCBcoOcIDBRATZmwxzW68P45tTQvBg7Wuy6F3pbAqb1Bax8B3Yxlq+s8+WTCEX4
         H6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3rVctSeQirupZpWSYJHGz0z2uSVizp8x+1+ZyXiShc=;
        b=iGjMV0H5mNl1CA1eSSlRbsU01GdKtHGZhN8Ah7oF6qjZK5RH6xE20nMtsSfXBHNVjh
         1sT7WSfJTqaDqB9hzv4ZSQYfSQK9AMX3JPUTkUK8EtOf0t/GddLELKT2WtLPDFAKqc5m
         VRzCKK1055gV7Vqp9GgM/KWWt2qgdGMJMayNk7KdLEqT98BIN4PF1E06wdGv+GRcnSXy
         71hENvX2U9/ZrgQISuMbKTD0+8jNA80hGZ7WimDc9dul1izTxX9pG/s2GBgJsiP3o10m
         wViBi+ZPGj+z/y9EHMlrFwjA9dqbUOMcfs6DM4tF+lLs7o7zUbZ3nZcuvJSmUV6CXxP5
         it/g==
X-Gm-Message-State: AD7BkJKR+3DBTk8GLTmNfcpjxHJKOioOYVRtUgzc7djDVlAlHu/cjvPEA9s1XlcYZ8I4hQ==
X-Received: by 10.141.1.2 with SMTP id c2mr24549995qhd.32.1456793610606;
        Mon, 29 Feb 2016 16:53:30 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:29 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287946>

Now that resolve_ref_unsafe's only interaction with the backend is
through read_raw_ref, we can move it into the common code. Later,
we'll replace read_raw_ref with a backend function.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 115 ++-------------------------------------------------
 refs/refs-internal.h |   6 +++
 3 files changed, 114 insertions(+), 111 deletions(-)

diff --git a/refs.c b/refs.c
index b49c077..15aabc6 100644
--- a/refs.c
+++ b/refs.c
@@ -1161,3 +1161,107 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref(NULL, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
+/* This function needs to return a meaningful errno on failure */
+static const char *resolve_ref_1(const char *refname,
+				 int resolve_flags,
+				 unsigned char *sha1,
+				 int *flags,
+				 struct strbuf *sb_refname,
+				 struct strbuf *sb_path)
+{
+	int bad_name = 0;
+	int symref_count;
+
+	if (flags)
+		*flags = 0;
+
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (flags)
+			*flags |= REF_BAD_NAME;
+
+		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+		    !refname_is_safe(refname)) {
+			errno = EINVAL;
+			return NULL;
+		}
+		/*
+		 * dwim_ref() uses REF_ISBROKEN to distinguish between
+		 * missing refs and refs that were present but invalid,
+		 * to complain about the latter to stderr.
+		 *
+		 * We don't know whether the ref exists, so don't set
+		 * REF_ISBROKEN yet.
+		 */
+		bad_name = 1;
+	}
+
+	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
+		unsigned int read_flags = 0;
+
+		if (read_raw_ref(refname, sha1, sb_refname, sb_path, &read_flags)) {
+			int saved_errno = errno;
+			if (flags)
+				*flags |= read_flags;
+			errno = saved_errno;
+			if (bad_name) {
+				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
+			if (resolve_flags & RESOLVE_REF_READING || errno != ENOENT) {
+				return NULL;
+			} else {
+				hashclr(sha1);
+				return refname;
+			}
+		}
+		if (flags)
+			*flags |= read_flags;
+
+		if (!(read_flags & REF_ISSYMREF)) {
+			if (bad_name) {
+				hashclr(sha1);
+				if (flags)
+					*flags |= REF_ISBROKEN;
+			}
+			return refname;
+		}
+
+		refname = sb_refname->buf;
+		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
+			hashclr(sha1);
+			if (bad_name && flags)
+				*flags |= REF_ISBROKEN;
+			return refname;
+		}
+
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+			if (flags)
+				*flags |= REF_ISBROKEN;
+			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+			    !refname_is_safe(refname)) {
+				errno = EINVAL;
+				return NULL;
+			}
+			bad_name = 1;
+		}
+	}
+
+	if (flags)
+		*flags |= REF_ISBROKEN;
+	return NULL;
+}
+
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
+			       unsigned char *sha1, int *flags)
+{
+	static struct strbuf sb_refname = STRBUF_INIT;
+	struct strbuf sb_path = STRBUF_INIT;
+	const char *ret;
+
+	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
+			    &sb_refname, &sb_path);
+
+	strbuf_release(&sb_path);
+	return ret;
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8c6a58e..2fb7714 100644
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
@@ -1415,9 +1413,9 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * sb_path is workspace: the caller should allocate and free it.
  */
-static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, struct strbuf *sb_path,
-			unsigned int *flags)
+int read_raw_ref(const char *refname, unsigned char *sha1,
+		 struct strbuf *symref, struct strbuf *sb_path,
+		 unsigned int *flags)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	int ret = -1;
@@ -1535,111 +1533,6 @@ static int read_raw_ref(const char *refname, unsigned char *sha1,
 	return ret;
 }
 
-/* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_1(const char *refname,
-				 int resolve_flags,
-				 unsigned char *sha1,
-				 int *flags,
-				 struct strbuf *sb_refname,
-				 struct strbuf *sb_path)
-{
-	int bad_name = 0;
-	int symref_count;
-
-	if (flags)
-		*flags = 0;
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (flags)
-			*flags |= REF_BAD_NAME;
-
-		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-		    !refname_is_safe(refname)) {
-			errno = EINVAL;
-			return NULL;
-		}
-		/*
-		 * dwim_ref() uses REF_ISBROKEN to distinguish between
-		 * missing refs and refs that were present but invalid,
-		 * to complain about the latter to stderr.
-		 *
-		 * We don't know whether the ref exists, so don't set
-		 * REF_ISBROKEN yet.
-		 */
-		bad_name = 1;
-	}
-
-	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
-		unsigned int read_flags = 0;
-
-		if (read_raw_ref(refname, sha1, sb_refname, sb_path, &read_flags)) {
-			int saved_errno = errno;
-			if (flags)
-				*flags |= read_flags;
-			errno = saved_errno;
-			if (bad_name) {
-				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
-			}
-			if (resolve_flags & RESOLVE_REF_READING || errno != ENOENT) {
-				return NULL;
-			} else {
-				hashclr(sha1);
-				return refname;
-			}
-		}
-		if (flags)
-			*flags |= read_flags;
-
-		if (!(read_flags & REF_ISSYMREF)) {
-			if (bad_name) {
-				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
-			}
-			return refname;
-		}
-
-		refname = sb_refname->buf;
-		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-			hashclr(sha1);
-			if (bad_name && flags)
-				*flags |= REF_ISBROKEN;
-			return refname;
-		}
-
-		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-			if (flags)
-				*flags |= REF_ISBROKEN;
-			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(refname)) {
-				errno = EINVAL;
-				return NULL;
-			}
-			bad_name = 1;
-		}
-	}
-
-	if (flags)
-		*flags |= REF_ISBROKEN;
-	return NULL;
-}
-
-const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
-			       unsigned char *sha1, int *flags)
-{
-	static struct strbuf sb_refname = STRBUF_INIT;
-	struct strbuf sb_path = STRBUF_INIT;
-	const char *ret;
-
-	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path);
-
-	strbuf_release(&sb_path);
-	return ret;
-}
-
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 92aae80..979a136 100644
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
+		 struct strbuf *symref, struct strbuf *sb_path,
+		 unsigned int *flags);
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.4.2.767.g62658d5-twtrsrc
