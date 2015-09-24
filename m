From: Jeff King <peff@peff.net>
Subject: [PATCH 23/68] add_packed_git: convert strcpy into xsnprintf
Date: Thu, 24 Sep 2015 17:06:55 -0400
Message-ID: <20150924210655.GT30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDjN-0001Ak-WE
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbbIXVHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:07:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:35954 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751802AbbIXVG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:06:58 -0400
Received: (qmail 11933 invoked by uid 102); 24 Sep 2015 21:06:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:06:58 -0500
Received: (qmail 29151 invoked by uid 107); 24 Sep 2015 21:07:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:06:55 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278578>

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
 sha1_file.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 030b880..d206d64 100644
--- a/cache.h
+++ b/cache.h
@@ -1309,7 +1309,7 @@ extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
 extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *, int, int);
+extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Return the SHA-1 of the nth object within the specified packfile.
diff --git a/sha1_file.c b/sha1_file.c
index f106091..592226e 100644
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
@@ -1161,18 +1162,22 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	 * Make sure a corresponding .pack file exists and that
 	 * the index looks sane.
 	 */
-	path_len -= strlen(".idx");
-	if (path_len < 1) {
-		free(p);
+	if (!strip_suffix_mem(path, &path_len, ".idx"))
 		return NULL;
-	}
+
+	/*
+	 * ".pack" is long enough to hold any suffix we're adding (and
+	 * the use xsnprintf double-checks that)
+	 */
+	alloc = path_len + strlen(".pack") + 1;
+	p = alloc_packed_git(alloc);
 	memcpy(p->pack_name, path, path_len);
 
-	strcpy(p->pack_name + path_len, ".keep");
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
 
-	strcpy(p->pack_name + path_len, ".pack");
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
 	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
 		free(p);
 		return NULL;
-- 
2.6.0.rc3.454.g204ad51
