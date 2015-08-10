From: Jeff King <peff@peff.net>
Subject: [PATCH 14/17] refs.c: remove_empty_directories can take a strbuf
Date: Mon, 10 Aug 2015 05:37:27 -0400
Message-ID: <20150810093727.GN30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjWT-0005G8-28
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbbHJJhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:37:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:42857 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754564AbbHJJhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:37:32 -0400
Received: (qmail 31061 invoked by uid 102); 10 Aug 2015 09:37:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:37:32 -0500
Received: (qmail 3254 invoked by uid 107); 10 Aug 2015 09:37:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:37:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:37:27 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275580>

The first thing we do in this function is copy the input
into a strbuf. Of the 4 callers, 3 of them already have a
strbuf we could use. Let's just take the strbuf, and convert
the remaining caller to use a strbuf, rather than a raw
git_path. This is safer, anyway, as remove_dir_recursively
is a non-trivial function that might use the pathname
buffers itself (this is _probably_ OK, as the likely culprit
would be calling resolve_gitlink_ref, but we do not pass the
proper flags to ask it to avoid blowing away gitlinks).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/refs.c b/refs.c
index 8566677..ec1d06c 100644
--- a/refs.c
+++ b/refs.c
@@ -2290,25 +2290,14 @@ static int verify_lock(struct ref_lock *lock,
 	return 0;
 }
 
-static int remove_empty_directories(const char *file)
+static int remove_empty_directories(struct strbuf *path)
 {
-	/* we want to create a file but there is a directory there;
+	/*
+	 * we want to create a file but there is a directory there;
 	 * if that is an empty directory (or a directory that contains
 	 * only empty directories), remove them.
 	 */
-	struct strbuf path;
-	int result, save_errno;
-
-	strbuf_init(&path, 20);
-	strbuf_addstr(&path, file);
-
-	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
-	save_errno = errno;
-
-	strbuf_release(&path);
-	errno = save_errno;
-
-	return result;
+	return remove_dir_recursively(path, REMOVE_DIR_EMPTY_ONLY);
 }
 
 /*
@@ -2440,7 +2429,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 * to remain.
 		 */
 		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
-		if (remove_empty_directories(orig_ref_file.buf)) {
+		if (remove_empty_directories(&orig_ref_file)) {
 			last_errno = errno;
 			if (!verify_refname_available(orig_refname, extras, skip,
 						      get_loose_refs(&ref_cache), err))
@@ -2961,7 +2950,7 @@ static int rename_tmp_log(const char *newrefname)
 			 * directory ought to result in ISDIR, but
 			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
 			 */
-			if (remove_empty_directories(path.buf)) {
+			if (remove_empty_directories(&path)) {
 				error("Directory not empty: logs/%s", newrefname);
 				goto out;
 			}
@@ -3046,7 +3035,14 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
-			if (remove_empty_directories(git_path("%s", newrefname))) {
+			struct strbuf path = STRBUF_INIT;
+			int result;
+
+			strbuf_git_path(&path, "%s", newrefname);
+			result = remove_empty_directories(&path);
+			strbuf_release(&path);
+
+			if (result) {
 				error("Directory not empty: %s", newrefname);
 				goto rollback;
 			}
@@ -3183,7 +3179,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 			return 0;
 
 		if (errno == EISDIR) {
-			if (remove_empty_directories(logfile->buf)) {
+			if (remove_empty_directories(logfile)) {
 				strbuf_addf(err, "There are still logs under "
 					    "'%s'", logfile->buf);
 				return -1;
-- 
2.5.0.414.g670f2a4
