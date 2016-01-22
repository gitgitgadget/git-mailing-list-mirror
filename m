From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] resolve_gitlink_ref: ignore non-repository paths
Date: Fri, 22 Jan 2016 17:29:30 -0500
Message-ID: <20160122222930.GB15560@sigill.intra.peff.net>
References: <20160122222650.GA14772@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:29:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkD7-0000iX-JB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbcAVW3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:29:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:58961 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753444AbcAVW3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:29:32 -0500
Received: (qmail 17757 invoked by uid 102); 22 Jan 2016 22:29:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:29:32 -0500
Received: (qmail 6617 invoked by uid 107); 22 Jan 2016 22:29:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:29:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 17:29:30 -0500
Content-Disposition: inline
In-Reply-To: <20160122222650.GA14772@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284596>

When we want to look up a submodule ref, we use
get_ref_cache(path) to find or auto-create its ref cache.
But if we feed a path that isn't actually a git repository,
we blindly create the ref cache, and then may die deeper in
the code when we try to access it. This is a problem because
many callers speculatively feed us a path that looks vaguely
like a repository, and expect us to tell them when it is
not.

This patch teaches resolve_gitlink_ref to reject
non-repository paths without creating a ref_cache. This
avoids the die(), and also performs better if you have a
large number of these faux-submodule directories (because
the ref_cache lookup is linear, under the assumption that
there won't be a large number of submodules).

To accomplish this, we also break get_ref_cache into two
pieces: the lookup and auto-creation (the latter is lumped
into create_ref_cache). This lets us first cheaply ask our
cache "is it a submodule we know about?" If so, we can avoid
repeating our filesystem lookup. So lookups of real
submodules are not penalized; they examine the submodule's
.git directory only once.

The test in t3000 demonstrates a case where this improves
correctness (we used to just die). The new perf case in
p7300 shows off the speed improvement in an admittedly
pathological repository:

Test                  HEAD^               HEAD
----------------------------------------------------------------
7300.4: ls-files -o   66.97(66.15+0.87)   0.33(0.08+0.24) -99.5%

Signed-off-by: Jeff King <peff@peff.net>
---
 refs/files-backend.c       | 46 ++++++++++++++++++++++++++++++++--------------
 t/perf/p7300-clean.sh      |  4 ++++
 t/t3000-ls-files-others.sh |  7 +++++++
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c648b5e..3a27f27 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -933,6 +933,10 @@ static void clear_loose_ref_cache(struct ref_cache *refs)
 	}
 }
 
+/*
+ * Create a new submodule ref cache and add it to the internal
+ * set of caches.
+ */
 static struct ref_cache *create_ref_cache(const char *submodule)
 {
 	int len;
@@ -942,16 +946,12 @@ static struct ref_cache *create_ref_cache(const char *submodule)
 	len = strlen(submodule) + 1;
 	refs = xcalloc(1, sizeof(struct ref_cache) + len);
 	memcpy(refs->name, submodule, len);
+	refs->next = submodule_ref_caches;
+	submodule_ref_caches = refs;
 	return refs;
 }
 
-/*
- * Return a pointer to a ref_cache for the specified submodule. For
- * the main repository, use submodule==NULL. The returned structure
- * will be allocated and initialized but not necessarily populated; it
- * should not be freed.
- */
-static struct ref_cache *get_ref_cache(const char *submodule)
+static struct ref_cache *lookup_ref_cache(const char *submodule)
 {
 	struct ref_cache *refs;
 
@@ -961,10 +961,20 @@ static struct ref_cache *get_ref_cache(const char *submodule)
 	for (refs = submodule_ref_caches; refs; refs = refs->next)
 		if (!strcmp(submodule, refs->name))
 			return refs;
+	return NULL;
+}
 
-	refs = create_ref_cache(submodule);
-	refs->next = submodule_ref_caches;
-	submodule_ref_caches = refs;
+/*
+ * Return a pointer to a ref_cache for the specified submodule. For
+ * the main repository, use submodule==NULL. The returned structure
+ * will be allocated and initialized but not necessarily populated; it
+ * should not be freed.
+ */
+static struct ref_cache *get_ref_cache(const char *submodule)
+{
+	struct ref_cache *refs = lookup_ref_cache(submodule);
+	if (!refs)
+		refs = create_ref_cache(submodule);
 	return refs;
 }
 
@@ -1336,16 +1346,24 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
 	int len = strlen(path), retval;
-	char *submodule;
+	struct strbuf submodule = STRBUF_INIT;
 	struct ref_cache *refs;
 
 	while (len && path[len-1] == '/')
 		len--;
 	if (!len)
 		return -1;
-	submodule = xstrndup(path, len);
-	refs = get_ref_cache(submodule);
-	free(submodule);
+
+	strbuf_add(&submodule, path, len);
+	refs = lookup_ref_cache(submodule.buf);
+	if (!refs) {
+		if (!is_nonbare_repository_dir(&submodule)) {
+			strbuf_release(&submodule);
+			return -1;
+		}
+		refs = create_ref_cache(submodule.buf);
+	}
+	strbuf_release(&submodule);
 
 	retval = resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
 	return retval;
diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
index ec94cdd..7c1888a 100755
--- a/t/perf/p7300-clean.sh
+++ b/t/perf/p7300-clean.sh
@@ -28,4 +28,8 @@ test_perf 'clean many untracked sub dirs, ignore nested git' '
 	git clean -n -q -f -f -d 100000_sub_dirs/
 '
 
+test_perf 'ls-files -o' '
+	git ls-files -o
+'
+
 test_done
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 88be904..c525656 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -65,6 +65,13 @@ test_expect_success '--no-empty-directory hides empty directory' '
 	test_cmp expected3 output
 '
 
+test_expect_success 'ls-files --others handles non-submodule .git' '
+	mkdir not-a-submodule &&
+	echo foo >not-a-submodule/.git &&
+	git ls-files -o >output &&
+	test_cmp expected1 output
+'
+
 test_expect_success SYMLINKS 'ls-files --others with symlinked submodule' '
 	git init super &&
 	git init sub &&
-- 
2.7.0.384.gae54cb4
