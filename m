From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Fri, 01 Sep 2006 16:14:23 -0700
Message-ID: <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
	<9e4733910608291037k2d9fb791v18abc19bdddf5e89@mail.gmail.com>
	<20060829175819.GE21729@spearce.org>
	<9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	<20060829190548.GK21729@spearce.org>
	<9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	<20060829232007.GC22935@spearce.org>
	<9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	<20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 01:14:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJIDP-0002jU-Mt
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 01:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWIAXOS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 19:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWIAXOS
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 19:14:18 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44533 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751162AbWIAXOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 19:14:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901231417.NFHX12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Sep 2006 19:14:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HBEG1V01G1kojtg0000000
	Fri, 01 Sep 2006 19:14:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 1 Sep 2006 11:35:23 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26312>

When reusing data from an existing pack and from a new style
loose objects, we used to just copy it staight into the
resulting pack.  Instead make sure they are not corrupt, but
do so only when we are not streaming to stdout, in which case
the receiving end will do the validation either by unpacking
the stream or by constructing the .idx file.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Linus Torvalds <torvalds@osdl.org> writes:

  > On Fri, 1 Sep 2006, A Large Angry SCM wrote:
  >> 
  >> Unfortunately, the zlib CRC is of the _uncompressed_ data [1], so
  >> inflating the stream is still necessary to check for corruption.
  >
  > I don't think that is unfortunate.
  >
  > We really should inflate the stream anyway, since not only inflating it, 
  > but also applying any deltas to the base object is really the only way to 
  > verify its correctness for a delta thing. Otherwise, the SHA1 of the base 
  > could be totally corrupt.
  >
  > And once you inflate it and apply all deltas, you obviously also get the 
  > full SHA1 check, so you're _really_ safe.
  >
  > So let's do the really safe thing first, and see if it actually results in 
  > any problems.

  So here is an attempt to do this.

 builtin-pack-objects.c |   64 +++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 46f524d..10ba866 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -65,6 +65,7 @@ static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static volatile sig_atomic_t progress_update;
 static int window = 10;
+static int pack_to_stdout;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -242,6 +243,55 @@ static int encode_header(enum object_typ
 	return n;
 }
 
+static int revalidate_one(struct object_entry *entry,
+			  void *data, char *type, unsigned long size)
+{
+	unsigned char hdr[50];
+	int hdrlen;
+	unsigned char sha1[20];
+
+	if (!data)
+		return -1;
+	if (size != entry->size)
+		return -1;
+	write_sha1_file_prepare(data, size, type, sha1, hdr, &hdrlen);
+	free(data);
+	if (hashcmp(sha1, entry->sha1))
+		return -1;
+	return 0;
+}
+
+/*
+ * we are going to reuse the existing pack entry data.  make
+ * sure it is not corrupt.
+ */
+static int revalidate_pack_entry(struct object_entry *entry)
+{
+	void *data;
+	char type[20];
+	unsigned long size;
+	struct pack_entry e;
+
+	e.p = entry->in_pack;
+	e.offset = entry->in_pack_offset;
+
+	/* the caller has already called use_packed_git() for us */
+	data = unpack_entry_gently(&e, type, &size);
+	return revalidate_one(entry, data, type, size);
+}
+
+static int revalidate_loose_object(struct object_entry *entry,
+				   unsigned char *map,
+				   unsigned long mapsize)
+{
+	/* we already know this is a loose object with new type header. */
+	void *data;
+	char type[20];
+	unsigned long size;
+	data = unpack_sha1_file(map, mapsize, type, &size);
+	return revalidate_one(entry, data, type, size);
+}
+
 static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry)
 {
@@ -276,6 +326,9 @@ static unsigned long write_object(struct
 		map = map_sha1_file(entry->sha1, &mapsize);
 		if (map && !legacy_loose_object(map)) {
 			/* We can copy straight into the pack file */
+			if (revalidate_loose_object(entry, map, mapsize))
+				die("corrupt loose object %s",
+				    sha1_to_hex(entry->sha1));
 			sha1write(f, map, mapsize);
 			munmap(map, mapsize);
 			written++;
@@ -286,7 +339,7 @@ static unsigned long write_object(struct
 			munmap(map, mapsize);
 	}
 
-	if (! to_reuse) {
+	if (!to_reuse) {
 		buf = read_sha1_file(entry->sha1, type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
@@ -319,6 +372,9 @@ static unsigned long write_object(struct
 
 		datalen = find_packed_object_size(p, entry->in_pack_offset);
 		buf = (char *) p->pack_base + entry->in_pack_offset;
+
+		if (revalidate_pack_entry(entry))
+			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
 		hdrlen = 0; /* not really */
@@ -1163,7 +1219,7 @@ static void prepare_pack(int window, int
 		find_deltas(sorted_by_type, window+1, depth);
 }
 
-static int reuse_cached_pack(unsigned char *sha1, int pack_to_stdout)
+static int reuse_cached_pack(unsigned char *sha1)
 {
 	static const char cache[] = "pack-cache/pack-%s.%s";
 	char *cached_pack, *cached_idx;
@@ -1247,7 +1303,7 @@ int cmd_pack_objects(int argc, const cha
 {
 	SHA_CTX ctx;
 	char line[40 + 1 + PATH_MAX + 2];
-	int depth = 10, pack_to_stdout = 0;
+	int depth = 10;
 	struct object_entry **list;
 	int num_preferred_base = 0;
 	int i;
@@ -1367,7 +1423,7 @@ int cmd_pack_objects(int argc, const cha
 	if (progress && (nr_objects != nr_result))
 		fprintf(stderr, "Result has %d objects.\n", nr_result);
 
-	if (reuse_cached_pack(object_list_sha1, pack_to_stdout))
+	if (reuse_cached_pack(object_list_sha1))
 		;
 	else {
 		if (nr_result)
-- 
1.4.2.ga2654



-- 
VGER BF report: U 0.5
