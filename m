From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 17:03:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 02:03:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0SCV-0003Re-PI
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 02:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWGLADd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 20:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWGLADd
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 20:03:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55743 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbWGLADc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 20:03:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6C03LnW005317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 17:03:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6C03K8b015876;
	Tue, 11 Jul 2006 17:03:20 -0700
To: Junio C Hamano <junkio@cox.net>, sf <sf-gmane@stephan-feder.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23750>



On Tue, 11 Jul 2006, Junio C Hamano wrote:
> 
> I do not like to rely too heavily on what zlib compression's
> beginning of stream looks like.

Well, I normally would agree with you if it was a "oh, all our zlib 
objects seem to start with 0x78" thing, but after having dug into both the 
zlib standard (which is actually an RFC, not just some random thing), and 
looked at the sources, it's definitely the case that the "0x78" byte isn't 
just an implementation detail.

It's actually really part of the specs, and not just happenstance.

> I think the new format can be deflated new header (fully
> synched) followed by deflated payload.

That would work, but on the other hand, one of the advantages of doing the 
new format would be that the "check size and type" code wouldn't even need 
to call into the zlib code. 

Anyway, I think this following patch replaces the old 2/3 and 3/3 (it 
still depends on the original [1/3] cleanup.

(It also renames and reverses the meaning of the config file option: it's 
now "[core] LegacyHeaders = true" for using legacy headers.)

Not heavily tested, but seems ok.

sf? Dscho? Can you check this thing out?

		Linus
----
 Documentation/config.txt |    6 +++
 cache.h                  |    1 
 config.c                 |    5 ++
 environment.c            |    1 
 sha1_file.c              |  106 +++++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0b434c1..9780c89 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -97,6 +97,12 @@ core.compression::
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
 	slowest.
 
+core.legacyheaders::
+	A boolean which enables the legacy object header format in case
+	you want to interoperate with old clients accessing the object
+	database directly (where the "http://" and "rsync://" protocols
+	count as direct access).
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index d433d46..eee5fc9 100644
--- a/cache.h
+++ b/cache.h
@@ -176,6 +176,7 @@ extern int commit_lock_file(struct lock_
 extern void rollback_lock_file(struct lock_file *);
 
 /* Environment bits from configuration mechanism */
+extern int use_legacy_headers;
 extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index 8445f7d..0ac6aeb 100644
--- a/config.c
+++ b/config.c
@@ -279,6 +279,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.legacyheaders")) {
+		use_legacy_headers = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.compression")) {
 		int level = git_config_int(var, value);
 		if (level == -1)
diff --git a/environment.c b/environment.c
index 97d42b1..d80a39a 100644
--- a/environment.c
+++ b/environment.c
@@ -11,6 +11,7 @@ #include "cache.h"
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
+int use_legacy_headers = 0;
 int trust_executable_bit = 1;
 int assume_unchanged = 0;
 int prefer_symlink_refs = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 8734d50..475b23d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -684,26 +684,74 @@ static void *map_sha1_file_internal(cons
 	return map;
 }
 
-static int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size)
+static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz)
 {
+	unsigned char c;
+	unsigned int word, bits;
+	unsigned long size;
+	static const char *typename[8] = {
+		NULL,	/* OBJ_EXT */
+		"commit", "tree", "blob", "tag",
+		NULL, NULL, NULL
+	};
+	const char *type;
+
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in = map;
 	stream->avail_in = mapsize;
 	stream->next_out = buffer;
-	stream->avail_out = size;
+	stream->avail_out = bufsiz;
+
+	/*
+	 * Is it a zlib-compressed buffer? If so, the first byte
+	 * must be 0x78 (15-bit window size, deflated), and the
+	 * first 16-bit word is evenly divisible by 31
+	 */
+	word = (map[0] << 8) + map[1];
+	if (map[0] == 0x78 && !(word % 31)) {
+		inflateInit(stream);
+		return inflate(stream, 0);  
+	}
+
+	c = *map++;
+	mapsize--;
+	type = typename[(c >> 4) & 7];
+	if (!type)
+		return -1;
+	
+	bits = 4;
+	size = c & 0xf;
+	while (!(c & 0x80)) {
+		if (bits >= 8*sizeof(long))
+			return -1;
+		c = *map++;
+		size += (c & 0x7f) << bits;
+		bits += 7;
+		mapsize--;
+	}
 
+	/* Set up the stream for the rest.. */
+	stream->next_in = map;
+	stream->avail_in = mapsize;
 	inflateInit(stream);
-	return inflate(stream, 0);
+
+	/* And generate the fake traditional header */
+	stream->total_out = 1 + snprintf(buffer, bufsiz, "%s %lu", type, size);
+	return 0;
 }
 
 static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmalloc(1+size);
+	unsigned long n;
 
-	memcpy(buf, (char *) buffer + bytes, stream->total_out - bytes);
-	bytes = stream->total_out - bytes;
+	n = stream->total_out - bytes;
+	if (n > size)
+		n = size;
+	memcpy(buf, (char *) buffer + bytes, n);
+	bytes = n;
 	if (bytes < size) {
 		stream->next_out = buf + bytes;
 		stream->avail_out = size - bytes;
@@ -1414,6 +1462,49 @@ static int write_buffer(int fd, const vo
 	return 0;
 }
 
+static int write_binary_header(unsigned char *hdr, enum object_type type, unsigned long len)
+{
+	int hdr_len;
+	unsigned char c;
+
+	c = (type << 4) | (len & 15);
+	len >>= 4;
+	hdr_len = 1;
+	while (len) {
+		*hdr++ = c;
+		hdr_len++;
+		c = (len & 0x7f);
+		len >>= 7;
+	}
+	*hdr = c | 0x80;
+	return hdr_len;
+}
+
+static void setup_object_header(z_stream *stream, const char *type, unsigned long len)
+{
+	int obj_type, hdr;
+
+	if (use_legacy_headers) {
+		while (deflate(stream, 0) == Z_OK)
+			/* nothing */;
+		return;
+	}
+	if (!strcmp(type, blob_type))
+		obj_type = OBJ_BLOB;
+	else if (!strcmp(type, tree_type))
+		obj_type = OBJ_TREE;
+	else if (!strcmp(type, commit_type))
+		obj_type = OBJ_COMMIT;
+	else if (!strcmp(type, tag_type))
+		obj_type = OBJ_TAG;
+	else
+		die("trying to generate bogus object of type '%s'", type);
+	hdr = write_binary_header(stream->next_out, obj_type, len);
+	stream->total_out = hdr;
+	stream->next_out += hdr;
+	stream->avail_out -= hdr;
+}
+
 int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	int size;
@@ -1459,7 +1550,7 @@ int write_sha1_file(void *buf, unsigned 
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	deflateInit(&stream, zlib_compression_level);
-	size = deflateBound(&stream, len+hdrlen);
+	size = 8 + deflateBound(&stream, len+hdrlen);
 	compressed = xmalloc(size);
 
 	/* Compress it */
@@ -1469,8 +1560,7 @@ int write_sha1_file(void *buf, unsigned 
 	/* First header.. */
 	stream.next_in = hdr;
 	stream.avail_in = hdrlen;
-	while (deflate(&stream, 0) == Z_OK)
-		/* nothing */;
+	setup_object_header(&stream, type, len);
 
 	/* Then the data itself.. */
 	stream.next_in = buf;
