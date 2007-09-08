From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pack-objects --repack-unpacked
Date: Sat, 08 Sep 2007 03:01:24 -0700
Message-ID: <7vodgdzdaj.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709061651550.28586@racer.site>
	<7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
	<7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
	<7vwsv36q6p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Sep 08 12:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITx8Y-0000e4-QR
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 12:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbXIHKBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 06:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbXIHKBw
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 06:01:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbXIHKBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 06:01:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 42C37130654;
	Sat,  8 Sep 2007 06:02:01 -0400 (EDT)
In-Reply-To: <7vwsv36q6p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Sep 2007 21:43:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58115>

The usual command line that uses "--unpacked=<existing>" option
looks like this:

	git pack-objects --non-empty --all --reflog \
        	--unpacked --unpacked=<existing> \
                packname-prefix

This packs loose objects and objects in the named existing
packs that are reachable from any and all refs and reflog
entries.  It is typically used by "git repack -a -d", which
then removes the named existing packs from the repository, and
has an effect of getting rid of unreachable objects these packs
hold.

This adds "--repack-unpacked" option to pack-objects to help
combining small packs into one, without losing unreferenced
objects that are in the packs.  When this option is given in
addition to the above command line, we also make sure all the
objects in the named existing packs are included in the result.

This allows us to safely remove the packs that were named on the
command line after installing the resulting pack in the
repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I am too tired to keep staring at this code now.  Fixes,
 improvements, replacements and enhancements, in the code,
 documentation and tests, are very much welcomed.

 builtin-pack-objects.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 12509fa..9bc2faa 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -21,7 +21,7 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [<ref-list | <object-list]";
+	[--stdout | base-name] [--repack-unpacked] [<ref-list | <object-list]";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -57,7 +57,7 @@ static struct object_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
-static int no_reuse_delta, no_reuse_object;
+static int no_reuse_delta, no_reuse_object, repack_unpacked;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -1625,15 +1625,21 @@ static void read_object_list_from_stdin(void)
 	}
 }
 
+#define OBJECT_ADDED (1u<<20)
+
 static void show_commit(struct commit *commit)
 {
 	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
+	commit->object.flags |= OBJECT_ADDED;
 }
 
 static void show_object(struct object_array_entry *p)
 {
+	struct object *o = lookup_unknown_object(p->item->sha1);
+
 	add_preferred_base_object(p->name);
 	add_object_entry(p->item->sha1, p->item->type, p->name, 0);
+	o->flags |= OBJECT_ADDED;
 }
 
 static void show_edge(struct commit *commit)
@@ -1641,6 +1647,84 @@ static void show_edge(struct commit *commit)
 	add_preferred_base(commit->object.sha1);
 }
 
+struct in_pack_object {
+	off_t offset;
+	const unsigned char *sha1;
+};
+
+struct in_pack {
+	int alloc;
+	int nr;
+	struct in_pack_object *array;
+};
+
+static void mark_in_pack_object(const unsigned char *sha1, struct packed_git *p, struct in_pack *in_pack)
+{
+	in_pack->array[in_pack->nr].offset = find_pack_entry_one(sha1, p);
+	in_pack->array[in_pack->nr].sha1 = sha1;
+	in_pack->nr++;
+}
+
+/*
+ * Compare the objects in the offset order, in order to emulate the
+ * "git-rev-list --objects" output that produced the pack originally.
+ */
+static int ofscmp(const void *a_, const void *b_)
+{
+	struct in_pack_object *a = (struct in_pack_object *)a_;
+	struct in_pack_object *b = (struct in_pack_object *)b_;
+
+	if (a->offset < b->offset)
+		return -1;
+	else if (a->offset > b->offset)
+		return 1;
+	else
+		return hashcmp(a->sha1, b->sha1);
+}
+
+static void add_objects_in_unpacked_packs(struct rev_info *revs)
+{
+	struct packed_git *p;
+
+	for (p = packed_git; p; p = p->next) {
+		struct in_pack in_pack;
+		const unsigned char *sha1;
+		struct object *o;
+		uint32_t i;
+
+		for (i = 0; i < revs->num_ignore_packed; i++) {
+			if (matches_pack_name(p, revs->ignore_packed[i]))
+				break;
+		}
+		if (revs->num_ignore_packed <= i)
+			continue;
+		if (open_pack_index(p))
+			die("cannot open pack index");
+
+		in_pack.alloc = p->num_objects;
+		in_pack.nr = 0;
+		in_pack.array = xmalloc(sizeof(in_pack.array[0]) *
+					p->num_objects);
+		for (i = 0; i < p->num_objects; i++) {
+			sha1 = nth_packed_object_sha1(p, i);
+			o = lookup_unknown_object(sha1);
+			if (!(o->flags & OBJECT_ADDED))
+				mark_in_pack_object(sha1, p, &in_pack);
+			o->flags |= OBJECT_ADDED;
+		}
+		if (!in_pack.nr)
+			continue;
+		qsort(in_pack.array, in_pack.nr, sizeof(in_pack.array[0]),
+		      ofscmp);
+		for (i = 0; i < in_pack.nr; i++) {
+			sha1 = in_pack.array[i].sha1;
+			o = lookup_unknown_object(sha1);
+			add_object_entry(sha1, o->type, "", 0);
+		}
+		free(in_pack.array);
+	}
+}
+
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
@@ -1672,6 +1756,9 @@ static void get_object_list(int ac, const char **av)
 	prepare_revision_walk(&revs);
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
 	traverse_commit_list(&revs, show_commit, show_object);
+
+	if (repack_unpacked)
+		add_objects_in_unpacked_packs(&revs);
 }
 
 static int adjust_perm(const char *path, mode_t mode)
@@ -1789,6 +1876,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			use_internal_rev_list = 1;
 			continue;
 		}
+		if (!strcmp("--repack-unpacked", arg)) {
+			repack_unpacked = 1;
+			continue;
+		}
 		if (!strcmp("--unpacked", arg) ||
 		    !prefixcmp(arg, "--unpacked=") ||
 		    !strcmp("--reflog", arg) ||
