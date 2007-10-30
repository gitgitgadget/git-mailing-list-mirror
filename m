From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/5] relax usage of the progress API
Date: Tue, 30 Oct 2007 14:57:33 -0400
Message-ID: <1193770655-20492-4-git-send-email-nico@cam.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
 <1193770655-20492-3-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:59:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwIn-0001oE-0J
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbXJ3S6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbXJ3S6N
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:58:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbXJ3S6I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:58:08 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ0021VNC05WB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:57:38 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1463.gf79ad2
In-reply-to: <1193770655-20492-3-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62733>

Since it is now OK to pass a null pointer to display_progress() and
stop_progress() resulting in a no-op, then we can simplify the code
and remove a bunch of lines by not making those calls conditional all
the time.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |   18 ++++++------------
 builtin-prune-packed.c   |    6 ++----
 builtin-unpack-objects.c |    6 ++----
 index-pack.c             |   20 +++++++-------------
 unpack-trees.c           |    8 +++-----
 5 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 3ca5cc7..52a26a2 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -629,8 +629,7 @@ static void write_pack_file(void)
 			if (!offset_one)
 				break;
 			offset = offset_one;
-			if (do_progress)
-				display_progress(progress_state, written);
+			display_progress(progress_state, written);
 		}
 
 		/*
@@ -684,8 +683,7 @@ static void write_pack_file(void)
 	} while (nr_remaining && i < nr_objects);
 
 	free(written_list);
-	if (do_progress)
-		stop_progress(&progress_state);
+	stop_progress(&progress_state);
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
 	/*
@@ -853,8 +851,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	else
 		object_ix[-1 - ix] = nr_objects;
 
-	if (progress)
-		display_progress(progress_state, nr_objects);
+	display_progress(progress_state, nr_objects);
 
 	if (name && no_try_delta(name))
 		entry->no_try_delta = 1;
@@ -1517,8 +1514,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 
 		progress_lock();
 		(*processed)++;
-		if (progress)
-			display_progress(progress_state, *processed);
+		display_progress(progress_state, *processed);
 		progress_unlock();
 
 		/*
@@ -1722,8 +1718,7 @@ static void prepare_pack(int window, int depth)
 							nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
-		if (progress)
-			stop_progress(&progress_state);
+		stop_progress(&progress_state);
 		if (nr_done != nr_deltas)
 			die("inconsistency with delta count");
 	}
@@ -2142,8 +2137,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		rp_av[rp_ac] = NULL;
 		get_object_list(rp_ac, rp_av);
 	}
-	if (progress)
-		stop_progress(&progress_state);
+	stop_progress(&progress_state);
 
 	if (non_empty && !nr_result)
 		return 0;
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index c66fb03..f4287da 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -15,8 +15,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 	struct dirent *de;
 	char hex[40];
 
-	if (opts == VERBOSE)
-		display_progress(progress, i + 1);
+	display_progress(progress, i + 1);
 
 	sprintf(hex, "%02x", i);
 	while ((de = readdir(dir)) != NULL) {
@@ -64,8 +63,7 @@ void prune_packed_objects(int opts)
 		prune_dir(i, d, pathname, len + 3, opts);
 		closedir(d);
 	}
-	if (opts == VERBOSE)
-		stop_progress(&progress);
+	stop_progress(&progress);
 }
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index e0ecbc5..1e51865 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -326,11 +326,9 @@ static void unpack_all(void)
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
-		if (!quiet)
-			display_progress(progress, i + 1);
+		display_progress(progress, i + 1);
 	}
-	if (!quiet)
-		stop_progress(&progress);
+	stop_progress(&progress);
 
 	if (delta_list)
 		die("unresolved deltas left after unpacking");
diff --git a/index-pack.c b/index-pack.c
index b4543a4..879ea15 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -418,12 +418,10 @@ static void parse_pack_objects(unsigned char *sha1)
 		} else
 			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
 		free(data);
-		if (verbose)
-			display_progress(progress, i+1);
+		display_progress(progress, i+1);
 	}
 	objects[i].idx.offset = consumed_bytes;
-	if (verbose)
-		stop_progress(&progress);
+	stop_progress(&progress);
 
 	/* Check pack integrity */
 	flush();
@@ -486,8 +484,7 @@ static void parse_pack_objects(unsigned char *sha1)
 						      obj->size, obj->type);
 			}
 		free(data);
-		if (verbose)
-			display_progress(progress, nr_resolved_deltas);
+		display_progress(progress, nr_resolved_deltas);
 	}
 }
 
@@ -594,8 +591,7 @@ static void fix_unresolved_deltas(int nr_unresolved)
 			die("local object %s is corrupt", sha1_to_hex(d->base.sha1));
 		append_obj_to_pack(d->base.sha1, data, size, type);
 		free(data);
-		if (verbose)
-			display_progress(progress, nr_resolved_deltas);
+		display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
 }
@@ -774,8 +770,7 @@ int main(int argc, char **argv)
 	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
 	parse_pack_objects(sha1);
 	if (nr_deltas == nr_resolved_deltas) {
-		if (verbose)
-			stop_progress(&progress);
+		stop_progress(&progress);
 		/* Flush remaining pack final 20-byte SHA1. */
 		flush();
 	} else {
@@ -788,11 +783,10 @@ int main(int argc, char **argv)
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
 			fix_unresolved_deltas(nr_unresolved);
-			if (verbose) {
-				stop_progress(&progress);
+			stop_progress(&progress);
+			if (verbose)
 				fprintf(stderr, "%d objects were added to complete this thin pack.\n",
 					nr_objects - nr_objects_initial);
-			}
 			fixup_pack_header_footer(output_fd, sha1,
 				curr_pack, nr_objects);
 		}
diff --git a/unpack-trees.c b/unpack-trees.c
index 6776c29..c527d7d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -316,9 +316,8 @@ static void check_updates(struct cache_entry **src, int nr,
 	while (nr--) {
 		struct cache_entry *ce = *src++;
 
-		if (total)
-			if (!ce->ce_mode || ce->ce_flags & mask)
-				display_progress(progress, ++cnt);
+		if (!ce->ce_mode || ce->ce_flags & mask)
+			display_progress(progress, ++cnt);
 		if (!ce->ce_mode) {
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
@@ -332,8 +331,7 @@ static void check_updates(struct cache_entry **src, int nr,
 			}
 		}
 	}
-	if (total)
-		stop_progress(&progress);
+	stop_progress(&progress);
 }
 
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
-- 
1.5.3.4.1463.gf79ad2
