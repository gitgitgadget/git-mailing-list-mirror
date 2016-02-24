From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 03/32] files-backend: break out ref reading
Date: Wed, 24 Feb 2016 17:58:35 -0500
Message-ID: <1456354744-8022-4-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQr-0004uX-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbcBXXBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:01:16 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34846 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759048AbcBXW7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:21 -0500
Received: by mail-qg0-f49.google.com with SMTP id y89so26977570qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xCYwuPgHYbUuy8bw8Hptig/yHvI9wPFCxmLNJma8w0=;
        b=VdqZppM+bXHmuNEx+KTjZQOTIFhytzH/xVXrhtOerC64zqwj42fs4+ooyyvt1CT8Ml
         lKJ+7hPIsHbnKfOu6H56FIov3PKs5PZTtLFJG6+Sy5J4GkLLPlwg3dy+QIwwt4xajFB3
         4Yqu+9VW08EetkiNl9pAjXrL06zBnxslixBkQbrbym5qoLmP0H7wSuEF6UpCoM+Elgzd
         iNDOtID1htIpXWny600ZzaB/dwtN6SDvddUdW1vGZj1mw5o3UKKltaq1Os5nCiUIa/Nq
         6FkI/tRjLo4pl6TDR76j/sqDcw54RZ3XD43UzWs88hDlQeT8II3FSkuUjpyDjsjQNhMA
         1ZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xCYwuPgHYbUuy8bw8Hptig/yHvI9wPFCxmLNJma8w0=;
        b=NNObwxqAC9jxTPSk57iZPvRS2LH/BiUnYoAOk+GElyCLV9pTlsT9gpGkFExuCd6CgG
         m9ajZ/+2E3lcgVW2JGIOukjMsFsT4xFiCpGbolLhILHM/cOyUyCJa/tCupXLb6vIafmR
         tV3aEZu+7xaDpnlnjHv64s+BYKtmxVLeWqAvzHj9sGWjHDtAcuaE9j0QgzXN6C6NkPVr
         WBisXtls+MPXL8MN44EiuZkWWZGHYLMEum1nmswo0oe88K2UWl6wT+a8IAV01ki+g1BA
         +0CEr6OjCyc3eDa1vtTFzZZd8g1pu7NtcXufMPsd3dHRuEya5UUibME2QBMaxTRcbnDJ
         Uq9A==
X-Gm-Message-State: AG10YOQRKOmAJ8AfcP4U2BX2z+lZGd+Lxx9XHPsyCdjlBWnbLb6M0vLk335O1qmjmPHSmg==
X-Received: by 10.140.221.16 with SMTP id r16mr24887217qhb.67.1456354755559;
        Wed, 24 Feb 2016 14:59:15 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:14 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287273>

Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
is responsible for reading ref data from the ref storage.

Later, we will make read_raw_ref a pluggable backend function, and make
resolve_ref_unsafe common.

Testing done: Hacked in code to run both old and new version of
resolve_ref_1 and compare all outputs, failing dramatically if outputs
differed.  Ran test suite.

Signed-off-by: David Turner <dturner@twopensource.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
---
 refs/files-backend.c | 265 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 159 insertions(+), 106 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fd664d6..ef5f28d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1377,10 +1377,9 @@ static struct ref_entry *get_packed_ref(const char *refname)
 
 /*
  * A loose ref file doesn't exist; check for a packed ref.  The
- * options are forwarded from resolve_safe_unsafe().
+ * options are forwarded from resolve_ref_unsafe().
  */
 static int resolve_missing_loose_ref(const char *refname,
-				     int resolve_flags,
 				     unsigned char *sha1,
 				     int *flags)
 {
@@ -1398,64 +1397,48 @@ static int resolve_missing_loose_ref(const char *refname,
 		return 0;
 	}
 	/* The reference is not a packed reference, either. */
-	if (resolve_flags & RESOLVE_REF_READING) {
-		errno = ENOENT;
-		return -1;
-	} else {
-		hashclr(sha1);
-		return 0;
-	}
+	errno = ENOENT;
+	return -1;
 }
 
-/* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_1(const char *refname,
-				 int resolve_flags,
-				 unsigned char *sha1,
-				 int *flags,
-				 struct strbuf *sb_refname,
-				 struct strbuf *sb_path,
-				 struct strbuf *sb_contents)
+/*
+ * Read a raw ref from the filesystem or packed refs file.
+ *
+ * If the ref is a sha1, fill in sha1 and return 0.
+ *
+ * If the ref is symbolic, fill in *symref with the referrent
+ * (e.g. "refs/heads/master") and return 0.  The caller is responsible
+ * for validating the referrent.  Set REF_ISSYMREF in flags.
+ *
+ * If the ref is neither a symbolic ref nor a sha1, it is broken.  Set
+ * REF_ISBROKEN in flags, set errno to EINVAL, and return -1.
+ *
+ * If the ref doesn't exist, set errno to ENOENT and return -1.
+ *
+ * If there is another error reading the ref, set errno appropriately and
+ * return -1.
+ *
+ * Backend-specific flags might be set in flags as well, regardless of
+ * outcome.
+ *
+ * sb_path is workspace: the caller should allocate and free it.
+ */
+static int read_raw_ref(const char *refname, unsigned char *sha1,
+			struct strbuf *symref, struct strbuf *sb_path,
+			unsigned int *flags)
 {
-	int depth = MAXDEPTH;
-	int bad_name = 0;
-
-	if (flags)
-		*flags = 0;
+	struct strbuf sb_contents = STRBUF_INIT;
+	int ret = -1;
+	const char *path;
+	const char *buf;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (flags)
-			*flags |= REF_BAD_NAME;
+	strbuf_reset(sb_path);
+	strbuf_git_path(sb_path, "%s", refname);
+	path = sb_path->buf;
 
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
-	for (;;) {
-		const char *path;
+	for(;;) {
 		struct stat st;
-		char *buf;
 		int fd;
-
-		if (--depth < 0) {
-			errno = ELOOP;
-			return NULL;
-		}
-
-		strbuf_reset(sb_path);
-		strbuf_git_path(sb_path, "%s", refname);
-		path = sb_path->buf;
-
 		/*
 		 * We might have to loop back here to avoid a race
 		 * condition: first we lstat() the file, then we try
@@ -1465,49 +1448,45 @@ static const char *resolve_ref_1(const char *refname,
 		 * we don't want to report that as an error but rather
 		 * try again starting with the lstat().
 		 */
-	stat_ref:
+
 		if (lstat(path, &st) < 0) {
 			if (errno != ENOENT)
-				return NULL;
-			if (resolve_missing_loose_ref(refname, resolve_flags,
-						      sha1, flags))
-				return NULL;
-			if (bad_name) {
-				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
-			}
-			return refname;
+				break;
+			if (resolve_missing_loose_ref(refname, sha1, flags)) 
+				break;
+			ret = 0;
+			break;
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
-			strbuf_reset(sb_contents);
-			if (strbuf_readlink(sb_contents, path, 0) < 0) {
+			strbuf_reset(&sb_contents);
+			if (strbuf_readlink(&sb_contents, path, 0) < 0) {
 				if (errno == ENOENT || errno == EINVAL)
 					/* inconsistent with lstat; retry */
-					goto stat_ref;
+					continue;
 				else
-					return NULL;
+					break;
 			}
-			if (starts_with(sb_contents->buf, "refs/") &&
-			    !check_refname_format(sb_contents->buf, 0)) {
-				strbuf_swap(sb_refname, sb_contents);
-				refname = sb_refname->buf;
+			if (starts_with(sb_contents.buf, "refs/") &&
+			    !check_refname_format(sb_contents.buf, 0)) {
+				strbuf_swap(&sb_contents, symref);
 				if (flags)
 					*flags |= REF_ISSYMREF;
-				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-					hashclr(sha1);
-					return refname;
-				}
-				continue;
+				ret = 0;
+				break;
+			} else {
+				/* bogus symlink ref  */
+				if (flags)
+					*flags |= REF_ISBROKEN;
+				break;
 			}
 		}
 
 		/* Is it a directory? */
 		if (S_ISDIR(st.st_mode)) {
 			errno = EISDIR;
-			return NULL;
+			break;
 		}
 
 		/*
@@ -1518,35 +1497,110 @@ static const char *resolve_ref_1(const char *refname,
 		if (fd < 0) {
 			if (errno == ENOENT)
 				/* inconsistent with lstat; retry */
-				goto stat_ref;
+				continue;
 			else
-				return NULL;
+				break;
 		}
-		strbuf_reset(sb_contents);
-		if (strbuf_read(sb_contents, fd, 256) < 0) {
+		strbuf_reset(&sb_contents);
+		if (strbuf_read(&sb_contents, fd, 256) < 0) {
 			int save_errno = errno;
 			close(fd);
 			errno = save_errno;
-			return NULL;
+			break;
 		}
 		close(fd);
-		strbuf_rtrim(sb_contents);
+		strbuf_rtrim(&sb_contents);
+		buf = sb_contents.buf;
+		if (starts_with(buf, "ref:")) {
+			buf += 4;
+			while (isspace(*buf))
+				buf++;
+
+			strbuf_reset(symref);
+			strbuf_addstr(symref, buf);
+			if (flags)
+				*flags |= REF_ISSYMREF;
+			ret = 0;
+			break;
+		}
 
 		/*
-		 * Is it a symbolic ref?
+		 * Please note that FETCH_HEAD has additional
+		 * data after the sha.
 		 */
-		if (!starts_with(sb_contents->buf, "ref:")) {
-			/*
-			 * Please note that FETCH_HEAD has a second
-			 * line containing other data.
-			 */
-			if (get_sha1_hex(sb_contents->buf, sha1) ||
-			    (sb_contents->buf[40] != '\0' && !isspace(sb_contents->buf[40]))) {
+		if (get_sha1_hex(buf, sha1) ||
+		    (buf[40] != '\0' && !isspace(buf[40]))) {
+			if (flags)
+				*flags |= REF_ISBROKEN;
+			errno = EINVAL;
+			break;
+		}
+		ret = 0;
+		break;
+	}
+
+	strbuf_release(&sb_contents);
+	return ret;
+}
+
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
+	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
+		int read_flags = 0;
+
+		if (read_raw_ref(refname, sha1, sb_refname, sb_path, &read_flags)) {
+			int saved_errno = errno;
+			if (flags)
+				*flags |= read_flags;
+			errno = saved_errno;
+			if (bad_name) {
+				hashclr(sha1);
 				if (flags)
 					*flags |= REF_ISBROKEN;
-				errno = EINVAL;
+			}
+			if (resolve_flags & RESOLVE_REF_READING || errno != ENOENT) {
 				return NULL;
+			} else {
+				hashclr(sha1);
+				return refname;
 			}
+		}
+		if (flags)
+			*flags |= read_flags;
+
+		if (!(read_flags & REF_ISSYMREF)) {
 			if (bad_name) {
 				hashclr(sha1);
 				if (flags)
@@ -1554,44 +1608,43 @@ static const char *resolve_ref_1(const char *refname,
 			}
 			return refname;
 		}
-		if (flags)
-			*flags |= REF_ISSYMREF;
-		buf = sb_contents->buf + 4;
-		while (isspace(*buf))
-			buf++;
-		strbuf_reset(sb_refname);
-		strbuf_addstr(sb_refname, buf);
+
 		refname = sb_refname->buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
+			if (bad_name && flags)
+				*flags |= REF_ISBROKEN;
 			return refname;
 		}
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
+
+		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (flags)
 				*flags |= REF_ISBROKEN;
-
 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(buf)) {
+			    !refname_is_safe(refname)) {
 				errno = EINVAL;
 				return NULL;
 			}
 			bad_name = 1;
 		}
 	}
+
+	if (flags)
+		*flags |= REF_ISBROKEN;
+	return NULL;
 }
 
 const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
-	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *ret;
 
 	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path, &sb_contents);
+			    &sb_refname, &sb_path);
+
 	strbuf_release(&sb_path);
-	strbuf_release(&sb_contents);
 	return ret;
 }
 
-- 
2.4.2.767.g62658d5-twtrsrc
