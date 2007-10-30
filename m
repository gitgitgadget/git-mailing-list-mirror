From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/5] make struct progress an opaque type
Date: Tue, 30 Oct 2007 14:57:32 -0400
Message-ID: <1193770655-20492-3-git-send-email-nico@cam.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
 <1193770655-20492-2-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwIA-0001bd-Ad
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbXJ3S6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbXJ3S6K
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:58:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbXJ3S6G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:58:06 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ0021VNC05WB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:57:37 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1463.gf79ad2
In-reply-to: <1193770655-20492-2-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62732>

This allows for better management of progress "object" existence,
as well as making the progress display implementation more independent
from its callers.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |   16 ++++++++--------
 builtin-prune-packed.c   |    7 +++----
 builtin-unpack-objects.c |    6 +++---
 index-pack.c             |   12 ++++++------
 progress.c               |   33 +++++++++++++++++++++++++++------
 progress.h               |   18 +++++-------------
 unpack-trees.c           |   10 +++++-----
 7 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 21ba977..3ca5cc7 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -73,7 +73,7 @@ static int depth = 50;
 static int delta_search_threads = 1;
 static int pack_to_stdout;
 static int num_preferred_base;
-static struct progress progress_state;
+static struct progress *progress_state;
 static int pack_compression_level = Z_DEFAULT_COMPRESSION;
 static int pack_compression_seen;
 
@@ -598,7 +598,7 @@ static void write_pack_file(void)
 	uint32_t nr_remaining = nr_result;
 
 	if (do_progress)
-		start_progress(&progress_state, "Writing objects", nr_result);
+		progress_state = start_progress("Writing objects", nr_result);
 	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
 
 	do {
@@ -630,7 +630,7 @@ static void write_pack_file(void)
 				break;
 			offset = offset_one;
 			if (do_progress)
-				display_progress(&progress_state, written);
+				display_progress(progress_state, written);
 		}
 
 		/*
@@ -854,7 +854,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 		object_ix[-1 - ix] = nr_objects;
 
 	if (progress)
-		display_progress(&progress_state, nr_objects);
+		display_progress(progress_state, nr_objects);
 
 	if (name && no_try_delta(name))
 		entry->no_try_delta = 1;
@@ -1518,7 +1518,7 @@ static void find_deltas(struct object_entry **list, unsigned list_size,
 		progress_lock();
 		(*processed)++;
 		if (progress)
-			display_progress(&progress_state, *processed);
+			display_progress(progress_state, *processed);
 		progress_unlock();
 
 		/*
@@ -1718,8 +1718,8 @@ static void prepare_pack(int window, int depth)
 	if (nr_deltas && n > 1) {
 		unsigned nr_done = 0;
 		if (progress)
-			start_progress(&progress_state, "Compressing objects",
-					nr_deltas);
+			progress_state = start_progress("Compressing objects",
+							nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		if (progress)
@@ -2135,7 +2135,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	prepare_packed_git();
 
 	if (progress)
-		start_progress(&progress_state, "Counting objects", 0);
+		progress_state = start_progress("Counting objects", 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 907e368..c66fb03 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -8,7 +8,7 @@ static const char prune_packed_usage[] =
 #define DRY_RUN 01
 #define VERBOSE 02
 
-static struct progress progress;
+static struct progress *progress;
 
 static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 {
@@ -16,7 +16,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 	char hex[40];
 
 	if (opts == VERBOSE)
-		display_progress(&progress, i + 1);
+		display_progress(progress, i + 1);
 
 	sprintf(hex, "%02x", i);
 	while ((de = readdir(dir)) != NULL) {
@@ -46,8 +46,7 @@ void prune_packed_objects(int opts)
 	int len = strlen(dir);
 
 	if (opts == VERBOSE)
-		start_progress_delay(&progress,
-			"Removing duplicate objects",
+		progress = start_progress_delay("Removing duplicate objects",
 			256, 95, 2);
 
 	if (len > PATH_MAX - 42)
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 2317b8f..e0ecbc5 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -311,7 +311,7 @@ static void unpack_one(unsigned nr)
 static void unpack_all(void)
 {
 	int i;
-	struct progress progress;
+	struct progress *progress = NULL;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 	unsigned nr_objects = ntohl(hdr->hdr_entries);
 
@@ -322,12 +322,12 @@ static void unpack_all(void)
 	use(sizeof(struct pack_header));
 
 	if (!quiet)
-		start_progress(&progress, "Unpacking objects", nr_objects);
+		progress = start_progress("Unpacking objects", nr_objects);
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		if (!quiet)
-			display_progress(&progress, i + 1);
+			display_progress(progress, i + 1);
 	}
 	if (!quiet)
 		stop_progress(&progress);
diff --git a/index-pack.c b/index-pack.c
index 2f149a4..b4543a4 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -46,7 +46,7 @@ static int nr_resolved_deltas;
 static int from_stdin;
 static int verbose;
 
-static struct progress progress;
+static struct progress *progress;
 
 /* We always read in 4kB chunks. */
 static unsigned char input_buffer[4096];
@@ -406,7 +406,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - remember base (SHA1 or offset) for all deltas.
 	 */
 	if (verbose)
-		start_progress(&progress, "Indexing objects", nr_objects);
+		progress = start_progress("Indexing objects", nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
@@ -419,7 +419,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			sha1_object(data, obj->size, obj->type, obj->idx.sha1);
 		free(data);
 		if (verbose)
-			display_progress(&progress, i+1);
+			display_progress(progress, i+1);
 	}
 	objects[i].idx.offset = consumed_bytes;
 	if (verbose)
@@ -455,7 +455,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	 *   for some more deltas.
 	 */
 	if (verbose)
-		start_progress(&progress, "Resolving deltas", nr_deltas);
+		progress = start_progress("Resolving deltas", nr_deltas);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		union delta_base base;
@@ -487,7 +487,7 @@ static void parse_pack_objects(unsigned char *sha1)
 			}
 		free(data);
 		if (verbose)
-			display_progress(&progress, nr_resolved_deltas);
+			display_progress(progress, nr_resolved_deltas);
 	}
 }
 
@@ -595,7 +595,7 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		append_obj_to_pack(d->base.sha1, data, size, type);
 		free(data);
 		if (verbose)
-			display_progress(&progress, nr_resolved_deltas);
+			display_progress(progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
 }
diff --git a/progress.c b/progress.c
index 7629e05..7f9b00e 100644
--- a/progress.c
+++ b/progress.c
@@ -1,6 +1,15 @@
 #include "git-compat-util.h"
 #include "progress.h"
 
+struct progress {
+	const char *title;
+	int last_value;
+	unsigned total;
+	unsigned last_percent;
+	unsigned delay;
+	unsigned delayed_percent_treshold;
+};
+
 static volatile sig_atomic_t progress_update;
 
 static void progress_interval(int signum)
@@ -76,12 +85,18 @@ static int display(struct progress *progress, unsigned n, int done)
 
 int display_progress(struct progress *progress, unsigned n)
 {
-	return display(progress, n, 0);
+	return progress ? display(progress, n, 0) : 0;
 }
 
-void start_progress_delay(struct progress *progress, const char *title,
-			  unsigned total, unsigned percent_treshold, unsigned delay)
+struct progress * start_progress_delay(const char *title, unsigned total,
+				       unsigned percent_treshold, unsigned delay)
 {
+	struct progress *progress = malloc(sizeof(*progress));
+	if (!progress) {
+		/* unlikely, but here's a good fallback */
+		fprintf(stderr, "%s...\n", title);
+		return NULL;
+	}
 	progress->title = title;
 	progress->total = total;
 	progress->last_value = -1;
@@ -89,19 +104,25 @@ void start_progress_delay(struct progress *progress, const char *title,
 	progress->delayed_percent_treshold = percent_treshold;
 	progress->delay = delay;
 	set_progress_signal();
+	return progress;
 }
 
-void start_progress(struct progress *progress, const char *title, unsigned total)
+struct progress * start_progress(const char *title, unsigned total)
 {
-	start_progress_delay(progress, title, total, 0, 0);
+	return start_progress_delay(title, total, 0, 0);
 }
 
-void stop_progress(struct progress *progress)
+void stop_progress(struct progress **p_progress)
 {
+	struct progress *progress = *p_progress;
+	if (!progress)
+		return;
+	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
 		progress_update = 1;
 		display(progress, progress->last_value, 1);
 	}
 	clear_progress_signal();
+	free(progress);
 }
diff --git a/progress.h b/progress.h
index 07b56bd..29780ce 100644
--- a/progress.h
+++ b/progress.h
@@ -1,20 +1,12 @@
 #ifndef PROGRESS_H
 #define PROGRESS_H
 
-struct progress {
-	const char *title;
-	int last_value;
-	unsigned total;
-	unsigned last_percent;
-	unsigned delay;
-	unsigned delayed_percent_treshold;
-};
+struct progress;
 
 int display_progress(struct progress *progress, unsigned n);
-void start_progress(struct progress *progress, const char *title,
-		    unsigned total);
-void start_progress_delay(struct progress *progress, const char *title,
-			  unsigned total, unsigned percent_treshold, unsigned delay);
-void stop_progress(struct progress *progress);
+struct progress * start_progress(const char *title, unsigned total);
+struct progress * start_progress_delay(const char *title, unsigned total,
+				       unsigned percent_treshold, unsigned delay);
+void stop_progress(struct progress **progress);
 
 #endif
diff --git a/unpack-trees.c b/unpack-trees.c
index 3225101..6776c29 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -297,7 +297,7 @@ static void check_updates(struct cache_entry **src, int nr,
 {
 	unsigned short mask = htons(CE_UPDATE);
 	unsigned cnt = 0, total = 0;
-	struct progress progress;
+	struct progress *progress = NULL;
 	char last_symlink[PATH_MAX];
 
 	if (o->update && o->verbose_update) {
@@ -307,8 +307,8 @@ static void check_updates(struct cache_entry **src, int nr,
 				total++;
 		}
 
-		start_progress_delay(&progress, "Checking out files",
-				     total, 50, 2);
+		progress = start_progress_delay("Checking out files",
+						total, 50, 2);
 		cnt = 0;
 	}
 
@@ -318,7 +318,7 @@ static void check_updates(struct cache_entry **src, int nr,
 
 		if (total)
 			if (!ce->ce_mode || ce->ce_flags & mask)
-				display_progress(&progress, ++cnt);
+				display_progress(progress, ++cnt);
 		if (!ce->ce_mode) {
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
@@ -333,7 +333,7 @@ static void check_updates(struct cache_entry **src, int nr,
 		}
 	}
 	if (total)
-		stop_progress(&progress);;
+		stop_progress(&progress);
 }
 
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
-- 
1.5.3.4.1463.gf79ad2
