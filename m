From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Limit the size of the new delta_base_cache
Date: Mon, 19 Mar 2007 01:14:37 -0400
Message-ID: <20070319051437.GA22494@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 06:15:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTACz-0007UN-LZ
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 06:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbXCSFOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 01:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbXCSFOn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 01:14:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51609 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbXCSFOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 01:14:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HTACd-0003wC-Uu; Mon, 19 Mar 2007 01:14:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DDCDA20FBAE; Mon, 19 Mar 2007 01:14:37 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42589>

Round two, based on comments on IRC from Junio:

-->8--
[PATCH] Limit the size of the new delta_base_cache

The new configuration variable core.deltaBaseCacheLimit allows the
user to control how much memory they are willing to give to Git for
caching base objects of deltas.  This is not normally meant to be
a user tweakable knob; the "out of the box" settings are meant to
be suitable for almost all workloads.

We default to 16 MiB under the assumption that the cache is not
meant to consume all of the user's available memory, and that the
cache's main purpose was to cache trees, for faster path limiters
during revision traversal.  Since trees tend to be relatively small
objects, this relatively small limit should still allow a large
number of objects.

On the other hand we don't want the cache to start storing 200
different versions of a 200 MiB blob, as this could easily blow
the entire address space of a 32 bit process.

We evict OBJ_BLOB from the cache first (credit goes to Junio) as
we want to favor OBJ_TREE within the cache.  These are the objects
that have the highest inflate() startup penalty, as they tend to
be small and thus don't have that much of a chance to ammortize
that penalty over the entire data.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |   13 +++++++++++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 sha1_file.c              |   31 ++++++++++++++++++++++++++-----
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 953acae..8796929 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -240,6 +240,19 @@ the largest projects.  You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.deltaBaseCacheLimit::
+	Maximum number of bytes to reserve for caching base objects
+	that multiple deltafied objects reference.  By storing the
+	entire decompressed base objects in a cache Git is able
+	to avoid unpacking and decompressing frequently used base
+	objects multiple times.
++
+Default is 16 MiB on all platforms.  This should be reasonable
+for all users/operating systems, except on the largest projects.
+You probably do not need to adjust this value.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 3818e10..9a3c8c8 100644
--- a/cache.h
+++ b/cache.h
@@ -228,6 +228,7 @@ extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
+extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 
 #define GIT_REPO_VERSION 0
diff --git a/config.c b/config.c
index d537311..6479855 100644
--- a/config.c
+++ b/config.c
@@ -331,6 +331,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.deltabasecachelimit")) {
+		delta_base_cache_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = -1;
diff --git a/environment.c b/environment.c
index 0151ad0..ef2f490 100644
--- a/environment.c
+++ b/environment.c
@@ -27,6 +27,7 @@ const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
+size_t delta_base_cache_limit = 16 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color = 1;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
diff --git a/sha1_file.c b/sha1_file.c
index ee64865..0d039a3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1354,6 +1354,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 
 #define MAX_DELTA_CACHE (256)
 
+static size_t delta_base_cached;
 static struct delta_base_cache_entry {
 	struct packed_git *p;
 	off_t base_offset;
@@ -1384,9 +1385,10 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	return unpack_entry(p, base_offset, type, base_size);
 
 found_cache_entry:
-	if (!keep_cache)
+	if (!keep_cache) {
 		ent->data = NULL;
-	else {
+		delta_base_cached -= ent->size;
+	} else {
 		ret = xmalloc(ent->size + 1);
 		memcpy(ret, ent->data, ent->size);
 		((char *)ret)[ent->size] = 0;
@@ -1396,14 +1398,33 @@ found_cache_entry:
 	return ret;
 }
 
+static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
+{
+	if (ent->data) {
+		free(ent->data);
+		ent->data = NULL;
+		delta_base_cached -= ent->size;
+	}
+}
+
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-	unsigned long hash = pack_entry_hash(p, base_offset);
+	unsigned long i, hash = pack_entry_hash(p, base_offset);
 	struct delta_base_cache_entry *ent = delta_base_cache + hash;
 
-	if (ent->data)
-		free(ent->data);
+	release_delta_base_cache(ent);
+	delta_base_cached += base_size;
+	for (i = 0; delta_base_cached > delta_base_cache_limit
+		&& i < ARRAY_SIZE(delta_base_cache); i++) {
+		struct delta_base_cache_entry *f = delta_base_cache + i;
+		if (f->type == OBJ_BLOB)
+			release_delta_base_cache(f);
+	}
+	for (i = 0; delta_base_cached > delta_base_cache_limit
+		&& i < ARRAY_SIZE(delta_base_cache); i++)
+		release_delta_base_cache(delta_base_cache + i);
+
 	ent->p = p;
 	ent->base_offset = base_offset;
 	ent->type = type;
-- 
1.5.0.5.1030.gc69a
