From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sun, 03 Sep 2006 21:06:59 -0700
Message-ID: <7vhczos2ak.fsf@assigned-by-dhcp.cox.net>
References: <20060829165811.GB21729@spearce.org>
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
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609021138500.27779@g5.osdl.org>
	<7vslj8tydc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609031456520.27779@g5.osdl.org>
	<7vodtwtw9v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 06:07:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK5jr-0002CJ-4B
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 06:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWIDEGn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 00:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWIDEGn
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 00:06:43 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64386 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932241AbWIDEGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 00:06:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904040641.MDNG2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 Sep 2006 00:06:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J46h1V00u1kojtg0000000
	Mon, 04 Sep 2006 00:06:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vodtwtw9v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 03 Sep 2006 15:34:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26397>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Ok. Is it less painful if it just checks the zlib CRC...
>
> I haven't checked myself but somebody said that zlib CRC is of
> preimage so we would need to incur inflate cost anyway if that
> is the case.  But I think it may be a reasonable comproise to
> assume that an existing delta that inflates properly would apply
> to its base object, and if we can assume that we do not have to
> check the inflated xdelta data.
> ...
> Another thing the current check is _not_ doing is for this
> pathological case:
>
>  - .idx table says the pack entry is N bytes
>
>  - unpack_entry_gently() used in the revalidate code uses the
>    usual codepath that says "here is the start of the pack
>    entry; inflate using as much data as you need"; .idx is
>    somehow wrong and it needed N+M bytes where 0 < M.
>
>  - we copy out N bytes because we belive .idx.

So here is a patch against "master" which contains none of the
earlier patches in this thread.

When copying from an existing pack and when copying from a loose
object with new style header, the code makes sure that the piece
we are going to copy out inflates well and inflate() consumes
the data in full while doing so.

The check to see if the xdelta really apply is quite expensive
as you described, because you would need to have the image of
the base object which can be represented as a delta against
something else.

The same repack takes this much with this code.

Total 301361, written 301361 (delta 238935), reused 300995 (delta 238663)
6.66user 0.67system 0:07.40elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+62728minor)pagefaults 0swaps

---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 46f524d..149fa28 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -65,6 +65,7 @@ static unsigned char pack_file_sha1[20];
 static int progress = 1;
 static volatile sig_atomic_t progress_update;
 static int window = 10;
+static int pack_to_stdout;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -242,6 +243,82 @@ static int encode_header(enum object_typ
 	return n;
 }
 
+static int check_inflate(unsigned char *data, unsigned long len, unsigned long expect)
+{
+	z_stream stream;
+	unsigned char fakebuf[4096];
+	int st;
+
+	memset(&stream, 0, sizeof(stream));
+	stream.next_in = data;
+	stream.avail_in = len;
+	stream.next_out = fakebuf;
+	stream.avail_out = sizeof(fakebuf);
+	inflateInit(&stream);
+
+	while (1) {
+		st = inflate(&stream, Z_FINISH);
+		if (st == Z_STREAM_END || st == Z_OK) {
+			st = (stream.total_out == expect &&
+			      stream.total_in == len) ? 0 : -1;
+			break;
+		}
+		if (st != Z_BUF_ERROR) {
+			st = -1;
+			break;
+		}
+		stream.next_out = fakebuf;
+		stream.avail_out = sizeof(fakebuf);
+	}
+	inflateEnd(&stream);
+	return st;
+}
+
+/*
+ * we are going to reuse the existing pack entry data.  make
+ * sure it is not corrupt.
+ */
+static int revalidate_pack_entry(struct object_entry *entry, unsigned char *data, unsigned long len)
+{
+	enum object_type type;
+	unsigned long size, used;
+
+	if (pack_to_stdout)
+		return 0;
+
+	/* the caller has already called use_packed_git() for us,
+	 * so it is safe to access the pack data from mmapped location.
+	 * make sure the entry inflates correctly.
+	 */
+	used = unpack_object_header_gently(data, len, &type, &size);
+	if (!used)
+		return -1;
+	if (type == OBJ_DELTA)
+		used += 20; /* skip base object name */
+	data += used;
+	len -= used;
+	return check_inflate(data, len, entry->size);
+}
+
+static int revalidate_loose_object(struct object_entry *entry,
+				   unsigned char *map,
+				   unsigned long mapsize)
+{
+	/* we already know this is a loose object with new type header. */
+	enum object_type type;
+	unsigned long size, used;
+
+	if (pack_to_stdout)
+		return 0;
+
+	used = unpack_object_header_gently(map, mapsize, &type, &size);
+	if (!used)
+		return -1;
+	map += used;
+	mapsize -= used;
+	return check_inflate(map, mapsize, size);
+}
+
 static unsigned long write_object(struct sha1file *f,
 				  struct object_entry *entry)
 {
@@ -276,6 +353,9 @@ static unsigned long write_object(struct
 		map = map_sha1_file(entry->sha1, &mapsize);
 		if (map && !legacy_loose_object(map)) {
 			/* We can copy straight into the pack file */
+			if (revalidate_loose_object(entry, map, mapsize))
+				die("corrupt loose object %s",
+				    sha1_to_hex(entry->sha1));
 			sha1write(f, map, mapsize);
 			munmap(map, mapsize);
 			written++;
@@ -286,7 +366,7 @@ static unsigned long write_object(struct
 			munmap(map, mapsize);
 	}
 
-	if (! to_reuse) {
+	if (!to_reuse) {
 		buf = read_sha1_file(entry->sha1, type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
@@ -319,6 +399,9 @@ static unsigned long write_object(struct
 
 		datalen = find_packed_object_size(p, entry->in_pack_offset);
 		buf = (char *) p->pack_base + entry->in_pack_offset;
+
+		if (revalidate_pack_entry(entry, buf, datalen))
+			die("corrupt delta in pack %s", sha1_to_hex(entry->sha1));
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
 		hdrlen = 0; /* not really */
@@ -1163,7 +1246,7 @@ static void prepare_pack(int window, int
 		find_deltas(sorted_by_type, window+1, depth);
 }
 
-static int reuse_cached_pack(unsigned char *sha1, int pack_to_stdout)
+static int reuse_cached_pack(unsigned char *sha1)
 {
 	static const char cache[] = "pack-cache/pack-%s.%s";
 	char *cached_pack, *cached_idx;
@@ -1247,7 +1330,7 @@ int cmd_pack_objects(int argc, const cha
 {
 	SHA_CTX ctx;
 	char line[40 + 1 + PATH_MAX + 2];
-	int depth = 10, pack_to_stdout = 0;
+	int depth = 10;
 	struct object_entry **list;
 	int num_preferred_base = 0;
 	int i;
@@ -1367,7 +1450,7 @@ int cmd_pack_objects(int argc, const cha
 	if (progress && (nr_objects != nr_result))
 		fprintf(stderr, "Result has %d objects.\n", nr_result);
 
-	if (reuse_cached_pack(object_list_sha1, pack_to_stdout))
+	if (reuse_cached_pack(object_list_sha1))
 		;
 	else {
 		if (nr_result)


-- 
VGER BF report: U 0.976258
