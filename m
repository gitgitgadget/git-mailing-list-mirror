From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] deprecate the new loose object header format
Date: Wed, 09 May 2007 14:42:42 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705091422130.24220@xanadu.home>
References: <4640FBDE.1000609@gmail.com>
 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
 <alpine.LFD.0.99.0705082106590.24220@xanadu.home>
 <56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
 <alpine.LFD.0.99.0705091048120.24220@xanadu.home>
 <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 20:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlr7v-0008Al-Pp
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbXEISm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756861AbXEISm6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:42:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39996 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbXEISm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:42:57 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHS0098HEN61970@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 May 2007 14:42:43 -0400 (EDT)
In-reply-to: <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46766>

Now that we encourage and actively preserve objects in a packed form 
more agressively than we did at the time the new loose object format and 
core.legacyheaders were introduced, that extra loose object format 
doesn't appear to be worth it anymore.

Because the packing of loose objects has to go through the delta match 
loop anyway, and since most of them should end up being deltified in 
most cases, there is really little advantage to have this parallel loose 
object format as the CPU savings it might provide is rather lost in the 
noise in the end.

This patch gets rid of core.legacyheaders, preserve the legacy format as 
the only writable loose object format and deprecate the other one to 
keep things simpler.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

On Wed, 9 May 2007, Junio C Hamano wrote:

> I agree with your analysis, especially when deeper delta chains
> are allowed, straight copy of loose object becomes less and less
> likely.

So here it is, with a nice code reduction:

 Documentation/config.txt |   13 --------
 builtin-pack-objects.c   |   69 ----------------------------------------------
 cache.h                  |    2 -
 config.c                 |    5 ---
 environment.c            |    1 -
 sha1_file.c              |   47 +++++++------------------------
 6 files changed, 11 insertions(+), 126 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ea434af..d6d89ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -209,19 +209,6 @@ core.compression::
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
 	slowest.
 
-core.legacyheaders::
-	A boolean which
-	changes the format of loose objects so that they are more
-	efficient to pack and to send out of the repository over git
-	native protocol, since v1.4.2.  However, loose objects
-	written in the new format cannot be read by git older than
-	that version; people fetching from your repository using
-	older versions of git over dumb transports (e.g. http)
-	will also be affected.
-+
-To let git use the new loose object format, you have to
-set core.legacyheaders to false.
-
 core.packedGitWindowSize::
 	Number of bytes of a pack file to map into memory in a
 	single mapping operation.  Larger window sizes may allow
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 966f843..c74a361 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -346,56 +346,6 @@ static void copy_pack_data(struct sha1file *f,
 	}
 }
 
-static int check_loose_inflate(unsigned char *data, unsigned long len, unsigned long expect)
-{
-	z_stream stream;
-	unsigned char fakebuf[4096];
-	int st;
-
-	memset(&stream, 0, sizeof(stream));
-	stream.next_in = data;
-	stream.avail_in = len;
-	stream.next_out = fakebuf;
-	stream.avail_out = sizeof(fakebuf);
-	inflateInit(&stream);
-
-	while (1) {
-		st = inflate(&stream, Z_FINISH);
-		if (st == Z_STREAM_END || st == Z_OK) {
-			st = (stream.total_out == expect &&
-			      stream.total_in == len) ? 0 : -1;
-			break;
-		}
-		if (st != Z_BUF_ERROR) {
-			st = -1;
-			break;
-		}
-		stream.next_out = fakebuf;
-		stream.avail_out = sizeof(fakebuf);
-	}
-	inflateEnd(&stream);
-	return st;
-}
-
-static int revalidate_loose_object(struct object_entry *entry,
-				   unsigned char *map,
-				   unsigned long mapsize)
-{
-	/* we already know this is a loose object with new type header. */
-	enum object_type type;
-	unsigned long size, used;
-
-	if (pack_to_stdout)
-		return 0;
-
-	used = unpack_object_header_gently(map, mapsize, &type, &size);
-	if (!used)
-		return -1;
-	map += used;
-	mapsize -= used;
-	return check_loose_inflate(map, mapsize, size);
-}
-
 static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry)
 {
@@ -425,25 +375,6 @@ static unsigned long write_object(struct sha1file *f,
 				 * and we do not need to deltify it.
 				 */
 
-	if (!entry->in_pack && !entry->delta) {
-		unsigned char *map;
-		unsigned long mapsize;
-		map = map_sha1_file(entry->sha1, &mapsize);
-		if (map && !legacy_loose_object(map)) {
-			/* We can copy straight into the pack file */
-			if (revalidate_loose_object(entry, map, mapsize))
-				die("corrupt loose object %s",
-				    sha1_to_hex(entry->sha1));
-			sha1write(f, map, mapsize);
-			munmap(map, mapsize);
-			written++;
-			reused++;
-			return mapsize;
-		}
-		if (map)
-			munmap(map, mapsize);
-	}
-
 	if (!to_reuse) {
 		buf = read_sha1_file(entry->sha1, &type, &size);
 		if (!buf)
diff --git a/cache.h b/cache.h
index 8e76152..5725bce 100644
--- a/cache.h
+++ b/cache.h
@@ -273,7 +273,6 @@ extern void rollback_lock_file(struct lock_file *);
 extern int delete_ref(const char *, const unsigned char *sha1);
 
 /* Environment bits from configuration mechanism */
-extern int use_legacy_headers;
 extern int trust_executable_bit;
 extern int has_symlinks;
 extern int assume_unchanged;
@@ -354,7 +353,6 @@ extern int move_temp_to_file(const char *tmpfile, const char *filename);
 extern int has_sha1_pack(const unsigned char *sha1, const char **ignore);
 extern int has_sha1_file(const unsigned char *sha1);
 extern void *map_sha1_file(const unsigned char *sha1, unsigned long *);
-extern int legacy_loose_object(unsigned char *);
 
 extern int has_pack_file(const unsigned char *sha1);
 extern int has_pack_index(const unsigned char *sha1);
diff --git a/config.c b/config.c
index 70d1055..298966f 100644
--- a/config.c
+++ b/config.c
@@ -299,11 +299,6 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.legacyheaders")) {
-		use_legacy_headers = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.compression")) {
 		int level = git_config_int(var, value);
 		if (level == -1)
diff --git a/environment.c b/environment.c
index 2231659..54e3aba 100644
--- a/environment.c
+++ b/environment.c
@@ -11,7 +11,6 @@
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
-int use_legacy_headers = 1;
 int trust_executable_bit = 1;
 int has_symlinks = 1;
 int assume_unchanged;
diff --git a/sha1_file.c b/sha1_file.c
index 32244d7..e715527 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -972,7 +972,7 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 	return map;
 }
 
-int legacy_loose_object(unsigned char *map)
+static int legacy_loose_object(unsigned char *map)
 {
 	unsigned int word;
 
@@ -1034,6 +1034,14 @@ static int unpack_sha1_header(z_stream *stream, unsigned char *map, unsigned lon
 		return inflate(stream, 0);
 	}
 
+
+	/*
+	 * There used to be a second loose object header format which
+	 * was meant to mimic the in-pack format, allowing for direct
+	 * copy of the object data.  This format turned up not to be
+	 * really worth it and we don't write it any longer.  But we
+	 * can still read it.
+	 */
 	used = unpack_object_header_gently(map, mapsize, &type, &size);
 	if (!used || !valid_loose_object_type[type])
 		return -1;
@@ -1962,40 +1970,6 @@ static int write_buffer(int fd, const void *buf, size_t len)
 	return 0;
 }
 
-static int write_binary_header(unsigned char *hdr, enum object_type type, unsigned long len)
-{
-	int hdr_len;
-	unsigned char c;
-
-	c = (type << 4) | (len & 15);
-	len >>= 4;
-	hdr_len = 1;
-	while (len) {
-		*hdr++ = c | 0x80;
-		hdr_len++;
-		c = (len & 0x7f);
-		len >>= 7;
-	}
-	*hdr = c;
-	return hdr_len;
-}
-
-static void setup_object_header(z_stream *stream, const char *type, unsigned long len)
-{
-	int obj_type, hdrlen;
-
-	if (use_legacy_headers) {
-		while (deflate(stream, 0) == Z_OK)
-			/* nothing */;
-		return;
-	}
-	obj_type = type_from_string(type);
-	hdrlen = write_binary_header(stream->next_out, obj_type, len);
-	stream->total_out = hdrlen;
-	stream->next_out += hdrlen;
-	stream->avail_out -= hdrlen;
-}
-
 int hash_sha1_file(const void *buf, unsigned long len, const char *type,
                    unsigned char *sha1)
 {
@@ -2062,7 +2036,8 @@ int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned cha
 	/* First header.. */
 	stream.next_in = (unsigned char *)hdr;
 	stream.avail_in = hdrlen;
-	setup_object_header(&stream, type, len);
+	while (deflate(&stream, 0) == Z_OK)
+		/* nothing */;
 
 	/* Then the data itself.. */
 	stream.next_in = buf;
