From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] add a stat_validity struct
Date: Mon, 6 May 2013 22:39:42 -0400
Message-ID: <20130507023942.GB22940@sigill.intra.peff.net>
References: <20130507023610.GA22053@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:39:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXoj-00059L-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934223Ab3EGCjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:39:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:43656 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757859Ab3EGCjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:39:44 -0400
Received: (qmail 14451 invoked by uid 102); 7 May 2013 02:40:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:40:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:39:42 -0400
Content-Disposition: inline
In-Reply-To: <20130507023610.GA22053@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223526>

It can sometimes be useful to know whether a path in the
filesystem has been updated without going to the work of
opening and re-reading its content. We trust the stat()
information on disk already to handle index updates, and we
can use the same trick here.

This patch introduces a "stat_validity" struct which
encapsulates the concept of checking the stat-freshness of a
file. It is implemented on top of "struct cache_entry" to
reuse the logic about which stat entries to trust for a
particular platform, but hides the complexity behind two
simple functions: check and update.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is prep for the next patch. I'm not super-happy with the way it
builds around cache_entry, just because cache entries may end up
following different rules in the long run. But I at least tried to
encapsulate the grossness, so if it turns out to be a problem, we can
factor out the relevant bits from ce_match_stat_basic into a shared
function.

 cache.h      | 27 +++++++++++++++++++++++++++
 read-cache.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/cache.h b/cache.h
index 94ca1ac..adf2874 100644
--- a/cache.h
+++ b/cache.h
@@ -1326,4 +1326,31 @@ int sane_execvp(const char *file, char *const argv[]);
 
 int sane_execvp(const char *file, char *const argv[]);
 
+/*
+ * A struct to encapsulate the concept of whether a file has changed
+ * since we last checked it. This is a simplified version of the up-to-date
+ * checks we use for the index. The implementation is built on an index entry,
+ * but we shield the callers from that ugliness with our struct.
+ */
+struct stat_validity {
+	struct cache_entry *ce;
+};
+
+void stat_validity_clear(struct stat_validity *sv);
+
+/*
+ * Returns 1 if the path matches the saved stat_validity, 0 otherwise.
+ * A missing or inaccessible file is considered a match if the struct was just
+ * initialized, or if the previous update found an inaccessible file.
+ */
+int stat_validity_check(struct stat_validity *sv, const char *path);
+
+/*
+ * Update the stat_validity from a file opened at descriptor fd (if the file
+ * is missing or inaccessible, the validity will reflect that, and future
+ * calls to stat_validity_check will match only if it continues to be
+ * inaccessible).
+ */
+void stat_validity_update(struct stat_validity *sv, int fd);
+
 #endif /* CACHE_H */
diff --git a/read-cache.c b/read-cache.c
index 04ed561..a0bd06c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1933,3 +1933,34 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
 		*size = sz;
 	return data;
 }
+
+void stat_validity_clear(struct stat_validity *sv)
+{
+	free(sv->ce);
+	sv->ce = NULL;
+}
+
+int stat_validity_check(struct stat_validity *sv, const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st) < 0)
+		return sv->ce == NULL;
+	if (!sv->ce)
+		return 0;
+	return !ce_match_stat_basic(sv->ce, &st);
+}
+
+void stat_validity_update(struct stat_validity *sv, int fd)
+{
+	struct stat st;
+
+	if (fstat(fd, &st) < 0)
+		stat_validity_clear(sv);
+	else {
+		if (!sv->ce)
+			sv->ce = xcalloc(1, cache_entry_size(0));
+		fill_stat_cache_info(sv->ce, &st);
+		sv->ce->ce_mode = create_ce_mode(st.st_mode);
+	}
+}
-- 
1.8.3.rc1.2.g12db477
