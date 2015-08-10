From: Jeff King <peff@peff.net>
Subject: [PATCH 16/17] get_repo_path: refactor path-allocation
Date: Mon, 10 Aug 2015 05:37:55 -0400
Message-ID: <20150810093754.GP30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:38:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjWv-0005Ts-KS
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbbHJJiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:38:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:42864 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754457AbbHJJiA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:38:00 -0400
Received: (qmail 31080 invoked by uid 102); 10 Aug 2015 09:38:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:38:00 -0500
Received: (qmail 3288 invoked by uid 107); 10 Aug 2015 09:38:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:38:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:37:55 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275582>

The get_repo_path function calls mkpath() and then does some
non-trivial operations on it, like calling
is_git_directory() and read_gitfile(). These are actually
OK (they do not use more pathname static buffers
themselves), but it takes a fair bit of work to verify.

Let's use our own strbuf to store the path, and we can
simply reuse it for each iteration of the loop (we can even
avoid rewriting the beginning part, since we are trying a
series of suffixes).

To make the strbuf cleanup easier, we split out a thin
wrapper. As a bonus, this wrapper can factor out the
canonicalization that happens in all of the early-return
code paths.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 303a3a7..5864ad1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -99,51 +99,66 @@ static const char *argv_submodule[] = {
 	"submodule", "update", "--init", "--recursive", NULL
 };
 
-static char *get_repo_path(const char *repo, int *is_bundle)
+static const char *get_repo_path_1(struct strbuf *path, int *is_bundle)
 {
 	static char *suffix[] = { "/.git", "", ".git/.git", ".git" };
 	static char *bundle_suffix[] = { ".bundle", "" };
+	size_t baselen = path->len;
 	struct stat st;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
-		const char *path;
-		path = mkpath("%s%s", repo, suffix[i]);
-		if (stat(path, &st))
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, suffix[i]);
+		if (stat(path->buf, &st))
 			continue;
-		if (S_ISDIR(st.st_mode) && is_git_directory(path)) {
+		if (S_ISDIR(st.st_mode) && is_git_directory(path->buf)) {
 			*is_bundle = 0;
-			return xstrdup(absolute_path(path));
+			return path->buf;
 		} else if (S_ISREG(st.st_mode) && st.st_size > 8) {
 			/* Is it a "gitfile"? */
 			char signature[8];
-			int len, fd = open(path, O_RDONLY);
+			const char *dst;
+			int len, fd = open(path->buf, O_RDONLY);
 			if (fd < 0)
 				continue;
 			len = read_in_full(fd, signature, 8);
 			close(fd);
 			if (len != 8 || strncmp(signature, "gitdir: ", 8))
 				continue;
-			path = read_gitfile(path);
-			if (path) {
+			dst = read_gitfile(path->buf);
+			if (dst) {
 				*is_bundle = 0;
-				return xstrdup(absolute_path(path));
+				return dst;
 			}
 		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(bundle_suffix); i++) {
-		const char *path;
-		path = mkpath("%s%s", repo, bundle_suffix[i]);
-		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, bundle_suffix[i]);
+		if (!stat(path->buf, &st) && S_ISREG(st.st_mode)) {
 			*is_bundle = 1;
-			return xstrdup(absolute_path(path));
+			return path->buf;
 		}
 	}
 
 	return NULL;
 }
 
+static char *get_repo_path(const char *repo, int *is_bundle)
+{
+	struct strbuf path = STRBUF_INIT;
+	const char *raw;
+	char *canon;
+
+	strbuf_addstr(&path, repo);
+	raw = get_repo_path_1(&path, is_bundle);
+	canon = raw ? xstrdup(absolute_path(raw)) : NULL;
+	strbuf_release(&path);
+	return canon;
+}
+
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
-- 
2.5.0.414.g670f2a4
