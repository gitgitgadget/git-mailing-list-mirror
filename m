From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 04/33] files-backend: break out ref reading
Date: Mon, 29 Feb 2016 19:52:37 -0500
Message-ID: <1456793586-22082-5-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:54:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaN-0007bz-WA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbcCAAxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:34 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36042 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcCAAxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:30 -0500
Received: by mail-qg0-f41.google.com with SMTP id u110so1409418qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rMyj9g23MpUmAEsmXi4rsHGrGtCX48owvW0wtW0SQpM=;
        b=KVxA/+Z6HJcqFNNCm0SKht2GdzGvo2e2RvVePhOOHMcTuhS8bWhPpOCyJKm+wqBeJk
         Cr5yAIzyEbS936B2LR+fcMgqk6O5wvuhZBuaVrWRh9GS2hFZsSKegmFiGW7rgtOBa3Ta
         TlUFCeJy+zgkQNZRtD5Hcukll/d8R5UzxPr0IKAaY4BC8OVksA6HKo9ep19S9kYThYjp
         RocYhHgE6Xtw7wBs9IFG5anbEfArtdIPnV2NVZeiczipYPQgT+zEy3bSM4uZ1akDgpLr
         qqbyTZwnayluckncsWY2QYCZ3elzXJ3IdcAnMci1+2UZyf/weM3Pf9QzUOitFI3KtXpS
         UTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rMyj9g23MpUmAEsmXi4rsHGrGtCX48owvW0wtW0SQpM=;
        b=aylj3FtEBwzy2rBMsbfx8Ruuccgb8N5HqiUlE6XtQmI4xQjmTO6Jg/rjAcwCsP/vDx
         IUfMf/6nzYHKQK9CjkWgWW4iUtUKDaXx90AXv5iNQ5T56lqTLFngB3h+fpbLgchlhyKP
         8nu1jC5Z71J0+2m3jwl0E3wqStRtJOQZfuYtZlwTanV2YplfHAjfyBbNrLHYE1zBnHL+
         ZBwCi3gHoIyDPWoTJUphGSAGxmuFw0Ee30XBZgKaIkXj9Nzjd+OLlhWlDDHOxaVEzvYy
         Boa2xTJJXxBWUX/YZWcD/JupE1VxuY31WTeFbweeRgDlqhRBjjju542Qb71I+8s8vGiH
         HzYQ==
X-Gm-Message-State: AD7BkJIq5uYeiixxjfaBj8XbhYh4Sl078IQ1G+p7er3EUdK6YQtGpW6hHW0KjOPYqQMMtQ==
X-Received: by 10.140.225.6 with SMTP id v6mr22517524qhb.0.1456793609315;
        Mon, 29 Feb 2016 16:53:29 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:28 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287971>

Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
is responsible for reading ref data from the ref storage.

Later, we will make read_raw_ref a pluggable backend function, and make
resolve_ref_unsafe common.

Testing done: Hacked in code to run both old and new version of
resolve_ref_1 and compare all outputs, failing dramatically if outputs
differed.  Ran test suite.

Signed-off-by: David Turner <dturner@twopensource.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 265 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 159 insertions(+), 106 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9676ec2..8c6a58e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1369,12 +1369,11 @@ static struct ref_entry *get_packed_ref(const char *refname)
 
 /*
  * A loose ref file doesn't exist; check for a packed ref.  The
- * options are forwarded from resolve_safe_unsafe().
+ * options are forwarded from resolve_ref_unsafe().
  */
 static int resolve_missing_loose_ref(const char *refname,
-				     int resolve_flags,
 				     unsigned char *sha1,
-				     int *flags)
+				     unsigned int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1390,64 +1389,48 @@ static int resolve_missing_loose_ref(const char *refname,
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
 	for (;;) {
-		const char *path;
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
@@ -1457,49 +1440,45 @@ static const char *resolve_ref_1(const char *refname,
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
@@ -1510,35 +1489,110 @@ static const char *resolve_ref_1(const char *refname,
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
+		unsigned int read_flags = 0;
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
@@ -1546,44 +1600,43 @@ static const char *resolve_ref_1(const char *refname,
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
