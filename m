From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 04/32] refs: move resolve_ref_unsafe into common code
Date: Wed, 24 Feb 2016 17:58:36 -0500
Message-ID: <1456354744-8022-5-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPJ-0003fn-02
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759082AbcBXW7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:22 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34856 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759040AbcBXW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:17 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so26977884qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpkPSocR5d4N54jYyGxeWmZe0qCfJpoYeDnp4HnDSSE=;
        b=K+vsdkmaVzc9Vzcx7nPxQStz5RKrs6F/PjBvtU7CReaYBK2VAmsnJ3OqFEonrkI3Eh
         3sX+yvRXnxbQVOC69iymhds4wk+TflH6AwXS0K3eNWvYXyJJlM7d27gKbRiI4qoNTpqT
         dtX+kvBPmjPfWivHZdNE1bknCdfPKjwUxdR45TR0fjAip9TxhV8UqieApVlFxTCumP3F
         etjaRwHrR3tJ2B1IzPEKGyfCc0YaS1NpJhJ8f2h3TFQosoYtsewsYUaR5xfdKkaGSE86
         W/FzJoTljw/+Z5qGJcuuwdA4W2zhj4DAG2Zv54O+J0MSgFqna7wqzWWDb1dDz+hM+2pQ
         1FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gpkPSocR5d4N54jYyGxeWmZe0qCfJpoYeDnp4HnDSSE=;
        b=fxPbQP8Nh11NDXWkpILyn/HAkZn5Ii1Ea2LhVC49ZveqUo8ZioB8iFF6FeDe77vZZR
         Pg8WRDBiVvhv8vdEyxICTi47FiNqfrrO91PuqiyDSe8KzNaxO3UdpfBhgtT2LdnEargh
         6FTi4GjnCL6ou7rtzcX24VQvXlm0eP8+ZNvbBWQPouziVouiMbuKTyslapv0pU8bV4wo
         OLpGvePim3rvTiURyWsDlCB39XVQofNNVlb/o6XQv9djH9l9USldX31TrIle0pALh9iQ
         wWXRctg1EhSeOr1Mf/ucwskHLQWYDh+Xgymf8WnMMV+bjD9FId3uRael1ZLMZY/HojIA
         fpBQ==
X-Gm-Message-State: AG10YOQOc9UYP2zijsz2RsLQ2d7R9i/g+A4Ar6f/1dM4aEqR7U6P0Bkvy+ob+27Zh8Q3/w==
X-Received: by 10.140.81.231 with SMTP id f94mr5462039qgd.25.1456354756799;
        Wed, 24 Feb 2016 14:59:16 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:15 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287243>

Now that resolve_ref_unsafe's only interaction with the backend is
through read_raw_ref, we can move it into the common code. Later,
we'll replace read_raw_ref with a backend function.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c | 115 ++-------------------------------------------------
 refs/refs-internal.h |   6 +++
 3 files changed, 114 insertions(+), 111 deletions(-)

diff --git a/refs.c b/refs.c
index c38311b..f4c0a85 100644
--- a/refs.c
+++ b/refs.c
@@ -1157,3 +1157,107 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
+		int read_flags = 0;
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
index ef5f28d..5749eff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1277,8 +1277,6 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
-/* We allow "recursive" symbolic refs. Only within reason, though */
-#define MAXDEPTH 5
 #define MAXREFLEN (1024)
 
 /*
@@ -1308,7 +1306,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 	char buffer[128], *p;
 	char *path;
 
-	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
+	if (recursion > SYMREF_MAXDEPTH || strlen(refname) > MAXREFLEN)
 		return -1;
 	path = *refs->name
 		? git_pathdup_submodule(refs->name, "%s", refname)
@@ -1423,9 +1421,9 @@ static int resolve_missing_loose_ref(const char *refname,
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
@@ -1543,111 +1541,6 @@ static int read_raw_ref(const char *refname, unsigned char *sha1,
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
-		int read_flags = 0;
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
