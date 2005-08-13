From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [RFC] [PATCH] Add "--compression-level=N" option to git-pack-objects
Date: Sat, 13 Aug 2005 20:23:52 +0400
Message-ID: <20050813162352.GB11609@procyon.home>
References: <20050813162242.GA11609@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 18:25:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3ynm-0000BK-Ly
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:24:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVHMQYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVHMQYD
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:24:03 -0400
Received: from mail.murom.net ([213.177.124.17]:52402 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S932100AbVHMQYB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:24:01 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E3yng-00053t-5X; Sat, 13 Aug 2005 20:24:00 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 03A5AE3CF1C; Sat, 13 Aug 2005 20:23:52 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050813162242.GA11609@procyon.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] Add "--compression-level=N" option to git-pack-objects

Setting the compression level for objects in the pack is useful in some
cases; in particular, disabling compression of the individual objects and
then compressing the whole pack can improve the overall compression ratio.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 Documentation/git-pack-objects.txt |   14 +++++++++++++-
 csum-file.c                        |    5 +++--
 csum-file.h                        |    2 +-
 pack-objects.c                     |   15 +++++++++++++--
 4 files changed, 30 insertions(+), 6 deletions(-)

e54e13c2f057e71998ed39299545717311c7678d
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -9,7 +9,7 @@ git-pack-objects - Create a packed archi
 
 SYNOPSIS
 --------
-'git-pack-objects' [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list
+'git-pack-objects' [--incremental] [--window=N] [--depth=N] [--compression-level=N] {--stdout | base-name} < object-list
 
 
 DESCRIPTION
@@ -61,6 +61,18 @@ base-name::
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
 
+--compression-level::
+	Set zlib compression level for the object data.  The
+	compression level is a number from 0 to 9, where 0 means
+	no compression, 1 indicates the fastest compression
+	method (less compression), and 9 indicates the slowest
+	compression method (best compression).  The default
+	compression level is 6.  Setting the compression level
+	to 0 may be useful when the pack will be compressed as a
+	whole at a later stage (in the pack format every object
+	is compressed separately to allow random access, which
+	is less efficient than compressing the whole file).
+
 --incremental::
 	This flag causes an object already in a pack ignored
 	even if it appears in the standard input.
diff --git a/csum-file.c b/csum-file.c
--- a/csum-file.c
+++ b/csum-file.c
@@ -117,14 +117,15 @@ struct sha1file *sha1fd(int fd, const ch
 	return f;
 }
 
-int sha1write_compressed(struct sha1file *f, void *in, unsigned int size)
+int sha1write_compressed(struct sha1file *f, void *in, unsigned int size,
+			 int compression_level)
 {
 	z_stream stream;
 	unsigned long maxsize;
 	void *out;
 
 	memset(&stream, 0, sizeof(stream));
-	deflateInit(&stream, Z_DEFAULT_COMPRESSION);
+	deflateInit(&stream, compression_level);
 	maxsize = deflateBound(&stream, size);
 	out = xmalloc(maxsize);
 
diff --git a/csum-file.h b/csum-file.h
--- a/csum-file.h
+++ b/csum-file.h
@@ -14,6 +14,6 @@ extern struct sha1file *sha1fd(int fd, c
 extern struct sha1file *sha1create(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern int sha1close(struct sha1file *, unsigned char *, int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
-extern int sha1write_compressed(struct sha1file *, void *, unsigned int);
+extern int sha1write_compressed(struct sha1file *, void *, unsigned int, int);
 
 #endif
diff --git a/pack-objects.c b/pack-objects.c
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -5,7 +5,7 @@
 #include "pack.h"
 #include "csum-file.h"
 
-static const char pack_usage[] = "git-pack-objects [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
+static const char pack_usage[] = "git-pack-objects [--incremental] [--window=N] [--depth=N] [--compression-level=N] {--stdout | base-name} < object-list";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -21,6 +21,7 @@ struct object_entry {
 static unsigned char object_list_sha1[20];
 static int non_empty = 0;
 static int incremental = 0;
+static int compression_level = Z_DEFAULT_COMPRESSION;
 static struct object_entry **sorted_by_sha, **sorted_by_type;
 static struct object_entry *objects = NULL;
 static int nr_objects = 0, nr_alloc = 0;
@@ -103,7 +104,7 @@ static unsigned long write_object(struct
 		sha1write(f, entry->delta, 20);
 		hdrlen += 20;
 	}
-	datalen = sha1write_compressed(f, buf, size);
+	datalen = sha1write_compressed(f, buf, size, compression_level);
 	free(buf);
 	return hdrlen + datalen;
 }
@@ -421,6 +422,16 @@ int main(int argc, char **argv)
 					usage(pack_usage);
 				continue;
 			}
+			if (!strncmp("--compression-level=", arg, 20)) {
+				char *end;
+				compression_level = strtoul(arg+20, &end, 0);
+				if (!arg[20] || *end)
+					usage(pack_usage);
+				if (compression_level < Z_NO_COMPRESSION
+				    || compression_level > Z_BEST_COMPRESSION)
+					die("invalid compression level");
+				continue;
+			}
 			if (!strcmp("--stdout", arg)) {
 				pack_to_stdout = 1;
 				continue;
