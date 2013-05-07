From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] resolve_ref: close race condition for packed refs
Date: Mon, 6 May 2013 22:38:03 -0400
Message-ID: <20130507023802.GA22940@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:38:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXnA-0003uQ-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934130Ab3EGCiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:38:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:43640 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758546Ab3EGCiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:38:06 -0400
Received: (qmail 14347 invoked by uid 102); 7 May 2013 02:38:25 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:38:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:38:03 -0400
Content-Disposition: inline
In-Reply-To: <20130507023610.GA22053@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223525>

When we attempt to resolve a ref, the first thing we do is
call lstat() to see if it is a symlink or a real ref. If we
find that the ref is missing, we fall back to looking it up
in the packed-refs file. If we find the loose ref does exist
(and is a regular file), we continue with trying to open it.

However, we do not do the same fallback if our open() call
fails; we just report the ref as missing.  A "git pack-refs
--prune" process which is simultaneously running may remove
the loose ref between our lstat() and open().  In this case,
we would erroneously report the ref as missing, even though
we could find it if we checked the packed-refs file.

This patch solves it by factoring out the fallback code from
the lstat() case and calling it from both places. We do not
need to do the same thing for the symlink/readlink code
path, even though it might receive ENOENT, too, because
symlinks cannot be packed (so if it disappears after the
lstat, it is truly being deleted).

Note that this solves only the part of the race within
resolve_ref_unsafe. In the situation described above, we may
still be depending on a cached view of the packed-refs file;
that race will be dealt with in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---

 refs.c | 63 ++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index de2d8eb..5a14703 100644
--- a/refs.c
+++ b/refs.c
@@ -1083,6 +1083,43 @@ static int get_packed_ref(const char *refname, unsigned char *sha1)
 	return -1;
 }
 
+/*
+ * This should be called from resolve_ref_unsafe when a loose ref cannot be
+ * accessed; err must represent the errno from the last attempt to access the
+ * loose ref, and the other options are forwarded from resolve_safe_unsaefe.
+ */
+static const char *handle_loose_ref_failure(int err,
+					    const char *refname,
+					    unsigned char *sha1,
+					    int reading,
+					    int *flag)
+{
+	/*
+	 * If we didn't get ENOENT, something is broken
+	 * with the loose ref, and we should not fallback,
+	 * but instead pretend it doesn't exist.
+	 */
+	if (err != ENOENT)
+		return NULL;
+
+	/*
+	 * The loose reference file does not exist;
+	 * check for a packed reference.
+	 */
+	if (!get_packed_ref(refname, sha1)) {
+		if (flag)
+			*flag |= REF_ISPACKED;
+		return refname;
+	}
+
+	/* The reference is not a packed reference, either. */
+	if (reading)
+		return NULL;
+
+	hashclr(sha1);
+	return refname;
+}
+
 const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
 {
 	int depth = MAXDEPTH;
@@ -1107,26 +1144,9 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 
 		git_snpath(path, sizeof(path), "%s", refname);
 
-		if (lstat(path, &st) < 0) {
-			if (errno != ENOENT)
-				return NULL;
-			/*
-			 * The loose reference file does not exist;
-			 * check for a packed reference.
-			 */
-			if (!get_packed_ref(refname, sha1)) {
-				if (flag)
-					*flag |= REF_ISPACKED;
-				return refname;
-			}
-			/* The reference is not a packed reference, either. */
-			if (reading) {
-				return NULL;
-			} else {
-				hashclr(sha1);
-				return refname;
-			}
-		}
+		if (lstat(path, &st) < 0)
+			return handle_loose_ref_failure(errno, refname, sha1,
+							reading, flag);
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
@@ -1156,7 +1176,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		 */
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
-			return NULL;
+			return handle_loose_ref_failure(errno, refname, sha1,
+							reading, flag);
 		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		close(fd);
 		if (len < 0)
-- 
1.8.3.rc1.2.g12db477
