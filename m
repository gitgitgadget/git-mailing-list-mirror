From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/8] pack-objects --keep-unreachable
Date: Mon, 17 Sep 2007 01:44:48 -0700
Message-ID: <11900186973144-git-send-email-gitster@pobox.com>
References: <11900186941912-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCEP-00089U-Pl
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbXIQIpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbXIQIpF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:45:05 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275AbXIQIpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:45:01 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D0A241368AF;
	Mon, 17 Sep 2007 04:45:20 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <11900186941912-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58397>

This new option is meant to be used in conjunction with the
options "git repack -a -d" usually invokes the underlying
pack-objects.  When this option is given, objects unreachable
from the refs in packs named with --unpacked= option are added
to the resulting pack, in addition to the reachable objects that
are not in packs marked with *.keep files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-pack-objects.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 12509fa..ba7c8da 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -21,7 +21,7 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--window=N] [--window-memory=N] [--depth=N] \n\
 	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
 	[--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [<ref-list | <object-list]";
+	[--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -57,7 +57,7 @@ static struct object_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
 
 static int non_empty;
-static int no_reuse_delta, no_reuse_object;
+static int no_reuse_delta, no_reuse_object, keep_unreachable;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -1625,15 +1625,19 @@ static void read_object_list_from_stdin(void)
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
 	add_preferred_base_object(p->name);
 	add_object_entry(p->item->sha1, p->item->type, p->name, 0);
+	p->item->flags |= OBJECT_ADDED;
 }
 
 static void show_edge(struct commit *commit)
@@ -1641,6 +1645,86 @@ static void show_edge(struct commit *commit)
 	add_preferred_base(commit->object.sha1);
 }
 
+struct in_pack_object {
+	off_t offset;
+	struct object *object;
+};
+
+struct in_pack {
+	int alloc;
+	int nr;
+	struct in_pack_object *array;
+};
+
+static void mark_in_pack_object(struct object *object, struct packed_git *p, struct in_pack *in_pack)
+{
+	in_pack->array[in_pack->nr].offset = find_pack_entry_one(object->sha1, p);
+	in_pack->array[in_pack->nr].object = object;
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
+		return hashcmp(a->object->sha1, b->object->sha1);
+}
+
+static void add_objects_in_unpacked_packs(struct rev_info *revs)
+{
+	struct packed_git *p;
+	struct in_pack in_pack;
+	uint32_t i;
+
+	memset(&in_pack, 0, sizeof(in_pack));
+
+	for (p = packed_git; p; p = p->next) {
+		const unsigned char *sha1;
+		struct object *o;
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
+		ALLOC_GROW(in_pack.array,
+			   in_pack.nr + p->num_objects,
+			   in_pack.alloc);
+
+		for (i = 0; i < p->num_objects; i++) {
+			sha1 = nth_packed_object_sha1(p, i);
+			o = lookup_unknown_object(sha1);
+			if (!(o->flags & OBJECT_ADDED))
+				mark_in_pack_object(o, p, &in_pack);
+			o->flags |= OBJECT_ADDED;
+		}
+	}
+
+	if (in_pack.nr) {
+		qsort(in_pack.array, in_pack.nr, sizeof(in_pack.array[0]),
+		      ofscmp);
+		for (i = 0; i < in_pack.nr; i++) {
+			struct object *o = in_pack.array[i].object;
+			add_object_entry(o->sha1, o->type, "", 0);
+		}
+	}
+	free(in_pack.array);
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
+	if (keep_unreachable)
+		add_objects_in_unpacked_packs(&revs);
 }
 
 static int adjust_perm(const char *path, mode_t mode)
@@ -1789,6 +1876,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			use_internal_rev_list = 1;
 			continue;
 		}
+		if (!strcmp("--keep-unreachable", arg)) {
+			keep_unreachable = 1;
+			continue;
+		}
 		if (!strcmp("--unpacked", arg) ||
 		    !prefixcmp(arg, "--unpacked=") ||
 		    !strcmp("--reflog", arg) ||
-- 
1.5.3.1.967.g6bb01
