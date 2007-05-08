From: Dana How <danahow@gmail.com>
Subject: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 08 May 2007 15:38:22 -0700
Message-ID: <4640FBDE.1000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, danahow@gmail.com
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 00:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlYKI-00076I-Hx
	for gcvg-git@gmane.org; Wed, 09 May 2007 00:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967073AbXEHWi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 18:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967171AbXEHWi1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 18:38:27 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5154 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967073AbXEHWi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 18:38:26 -0400
Received: by py-out-1112.google.com with SMTP id a29so1613899pyi
        for <git@vger.kernel.org>; Tue, 08 May 2007 15:38:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ne9asvBdR9QpgZgOg9DazGWQJJXJV0SWPOfMAZM6AaTbDxBn2OIjQQ6bGUbP9mdEbodo4drYUqog7/iGiuh/5thpo21F5/pbF5iy2K3itxMpN3gZaI9L04cCC401Skjd3BaUlUi/Pjgc5rUmqdw1caMe4QsxXWdjN/QJ28Qzrfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ilnTZXJN4jGzg7Rn82A0aierzCi30K8ge9SRr0+OWDBme2+Te+2ts0nozFDNHpaOWF4W5XvbA+UAmeevTuTEkW3HZr0rc+RS5aadddrEpmzMVXookzq+pS0RViFQdiHt8nY/WBpL2D6v+wpiYJGec+tWd69Kx2g1PlBwCq3icew=
Received: by 10.65.183.7 with SMTP id k7mr13049156qbp.1178663904484;
        Tue, 08 May 2007 15:38:24 -0700 (PDT)
Received: from ?192.168.1.30? ( [64.186.171.227])
        by mx.google.com with ESMTP id 16sm33817384nzo.2007.05.08.15.38.23;
        Tue, 08 May 2007 15:38:23 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051006)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46631>


Add config variables pack.compression and core.loosecompression .
Loose objects will be compressed using level
  isset(core.loosecompression) ? core.loosecompression :
  isset(core.compression) ? core.compression : Z_BEST_SPEED
and objects in packs will be compressed using level
  isset(pack.compression) ? pack.compression :
  isset(core.compression) ? core.compression : Z_DEFAULT_COMPRESSION
pack-objects also accepts --compression=N which
overrides the latter expression.

This applies on top of the git-repack --max-pack-size patchset.

Signed-off-by: Dana L. How <danahow@gmail.com>
---
 builtin-pack-objects.c |   32 +++++++++++++++++++++++++++++++-
 cache.h                |    2 ++
 config.c               |   18 +++++++++++++++++-
 environment.c          |    4 +++-
 4 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 8824793..e80a1d6 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -70,6 +70,8 @@ static uint32_t pack_size_limit;
 static int pack_to_stdout;
 static int num_preferred_base;
 static struct progress progress_state;
+static int pack_compression_level = Z_DEFAULT_COMPRESSION;
+static int pack_compression_seen;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -444,6 +446,10 @@ static unsigned long write_object(struct sha1file *f,
 				 * and we do not need to deltify it.
 				 */
 
+	/* differing core & pack compression when loose object -> must recompress */
+	if (!entry->in_pack && pack_compression_level != zlib_compression_level)
+		to_reuse = 0;
+	else
 	if (!entry->in_pack && !entry->delta) {
 		unsigned char *map;
 		unsigned long mapsize;
@@ -492,7 +498,7 @@ static unsigned long write_object(struct sha1file *f,
 		}
 		/* compress the data to store and put compressed length in datalen */
 		memset(&stream, 0, sizeof(stream));
-		deflateInit(&stream, zlib_compression_level);
+		deflateInit(&stream, pack_compression_level);
 		maxsize = deflateBound(&stream, size);
 		out = xmalloc(maxsize);
 		/* Compress it */
@@ -1624,6 +1630,16 @@ static int git_pack_config(const char *k, const char *v)
 		window = git_config_int(k, v);
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
 
@@ -1734,6 +1750,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	rp_ac = 2;
 
 	git_config(git_pack_config);
+	if (!pack_compression_seen && core_compression_seen)
+		pack_compression_level = core_compression_level;
 
 	progress = isatty(2);
 	for (i = 1; i < argc; i++) {
@@ -1761,6 +1779,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				usage(pack_usage);
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
