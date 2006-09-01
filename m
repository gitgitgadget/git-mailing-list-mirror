From: Junio C Hamano <junkio@cox.net>
Subject: Re: Mozilla .git tree
Date: Fri, 01 Sep 2006 00:42:58 -0700
Message-ID: <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
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
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Sep 01 09:43:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ3g6-0003LR-13
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 09:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWIAHm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 03:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIAHm7
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 03:42:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:57749 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750816AbWIAHm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 03:42:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060901074257.CRVH2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 1 Sep 2006 03:42:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gvis1V00R1kojtg0000000
	Fri, 01 Sep 2006 03:42:53 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 30 Aug 2006 04:42:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26296>

Junio C Hamano <junkio@cox.net> writes:

> Nicolas Pitre <nico@cam.org> writes:
>
>> And the zlib header contains a CRC which we're about to use for 
>> validating the data when doing delta data reuse in order to prevent pack 
>> corruption propagation like the one recently posted on the list.  
>
> Ah, never thought of using the CRC directly.  I was thinking
> about inflating into void and see if it succeeds, which as you
> say is perhaps quite expensive.
>
> This brings me back to my pet-peeve, though.  I do not think
> zlib stream seeks back and leaves some clue at the beginning to
> tell me the deflated length, so it is quite hard to find where
> each deflated stream ends in a packfile cheaply.  Loose objects
> (with new or legacy style header) are easy (st.st_size is
> available), but I do not think of a way short of building a
> reverse index of pack .idx file, which means I am already
> talking about not so cheap way X-<.
>
> It might be a reason to define a new .idx format.  We could lift
> 32-bit offset limitation while we are at it.  Each entry could
> have 20-byte hash, 64-bit offset into the corresponding .pack,
> and 32-bit deflated length (heh, why not make it 64-bit while we
> are at it).  Luckily, .idx _is_ a local matter so we can even
> have a flag day and tell people to run the updated index-pack on
> existing packfiles to regenerate .idx.

So I whipped up this as the zeroth step to propose a migration
plan:

 Step 0.  Prepare conversion and debugging tool.

 Step 1.  Prepare sha1_file (consumer) side to understand the
 	  idx file in the new format.  I haven't decided if
 	  making the runtime to understand both formats is
 	  feasible; I believe it is with what we currently do,
 	  but finding out where the end of each pack entry
 	  cheaply was one of the side effects I wanted to get
 	  from this conversion whose primary purpose is to bust
 	  the 4GB ceiling

 Step 2.  Update pack-objects and index-pack to emit the new
	  format.

 Step 3.  Work on integrating partial mmap() support with Shawn.
          This is more or less orthogonal to 4GB ceiling (people
          would hit mmap() limit even with a 1.5GB pack), but I
          suspect it would be necessary to be able to tell where
          the end of each pack entry is cheaply to implement
          this.

This patch is step 0.

-- >8 --
Subject: [PATCH] convert-idx: prepare large pack idx support.

This adds git-convert-idx which converts between the traditional
32-bit offset pack .idx file and the new 64-bit offset pack .idx
file, and updates git-show-index to understand both formats.

Don't get too excited, not just yet.  The programs pack-objects
and index-pack need to be updated to produce 64-bit pack .idx
files, and the core sha1_file routines also needs to be told
about the new format.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Makefile              |    1 
 builtin-convert-idx.c |  351 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h             |    1 
 git.c                 |    1 
 show-index.c          |   36 ++++-
 5 files changed, 384 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 05bd77f..fccf747 100644
--- a/Makefile
+++ b/Makefile
@@ -260,6 +260,7 @@ BUILTIN_OBJS = \
 	builtin-check-ref-format.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
+	builtin-convert-idx.o \
 	builtin-diff.o \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
diff --git a/builtin-convert-idx.c b/builtin-convert-idx.c
new file mode 100644
index 0000000..af111d2
--- /dev/null
+++ b/builtin-convert-idx.c
@@ -0,0 +1,351 @@
+#include "cache.h"
+
+/*****************************************************************
+
+The differences between the original and new style pack-*.idx files
+are as follows:
+
+ - A new style .idx file can record 64-bit offsets into corresponding
+   .pack file (an original .idx has 32-bit offsets hence limiting the
+   .pack file to 4GB).
+
+ - A new style .idx file allows finding out the end of one entry in
+   the .pack (you need to find the object with next offset in an
+   original .idx file).
+
+Other than these major differences, the overall structure is quite
+similar.
+
+A new style .idx file begins with a signature, "\377tOc", and a
+version number as a 4-byte network byte order integer.  The version
+of this implementation is 2.
+
+The location of the signature used to hold the number of objects in
+the pack whose object name start with byte 0x00 as a 4-byte integer in
+the network byte order.  The original .idx format allowed only 32-bit
+offset into the pack, and data for 0xFF744F63 objects would certainly
+exceed 4GB (because an object needs at least 1-byte for type and its
+deflated length, and deflated data will be 1 or more bytes), so the
+older git would not mistake the new style .idx file as something
+valid.
+
+Following the signature and the version number is a header, which
+consists of 256 4-byte network byte order integers.  N-th entry of
+this table records the number of objects in the corresponding pack,
+the first byte of whose object name are smaller than N.  This means a
+.pack file is still limited to maximum 4 billion objects.
+
+The header is followed by the main toc table, which is a list of
+N-byte entries, one entry per object in the pack, sorted by the object
+name.  Each entry is:
+
+ . 8-byte network byte order integer, recording where the object is
+   stored in the packfile as the offset from the beginning.
+
+ . 4-byte network byte order integer, recording the location of the
+   next object in the main toc table.
+
+ . 20-byte object name.
+
+The file is concluded with a trailer:
+
+ . A copy of the 20-byte SHA-1 checksum at the end of the
+   corresponding packfile.
+
+ . 20-byte SHA-1 checksum of all of the above.
+
+******************************************************************/
+
+#define PACK_IDX_SIGNATURE	0xFF744F63 /* "\377tOc" */
+#define PACK_IDX_VERSION	2
+
+static unsigned get4(const void *buf, unsigned long offset)
+{
+	const unsigned char *p = ((const unsigned char *)buf) + offset;
+
+	return (p[3] | (p[2]<<8) | (p[1]<<16) | (p[0]<<24));
+}
+
+static unsigned long long get8(const void *buf, unsigned long offset)
+{
+	unsigned long long n, m;
+	n = get4(buf, offset);
+	m = get4(buf, offset + 4);
+	return (n << 32) | m;
+}
+
+static void put4(void *buf, unsigned long offset, unsigned data)
+{
+	unsigned char *p = ((unsigned char *)buf) + offset;
+
+	p[3] = data; data >>= 8;
+	p[2] = data; data >>= 8;
+	p[1] = data; data >>= 8;
+	p[0] = data;
+}
+
+static void put8(void *buf, unsigned long offset, unsigned long long data)
+{
+	put4(buf, offset, data >> 32);
+	put4(buf, offset + 4, data);
+}
+
+static int write_out(const char *path, void *data, unsigned long sz)
+{
+	char newpath[PATH_MAX];
+	int fd;
+
+	if (PATH_MAX < strlen(path) + 10)
+		return error("%s: pathname too long", path);
+	sprintf(newpath, "%s_XXXXXX", path);
+	fd = mkstemp(newpath);
+	if (fd < 0)
+		return error("%s: unable to create temporary file: %s",
+			     newpath, strerror(errno));
+	write_or_die(fd, data, sz);
+	return rename(newpath, path);
+}
+
+static int downgrade_idx(const char *path, const unsigned char *data, unsigned long sz)
+{
+	unsigned i, num = 0;
+	unsigned osz;
+	unsigned char *odata, *otable;
+	const unsigned char *table;
+	unsigned char hash[20];
+	SHA_CTX ctx;
+
+	if (get4(data, 0) != PACK_IDX_SIGNATURE)
+		return error("%s is not a new style index", path);
+	if (get4(data, 4) != 2)
+		return error("%s: version %u of new style index not supported",
+			     path, get4(data, 4));
+
+	/* Validate the fan-out and find out the number of objects */
+	for (i = 0; i < 256; i++) {
+		unsigned n = get4(data + 8, i * 4);
+		if (n < num)
+			return error("%s: corrupt old index file", path);
+		num = n;
+	}
+
+	/* Make sure the sz is correct */
+	if (sz != 8 + 4 * 256 + 32 * num + 40)
+		return error("%s: new index file with incorrect size", path);
+
+	/* Make sure the hash matches */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, data, sz - 20);
+	SHA1_Final(hash, &ctx);
+	if (memcmp(hash, data + sz - 20, 20))
+		return error("%s: new index file with incorrect hash", path);
+
+	osz = 4 * 256 + 24 * num + 40;
+	odata = xcalloc(1, osz);
+
+	/* Convert the fan-out */
+	for (i = 0; i < 256; i++)
+		put4(odata, i * 4, get4(data + 8, i * 4));
+
+	/* Make them point at the main table */
+	table = data + 4 * 256 + 8;
+	otable = odata + 4 * 256;
+
+	/* Convert entries, while validating that they are sorted */
+	for (i = 0; i < num; i++) {
+		unsigned long long ofs = get8(table, 32 * i);
+		unsigned const char *hash1, *hash2;
+
+		if (ofs & (0xFFFFFFFFLL << 32))
+			return error("%s: the packfile is too big to be "
+				     "indexed with an old index", path);
+		put4(otable + 24 * i, 0, ofs);
+		memcpy(otable + 24 * i + 4, table + 32 * i + 12, 20);
+		if (!i)
+			continue;
+		hash1 = table + 32 * (i-1) + 12;
+		hash2 = hash1 + 32;
+		if (0 <= memcmp(hash1, hash2, 20))
+			return error("%s: new index file with unsorted table",
+				     path);
+		if (*hash1 != *hash2) {
+			/* fan-out of hash1[0] should point here */
+			if (get4(data + 8, *hash1 * 4) != i)
+				return error("%s: old index file with "
+					     "invalid fan-out", path);
+		}
+	}
+
+	/* Copy the pack SHA-1 checksum */
+	memcpy(odata + osz - 40, data + sz - 40, 20);
+
+	/* Compute the overall SHA-1 checksum */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, odata, osz - 20);
+	SHA1_Final(odata + osz - 20, &ctx);
+
+	/* Write it out */
+	return write_out(path, odata, osz);
+}
+
+static int map_compare(const void *a_, const void *b_)
+{
+	/* These point at new style table entry whose first element is
+	 * 8-byte network byte order offset.  Compare them
+	 */
+	const char *a = *((const char **)a_);
+	const char *b = *((const char **)b_);
+	unsigned long long aofs, bofs;
+
+	aofs = get8(a, 0);
+	bofs = get8(b, 0);
+	if (aofs < bofs)
+		return -1;
+	if (aofs == bofs)
+		return 0;
+	return 1;
+}
+
+static int upgrade_idx(const char *path, const unsigned char *data, unsigned long sz)
+{
+	const unsigned char *table;
+	unsigned char *ndata, *ntable, **map;
+	unsigned i, num = 0;
+	unsigned nsz;
+	unsigned prev_ix;
+	unsigned char hash[20];
+	SHA_CTX ctx;
+
+	if (get4(data, 0) == PACK_IDX_SIGNATURE)
+		return error("%s is a new style index", path);
+
+	/* Validate the fan-out and find out the number of objects */
+	for (i = 0; i < 256; i++) {
+		unsigned n = get4(data, i * 4);
+		if (n < num)
+			return error("%s: corrupt old index file", path);
+		num = n;
+	}
+
+	/* Make sure the sz is correct */
+	if (sz != 4 * 256 + 24 * num + 40)
+		return error("%s: old index file with incorrect size", path);
+
+	/* Make sure the hash matches */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, data, sz - 20);
+	SHA1_Final(hash, &ctx);
+	if (memcmp(hash, data + sz - 20, 20))
+		return error("%s: old index file with incorrect hash", path);
+
+	nsz = 8 + 4 * 256 + 32 * num + 40;
+	ndata = xcalloc(1, nsz);
+	map = xcalloc(sizeof(*map), num);
+
+	put4(ndata, 0, PACK_IDX_SIGNATURE);
+	put4(ndata, 4, PACK_IDX_VERSION);
+
+	/* Convert the fan-out */
+	for (i = 0; i < 256; i++)
+		put4(ndata, 8 + i * 4, get4(data, i * 4));
+
+	/* Make them point at the main table */
+	table = data + 4 * 256;
+	ntable = ndata + 8 + 4 * 256;
+
+	/* Convert entries, while validating that they are sorted */
+	for (i = 0; i < num; i++) {
+		unsigned ofs = get4(table, 24 * i);
+		unsigned const char *hash1, *hash2;
+		map[i] = ntable + 32 * i;
+		put8(ntable + 32 * i, 0, ofs);
+		memcpy(ntable + 32 * i + 12, table + 24 * i + 4, 20);
+		if (!i)
+			continue;
+		hash1 = table + 24 * (i-1) + 4;
+		hash2 = hash1 + 24;
+		if (0 <= memcmp(hash1, hash2, 20))
+			return error("%s: old index file with unsorted table",
+				     path);
+		if (*hash1 != *hash2) {
+			/* fan-out of hash1[0] should point here */
+			if (get4(data, *hash1 * 4) != i)
+				return error("%s: old index file with "
+					     "invalid fan-out", path);
+		}
+	}
+
+	/* Using the reverse map, fill in the next object number */
+	qsort(map, num, sizeof(*map), map_compare);
+	prev_ix = (map[0] - ntable) / 32;
+	for (i = 1; i < num; i++) {
+		/* map is an array of main table entry index,
+		 * sorted by the offset of the pack data.
+		 */
+		unsigned next_ix = (map[i] - ntable) / 32;
+		put4(ntable + 32 * prev_ix, 8, next_ix);
+		prev_ix = next_ix;
+	}
+	put4(map[num-1], 8, num); /* Mark the last entry with num */
+
+	/* Copy the pack SHA-1 checksum */
+	memcpy(ndata + nsz - 40, data + sz - 40, 20);
+
+	/* Compute the overall SHA-1 checksum */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, ndata, nsz - 20);
+	SHA1_Final(ndata + nsz - 20, &ctx);
+
+	/* Write it out */
+	return write_out(path, ndata, nsz);
+}
+
+static int convert_one(const char *path, int downgrade)
+{
+	int fd, err;
+	struct stat st;
+	void *map;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return error("%s: cannot open: %s", path, strerror(errno));
+	if (fstat(fd, &st)) {
+		err = errno;
+		close(fd);
+		return error("%s: cannot stat: %s", path, strerror(err));
+	}
+	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	err = downgrade
+		? downgrade_idx(path, map, st.st_size)
+		: upgrade_idx(path, map, st.st_size);
+	munmap(map, st.st_size);
+	return err;
+}
+
+static const char convert_idx_usage[] =
+"git-convert-idx [-d] <file>";
+
+int cmd_convert_idx(int ac, const char **av, const char *prefix)
+{
+	int i, downgrade = 0, status = 0;
+
+	for (i = 1; i < ac; i++) {
+		const char *arg = av[i];
+		if (arg[0] != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			i++;
+			break;
+		}
+		if (!strcmp(arg, "-d") || !strcmp(arg, "--downgrade")) {
+			downgrade = 1;
+			continue;
+		}
+		usage(convert_idx_usage);
+	}
+
+	for ( ; i < ac; i++)
+		status |= convert_one(av[i], downgrade);
+	return status;
+}
diff --git a/builtin.h b/builtin.h
index 25431d7..e282cb8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,6 +19,7 @@ extern int cmd_cat_file(int argc, const 
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_convert_idx(int ac, const char **av, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 05871ad..22dbad8 100644
--- a/git.c
+++ b/git.c
@@ -230,6 +230,7 @@ static void handle_internal_command(int 
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
+		{ "convert-idx", cmd_convert_idx },
 		{ "count-objects", cmd_count_objects },
 		{ "diff", cmd_diff, RUN_SETUP },
 		{ "diff-files", cmd_diff_files, RUN_SETUP },
diff --git a/show-index.c b/show-index.c
index c21d660..a00b691 100644
--- a/show-index.c
+++ b/show-index.c
@@ -1,14 +1,28 @@
 #include "cache.h"
 
+#define PACK_IDX_SIGNATURE	0xFF744F63 /* "\377tOc" */
+#define PACK_IDX_VERSION	2
+
 int main(int argc, char **argv)
 {
 	int i;
 	unsigned nr;
-	unsigned int entry[6];
+	unsigned int entry[8];
 	static unsigned int top_index[256];
+	int new_style = 0;
 
 	if (fread(top_index, sizeof(top_index), 1, stdin) != 1)
-		die("unable to read idex");
+		die("unable to read index");
+
+	if (ntohl(top_index[0]) == PACK_IDX_SIGNATURE) {
+		fprintf(stderr, "new style idx version %u\n",
+			ntohl(top_index[1]));
+		memmove(top_index, top_index + 2, 4 * 254);
+		if (fread(top_index + 254, sizeof(unsigned), 2, stdin) != 2)
+			die("unable to read index");
+		new_style = 1;
+	}
+
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned n = ntohl(top_index[i]);
@@ -16,13 +30,23 @@ int main(int argc, char **argv)
 			die("corrupt index file");
 		nr = n;
 	}
+
 	for (i = 0; i < nr; i++) {
-		unsigned offset;
+		unsigned long long offset;
 
-		if (fread(entry, 24, 1, stdin) != 1)
+		if (fread(entry,
+			  new_style ? 32 : 24,
+			  1, stdin) != 1)
 			die("unable to read entry %u/%u", i, nr);
-		offset = ntohl(entry[0]);
-		printf("%u %s\n", offset, sha1_to_hex((void *)(entry+1)));
+		if (new_style) {
+			offset = ntohl(entry[0]);
+			offset = (offset << 32) | ntohl(entry[1]);
+		}
+		else {
+			offset = ntohl(entry[0]);
+		}
+		printf("%llu %s\n", offset,
+		       sha1_to_hex((void *)(entry + 1 + new_style * 2)));
 	}
 	return 0;
 }
-- 
1.4.2.gc9dce
