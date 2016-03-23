From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/21] files-backend: break out ref reading
Date: Wed, 23 Mar 2016 11:04:29 +0100
Message-ID: <31684011a0fdadf5d4b9bf7cd7d384a103dfb719.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:05:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiffE-0002lB-4K
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbcCWKFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:05:09 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:51181 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402AbcCWKFH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:05:07 -0400
X-AuditID: 12074414-8b3ff70000005020-51-56f26a521ed5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F6.DC.20512.25A62F65; Wed, 23 Mar 2016 06:05:06 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1H018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:04 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqBuU9SnMYPZCfov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8arE4cZC9Y7VPx69Jm5gfGGQRcjJ4eEgInE3jvn
	WEFsIYGtjBITJkVC2CeZJD5tTwWx2QR0JRb1NDOB2CICahIT2w6xdDFycTALXGKU+LntCRtI
	QljAWqLj80oWEJtFQFWia+8qMJtXIEpiZWcPK8QyJYkNDy6ADeIUsJA4eXIpI8Qyc4ntD9Yy
	TWDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJMBEdjAeOSl3iFGA
	g1GJh7fg3McwIdbEsuLK3EOMkhxMSqK854M+hQnxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4T2Y
	CZTjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgbQdpFCxKTU+tSMvM
	KUFIM3FwggznkhIpTs1LSS1KLC3JiAdFQHwxMAZAUjxAew+B7S0uSMwFikK0nmJUlBLn9QZJ
	CIAkMkrz4MbC0sYrRnGgL4V5OUGqeIApB677FdBgJqDBC33ABpckIqSkGhhVTp+3zWI7umff
	u9TUlPdyGmuTGhPCnnkYyTnGeD2ep6yekqpzsMDqeKdmYKjMiu/nnvVtVrjI0yG+1T/YOrHE
	fbW4T9ue+ECR5AldEU131krOnrYpiVd3/ZJ1ttG3IvhvHOMTT9594LNTp/a9kmly 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289610>

From: David Turner <dturner@twopensource.com>

Refactor resolve_ref_1 in terms of a new function read_raw_ref, which
is responsible for reading ref data from the ref storage.

Later, we will make read_raw_ref a pluggable backend function, and make
resolve_ref_unsafe common.

Signed-off-by: David Turner <dturner@twopensource.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 244 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 145 insertions(+), 99 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b865ba5..d51e778 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1390,6 +1390,141 @@ static int resolve_missing_loose_ref(const char *refname,
 	return -1;
 }
 
+/*
+ * Read a raw ref from the filesystem or packed refs file.
+ *
+ * If the ref is a sha1, fill in sha1 and return 0.
+ *
+ * If the ref is symbolic, fill in *symref with the referrent
+ * (e.g. "refs/heads/master") and return 0.  The caller is responsible
+ * for validating the referrent.  Set REF_ISSYMREF in flags.
+ *
+ * If the ref doesn't exist, set errno to ENOENT and return -1.
+ *
+ * If the ref exists but is neither a symbolic ref nor a sha1, it is
+ * broken. Set REF_ISBROKEN in flags, set errno to EINVAL, and return
+ * -1.
+ *
+ * If there is another error reading the ref, set errno appropriately and
+ * return -1.
+ *
+ * Backend-specific flags might be set in flags as well, regardless of
+ * outcome.
+ *
+ * sb_path is workspace: the caller should allocate and free it.
+ *
+ * It is OK for refname to point into symref. In this case:
+ * - if the function succeeds with REF_ISSYMREF, symref will be
+ *   overwritten and the memory pointed to by refname might be changed
+ *   or even freed.
+ * - in all other cases, symref will be untouched, and therefore
+ *   refname will still be valid and unchanged.
+ */
+static int read_raw_ref(const char *refname, unsigned char *sha1,
+			struct strbuf *symref, struct strbuf *sb_path,
+			struct strbuf *sb_contents, int *flags)
+{
+	const char *path;
+	const char *buf;
+	struct stat st;
+	int fd;
+
+	strbuf_reset(sb_path);
+	strbuf_git_path(sb_path, "%s", refname);
+	path = sb_path->buf;
+
+stat_ref:
+	/*
+	 * We might have to loop back here to avoid a race
+	 * condition: first we lstat() the file, then we try
+	 * to read it as a link or as a file.  But if somebody
+	 * changes the type of the file (file <-> directory
+	 * <-> symlink) between the lstat() and reading, then
+	 * we don't want to report that as an error but rather
+	 * try again starting with the lstat().
+	 */
+
+	if (lstat(path, &st) < 0) {
+		if (errno != ENOENT)
+			return -1;
+		if (resolve_missing_loose_ref(refname, sha1, flags)) {
+			errno = ENOENT;
+			return -1;
+		}
+		return 0;
+	}
+
+	/* Follow "normalized" - ie "refs/.." symlinks by hand */
+	if (S_ISLNK(st.st_mode)) {
+		strbuf_reset(sb_contents);
+		if (strbuf_readlink(sb_contents, path, 0) < 0) {
+			if (errno == ENOENT || errno == EINVAL)
+				/* inconsistent with lstat; retry */
+				goto stat_ref;
+			else
+				return -1;
+		}
+		if (starts_with(sb_contents->buf, "refs/") &&
+		    !check_refname_format(sb_contents->buf, 0)) {
+			strbuf_swap(sb_contents, symref);
+			*flags |= REF_ISSYMREF;
+			return 0;
+		}
+	}
+
+	/* Is it a directory? */
+	if (S_ISDIR(st.st_mode)) {
+		errno = EISDIR;
+		return -1;
+	}
+
+	/*
+	 * Anything else, just open it and try to use it as
+	 * a ref
+	 */
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			/* inconsistent with lstat; retry */
+			goto stat_ref;
+		else
+			return -1;
+	}
+	strbuf_reset(sb_contents);
+	if (strbuf_read(sb_contents, fd, 256) < 0) {
+		int save_errno = errno;
+		close(fd);
+		errno = save_errno;
+		return -1;
+	}
+	close(fd);
+	strbuf_rtrim(sb_contents);
+	buf = sb_contents->buf;
+	if (starts_with(buf, "ref:")) {
+		buf += 4;
+		while (isspace(*buf))
+			buf++;
+
+		strbuf_reset(symref);
+		strbuf_addstr(symref, buf);
+		*flags |= REF_ISSYMREF;
+		return 0;
+	}
+
+	/*
+	 * Please note that FETCH_HEAD has additional
+	 * data after the sha.
+	 */
+	if (get_sha1_hex(buf, sha1) ||
+	    (buf[40] != '\0' && !isspace(buf[40]))) {
+		*flags |= REF_ISBROKEN;
+		errno = EINVAL;
+		return -1;
+	}
+
+	return 0;
+}
+
 /* This function needs to return a meaningful errno on failure */
 static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
@@ -1422,118 +1557,29 @@ static const char *resolve_ref_1(const char *refname,
 	}
 
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
-		const char *path;
-		struct stat st;
-		int fd;
+		int read_flags = 0;
 
-		strbuf_reset(sb_path);
-		strbuf_git_path(sb_path, "%s", refname);
-		path = sb_path->buf;
-
-		/*
-		 * We might have to loop back here to avoid a race
-		 * condition: first we lstat() the file, then we try
-		 * to read it as a link or as a file.  But if somebody
-		 * changes the type of the file (file <-> directory
-		 * <-> symlink) between the lstat() and reading, then
-		 * we don't want to report that as an error but rather
-		 * try again starting with the lstat().
-		 */
-	stat_ref:
-		if (lstat(path, &st) < 0) {
-			if (errno != ENOENT)
+		if (read_raw_ref(refname, sha1, sb_refname,
+				 sb_path, sb_contents, &read_flags)) {
+			*flags |= read_flags;
+			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
-			if (resolve_missing_loose_ref(refname, sha1, flags)) {
-				if (resolve_flags & RESOLVE_REF_READING) {
-					errno = ENOENT;
-					return NULL;
-				}
-				hashclr(sha1);
-			}
-			if (*flags & REF_BAD_NAME) {
-				hashclr(sha1);
+			hashclr(sha1);
+			if (*flags & REF_BAD_NAME)
 				*flags |= REF_ISBROKEN;
-			}
 			return refname;
 		}
 
-		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-		if (S_ISLNK(st.st_mode)) {
-			strbuf_reset(sb_contents);
-			if (strbuf_readlink(sb_contents, path, 0) < 0) {
-				if (errno == ENOENT || errno == EINVAL)
-					/* inconsistent with lstat; retry */
-					goto stat_ref;
-				else
-					return NULL;
-			}
-			if (starts_with(sb_contents->buf, "refs/") &&
-			    !check_refname_format(sb_contents->buf, 0)) {
-				strbuf_swap(sb_refname, sb_contents);
-				refname = sb_refname->buf;
-				*flags |= REF_ISSYMREF;
-				if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
-					hashclr(sha1);
-					return refname;
-				}
-				continue;
-			}
-		}
+		*flags |= read_flags;
 
-		/* Is it a directory? */
-		if (S_ISDIR(st.st_mode)) {
-			errno = EISDIR;
-			return NULL;
-		}
-
-		/*
-		 * Anything else, just open it and try to use it as
-		 * a ref
-		 */
-		fd = open(path, O_RDONLY);
-		if (fd < 0) {
-			if (errno == ENOENT)
-				/* inconsistent with lstat; retry */
-				goto stat_ref;
-			else
-				return NULL;
-		}
-		strbuf_reset(sb_contents);
-		if (strbuf_read(sb_contents, fd, 256) < 0) {
-			int save_errno = errno;
-			close(fd);
-			errno = save_errno;
-			return NULL;
-		}
-		close(fd);
-		strbuf_rtrim(sb_contents);
-
-		/*
-		 * Is it a symbolic ref?
-		 */
-		if (!starts_with(sb_contents->buf, "ref:")) {
-			/*
-			 * Please note that FETCH_HEAD has a second
-			 * line containing other data.
-			 */
-			if (get_sha1_hex(sb_contents->buf, sha1) ||
-			    (sb_contents->buf[40] != '\0' && !isspace(sb_contents->buf[40]))) {
-				*flags |= REF_ISBROKEN;
-				errno = EINVAL;
-				return NULL;
-			}
+		if (!(read_flags & REF_ISSYMREF)) {
 			if (*flags & REF_BAD_NAME) {
 				hashclr(sha1);
 				*flags |= REF_ISBROKEN;
 			}
 			return refname;
 		}
-		*flags |= REF_ISSYMREF;
-		refname = sb_contents->buf + 4;
-		while (isspace(*refname))
-			refname++;
-		strbuf_reset(sb_refname);
-		strbuf_addstr(sb_refname, refname);
+
 		refname = sb_refname->buf;
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
-- 
2.8.0.rc3
