From: Dana How <danahow@gmail.com>
Subject: [PATCH v3] Custom compression levels for objects and packs
Date: Wed, 09 May 2007 13:56:50 -0700
Message-ID: <46423592.1050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 22:57:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HltDf-0006NT-Sg
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbXEIU47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbXEIU47
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:56:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:40171 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbXEIU45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:56:57 -0400
Received: by wx-out-0506.google.com with SMTP id h31so320407wxd
        for <git@vger.kernel.org>; Wed, 09 May 2007 13:56:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=FRfxsqCvmmqx9wgJ6Sg2QV5vb3icTp84uyVgX/LeAm4qf4pyo79yRDS9cQ44SJqlkrNcepeRGM2WVUUNDStkP84OehCbARwrKkeFdD6eQ+IqEiyRrF7JEYqJ+i5JiNGR05rpl4T/F6HmEOGimZvA+1NBrPUwUr8B2s/EoOEBCDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=H0y7yhwnpba3yzy8iDvDAFhMIPpE6hBol5SEsbzaZO9g3CpXzLzFYojB+x/5K/xrA9vMLLLWhCkqZD0mjB/Gv5Ks8w0BQXPfxK5lRRn9kU3qQwYCHVcmnzsCkvuQyTytVkAbQZI3MiUErB4tqt2OOGqGNeC1FqEba/407Y9w/TU=
Received: by 10.90.54.4 with SMTP id c4mr1002588aga.1178744214317;
        Wed, 09 May 2007 13:56:54 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 27sm11960078wra.2007.05.09.13.56.51;
        Wed, 09 May 2007 13:56:52 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46789>


Add config variables pack.compression and core.loosecompression ,
and switch --compression=level to pack-objects.

Loose objects will be compressed using core.loosecompression if set,
else core.compression if set, else Z_BEST_SPEED.
Packed objects will be compressed using --compression=level if seen,
else pack.compression if set, else core.compression if set,
else Z_DEFAULT_COMPRESSION.  This is the "pack compression level".

Loose objects added to a pack undeltified will be recompressed
to the pack compression level if it is unequal to the current
loose compression level by the preceding rules,  or if the loose
object was written while core.legacyheaders = true.  Newly
deltified loose objects are always compressed to the current
pack compression level.

Previously packed objects added to a pack are recompressed
to the current pack compression level exactly when their
deltification status changes,  since the previous pack data
cannot be reused.

In either case,  the --no-reuse-object switch from the first
patch below will always force recompression to the current pack
compression level,  instead of assuming the pack compression level
hasn't changed and pack data can be reused when possible.

This applies on top of the following patches from Nicolas Pitre:
[PATCH] allow for undeltified objects not to be reused
[PATCH] make "repack -f" imply "pack-objects --no-reuse-object"

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 Documentation/config.txt           |   17 +++++++++++++++--
 Documentation/git-pack-objects.txt |   14 +++++++++++++-
 builtin-pack-objects.c             |   33 +++++++++++++++++++++++++++++++--
 cache.h                            |    2 ++
 config.c                           |   18 +++++++++++++++++-
 csum-file.c                        |    4 ++--
 csum-file.h                        |    2 +-
 environment.c                      |    4 +++-
 8 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ea434af..382a31b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -204,10 +204,16 @@ core.warnAmbiguousRefs::
 	and might match multiple refs in the .git/refs/ tree. True by default.
 
 core.compression::
+	An integer -1..9, indicating a default compression level.
+	-1 is the zlib default. 0 means no compression,
+	and 1..9 are various speed/size tradeoffs, 9 being slowest.
+
+core.loosecompression::
 	An integer -1..9, indicating the compression level for objects that
-	are not in a pack file. -1 is the zlib and git default. 0 means no
+	are not in a pack file. -1 is the zlib default. 0 means no
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
-	slowest.
+	slowest.  If not set,  defaults to core.compression.  If that is
+	not set,  defaults to 0 (best speed).
 
 core.legacyheaders::
 	A boolean which
@@ -550,6 +556,13 @@ pack.depth::
 	The maximum delta depth used by gitlink:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
 
+pack.compression::
+	An integer -1..9, indicating the compression level for objects
+	in a pack file. -1 is the zlib default. 0 means no
+	compression, and 1..9 are various speed/size tradeoffs, 9 being
+	slowest.  If not set,  defaults to core.compression.  If that is
+	not set,  defaults to -1.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index ce89214..2531238 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -130,10 +130,22 @@ base-name::
 --no-reuse-object::
 	This flag tells the command not to reuse existing object data at all,
 	including non deltified object, forcing recompression of everything.
-	This implies --no-reuse-delta. Useful only in the obscur case where
+	This implies --no-reuse-delta. Useful only in the obscure case where
 	wholesale enforcement of a different compression level on the
 	packed data is desired.
 
+--compression=[N]::
+	Specifies compression level for newly-compressed data in the
+	generated pack.  If not specified,  pack compression level is
+	determined first by pack.compression,  then by core.compression,
+	and defaults to -1,  the zlib default,  if neither is set.
+	Data copied from loose objects will be recompressed
+	if core.legacyheaders was true when they were created or if
+	the loose compression level (see core.loosecompression and
+	core.compression) is now a different value than the pack
+	compression level.  Add --no-reuse-object if you want to force
+	a uniform compression level on all data no matter the source.
+
 --delta-base-offset::
 	A packed archive can express base object of a delta as
 	either 20-byte object name or as an offset in the
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index d94c79a..5c468aa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -68,6 +68,8 @@ static int depth = 50;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress progress_state;
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+static int pack_compression_seen;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -427,7 +429,10 @@ static unsigned long write_object(struct sha1file *f,
 				 * and we do not need to deltify it.
 				 */
 
-	if (!no_reuse_object && !entry->in_pack && !entry->delta) {
+	/* differing core & pack compression when loose object -> must recompress */
+	if (!entry->in_pack && pack_compression_level != zlib_compression_level)
+		to_reuse = 0;
+	else if (!no_reuse_object && !entry->in_pack && !entry->delta) {
 		unsigned char *map;
 		unsigned long mapsize;
 		map = map_sha1_file(entry->sha1, &mapsize);
@@ -487,7 +492,7 @@ static unsigned long write_object(struct sha1file *f,
 			sha1write(f, entry->delta->sha1, 20);
 			hdrlen += 20;
 		}
-		datalen = sha1write_compressed(f, buf, size);
+		datalen = sha1write_compressed(f, buf, size, pack_compression_level);
 		free(buf);
 	}
 	else {
@@ -1496,6 +1501,16 @@ static int git_pack_config(const char *k, const char *v)
 		depth = git_config_int(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.compression")) {
+		int level = git_config_int(k, v);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad pack compression level %d", level);
+		pack_compression_level = level;
+		pack_compression_seen = 1;
+		return 0;
+	}
 	return git_default_config(k, v);
 }
 
@@ -1607,6 +1622,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_ac = 2;
 
 	git_config(git_pack_config);
+	if (!pack_compression_seen && core_compression_seen)
+		pack_compression_level = core_compression_level;
 
 	progress = isatty(2);
 	for (i = 1; i < argc; i++) {
@@ -1627,6 +1644,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			incremental = 1;
 			continue;
 		}
+		if (!prefixcmp(arg, "--compression=")) {
+			char *end;
+			int level = strtoul(arg+14, &end, 0);
+			if (!arg[14] || *end)
+				usage(pack_usage);
+			if (level == -1)
+				level = Z_DEFAULT_COMPRESSION;
+			else if (level < 0 || level > Z_BEST_COMPRESSION)
+				die("bad pack compression level %d", level);
+			pack_compression_level = level;
+			continue;
+		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
diff --git a/cache.h b/cache.h
index 8e76152..2b3f359 100644
--- a/cache.h
+++ b/cache.h
@@ -283,6 +283,8 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
+extern int core_compression_level;
+extern int core_compression_seen;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
diff --git a/config.c b/config.c
index 70d1055..5627ed6 100644
--- a/config.c
+++ b/config.c
@@ -12,6 +12,8 @@
 static FILE *config_file;
 static const char *config_file_name;
 static int config_linenr;
+static int zlib_compression_seen;
+
 static int get_next_char(void)
 {
 	int c;
@@ -304,13 +306,27 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.compression")) {
+	if (!strcmp(var, "core.loosecompression")) {
 		int level = git_config_int(var, value);
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die("bad zlib compression level %d", level);
 		zlib_compression_level = level;
+		zlib_compression_seen = 1;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.compression")) {
+		int level = git_config_int(var, value);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die("bad zlib compression level %d", level);
+		core_compression_level = level;
+		core_compression_seen = 1;
+		if (!zlib_compression_seen)
+			zlib_compression_level = level;
 		return 0;
 	}
 
diff --git a/csum-file.c b/csum-file.c
index 7c806ad..7088f6e 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -119,14 +119,14 @@ struct sha1file *sha1fd(int fd, const char *name)
 	return f;
 }
 
-int sha1write_compressed(struct sha1file *f, void *in, unsigned int size)
+int sha1write_compressed(struct sha1file *f, void *in, unsigned int size, int level)
 {
 	z_stream stream;
 	unsigned long maxsize;
 	void *out;
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, zlib_compression_level);
+	deflateInit(&stream, level);
 	maxsize = deflateBound(&stream, size);
 	out = xmalloc(maxsize);
 
diff --git a/csum-file.h b/csum-file.h
index 7e13391..4e8b83e 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -16,7 +16,7 @@ extern struct sha1file *sha1fd(int fd, const char *name);
 extern struct sha1file *sha1create(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern int sha1close(struct sha1file *, unsigned char *, int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
-extern int sha1write_compressed(struct sha1file *, void *, unsigned int);
+extern int sha1write_compressed(struct sha1file *, void *, unsigned int, int);
 extern void crc32_begin(struct sha1file *);
 extern uint32_t crc32_end(struct sha1file *);
 
diff --git a/environment.c b/environment.c
index 2231659..b7aeb1a 100644
--- a/environment.c
+++ b/environment.c
@@ -24,7 +24,9 @@ const char *git_commit_encoding;
 const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
-int zlib_compression_level = Z_DEFAULT_COMPRESSION;
+int zlib_compression_level = Z_BEST_SPEED;
+int core_compression_level;
+int core_compression_seen;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 16 * 1024 * 1024;
-- 
1.5.2.rc0.787.g0014
