From: Jeff King <peff@peff.net>
Subject: [PATCH 23/67] add_packed_git: convert strcpy into xsnprintf
Date: Tue, 15 Sep 2015 11:41:43 -0400
Message-ID: <20150915154143.GW29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsN3-0003GO-GY
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbbIOPlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:41:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:59337 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753580AbbIOPlq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:41:46 -0400
Received: (qmail 11938 invoked by uid 102); 15 Sep 2015 15:41:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:41:45 -0500
Received: (qmail 7188 invoked by uid 107); 15 Sep 2015 15:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:41:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:41:43 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277925>

We have the path "foo.idx", and we create a buffer big
enough to hold "foo.pack" and "foo.keep", and then strcpy
straight into it. This isn't a bug (we have enough space),
but it's very hard to tell from the strcpy that this is so.

Let's instead use strip_suffix to take off the ".idx",
record the size of our allocation, and use xsnprintf to make
sure we don't violate our assumptions.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  2 +-
 sha1_file.c | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index cc59aba..11372ef 100644
--- a/cache.h
+++ b/cache.h
@@ -1305,7 +1305,7 @@ extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *, int, int);
+extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Return the SHA-1 of the nth object within the specified packfile.
diff --git a/sha1_file.c b/sha1_file.c
index f106091..28352a5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1146,11 +1146,12 @@ static void try_to_free_pack_memory(size_t size)
 	release_pack_memory(size);
 }
 
-struct packed_git *add_packed_git(const char *path, int path_len, int local)
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
 {
 	static int have_set_try_to_free_routine;
 	struct stat st;
-	struct packed_git *p = alloc_packed_git(path_len + 2);
+	size_t alloc;
+	struct packed_git *p;
 
 	if (!have_set_try_to_free_routine) {
 		have_set_try_to_free_routine = 1;
@@ -1161,18 +1162,18 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	 * Make sure a corresponding .pack file exists and that
 	 * the index looks sane.
 	 */
-	path_len -= strlen(".idx");
-	if (path_len < 1) {
-		free(p);
+	if (!strip_suffix_mem(path, &path_len, ".idx"))
 		return NULL;
-	}
-	memcpy(p->pack_name, path, path_len);
 
-	strcpy(p->pack_name + path_len, ".keep");
+	alloc = path_len + strlen(".pack") + 1;
+	p = alloc_packed_git(alloc);
+	memcpy(p->pack_name, path, path_len); /* NUL from zero-ed struct */
+
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
 
-	strcpy(p->pack_name + path_len, ".pack");
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
 		return NULL;
-- 
2.6.0.rc2.408.ga2926b9
