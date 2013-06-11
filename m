From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/4] resolve_ref_unsafe(): nest reference-reading code in an infinite loop
Date: Tue, 11 Jun 2013 16:26:19 +0200
Message-ID: <1370960780-1055-4-git-send-email-mhagger@alum.mit.edu>
References: <20130507023802.GA22940@sigill.intra.peff.net>
 <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 16:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmPXP-0005vU-V7
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 16:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466Ab3FKO0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 10:26:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50745 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754330Ab3FKO0q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 10:26:46 -0400
X-AuditID: 1207440d-b7f006d000000adf-58-51b733a69256
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.2B.02783.6A337B15; Tue, 11 Jun 2013 10:26:46 -0400 (EDT)
Received: from michael.fritz.box (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BEQVIU026521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 10:26:44 -0400
X-Mailer: git-send-email 1.8.3
In-Reply-To: <1370960780-1055-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqLvMeHugweGjMhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvj0uedjAV/5Ss+zL/K0sDYJN7FyMkhIWAiMXfSUyYIW0ziwr31bF2MXBxCApcZJb79
	28MM4Vxgkji0agsbSBWbgK7Eop5msA4RATWJiW2HWECKmAXaGSXeNe9jBkkIC0RJfGx5xwJi
	swioShz6eogdxOYVcJZ4sGkiC8Q6OYn3d3YB2RwcnAIuEqcbZUDCQgIlElNWvWWZwMi7gJFh
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZIUPHuYPy/TuYQowAHoxIPbwLj
	tkAh1sSy4srcQ4ySHExKorxTDLYHCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhbZQDyvGmJFZW
	pRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHj3GQE1ChalpqdWpGXmlCCkmTg4
	QQQXyAYeoA2fQQp5iwsSc4sz0yGKTjEqSonz3gVJCIAkMkrz4AbA4v8VozjQP8K8P0CqeICp
	A677FdBgJqDBU9S3gAwuSURISTUwqrPfjef/s+Si+qNH1y1V/l9p2yq6TE7fzOT9m7cSP3Zp
	2Lj8LzUPbwq6ubkg6kTZ3rcr/A+3z328WJP1+YJqhfbOaU9Yq854PtBX4+QU9Kw86cseUDLJ
	I1swWmVtXUjs8Q5urz9JPK6z5nxVmG+QO2Ge2xSNY9+0DJzzb1WGLHCKj5/QrVut 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227446>

The last statement of the loop body is "break", so this doesn't change
the logical flow...yet.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This commit is 98% whitespace changes, so do it in a separate commit
to make the changes in the next commit more obvious.

 refs.c | 123 ++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/refs.c b/refs.c
index 2722f75..7a77d76 100644
--- a/refs.c
+++ b/refs.c
@@ -1248,77 +1248,82 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
-		if (lstat(path, &st) < 0) {
-			if (errno == ENOENT)
-				return handle_missing_loose_ref(refname, sha1, reading, flag);
-			else
-				return NULL;
-		}
+		for (;;) {
+			if (lstat(path, &st) < 0) {
+				if (errno == ENOENT)
+					return handle_missing_loose_ref(
+							refname, sha1,
+							reading, flag);
+				else
+					return NULL;
+			}
 
-		/* Follow "normalized" - ie "refs/.." symlinks by hand */
-		if (S_ISLNK(st.st_mode)) {
-			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len < 0)
-				return NULL;
-			buffer[len] = 0;
-			if (!prefixcmp(buffer, "refs/") &&
-					!check_refname_format(buffer, 0)) {
-				strcpy(refname_buffer, buffer);
-				refname = refname_buffer;
-				if (flag)
-					*flag |= REF_ISSYMREF;
-				continue;
+			/* Follow "normalized" - ie "refs/.." symlinks by hand */
+			if (S_ISLNK(st.st_mode)) {
+				len = readlink(path, buffer, sizeof(buffer)-1);
+				if (len < 0)
+					return NULL;
+				buffer[len] = 0;
+				if (!prefixcmp(buffer, "refs/") &&
+				    !check_refname_format(buffer, 0)) {
+					strcpy(refname_buffer, buffer);
+					refname = refname_buffer;
+					if (flag)
+						*flag |= REF_ISSYMREF;
+					break;
+				}
 			}
-		}
 
-		/* Is it a directory? */
-		if (S_ISDIR(st.st_mode)) {
-			errno = EISDIR;
-			return NULL;
-		}
+			/* Is it a directory? */
+			if (S_ISDIR(st.st_mode)) {
+				errno = EISDIR;
+				return NULL;
+			}
 
-		/*
-		 * Anything else, just open it and try to use it as
-		 * a ref
-		 */
-		fd = open(path, O_RDONLY);
-		if (fd < 0)
-			return NULL;
-		len = read_in_full(fd, buffer, sizeof(buffer)-1);
-		close(fd);
-		if (len < 0)
-			return NULL;
-		while (len && isspace(buffer[len-1]))
-			len--;
-		buffer[len] = '\0';
+			/*
+			 * Anything else, just open it and try to use it as
+			 * a ref
+			 */
+			fd = open(path, O_RDONLY);
+			if (fd < 0)
+				return NULL;
+			len = read_in_full(fd, buffer, sizeof(buffer)-1);
+			close(fd);
+			if (len < 0)
+				return NULL;
+			while (len && isspace(buffer[len-1]))
+				len--;
+			buffer[len] = '\0';
 
-		/*
-		 * Is it a symbolic ref?
-		 */
-		if (prefixcmp(buffer, "ref:")) {
 			/*
-			 * Please note that FETCH_HEAD has a second
-			 * line containing other data.
+			 * Is it a symbolic ref?
 			 */
-			if (get_sha1_hex(buffer, sha1) ||
-			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
+			if (prefixcmp(buffer, "ref:")) {
+				/*
+				 * Please note that FETCH_HEAD has a second
+				 * line containing other data.
+				 */
+				if (get_sha1_hex(buffer, sha1) ||
+				    (buffer[40] != '\0' && !isspace(buffer[40]))) {
+					if (flag)
+						*flag |= REF_ISBROKEN;
+					return NULL;
+				}
+				return refname;
+			}
+			if (flag)
+				*flag |= REF_ISSYMREF;
+			buf = buffer + 4;
+			while (isspace(*buf))
+				buf++;
+			if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
 				if (flag)
 					*flag |= REF_ISBROKEN;
 				return NULL;
 			}
-			return refname;
-		}
-		if (flag)
-			*flag |= REF_ISSYMREF;
-		buf = buffer + 4;
-		while (isspace(*buf))
-			buf++;
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flag)
-				*flag |= REF_ISBROKEN;
-			return NULL;
+			refname = strcpy(refname_buffer, buf);
+			break;
 		}
-		refname = strcpy(refname_buffer, buf);
 	}
 }
 
-- 
1.8.3
