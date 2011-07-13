From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 5/6] check commit generation cache validity against
 grafts
Date: Wed, 13 Jul 2011 03:06:16 -0400
Message-ID: <20110713070616.GE18566@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 09:06:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtWZ-0006Hx-DX
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991Ab1GMHGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:06:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43239
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1GMHGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:06:18 -0400
Received: (qmail 21248 invoked by uid 107); 13 Jul 2011 07:06:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 03:06:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 03:06:16 -0400
Content-Disposition: inline
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177003>

Some caches, like the commit generation cache, rely on the
shape of the history graph to be accurate. Because commits
are immutable, that shape should never change. However, our
view onto the graph is modified by grafts and replace refs;
if these change, the values in our cache are invalid and
should be regenerated.

We take a pretty heavy-handed approach, and simply throw out
and regenerate the whole cache when either grafts or replace
refs change. In theory we could be slightly more efficient
by comparing the view under which our cache was generated to
the current one. But doing that is complex, and requires
storing the old state.

Instead, we summarize all of the grafts and replace objects
with a single 20-byte sha1. Because the grafts and replace
refs don't tend to change very often, this is simple and
efficient enough.

The actual contents of what we stir into the sha1 are not
important, as long as:

  1. A given state is consistently represented across runs.

  2. Distinct states generate distinct input to the sha1
     function.

Signed-off-by: Jeff King <peff@peff.net>
---
New in this version of the series.

 Documentation/technical/api-metadata-cache.txt |    7 ++++
 cache.h                                        |    1 +
 commit.c                                       |   24 +++++++++++++++-
 commit.h                                       |    2 +
 metadata-cache.c                               |   16 ++++++++++
 metadata-cache.h                               |    3 ++
 replace_object.c                               |   15 ++++++++++
 t/t6070-commit-generations.sh                  |   36 ++++++++++++++++++++++++
 8 files changed, 103 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-metadata-cache.txt b/Documentation/technical/api-metadata-cache.txt
index 192a868..f43b1ba 100644
--- a/Documentation/technical/api-metadata-cache.txt
+++ b/Documentation/technical/api-metadata-cache.txt
@@ -128,3 +128,10 @@ Functions
 	Convenience wrapper for storing unsigned 32-bit integers. Note
 	that integers are stored on disk in network-byte order, so it is
 	safe to access caches from any architecture.
+
+`metadata_graph_validity`::
+
+	This function is intended to be used with `METADATA_CACHE_INIT`
+	as a validity function. It returns a SHA1 summarizing the
+	current state of any commit grafts and replace objects that
+	would affect the shape of the history graph.
diff --git a/cache.h b/cache.h
index bc9e5eb..50e8a1c 100644
--- a/cache.h
+++ b/cache.h
@@ -745,6 +745,7 @@ static inline const unsigned char *lookup_replace_object(const unsigned char *sh
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
+extern void replace_object_validity(git_SHA_CTX *ctx);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/commit.c b/commit.c
index fb37aa0..e72bb3e 100644
--- a/commit.c
+++ b/commit.c
@@ -246,6 +246,27 @@ int unregister_shallow(const unsigned char *sha1)
 	return 0;
 }
 
+void commit_graft_validity(git_SHA_CTX *ctx)
+{
+	int i;
+
+	prepare_commit_graft();
+
+	for (i = 0; i < commit_graft_nr; i++) {
+		const struct commit_graft *c = commit_graft[i];
+		git_SHA1_Update(ctx, c->sha1, 20);
+		if (c->nr_parent < 0)
+			git_SHA1_Update(ctx, "shallow", 7);
+		else {
+			uint32_t v = htonl(c->nr_parent);
+			int j;
+			git_SHA1_Update(ctx, &v, sizeof(v));
+			for (j = 0; j < c->nr_parent; j++)
+				git_SHA1_Update(ctx, c->parent[j], 20);
+		}
+	}
+}
+
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
@@ -881,7 +902,8 @@ int commit_tree(const char *msg, unsigned char *tree,
 }
 
 static struct metadata_cache generations =
-	METADATA_CACHE_INIT("generations", sizeof(uint32_t), NULL);
+	METADATA_CACHE_INIT("generations", sizeof(uint32_t),
+			    metadata_graph_validity);
 
 static unsigned long commit_generation_recurse(struct commit *c)
 {
diff --git a/commit.h b/commit.h
index bff6b36..e6d144d 100644
--- a/commit.h
+++ b/commit.h
@@ -178,4 +178,6 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 
 unsigned long commit_generation(const struct commit *commit);
 
+void commit_graft_validity(git_SHA_CTX *ctx);
+
 #endif /* COMMIT_H */
diff --git a/metadata-cache.c b/metadata-cache.c
index e2e5ff8..32d3c21 100644
--- a/metadata-cache.c
+++ b/metadata-cache.c
@@ -2,6 +2,7 @@
 #include "metadata-cache.h"
 #include "sha1-lookup.h"
 #include "object.h"
+#include "commit.h"
 
 static struct metadata_cache **autowrite;
 static int autowrite_nr;
@@ -335,3 +336,18 @@ void metadata_cache_add_uint32(struct metadata_cache *c,
 	value = htonl(value);
 	metadata_cache_add(c, obj, &value);
 }
+
+void metadata_graph_validity(unsigned char out[20])
+{
+	git_SHA_CTX ctx;
+
+	git_SHA1_Init(&ctx);
+
+	git_SHA1_Update(&ctx, "grafts", 6);
+	commit_graft_validity(&ctx);
+
+	git_SHA1_Update(&ctx, "replace", 7);
+	replace_object_validity(&ctx);
+
+	git_SHA1_Final(out, &ctx);
+}
diff --git a/metadata-cache.h b/metadata-cache.h
index 5b761e1..15484b5 100644
--- a/metadata-cache.h
+++ b/metadata-cache.h
@@ -37,4 +37,7 @@ void metadata_cache_add_uint32(struct metadata_cache *,
 			       const struct object *,
 			       uint32_t value);
 
+/* Common validity token functions */
+void metadata_graph_validity(unsigned char out[20]);
+
 #endif /* METADATA_CACHE_H */
diff --git a/replace_object.c b/replace_object.c
index d0b1548..9ec462b 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -115,3 +115,18 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 
 	return cur;
 }
+
+void replace_object_validity(git_SHA_CTX *ctx)
+{
+	int i;
+
+	if (!read_replace_refs)
+		return;
+
+	prepare_replace_object();
+
+	for (i = 0; i < replace_object_nr; i++) {
+		git_SHA1_Update(ctx, replace_object[i]->sha1[0], 20);
+		git_SHA1_Update(ctx, replace_object[i]->sha1[1], 20);
+	}
+}
diff --git a/t/t6070-commit-generations.sh b/t/t6070-commit-generations.sh
index 3e0f2ad..0aefd01 100755
--- a/t/t6070-commit-generations.sh
+++ b/t/t6070-commit-generations.sh
@@ -38,4 +38,40 @@ test_expect_success 'cached values are the same' '
 	test_cmp expect actual
 '
 
+cat >expect-grafted <<'EOF'
+1 six
+0 Merge branch 'other'
+EOF
+test_expect_success 'adding grafts invalidates generation cache' '
+	git rev-parse six^ >.git/info/grafts &&
+	git log --format="%G %s" >actual &&
+	test_cmp expect-grafted actual
+'
+
+test_expect_success 'removing graft invalidates cache' '
+	rm .git/info/grafts &&
+	git log --format="%G %s" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup replace ref' '
+	H=$(git rev-parse six^) &&
+	R=$(git cat-file commit $H |
+	    sed /^parent/d |
+	    git hash-object -t commit --stdin -w) &&
+	git update-ref refs/replace/$H $R
+'
+
+test_expect_success 'adding replace refs invalidates generation cache' '
+	git log --format="%G %s" >actual &&
+	test_cmp expect-grafted actual
+'
+
+test_expect_success 'cache respects replace-object settings' '
+	git --no-replace-objects log --format="%G %s" >actual &&
+	test_cmp expect actual &&
+	git log --format="%G %s" >actual &&
+	test_cmp expect-grafted actual
+'
+
 test_done
-- 
1.7.6.37.g989c6
