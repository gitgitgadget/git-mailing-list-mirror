From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] cache patch ids on disk
Date: Thu, 4 Aug 2011 16:49:47 -0600
Message-ID: <20110804224947.GB28215@sigill.intra.peff.net>
References: <20110804224848.GA27545@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 00:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp6jj-0000Gn-4O
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 00:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab1HDWtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 18:49:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071Ab1HDWtu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 18:49:50 -0400
Received: (qmail 23562 invoked by uid 107); 4 Aug 2011 22:50:24 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 18:50:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 16:49:47 -0600
Content-Disposition: inline
In-Reply-To: <20110804224848.GA27545@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178775>

Some workflows may involve running "git cherry" a lot to
look for identical patches. Git ends up calculating the
patch-id of some commits many times, which can be slow.

This patch provides an option to cache the calculated patch
ids persistently on disk. This trades more disk space (and
more RAM used for disk cache) for less CPU time. Whether
this is a good idea depends on your workflow and how much
disk and RAM you have (the cache uses 40 bytes per stored
commit).

Here's one cherry-heavy workflow (checking which topic
branches have been accepted upstream), and some timings:

  have_commits() {
	  test -z "`git cherry "$@" | grep -v ^-`"
  }
  for i in $topic_branches; do
    if have_commits origin/master $i $i@{u}; then
      echo $i: merged to origin/master
    elif have_commits origin/next $i $i@{u}; then
      echo $i: merged to origin/next
    else
      echo $i: not merged
  done

  # without patch
  real    0m9.709s
  user    0m8.693s
  sys     0m0.676s

  # with patch, first run
  real    0m1.946s
  user    0m1.244s
  sys     0m0.428s

  # with patch, subsequent run
  real    0m1.379s
  user    0m0.844s
  sys     0m0.268s

and the disk used:

  $ du -h .git/cache/patch_id/*
  8.0K .git/cache/patch_id/0000000000000000000000000000000000000000

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h          |    1 +
 config.c         |    5 +++++
 map.c            |   16 ++++++++++++++++
 map.h            |    6 ++++++
 metadata-cache.c |    2 ++
 metadata-cache.h |    2 ++
 patch-ids.c      |   22 +++++++++++++++++++++-
 7 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 9e12d55..060f0f9 100644
--- a/cache.h
+++ b/cache.h
@@ -596,6 +596,7 @@ extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
+extern int core_cache_patch_id;
 
 enum branch_track {
 	BRANCH_TRACK_UNSPECIFIED = -1,
diff --git a/config.c b/config.c
index e42c59b..09e84c3 100644
--- a/config.c
+++ b/config.c
@@ -659,6 +659,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.cachepatchid")) {
+		core_cache_patch_id = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/map.c b/map.c
index bb0d60a..9d8d5ab 100644
--- a/map.c
+++ b/map.c
@@ -33,6 +33,16 @@ static void disk_to_uint32(const unsigned char *disk, uint32_t *out)
 	*out = ntohl(*out);
 }
 
+static void sha1_to_disk(struct sha1 v, unsigned char *out)
+{
+	hashcpy(out, v.v);
+}
+
+static void disk_to_sha1(const unsigned char *disk, struct sha1 *out)
+{
+	hashcpy(out->v, disk);
+}
+
 static const unsigned char *disk_lookup_sha1(const unsigned char *buf,
 					     unsigned nr,
 					     unsigned ksize, unsigned vsize,
@@ -244,3 +254,9 @@ int map_persist_flush_##name(struct map_persist_##name *m, int fd) \
 
 IMPLEMENT_MAP(object_uint32, obj_equal, hash_obj)
 IMPLEMENT_MAP(object_void, obj_equal, hash_obj)
+
+IMPLEMENT_MAP(object_sha1, obj_equal, hash_obj)
+IMPLEMENT_MAP_PERSIST(object_sha1,
+		      20, obj_to_disk,
+		      20, sha1_to_disk, disk_to_sha1,
+		      disk_lookup_sha1)
diff --git a/map.h b/map.h
index ceddc14..18eb939 100644
--- a/map.h
+++ b/map.h
@@ -40,7 +40,13 @@ extern void map_persist_attach_##name(struct map_persist_##name *, \
 				      unsigned int len); \
 extern int map_persist_flush_##name(struct map_persist_##name *, int fd);
 
+struct sha1 {
+	unsigned char v[20];
+};
+
 DECLARE_MAP(object_uint32, const struct object *, uint32_t)
 DECLARE_MAP(object_void, const struct object *, void *)
+DECLARE_MAP(object_sha1, const struct object *, struct sha1)
+DECLARE_MAP_PERSIST(object_sha1)
 
 #endif /* MAP_H */
diff --git a/metadata-cache.c b/metadata-cache.c
index e217db1..0ce0e90 100644
--- a/metadata-cache.c
+++ b/metadata-cache.c
@@ -124,3 +124,5 @@ int name##_cache_set(map_ktype_##map key, map_vtype_##map value) \
 	init_##name##_cache(); \
 	return map_persist_set_##map(&name##_map, key, value); \
 }
+
+IMPLEMENT_METADATA_CACHE(patch_id, object_sha1, NULL)
diff --git a/metadata-cache.h b/metadata-cache.h
index 851a4eb..ff2f6d3 100644
--- a/metadata-cache.h
+++ b/metadata-cache.h
@@ -7,4 +7,6 @@
 extern int name##_cache_get(map_ktype_##map key, map_vtype_##map *value); \
 extern int name##_cache_set(map_ktype_##map key, map_vtype_##map value);
 
+DECLARE_METADATA_CACHE(patch_id, object_sha1)
+
 #endif /* METADATA_CACHE_H */
diff --git a/patch-ids.c b/patch-ids.c
index 5717257..d1818eb 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -3,17 +3,37 @@
 #include "commit.h"
 #include "sha1-lookup.h"
 #include "patch-ids.h"
+#include "metadata-cache.h"
+
+int core_cache_patch_id;
 
 static int commit_patch_id(struct commit *commit, struct diff_options *options,
 		    unsigned char *sha1)
 {
+	if (core_cache_patch_id) {
+		struct sha1 v;
+		if (patch_id_cache_get(&commit->object, &v)) {
+			hashcpy(sha1, v.v);
+			return 0;
+		}
+	}
+
 	if (commit->parents)
 		diff_tree_sha1(commit->parents->item->object.sha1,
 		               commit->object.sha1, "", options);
 	else
 		diff_root_tree_sha1(commit->object.sha1, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, sha1);
+	if (diff_flush_patch_id(options, sha1) < 0)
+		return -1;
+
+	if (core_cache_patch_id) {
+		struct sha1 v;
+		hashcpy(v.v, sha1);
+		patch_id_cache_set(&commit->object, v);
+	}
+
+	return 0;
 }
 
 static const unsigned char *patch_id_access(size_t index, void *table)
-- 
1.7.6.34.g86521e
