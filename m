From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] stat_validity: handle non-regular files
Date: Fri, 22 May 2015 19:51:43 -0400
Message-ID: <20150522235143.GA4818@peff.net>
References: <20150522235116.GA4300@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Sat May 23 01:51:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwjG-0003qA-Tt
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538AbbEVXvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:51:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:35074 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756983AbbEVXvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 19:51:46 -0400
Received: (qmail 11480 invoked by uid 102); 22 May 2015 23:51:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 18:51:46 -0500
Received: (qmail 22399 invoked by uid 107); 22 May 2015 23:51:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 19:51:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 19:51:43 -0400
Content-Disposition: inline
In-Reply-To: <20150522235116.GA4300@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269777>

The stat_validity code was originally written to avoid
re-reading the packed-refs file when it has not changed. It
makes sure that the file continues to match S_ISREG() when
we check it.

However, we can use the same concept on a directory to see
whether it has been modified. Even though we still have to
touch the filesystem to do the stat, this can provide a
speedup even over opendir/readdir/closedir, especially on
high-latency filesystems like NFS.

This patch adds a "mode" field to stat_validity, which lets
us check that the mode has stayed the same (rather than
explicitly checking that it is a regular file).

As a bonus cleanup, we can stop allocating the embedded
"stat_data" on the heap. Prior to this patch, we needed to
represent the case where the file did not exist, and we used
"sv->sd == NULL" for that. Now we can simply check that
"sv->mode" is 0.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h      |  3 ++-
 read-cache.c | 16 ++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index c97d807..2941e7e 100644
--- a/cache.h
+++ b/cache.h
@@ -1660,7 +1660,8 @@ int sane_execvp(const char *file, char *const argv[]);
  * for the index.
  */
 struct stat_validity {
-	struct stat_data *sd;
+	struct stat_data sd;
+	unsigned mode;
 };
 
 void stat_validity_clear(struct stat_validity *sv);
diff --git a/read-cache.c b/read-cache.c
index 36ff89f..115b000 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2279,8 +2279,7 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
 
 void stat_validity_clear(struct stat_validity *sv)
 {
-	free(sv->sd);
-	sv->sd = NULL;
+	memset(sv, 0, sizeof(*sv));
 }
 
 int stat_validity_check(struct stat_validity *sv, const char *path)
@@ -2288,21 +2287,18 @@ int stat_validity_check(struct stat_validity *sv, const char *path)
 	struct stat st;
 
 	if (stat(path, &st) < 0)
-		return sv->sd == NULL;
-	if (!sv->sd)
-		return 0;
-	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
+		return sv->mode == 0;
+	return sv->mode == st.st_mode && !match_stat_data(&sv->sd, &st);
 }
 
 void stat_validity_update(struct stat_validity *sv, int fd)
 {
 	struct stat st;
 
-	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode))
+	if (fstat(fd, &st) < 0)
 		stat_validity_clear(sv);
 	else {
-		if (!sv->sd)
-			sv->sd = xcalloc(1, sizeof(struct stat_data));
-		fill_stat_data(sv->sd, &st);
+		sv->mode = st.st_mode;
+		fill_stat_data(&sv->sd, &st);
 	}
 }
-- 
2.4.1.538.g69ac333
