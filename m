From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] rm: do not complain about d/f conflicts during deletion
Date: Thu, 4 Apr 2013 15:03:35 -0400
Message-ID: <20130404190335.GA4063@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpSF-0003pY-DA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763943Ab3DDTDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:03:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56213 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764066Ab3DDTDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:03:41 -0400
Received: (qmail 5171 invoked by uid 107); 4 Apr 2013 19:05:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 15:05:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 15:03:35 -0400
Content-Disposition: inline
In-Reply-To: <20130404190211.GA15912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220068>

If we used to have an index entry "d/f", but "d" has been
replaced by a non-directory entry, the user may still want
to run "git rm" to delete the stale index entry. They could
use "git rm --cached" to just touch the index, but "git rm"
should also work: we explicitly try to handle the case that
the file has already been removed from the working tree.

However, because unlinking "d/f" in this case will not yield
ENOENT, but rather ENOTDIR, we do not notice that the file
is already gone. Instead, we report it as an error.

The simple solution is to treat ENOTDIR in this case exactly
like ENOENT; all we want to know is whether the file is
already gone, and if a leading path is no longer a
directory, then by definition the sub-path is gone.

Reported-by: jpinheiro <7jpinheiro@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rm.c  |  2 +-
 dir.c         |  2 +-
 t/t3600-rm.sh | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index dabfcf6..7b91d52 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -110,7 +110,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		ce = active_cache[pos];
 
 		if (lstat(ce->name, &st) < 0) {
-			if (errno != ENOENT)
+			if (errno != ENOENT && errno != ENOTDIR)
 				warning("'%s': %s", ce->name, strerror(errno));
 			/* It already vanished from the working tree */
 			continue;
diff --git a/dir.c b/dir.c
index 57394e4..f9e7355 100644
--- a/dir.c
+++ b/dir.c
@@ -1603,7 +1603,7 @@ int remove_path(const char *name)
 {
 	char *slash;
 
-	if (unlink(name) && errno != ENOENT)
+	if (unlink(name) && errno != ENOENT && errno != ENOTDIR)
 		return -1;
 
 	slash = strrchr(name, '/');
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 37bf5f1..73772b2 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -622,4 +622,29 @@ test_expect_success 'rm of a populated nested submodule with a nested .git direc
 	rm -rf submod
 '
 
+test_expect_success 'rm of d/f when d has become a non-directory' '
+	rm -rf d &&
+	mkdir d &&
+	>d/f &&
+	git add d &&
+	rm -rf d &&
+	>d &&
+	git rm d/f &&
+	test_must_fail git rev-parse --verify :d/f &&
+	test_path_is_file d
+'
+
+test_expect_success SYMLINKS 'rm of d/f when d has become a dangling symlink' '
+	rm -rf d &&
+	mkdir d &&
+	>d/f &&
+	git add d &&
+	rm -rf d &&
+	ln -s nonexistent d &&
+	git rm d/f &&
+	test_must_fail git rev-parse --verify :d/f &&
+	test -h d &&
+	test_path_is_missing d
+'
+
 test_done
-- 
1.8.2.rc0.33.gd915649
