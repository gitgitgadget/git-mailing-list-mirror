From: Jeff King <peff@peff.net>
Subject: [PATCH 12/17] refs.c: avoid repeated git_path calls in rename_tmp_log
Date: Mon, 10 Aug 2015 05:36:53 -0400
Message-ID: <20150810093653.GL30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:37:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjVv-0004yX-OO
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbbHJJg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:36:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:42847 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754035AbbHJJg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:36:58 -0400
Received: (qmail 30997 invoked by uid 102); 10 Aug 2015 09:36:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:36:59 -0500
Received: (qmail 3220 invoked by uid 107); 10 Aug 2015 09:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:37:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:36:53 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275578>

Because it's not safe to store the static-buffer results of
git_path for a long time, we end up formatting the same
filename over and over. We can fix this by using a
function-local strbuf to store the formatted pathname and
avoid repeating ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 3666132..61a318f 100644
--- a/refs.c
+++ b/refs.c
@@ -2930,9 +2930,13 @@ out:
 static int rename_tmp_log(const char *newrefname)
 {
 	int attempts_remaining = 4;
+	struct strbuf path = STRBUF_INIT;
+	int ret = -1;
 
  retry:
-	switch (safe_create_leading_directories_const(git_path("logs/%s", newrefname))) {
+	strbuf_reset(&path);
+	strbuf_git_path(&path, "logs/%s", newrefname);
+	switch (safe_create_leading_directories_const(path.buf)) {
 	case SCLD_OK:
 		break; /* success */
 	case SCLD_VANISHED:
@@ -2941,19 +2945,19 @@ static int rename_tmp_log(const char *newrefname)
 		/* fall through */
 	default:
 		error("unable to create directory for %s", newrefname);
-		return -1;
+		goto out;
 	}
 
-	if (rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newrefname))) {
+	if (rename(git_path(TMP_RENAMED_LOG), path.buf)) {
 		if ((errno==EISDIR || errno==ENOTDIR) && --attempts_remaining > 0) {
 			/*
 			 * rename(a, b) when b is an existing
 			 * directory ought to result in ISDIR, but
 			 * Solaris 5.8 gives ENOTDIR.  Sheesh.
 			 */
-			if (remove_empty_directories(git_path("logs/%s", newrefname))) {
+			if (remove_empty_directories(path.buf)) {
 				error("Directory not empty: logs/%s", newrefname);
-				return -1;
+				goto out;
 			}
 			goto retry;
 		} else if (errno == ENOENT && --attempts_remaining > 0) {
@@ -2966,10 +2970,13 @@ static int rename_tmp_log(const char *newrefname)
 		} else {
 			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
 				newrefname, strerror(errno));
-			return -1;
+			goto out;
 		}
 	}
-	return 0;
+	ret = 0;
+out:
+	strbuf_release(&path);
+	return ret;
 }
 
 static int rename_ref_available(const char *oldname, const char *newname)
-- 
2.5.0.414.g670f2a4
