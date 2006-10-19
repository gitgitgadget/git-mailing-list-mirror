From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 17:46:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181741590.3962@g5.osdl.org>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org>
 <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
 <Pine.LNX.4.63.0610190229270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 19 02:48:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaM3m-0001wn-Ng
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 02:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945934AbWJSAqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 20:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945935AbWJSAqz
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 20:46:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945934AbWJSAqy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 20:46:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9J0kdaX028556
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 17:46:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9J0kcKF025141;
	Wed, 18 Oct 2006 17:46:38 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610190229270.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.972 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29310>



On Thu, 19 Oct 2006, Johannes Schindelin wrote:
> 
> You do not write this to stdout, right? Why not just come back and correct 
> the number of objects? Of course, the SHA1 has to be calculated _after_ 
> that.

That's the issue. I wanted the pack-file thing to look as similar to the 
old code as possible. And that means using the "sha1write()" interfaces, 
which calculate the SHA1 checksum _as_ we write.

So yes, I wanted to do it all in one phase.

Anyway, if anybody is interested, here's a series of four patches that do 
something that _almost_ works. I save away the SHA1's and the offsets so 
that I could write an index too, but I didn't actually do that part.

But with this, I can rewrite a pack-file "in flight", and the end result 
can then have "git index-pack" run on it, and used as a pack. It's just 
that there are no deltas left because of some of the silly problems I 
outlined (the code to write out deltas is actually there and just 
uncommented - it works, but it leaves the end result with unsatisfied 
deltas again).

		Linus
---
commit 4efd9b0f44635b3075c9aad6d1cc8830e3abded3
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Wed Oct 18 17:22:04 2006 -0700

    Fix up csum-file interfaces
    
    Add "const" where appropriate
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/csum-file.c b/csum-file.c
index b7174c6..3237228 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -47,7 +47,7 @@ int sha1close(struct sha1file *f, unsign
 	return 0;
 }
 
-int sha1write(struct sha1file *f, void *buf, unsigned int count)
+int sha1write(struct sha1file *f, const void *buf, unsigned int count)
 {
 	while (count) {
 		unsigned offset = f->offset;
@@ -115,7 +115,7 @@ struct sha1file *sha1fd(int fd, const ch
 	return f;
 }
 
-int sha1write_compressed(struct sha1file *f, void *in, unsigned int size)
+int sha1write_compressed(struct sha1file *f, const void *in, unsigned int size)
 {
 	z_stream stream;
 	unsigned long maxsize;
@@ -127,7 +127,7 @@ int sha1write_compressed(struct sha1file
 	out = xmalloc(maxsize);
 
 	/* Compress it */
-	stream.next_in = in;
+	stream.next_in = (void *) in;
 	stream.avail_in = size;
 
 	stream.next_out = out;
diff --git a/csum-file.h b/csum-file.h
index 3ad1a99..fee8589 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -13,7 +13,7 @@ struct sha1file {
 extern struct sha1file *sha1fd(int fd, const char *name);
 extern struct sha1file *sha1create(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern int sha1close(struct sha1file *, unsigned char *, int);
-extern int sha1write(struct sha1file *, void *, unsigned int);
-extern int sha1write_compressed(struct sha1file *, void *, unsigned int);
+extern int sha1write(struct sha1file *, const void *, unsigned int);
+extern int sha1write_compressed(struct sha1file *, const void *, unsigned int);
 
 #endif

commit c2c8480b05a75d93f78a0ddd1cce18c6864738eb
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Wed Oct 18 17:20:53 2006 -0700

    Make some of the pack-writing helper functions available
    
    string_to_type() and encode_header() are useful in general.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 96c069a..ea39bf3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -220,6 +220,20 @@ static void *delta_against(void *buf, un
 	return delta_buf;
 }
 
+enum object_type string_to_type(const char *type, const unsigned char *sha1)
+{
+	if (!strcmp(type, commit_type))
+		return OBJ_COMMIT;
+	if (!strcmp(type, tree_type))
+		return OBJ_TREE;
+	if (!strcmp(type, blob_type))
+		return OBJ_BLOB;
+	if (!strcmp(type, tag_type))
+		return OBJ_TAG;
+	die("strange object %s of unknown type %s",
+		    sha1_to_hex(sha1), type);
+}
+
 /*
  * The per-object header is a pretty dense thing, which is
  *  - first byte: low four bits are "size", then three bits of "type",
@@ -227,7 +241,7 @@ static void *delta_against(void *buf, un
  *  - each byte afterwards: low seven bits are size continuation,
  *    with the high bit being "size continues"
  */
-static int encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
+int encode_header(enum object_type type, unsigned long size, unsigned char *hdr)
 {
 	int n = 1;
 	unsigned char c;
@@ -943,17 +957,7 @@ static void check_object(struct object_e
 		die("unable to get type of object %s",
 		    sha1_to_hex(entry->sha1));
 
-	if (!strcmp(type, commit_type)) {
-		entry->type = OBJ_COMMIT;
-	} else if (!strcmp(type, tree_type)) {
-		entry->type = OBJ_TREE;
-	} else if (!strcmp(type, blob_type)) {
-		entry->type = OBJ_BLOB;
-	} else if (!strcmp(type, tag_type)) {
-		entry->type = OBJ_TAG;
-	} else
-		die("unable to pack object %s of type %s",
-		    sha1_to_hex(entry->sha1), type);
+	entry->type = string_to_type(type, entry->sha1);
 }
 
 static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
diff --git a/pack.h b/pack.h
index eb07b03..346a430 100644
--- a/pack.h
+++ b/pack.h
@@ -15,6 +15,9 @@ struct pack_header {
 	unsigned int hdr_entries;
 };
 
+enum object_type string_to_type(const char *type, const unsigned char *sha1);
+int encode_header(enum object_type type, unsigned long size, unsigned char *hdr);
+
 extern int verify_pack(struct packed_git *, int);
 extern int check_reuse_pack_delta(struct packed_git *, unsigned long,
 				  unsigned char *, unsigned long *,

commit 94d620067b4a4179656c0ce347cb87be52a9d67f
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Wed Oct 18 15:44:40 2006 -0700

    git-unpack-objects: pass in the original delta data when writing the object
    
    This does nothing right now, but if we want to instead of loose objects
    write a new "verified packfile" with an index, this lets us do that instead.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 4f96bca..bbb6e21 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -109,7 +109,8 @@ static void add_delta_to_list(unsigned c
 
 static void added_object(unsigned char *sha1, const char *type, void *data, unsigned long size);
 
-static void write_object(void *buf, unsigned long size, const char *type)
+static void write_object(void *buf, unsigned long size, const char *type,
+	unsigned char *base, void *delta, unsigned long delta_size)
 {
 	unsigned char sha1[20];
 	if (write_sha1_file(buf, size, type, sha1) < 0)
@@ -117,7 +118,7 @@ static void write_object(void *buf, unsi
 	added_object(sha1, type, buf, size);
 }
 
-static void resolve_delta(const char *type,
+static void resolve_delta(const char *type, unsigned char *base_sha1,
 			  void *base, unsigned long base_size,
 			  void *delta, unsigned long delta_size)
 {
@@ -129,8 +130,8 @@ static void resolve_delta(const char *ty
 			     &result_size);
 	if (!result)
 		die("failed to apply delta");
+	write_object(result, result_size, type, base_sha1, delta, delta_size);
 	free(delta);
-	write_object(result, result_size, type);
 	free(result);
 }
 
@@ -143,7 +144,7 @@ static void added_object(unsigned char *
 		if (!hashcmp(info->base_sha1, sha1)) {
 			*p = info->next;
 			p = &delta_list;
-			resolve_delta(type, data, size, info->delta, info->size);
+			resolve_delta(type, sha1, data, size, info->delta, info->size);
 			free(info);
 			continue;
 		}
@@ -164,7 +165,7 @@ static void unpack_non_delta_entry(enum 
 	default: die("bad type %d", kind);
 	}
 	if (!dry_run && buf)
-		write_object(buf, size, type);
+		write_object(buf, size, type, NULL, NULL, 0);
 	free(buf);
 }
 
@@ -197,7 +198,7 @@ static void unpack_delta_entry(unsigned 
 		has_errors = 1;
 		return;
 	}
-	resolve_delta(type, base, base_size, delta_data, delta_size);
+	resolve_delta(type, base_sha1, base, base_size, delta_data, delta_size);
 	free(base);
 }
 
diff --git a/date.c b/date.c
index 1825922..0b06994 100644
--- a/date.c
+++ b/date.c
@@ -657,6 +657,7 @@ static const struct typelen {
 	{ "hours", 60*60 },
 	{ "days", 24*60*60 },
 	{ "weeks", 7*24*60*60 },
+	{ "fortnights", 2*7*24*60*60 },
 	{ NULL }
 };	
 

commit 636210e7fcceb7297ccf0fc54291bb1c8356f0d3
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Wed Oct 18 17:23:06 2006 -0700

    Make "unpack-objects" able to write a single pack-file instead
    
    This is idiotic. It writes everything undeltified, which is
    horrid. I need a brain.
    
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index bbb6e21..f139308 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -7,11 +7,12 @@ #include "blob.h"
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "csum-file.h"
 
 #include <sys/time.h>
 
 static int dry_run, quiet, recover, has_errors;
-static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
+static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] [--repack=pack-name] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -87,6 +88,56 @@ static void *get_data(unsigned long size
 	return buf;
 }
 
+static struct sha1file *pack_file;
+static unsigned long pack_file_offset;
+
+struct index_entry {
+	unsigned long offset;
+	unsigned char sha1[20];
+};
+
+static unsigned int index_nr, index_alloc;
+static struct index_entry **index_array;
+
+static void add_pack_index(unsigned char *sha1)
+{
+	struct index_entry *entry;
+	int nr = index_nr;
+	if (nr >= index_alloc) {
+		index_alloc = (index_alloc + 64) * 3 / 2;
+		index_array = xrealloc(index_array, index_alloc * sizeof(*index_array));
+	}
+	entry = xmalloc(sizeof(*entry));
+	entry->offset = pack_file_offset;
+	hashcpy(entry->sha1, sha1);
+	index_array[nr++] = entry;
+}
+
+static void write_pack_delta(const unsigned char *base, const void *delta, unsigned long delta_size)
+{
+	unsigned char header[10];
+	unsigned hdrlen, datalen;
+
+	hdrlen = encode_header(OBJ_DELTA, delta_size, header);
+	sha1write(pack_file, header, hdrlen);
+	sha1write(pack_file, base, 20);
+	datalen = sha1write_compressed(pack_file, delta, delta_size);
+
+	pack_file_offset += hdrlen + 20 + datalen;
+}
+
+static void write_pack_object(const char *type, const unsigned char *sha1, const void *buf, unsigned long size)
+{
+	unsigned char header[10];
+	unsigned hdrlen, datalen;
+
+	hdrlen = encode_header(string_to_type(type, sha1), size, header);
+	sha1write(pack_file, header, hdrlen);
+	datalen = sha1write_compressed(pack_file, buf, size);
+
+	pack_file_offset += hdrlen + datalen;
+}
+
 struct delta_info {
 	unsigned char base_sha1[20];
 	unsigned long size;
@@ -113,7 +164,16 @@ static void write_object(void *buf, unsi
 	unsigned char *base, void *delta, unsigned long delta_size)
 {
 	unsigned char sha1[20];
-	if (write_sha1_file(buf, size, type, sha1) < 0)
+
+	if (pack_file) {
+		if (hash_sha1_file(buf, size, type, sha1) < 0)
+			die("failed to compute object hash");
+		add_pack_index(sha1);
+		if (0 && base)
+			write_pack_delta(base, delta, delta_size);
+		else
+			write_pack_object(type, sha1, buf, size);
+	} else if (write_sha1_file(buf, size, type, sha1) < 0)
 		die("failed to write object");
 	added_object(sha1, type, buf, size);
 }
@@ -254,7 +314,7 @@ static void unpack_one(unsigned nr, unsi
 	}
 }
 
-static void unpack_all(void)
+static void unpack_all(const char *repack)
 {
 	int i;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
@@ -266,17 +326,32 @@ static void unpack_all(void)
 		die("unknown pack file version %d", ntohl(hdr->hdr_version));
 	fprintf(stderr, "Unpacking %d objects\n", nr_objects);
 
+	if (repack) {
+		struct pack_header newhdr;
+		newhdr.hdr_signature = htonl(PACK_SIGNATURE);
+		newhdr.hdr_version = htonl(PACK_VERSION);
+		newhdr.hdr_entries = htonl(nr_objects);
+		
+		pack_file = sha1create("%s.pack", repack);
+		sha1write(pack_file, &newhdr, sizeof(newhdr));
+		pack_file_offset = sizeof(newhdr);
+	}
+		
+
 	use(sizeof(struct pack_header));
 	for (i = 0; i < nr_objects; i++)
 		unpack_one(i+1, nr_objects);
 	if (delta_list)
 		die("unresolved deltas left after unpacking");
+	if (repack)
+		sha1close(pack_file, NULL, 1);
 }
 
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	unsigned char sha1[20];
+	const char *repack = NULL;
 
 	git_config(git_default_config);
 
@@ -298,6 +373,10 @@ int cmd_unpack_objects(int argc, const c
 				recover = 1;
 				continue;
 			}
+			if (!strncmp(arg, "--repack=", 9)) {
+				repack = arg + 9;
+				continue;
+			}
 			usage(unpack_usage);
 		}
 
@@ -305,7 +384,7 @@ int cmd_unpack_objects(int argc, const c
 		usage(unpack_usage);
 	}
 	SHA1_Init(&ctx);
-	unpack_all();
+	unpack_all(repack);
 	SHA1_Update(&ctx, buffer, offset);
 	SHA1_Final(sha1, &ctx);
 	if (hashcmp(fill(20), sha1))
