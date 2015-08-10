From: Jeff King <peff@peff.net>
Subject: [PATCH 09/17] refs.c: remove extra git_path calls from
 read_loose_refs
Date: Mon, 10 Aug 2015 05:36:19 -0400
Message-ID: <20150810093619.GI30981@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 11:36:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjVM-0004gW-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbbHJJgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:36:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:42836 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753421AbbHJJgY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 05:36:24 -0400
Received: (qmail 30969 invoked by uid 102); 10 Aug 2015 09:36:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 04:36:24 -0500
Received: (qmail 3169 invoked by uid 107); 10 Aug 2015 09:36:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 05:36:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 05:36:19 -0400
Content-Disposition: inline
In-Reply-To: <20150810092731.GA9027@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275576>

In iterating over the loose refs in "refs/foo/", we keep a
running strbuf with "refs/foo/one", "refs/foo/two", etc. But
we also need to access these files in the filesystem, as
".git/refs/foo/one", etc. For this latter purpose, we make a
series of independent calls to git_path(). These are safe
(we only use the result to call stat()), but assigning the
result of git_path is a suspicious pattern that we'd rather
avoid.

This patch keeps a running buffer with ".git/refs/foo/", and
we can just append/reset each directory element as we loop.
This matches how we handle the refnames. It should also be
more efficient, as we do not keep formatting the same
".git/refs/foo" prefix (which can be arbitrarily deep).

Technically we are dropping a call to strbuf_cleanup() on
each generated filename, but that's OK; it wasn't doing
anything, as we are putting in single-level names we read
from the filesystem (so it could not possibly be cleaning up
cruft like "./" in this instance).

A clever reader may also note that the running refname
buffer ("refs/foo/") is actually a subset of the filesystem
path buffer (".git/refs/foo/"). We could get by with one
buffer, indexing the length of $GIT_DIR when we want the
refname. However, having tried this, the resulting code
actually ends up a little more confusing, and the efficiency
improvement is tiny (and almost certainly dwarfed by the
system calls we are making).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index e70941a..06f95c4 100644
--- a/refs.c
+++ b/refs.c
@@ -1352,19 +1352,23 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 {
 	struct ref_cache *refs = dir->ref_cache;
 	DIR *d;
-	const char *path;
 	struct dirent *de;
 	int dirnamelen = strlen(dirname);
 	struct strbuf refname;
+	struct strbuf path = STRBUF_INIT;
+	size_t path_baselen;
 
 	if (*refs->name)
-		path = git_path_submodule(refs->name, "%s", dirname);
+		strbuf_git_path_submodule(&path, refs->name, "%s", dirname);
 	else
-		path = git_path("%s", dirname);
+		strbuf_git_path(&path, "%s", dirname);
+	path_baselen = path.len;
 
-	d = opendir(path);
-	if (!d)
+	d = opendir(path.buf);
+	if (!d) {
+		strbuf_release(&path);
 		return;
+	}
 
 	strbuf_init(&refname, dirnamelen + 257);
 	strbuf_add(&refname, dirname, dirnamelen);
@@ -1373,17 +1377,14 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		unsigned char sha1[20];
 		struct stat st;
 		int flag;
-		const char *refdir;
 
 		if (de->d_name[0] == '.')
 			continue;
 		if (ends_with(de->d_name, ".lock"))
 			continue;
 		strbuf_addstr(&refname, de->d_name);
-		refdir = *refs->name
-			? git_path_submodule(refs->name, "%s", refname.buf)
-			: git_path("%s", refname.buf);
-		if (stat(refdir, &st) < 0) {
+		strbuf_addstr(&path, de->d_name);
+		if (stat(path.buf, &st) < 0) {
 			; /* silently ignore */
 		} else if (S_ISDIR(st.st_mode)) {
 			strbuf_addch(&refname, '/');
@@ -1430,8 +1431,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_ref_entry(refname.buf, sha1, flag, 0));
 		}
 		strbuf_setlen(&refname, dirnamelen);
+		strbuf_setlen(&path, path_baselen);
 	}
 	strbuf_release(&refname);
+	strbuf_release(&path);
 	closedir(d);
 }
 
-- 
2.5.0.414.g670f2a4
