From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-objects: finishing touches.
Date: Fri, 17 Feb 2006 02:37:45 -0800
Message-ID: <7vlkwa6zk6.fsf@assigned-by-dhcp.cox.net>
References: <7vd5hpm2x0.fsf@assigned-by-dhcp.cox.net>
	<7vbqx8m62q.fsf@assigned-by-dhcp.cox.net>
	<7vu0ay8v4f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 17 11:37:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA2zn-00066v-Fp
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 11:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWBQKhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 05:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWBQKhs
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 05:37:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:9422 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964829AbWBQKhr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 05:37:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060217103613.LCEW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Feb 2006 05:36:13 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16335>

Junio C Hamano <junkio@cox.net> writes:

> This one has one nasty data corruption bug, which fortunately I
> think I have figured out how to fix.  Please do not use it for
> your production repository in the meantime.

It turns out that there wasn't a data corruption bug, but it can
create a pack with delta chains whose length exceeds twice the
specified depth.  The data corruption bug was on my unpublished
WIP and killed even before it hit "pu" ;-).  This addresses most
of the remaining issues and has been merged to "next" tonight.

-- >8 --
This introduces --no-reuse-delta option to disable reusing of
existing delta, which is a large part of the optimization
introduced by this series.  This may become necessary if
repeated repacking makes delta chain too long.  With this, the
output of the command becomes identical to that of the older
implementation.

It still allows reusing non-deltified representations; there is
no point uncompressing and recompressing the whole text.

It also adds a couple more statistics output, while squelching
it under -q flag, which the last round forgot to do.

One remaining minor issue when --no-reuse-delta option is not
used is that it can create a delta chain that is deeper than
specified.

    A<--B<--C<--D   E   F   G

Suppose we have a delta chain A to D (A is stored in full either
in a pack or as a loose object. B is depth1 delta relative to A,
C is depth2 delta relative to B...) with loose objects E, F, G.
And we are going to pack them.

B, C and D are left as delta against A, B and C respectively.
So A, E, F, and G are examined, and let's say we decided to keep
E expanded, and store the rest as deltas like this:

	E<--F<--G<--A

Oops.  We ended up making D a bit too deep, didn't we?  B, C and
D form a chain on top of A!

This is because we did not know what the final depth of A would
be when checking objects and deciding to keep the existing
delta.

To prevent this from happening, we could say that A should be
kept expanded.  But how would we tell that, cheaply?

To do this most precisely, after check_object() runs, each
object that is used as the base object of some existing delta
needs to be marked with the maximum depth of the objects we
decided to keep deltified (in this case, D is depth 3 relative
to A, so if no other delta chain that is longer than 3 based on
A exists, mark A with 3).  Then when attempting to deltify A, we
would take that number into account to see if the final delta
chain that leads to D becomes too deep.

However, this is a bit cumbersome to compute, so we would cheat
and reduce the maximum depth for A arbitrarily to depth/4 in
this implementation.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-pack-objects.txt |   21 +++++++
 pack-objects.c                     |  102 +++++++++++++++++++++++++-----------
 2 files changed, 91 insertions(+), 32 deletions(-)

98885061623676a37575e59d7f7aff64072e3300
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 2d67d39..4cb2e83 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -8,7 +8,10 @@ git-pack-objects - Create a packed archi
 
 SYNOPSIS
 --------
-'git-pack-objects' [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list
+[verse]
+'git-pack-objects' [-q] [--no-reuse-delta] [--non-empty]
+	[--local] [--incremental] [--window=N] [--depth=N]
+	{--stdout | base-name} < object-list
 
 
 DESCRIPTION
@@ -32,6 +35,10 @@ Placing both in the pack/ subdirectory o
 any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
 enables git to read from such an archive.
 
+In a packed archive, an object is either stored as a compressed
+whole, or as a difference from some other object.  The latter is
+often called a delta.
+
 
 OPTIONS
 -------
@@ -74,6 +81,18 @@ base-name::
         Only create a packed archive if it would contain at
         least one object.
 
+-q::
+	This flag makes the command not to report its progress
+	on the standard error stream.
+
+--no-reuse-delta::
+	When creating a packed archive in a repository that
+	has existing packs, the command reuses existing deltas.
+	This sometimes results in a slightly suboptimal pack.
+	This flag tells the command not to reuse existing deltas
+	but compute them from scratch.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/pack-objects.c b/pack-objects.c
index 70fb2af..38e1c99 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -5,7 +5,7 @@
 #include "csum-file.h"
 #include <sys/time.h>
 
-static const char pack_usage[] = "git-pack-objects [-q] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
+static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -14,10 +14,11 @@ struct object_entry {
 	unsigned int depth;	/* delta depth */
 	unsigned int hash;	/* name hint hash */
 	enum object_type type;
+	unsigned char edge;	/* reused delta chain points at this entry. */
+	enum object_type in_pack_type;	/* could be delta */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	struct object_entry *delta;	/* delta base object */
 	struct packed_git *in_pack; 	/* already in pack */
-	enum object_type in_pack_type;	/* could be delta */
 	unsigned int in_pack_offset;
 };
 
@@ -36,6 +37,7 @@ struct object_entry {
 
 static unsigned char object_list_sha1[20];
 static int non_empty = 0;
+static int no_reuse_delta = 0;
 static int local = 0;
 static int incremental = 0;
 static struct object_entry **sorted_by_sha, **sorted_by_type;
@@ -75,7 +77,9 @@ static int pack_revindex_hashsz = 0;
  * stats
  */
 static int written = 0;
+static int written_delta = 0;
 static int reused = 0;
+static int reused_delta = 0;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
@@ -227,10 +231,23 @@ static unsigned long write_object(struct
 	unsigned char header[10];
 	unsigned hdrlen, datalen;
 	enum object_type obj_type;
+	int to_reuse = 0;
 
 	obj_type = entry->type;
-	if (!entry->in_pack ||
-	    (obj_type != entry->in_pack_type)) {
+	if (! entry->in_pack)
+		to_reuse = 0;	/* can't reuse what we don't have */
+	else if (obj_type == OBJ_DELTA)
+		to_reuse = 1;	/* check_object() decided it for us */
+	else if (obj_type != entry->in_pack_type)
+		to_reuse = 0;	/* pack has delta which is unusable */
+	else if (entry->delta)
+		to_reuse = 0;	/* we want to pack afresh */
+	else
+		to_reuse = 1;	/* we have it in-pack undeltified,
+				 * and we do not need to deltify it.
+				 */
+
+	if (! to_reuse) {
 		buf = read_sha1_file(entry->sha1, type, &size);
 		if (!buf)
 			die("unable to read %s", sha1_to_hex(entry->sha1));
@@ -266,8 +283,12 @@ static unsigned long write_object(struct
 		sha1write(f, buf, datalen);
 		unuse_packed_git(p);
 		hdrlen = 0; /* not really */
+		if (obj_type == OBJ_DELTA)
+			reused_delta++;
 		reused++;
 	}
+	if (obj_type == OBJ_DELTA)
+		written_delta++;
 	written++;
 	return hdrlen + datalen;
 }
@@ -294,7 +315,6 @@ static void write_pack_file(void)
 	int i;
 	struct sha1file *f;
 	unsigned long offset;
-	unsigned long mb;
 	struct pack_header hdr;
 
 	if (!base_name)
@@ -357,10 +377,9 @@ static int add_object_entry(unsigned cha
 	unsigned int idx = nr_objects;
 	struct object_entry *entry;
 	struct packed_git *p;
-	unsigned int found_offset;
-	struct packed_git *found_pack;
+	unsigned int found_offset = 0;
+	struct packed_git *found_pack = NULL;
 
-	found_pack = NULL;
 	for (p = packed_git; p; p = p->next) {
 		struct pack_entry e;
 		if (find_pack_entry_one(sha1, &e, p)) {
@@ -420,32 +439,39 @@ static void check_object(struct object_e
 	char type[20];
 
 	if (entry->in_pack) {
+		unsigned char base[20];
+		unsigned long size;
+		struct object_entry *base_entry;
+
+		/* We want in_pack_type even if we do not reuse delta.
+		 * There is no point not reusing non-delta representations.
+		 */
+		check_reuse_pack_delta(entry->in_pack,
+				       entry->in_pack_offset,
+				       base, &size,
+				       &entry->in_pack_type);
+
 		/* Check if it is delta, and the base is also an object
 		 * we are going to pack.  If so we will reuse the existing
 		 * delta.
 		 */
-		unsigned char base[20];
-		unsigned long size;
-		struct object_entry *base_entry;
-		if (!check_reuse_pack_delta(entry->in_pack,
-					    entry->in_pack_offset,
-					    base, &size,
-					    &entry->in_pack_type) &&
+		if (!no_reuse_delta &&
+		    entry->in_pack_type == OBJ_DELTA &&
 		    (base_entry = locate_object_entry(base))) {
-			/* We do not know depth at this point, but it
-			 * does not matter.  Getting delta_chain_length
-			 * with packed_object_info_detail() is not so
-			 * expensive, so we could do that later if we
-			 * wanted to.  Calling sha1_object_info to get
-			 * the true size (and later an uncompressed
-			 * representation) of deeply deltified object
-			 * is quite expensive.
+
+			/* Depth value does not matter - find_deltas()
+			 * will never consider reused delta as the
+			 * base object to deltify other objects
+			 * against, in order to avoid circular deltas.
 			 */
-			entry->depth = 1;
-			/* uncompressed size */
+
+			/* uncompressed size of the delta data */
 			entry->size = entry->delta_size = size;
 			entry->delta = base_entry;
 			entry->type = OBJ_DELTA;
+
+			base_entry->edge = 1;
+
 			return;
 		}
 		/* Otherwise we would do the usual */
@@ -568,6 +594,13 @@ static int try_delta(struct unpacked *cu
 	if (cur_entry->type != old_entry->type)
 		return -1;
 
+	/* If the current object is at edge, take the depth the objects
+	 * that depend on the current object into account -- otherwise
+	 * they would become too deep.
+	 */
+	if (cur_entry->edge)
+		max_depth /= 4;
+
 	size = cur_entry->size;
 	if (size < 50)
 		return -1;
@@ -627,7 +660,7 @@ static void find_deltas(struct object_en
 
 		if (entry->delta)
 			/* This happens if we decided to reuse existing
-			 * delta from a pack.
+			 * delta from a pack.  "!no_reuse_delta &&" is implied.
 			 */
 			continue;
 
@@ -636,6 +669,7 @@ static void find_deltas(struct object_en
 		n->data = read_sha1_file(entry->sha1, type, &size);
 		if (size != entry->size)
 			die("object %s inconsistent object length (%lu vs %lu)", sha1_to_hex(entry->sha1), size, entry->size);
+
 		j = window;
 		while (--j > 0) {
 			unsigned int other_idx = idx + j;
@@ -664,7 +698,7 @@ static void prepare_pack(int window, int
 		fprintf(stderr, "Packing %d objects", nr_objects);
 	get_object_details();
 	if (progress)
-		fprintf(stderr, ".");
+		fputc('.', stderr);
 
 	sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
@@ -694,8 +728,9 @@ static int reuse_cached_pack(unsigned ch
 		}
 	}
 
-	fprintf(stderr, "Reusing %d objects pack %s\n", nr_objects,
-		sha1_to_hex(sha1));
+	if (progress)
+		fprintf(stderr, "Reusing %d objects pack %s\n", nr_objects,
+			sha1_to_hex(sha1));
 
 	if (pack_to_stdout) {
 		if (copy_fd(ifd, 1))
@@ -775,6 +810,10 @@ int main(int argc, char **argv)
 				progress = 0;
 				continue;
 			}
+			if (!strcmp("--no-reuse-delta", arg)) {
+				no_reuse_delta = 1;
+				continue;
+			}
 			if (!strcmp("--stdout", arg)) {
 				pack_to_stdout = 1;
 				continue;
@@ -850,7 +889,8 @@ int main(int argc, char **argv)
 			puts(sha1_to_hex(object_list_sha1));
 		}
 	}
-	fprintf(stderr, "Total %d, written %d, reused %d\n",
-		nr_objects, written, reused);
+	if (progress)
+		fprintf(stderr, "Total %d, written %d (delta %d), reused %d (delta %d)\n",
+			nr_objects, written, written_delta, reused, reused_delta);
 	return 0;
 }
-- 
1.2.1.g91016
