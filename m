From: David Turner <dturner@twopensource.com>
Subject: [PATCH 14/24] files-backend: break out ref reading
Date: Thu,  7 Apr 2016 15:03:01 -0400
Message-ID: <1460055791-23313-15-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDX-0007CX-HM
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbcDGTDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:45 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35046 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303AbcDGTDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:36 -0400
Received: by mail-qg0-f46.google.com with SMTP id f105so47945226qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ruM7CdI3fMD5rJ6e+3EbhLbXjtiRsgFcQAcIxJJiBJk=;
        b=NYJPVbfaJO4R/nA1Sp1RD0LHof8kRbhsVIkwLqCyaLilnLJ/OfV5L1RQHC6i+h3JgY
         NOst2RGBYNozigOoGDXKSkkrPey2bDymy82rJwvU98E0mcb5ohasADHpTlspJP0PS2U5
         LkqySLuIQ1kNUKPsbEl1frPz7OUat8e2gbRTnJoG/MaKGqFcZwwxTqStzsE3LJ/hYfON
         wFeFv2m/wGChVlxp/MFDmUPLY7MZKKAaQDHyooz/ELa3pSMIOMhyUNl83xWPesb09rHo
         RxreukJS0CR24Tt9KwhxBvXnWMxR5xzWgUx1AXu85TW/57Grqlw7OUFJ8nxZiuuVaTpM
         gLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ruM7CdI3fMD5rJ6e+3EbhLbXjtiRsgFcQAcIxJJiBJk=;
        b=E371kJAx5DFlyTUHvP/sPyG6DxOVOfwtaDa4UxSMgi613C0S/Gsh3N8cE725aimuQN
         4m/vBWMq1ICWju2ZEsvMFtuGNr26xuq3CbCS6N8aa3ts3tSAV9owTN4E5rkkq6m61QmZ
         FzPDC7FFjmR5zOeNDV7pyzy0rlIPYcF4ZFH420Nl8KspuKZYm2mLKjBPOzsxFreaGhtu
         UunPpUd9qEsU6Rk4iS4aiSSPv3i8AyFND9a1YxcTl24V2UunNVsRI6R3PZZEQJSWMvzq
         0wj3wOz8dNICzIm2SbTiglHDnm6LfC4tknTznSYzbNJSqrZFiT7nRQxDoM31UUSeLmAF
         jnWA==
X-Gm-Message-State: AD7BkJKKpQcJcuW1dK/Icvit2875+gAwW0Lng7DNc80UxDLTlivcHSKZU8F4tpzX26++Qg==
X-Received: by 10.140.201.130 with SMTP id w124mr6369392qha.57.1460055815504;
        Thu, 07 Apr 2016 12:03:35 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290960>

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
-
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
+		*flags |= read_flags;
 
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
2.4.2.767.g62658d5-twtrsrc
