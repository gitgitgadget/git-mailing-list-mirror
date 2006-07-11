From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 3/3] Enable the new binary header format for unpacked objects
Date: Tue, 11 Jul 2006 10:16:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111012110.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 19:23:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Lwp-00054a-1f
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 19:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWGKRW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 13:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbWGKRW4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 13:22:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751097AbWGKRWz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 13:22:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BHGOnW012532
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 10:16:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BHGNAL029917;
	Tue, 11 Jul 2006 10:16:23 -0700
To: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23719>


Enable the new binary header format for unpacked objects

This makes unpacked objects use the same header encoding as the packed
objects do, which should eventually allow us to be able to re-use the
object data directly when creating pack-files (rather than having to
decode and re-encode the data when inserting it in a pack).

It's enabled by default, but can be disabled with

	[core]
		BinaryHeaders = false

in the config file.

We can read both formats, of course, so you can have a mixed archive.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This should _not_ be applied to the main git sources, at least not
with the default being "use_binary_headers = 1".

But if you change that initial assignment to 0, this should be reasonably 
good.

Not extensively tested, of course. It fails t9102-git-svn-deep-rmdir.sh 
for me for some reason, I didn't really look at it yet, since this whole 
thing is more for Carl Baldwin to play with right now.

 Documentation/config.txt |    5 ++++
 cache.h                  |    1 +
 config.c                 |    5 ++++
 environment.c            |    1 +
 sha1_file.c              |   65 ++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0b434c1..bc95416 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -97,6 +97,11 @@ core.compression::
 	compression, and 1..9 are various speed/size tradeoffs, 9 being
 	slowest.
 
+core.binaryheaders::
+	A boolean, that if set to false, disables the use of the
+	new-style binary objects headers that share the same format with
+	the headers in a pack file.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index d433d46..756d89f 100644
--- a/cache.h
+++ b/cache.h
@@ -176,6 +176,7 @@ extern int commit_lock_file(struct lock_
 extern void rollback_lock_file(struct lock_file *);
 
 /* Environment bits from configuration mechanism */
+extern int use_binary_headers;
 extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index 8445f7d..2497447 100644
--- a/config.c
+++ b/config.c
@@ -289,6 +289,11 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
+	if (!strcmp(var, "core.binaryheaders")) {
+		use_binary_headers = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index 43823ff..340214d 100644
--- a/environment.c
+++ b/environment.c
@@ -11,6 +11,7 @@ #include "cache.h"
 
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
+int use_binary_headers = 1;
 int trust_executable_bit = 1;
 int assume_unchanged = 0;
 int prefer_symlink_refs = 0;
diff --git a/sha1_file.c b/sha1_file.c
index ca5f0c0..700f455 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -699,11 +699,14 @@ static int unpack_sha1_header(z_stream *
 
 static void *unpack_sha1_rest(z_stream *stream, void *buffer, unsigned long size, unsigned int hdrlen)
 {
-	int bytes = hdrlen;
+	unsigned long bytes = hdrlen, n;
 	unsigned char *buf = xmalloc(1+size);
 
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
@@ -1240,7 +1243,7 @@ struct packed_git *find_sha1_pack(const 
 
 int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
 {
-	int status, hdrlen;
+	int status;
 	unsigned long mapsize, size;
 	void *map;
 	z_stream stream;
@@ -1349,24 +1352,70 @@ void *read_object_with_reference(const u
 	}
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
+static int generate_binary_header(unsigned char *hdr, const char *type, unsigned long len)
+{
+	int obj_type;
+
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
+	return write_binary_header(hdr, obj_type, len);
+}
+
 char *write_sha1_file_prepare(void *buf,
 			      unsigned long len,
 			      const char *type,
 			      unsigned char *sha1,
 			      unsigned char *hdr,
-			      int *hdrlen)
+			      int *hdrlenp)
 {
 	SHA_CTX c;
+	int hdr_len;
 
-	/* Generate the header */
-	*hdrlen = sprintf((char *)hdr, "%s %lu", type, len)+1;
+	/*
+	 * Generate the header.
+	 *
+	 * NOTE! Regardless of whether we end up using the ASCII
+	 * or binary header, we always generate the SHA1 of the
+	 * file as if we had the ASCII header.
+	 */
+	hdr_len = sprintf((char *)hdr, "%s %lu", type, len)+1;
 
 	/* Sha1.. */
 	SHA1_Init(&c);
-	SHA1_Update(&c, hdr, *hdrlen);
+	SHA1_Update(&c, hdr, hdr_len);
 	SHA1_Update(&c, buf, len);
 	SHA1_Final(sha1, &c);
 
+	if (use_binary_headers)
+		hdr_len = generate_binary_header(hdr, type, len);
+	*hdrlenp = hdr_len;
+
 	return sha1_file_name(sha1);
 }
 
