From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/21] read_raw_ref(): manage own scratch space
Date: Wed, 23 Mar 2016 11:04:30 +0100
Message-ID: <2bc5bb4589a7a9e313a4f3ce082af765f11a443d.1458723959.git.mhagger@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:15:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aifmH-0000gX-De
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbcCWKMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:12:32 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54347 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754663AbcCWKMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 06:12:25 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Mar 2016 06:12:25 EDT
X-AuditID: 12074413-f03ff7000000516b-ff-56f26a537ee5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F0.AE.20843.35A62F65; Wed, 23 Mar 2016 06:05:07 -0400 (EDT)
Received: from michael.fritz.box (p548D66C6.dip0.t-ipconnect.de [84.141.102.198])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2NA4g1I018017
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 23 Mar 2016 06:05:06 -0400
X-Mailer: git-send-email 2.8.0.rc3
In-Reply-To: <cover.1458723959.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBuc9SnM4H6rpUXXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zxcyr1g5sHn/ff2Dy2DnrLrvHs949jB4XLyl77F+6jc3j8ya5ALYo
	bpukxJKy4Mz0PH27BO6MdV1bmQsuaVW8e7CSuYGxW7GLkZNDQsBE4uiUS6xdjFwcQgJbGSVe
	9q1mgXBOMkn8aW9gBaliE9CVWNTTzARiiwioSUxsOwRWxCywgFFi4+LFzCAJYQF7iU3fF7GA
	2CwCqhKzb5wCa+YViJKY276aCWKdksSGBxfAbE4BC4mTJ5cygthCAuYS2x+sZZrAyLOAkWEV
	o1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkhACe9g3HVS7hCjAAejEg9v4bmP
	YUKsiWXFlbmHGCU5mJREec8HfQoT4kvKT6nMSCzOiC8qzUktPsQowcGsJMLLmQmU401JrKxK
	LcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8G7LAGoULEpNT61Iy8wpQUgzcXCC
	DOeSEilOzUtJLUosLcmIB0VBfDEwDkBSPEB7ecH2Fhck5gJFIVpPMSpKifNqgMwVAElklObB
	jYWliVeM4kBfCkOczQNMMXDdr4AGMwENXugDNrgkESEl1cDIJsQ3Je7fY6Fv9248vJ7De7be
	WyvNVvA2z11JtccrtCW3FuTES+nt3fud9cRJAdk/U3xOdlZX8GRzFnV/DlJZ/Tazl/UPz9GF
	19bs35G45oMzh9319REfPcy0r0ofcJXoWXjmwSWhw8+MU65l/H3s/sP6gGzRkVOB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289624>

Instead of creating scratch space in resolve_ref_unsafe() and passing it
down through resolve_ref_1 to read_raw_ref(), teach read_raw_ref() to
manage its own scratch space. This reduces coupling across the functions
at the cost of some extra allocations. Also, when read_raw_ref() is
implemented for different reference backends, the other implementations
might have different scratch space requirements.

Note that we now preserve errno across the calls to strbuf_release(),
which calls free() and can thus theoretically overwrite errno.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 76 ++++++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d51e778..f752568 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1421,17 +1421,20 @@ static int resolve_missing_loose_ref(const char *refname,
  *   refname will still be valid and unchanged.
  */
 static int read_raw_ref(const char *refname, unsigned char *sha1,
-			struct strbuf *symref, struct strbuf *sb_path,
-			struct strbuf *sb_contents, int *flags)
+			struct strbuf *symref, int *flags)
 {
+	struct strbuf sb_contents = STRBUF_INIT;
+	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
 	const char *buf;
 	struct stat st;
 	int fd;
+	int ret = -1;
+	int save_errno;
 
-	strbuf_reset(sb_path);
-	strbuf_git_path(sb_path, "%s", refname);
-	path = sb_path->buf;
+	strbuf_reset(&sb_path);
+	strbuf_git_path(&sb_path, "%s", refname);
+	path = sb_path.buf;
 
 stat_ref:
 	/*
@@ -1446,36 +1449,38 @@ stat_ref:
 
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
-			return -1;
+			goto out;
 		if (resolve_missing_loose_ref(refname, sha1, flags)) {
 			errno = ENOENT;
-			return -1;
+			goto out;
 		}
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/* Follow "normalized" - ie "refs/.." symlinks by hand */
 	if (S_ISLNK(st.st_mode)) {
-		strbuf_reset(sb_contents);
-		if (strbuf_readlink(sb_contents, path, 0) < 0) {
+		strbuf_reset(&sb_contents);
+		if (strbuf_readlink(&sb_contents, path, 0) < 0) {
 			if (errno == ENOENT || errno == EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
 			else
-				return -1;
+				goto out;
 		}
-		if (starts_with(sb_contents->buf, "refs/") &&
-		    !check_refname_format(sb_contents->buf, 0)) {
-			strbuf_swap(sb_contents, symref);
+		if (starts_with(sb_contents.buf, "refs/") &&
+		    !check_refname_format(sb_contents.buf, 0)) {
+			strbuf_swap(&sb_contents, symref);
 			*flags |= REF_ISSYMREF;
-			return 0;
+			ret = 0;
+			goto out;
 		}
 	}
 
 	/* Is it a directory? */
 	if (S_ISDIR(st.st_mode)) {
 		errno = EISDIR;
-		return -1;
+		goto out;
 	}
 
 	/*
@@ -1488,18 +1493,18 @@ stat_ref:
 			/* inconsistent with lstat; retry */
 			goto stat_ref;
 		else
-			return -1;
+			goto out;
 	}
-	strbuf_reset(sb_contents);
-	if (strbuf_read(sb_contents, fd, 256) < 0) {
+	strbuf_reset(&sb_contents);
+	if (strbuf_read(&sb_contents, fd, 256) < 0) {
 		int save_errno = errno;
 		close(fd);
 		errno = save_errno;
-		return -1;
+		goto out;
 	}
 	close(fd);
-	strbuf_rtrim(sb_contents);
-	buf = sb_contents->buf;
+	strbuf_rtrim(&sb_contents);
+	buf = sb_contents.buf;
 	if (starts_with(buf, "ref:")) {
 		buf += 4;
 		while (isspace(*buf))
@@ -1508,7 +1513,8 @@ stat_ref:
 		strbuf_reset(symref);
 		strbuf_addstr(symref, buf);
 		*flags |= REF_ISSYMREF;
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	/*
@@ -1519,10 +1525,17 @@ stat_ref:
 	    (buf[40] != '\0' && !isspace(buf[40]))) {
 		*flags |= REF_ISBROKEN;
 		errno = EINVAL;
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	ret = 0;
+
+out:
+	save_errno = errno;
+	strbuf_release(&sb_path);
+	strbuf_release(&sb_contents);
+	errno = save_errno;
+	return ret;
 }
 
 /* This function needs to return a meaningful errno on failure */
@@ -1530,9 +1543,7 @@ static const char *resolve_ref_1(const char *refname,
 				 int resolve_flags,
 				 unsigned char *sha1,
 				 int *flags,
-				 struct strbuf *sb_refname,
-				 struct strbuf *sb_path,
-				 struct strbuf *sb_contents)
+				 struct strbuf *sb_refname)
 {
 	int symref_count;
 
@@ -1559,8 +1570,7 @@ static const char *resolve_ref_1(const char *refname,
 	for (symref_count = 0; symref_count < MAXDEPTH; symref_count++) {
 		int read_flags = 0;
 
-		if (read_raw_ref(refname, sha1, sb_refname,
-				 sb_path, sb_contents, &read_flags)) {
+		if (read_raw_ref(refname, sha1, sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
@@ -1604,8 +1614,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 			       unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
-	struct strbuf sb_contents = STRBUF_INIT;
-	struct strbuf sb_path = STRBUF_INIT;
 	int unused_flags;
 	const char *ret;
 
@@ -1613,9 +1621,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 		flags = &unused_flags;
 
 	ret = resolve_ref_1(refname, resolve_flags, sha1, flags,
-			    &sb_refname, &sb_path, &sb_contents);
-	strbuf_release(&sb_path);
-	strbuf_release(&sb_contents);
+			    &sb_refname);
 	return ret;
 }
 
-- 
2.8.0.rc3
