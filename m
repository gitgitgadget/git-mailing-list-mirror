From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] cache.h: move stat_validity definition up
Date: Fri, 22 May 2015 19:52:07 -0400
Message-ID: <20150522235207.GB4818@peff.net>
References: <20150522235116.GA4300@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Sat May 23 01:52:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvwje-0004JY-IH
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569AbbEVXwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:52:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:35080 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757301AbbEVXwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 19:52:09 -0400
Received: (qmail 11536 invoked by uid 102); 22 May 2015 23:52:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 18:52:09 -0500
Received: (qmail 22418 invoked by uid 107); 22 May 2015 23:52:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 19:52:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 19:52:07 -0400
Content-Disposition: inline
In-Reply-To: <20150522235116.GA4300@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269778>

It would be nice to embed stat_validity structs inside other
structs defined in cache.h. We cannot get away with a
forward declaration, because using it in a struct definition
means the compiler needs the real size.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/cache.h b/cache.h
index 2941e7e..cdd279a 100644
--- a/cache.h
+++ b/cache.h
@@ -1185,6 +1185,34 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
+/*
+ * A struct to encapsulate the concept of whether a file has changed
+ * since we last checked it. This uses criteria similar to those used
+ * for the index.
+ */
+struct stat_validity {
+	struct stat_data sd;
+	unsigned mode;
+};
+
+void stat_validity_clear(struct stat_validity *sv);
+
+/*
+ * Returns 1 if the path is a regular file (or a symlink to a regular
+ * file) and matches the saved stat_validity, 0 otherwise.  A missing
+ * or inaccessible file is considered a match if the struct was just
+ * initialized, or if the previous update found an inaccessible file.
+ */
+int stat_validity_check(struct stat_validity *sv, const char *path);
+
+/*
+ * Update the stat_validity from a file opened at descriptor fd. If
+ * the file is missing, inaccessible, or not a regular file, then
+ * future calls to stat_validity_check will match iff one of those
+ * conditions continues to be true.
+ */
+void stat_validity_update(struct stat_validity *sv, int fd);
+
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
 	char *name;
@@ -1654,34 +1682,6 @@ int checkout_fast_forward(const unsigned char *from,
 
 int sane_execvp(const char *file, char *const argv[]);
 
-/*
- * A struct to encapsulate the concept of whether a file has changed
- * since we last checked it. This uses criteria similar to those used
- * for the index.
- */
-struct stat_validity {
-	struct stat_data sd;
-	unsigned mode;
-};
-
-void stat_validity_clear(struct stat_validity *sv);
-
-/*
- * Returns 1 if the path is a regular file (or a symlink to a regular
- * file) and matches the saved stat_validity, 0 otherwise.  A missing
- * or inaccessible file is considered a match if the struct was just
- * initialized, or if the previous update found an inaccessible file.
- */
-int stat_validity_check(struct stat_validity *sv, const char *path);
-
-/*
- * Update the stat_validity from a file opened at descriptor fd. If
- * the file is missing, inaccessible, or not a regular file, then
- * future calls to stat_validity_check will match iff one of those
- * conditions continues to be true.
- */
-void stat_validity_update(struct stat_validity *sv, int fd);
-
 int versioncmp(const char *s1, const char *s2);
 
 #endif /* CACHE_H */
-- 
2.4.1.538.g69ac333
