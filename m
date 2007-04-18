From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] common progress display support
Date: Wed, 18 Apr 2007 14:27:45 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181422050.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 20:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeEt1-0007AM-Jp
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 20:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbXDRS1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbXDRS1v
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 14:27:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13696 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbXDRS1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 14:27:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP00E5JHY99IS0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 14:27:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44924>

Instead of having this code duplicated in multiple places, let's have
a common interface for progress display.  If someday someone wishes to
display a cheezy progress bar instead then only one file will have to
be changed.

Note: I left merge-recursive.c out since it has a strange notion of
progress as it apparently increase the expected total number as it goes.
Someone with more intimate knowledge of what that is supposed to mean
might look at converting it to the common progress interface.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Makefile                 |    4 +-
 builtin-pack-objects.c   |   83 +++++++++++----------------------------------
 builtin-unpack-objects.c |   38 +++++++++-----------
 index-pack.c             |   78 +++++++++++++------------------------------
 progress.c               |   68 +++++++++++++++++++++++++++++++++++++
 progress.h               |   14 ++++++++
 unpack-trees.c           |   54 +++++-------------------------
 7 files changed, 154 insertions(+), 185 deletions(-)
 create mode 100644 progress.c
 create mode 100644 progress.h

diff --git a/Makefile b/Makefile
index 596089e..f463149 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,7 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h
+	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -305,7 +305,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o
+	convert.o attr.o decorate.o progress.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 19fae4c..150f56c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -12,6 +12,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "progress.h"
 
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
@@ -69,10 +70,10 @@ static const char *pack_tmp_name, *idx_tmp_name;
 static char tmpname[PATH_MAX];
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
-static volatile sig_atomic_t progress_update;
 static int window = 10;
 static int pack_to_stdout;
 static int num_preferred_base;
+static struct progress progress_state;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -572,7 +573,6 @@ static off_t write_pack_file(void)
 	struct sha1file *f;
 	off_t offset, last_obj_offset = 0;
 	struct pack_header hdr;
-	unsigned last_percent = 999;
 	int do_progress = progress;
 
 	if (pack_to_stdout) {
@@ -588,8 +588,10 @@ static off_t write_pack_file(void)
 		f = sha1fd(fd, pack_tmp_name);
 	}
 
-	if (do_progress)
+	if (do_progress) {
 		fprintf(stderr, "Writing %u objects.\n", nr_result);
+		start_progress(&progress_state, "", nr_result);
+	}
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(PACK_VERSION);
@@ -601,18 +603,11 @@ static off_t write_pack_file(void)
 	for (i = 0; i < nr_objects; i++) {
 		last_obj_offset = offset;
 		offset = write_one(f, objects + i, offset);
-		if (do_progress) {
-			unsigned percent = written * 100 / nr_result;
-			if (progress_update || percent != last_percent) {
-				fprintf(stderr, "%4u%% (%u/%u) done\r",
-					percent, written, nr_result);
-				progress_update = 0;
-				last_percent = percent;
-			}
-		}
+		if (do_progress)
+			display_progress(&progress_state, written);
 	}
 	if (do_progress)
-		fputc('\n', stderr);
+		stop_progress(&progress_state);
  done:
 	if (written != nr_result)
 		die("wrote %u objects while expecting %u", written, nr_result);
@@ -873,10 +868,8 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	else
 		object_ix[-1 - ix] = nr_objects;
 
-	if (progress_update) {
-		fprintf(stderr, "Counting objects...%u\r", nr_objects);
-		progress_update = 0;
-	}
+	if (progress)
+		display_progress(&progress_state, nr_objects);
 
 	return 1;
 }
@@ -1398,15 +1391,16 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	uint32_t i = nr_objects, idx = 0, processed = 0;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array;
-	unsigned last_percent = 999;
 	int max_depth;
 
 	if (!nr_objects)
 		return;
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
-	if (progress)
+	if (progress) {
 		fprintf(stderr, "Deltifying %u objects.\n", nr_result);
+		start_progress(&progress_state, "", nr_result);
+	}
 
 	do {
 		struct object_entry *entry = list[--i];
@@ -1416,15 +1410,8 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		if (!entry->preferred_base)
 			processed++;
 
-		if (progress) {
-			unsigned percent = processed * 100 / nr_result;
-			if (percent != last_percent || progress_update) {
-				fprintf(stderr, "%4u%% (%u/%u) done\r",
-					percent, processed, nr_result);
-				progress_update = 0;
-				last_percent = percent;
-			}
-		}
+		if (progress)
+			display_progress(&progress_state, processed);
 
 		if (entry->delta)
 			/* This happens if we decided to reuse existing
@@ -1479,7 +1466,7 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 	} while (i > 0);
 
 	if (progress)
-		fputc('\n', stderr);
+		stop_progress(&progress_state);
 
 	for (i = 0; i < window; ++i) {
 		free_delta_index(array[i].index);
@@ -1506,28 +1493,6 @@ static void prepare_pack(int window, int depth)
 	free(delta_list);
 }
 
-static void progress_interval(int signum)
-{
-	progress_update = 1;
-}
-
-static void setup_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-}
-
 static int git_pack_config(const char *k, const char *v)
 {
 	if(!strcmp(k, "pack.window")) {
@@ -1760,31 +1725,25 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	if (progress) {
 		fprintf(stderr, "Generating pack...\n");
-		setup_progress_signal();
+		start_progress(&progress_state, "Counting objects: ", 0);
 	}
-
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
 		rp_av[rp_ac] = NULL;
 		get_object_list(rp_ac, rp_av);
 	}
-
-	if (progress)
+	if (progress) {
+		stop_progress(&progress_state);
 		fprintf(stderr, "Done counting %u objects.\n", nr_objects);
+	}
+
 	if (non_empty && !nr_result)
 		return 0;
 	if (progress && (nr_objects != nr_result))
 		fprintf(stderr, "Result has %u objects.\n", nr_result);
 	if (nr_result)
 		prepare_pack(window, depth);
-	if (progress == 1 && pack_to_stdout) {
-		/* the other end usually displays progress itself */
-		struct itimerval v = {{0,},};
-		setitimer(ITIMER_REAL, &v, NULL);
-		signal(SIGALRM, SIG_IGN );
-		progress_update = 0;
-	}
 	last_obj_offset = write_pack_file();
 	if (!pack_to_stdout) {
 		unsigned char object_list_sha1[20];
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index f821906..c370c7f 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "progress.h"
 
 static int dry_run, quiet, recover, has_errors;
 static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
@@ -264,7 +265,7 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 	free(base);
 }
 
-static void unpack_one(unsigned nr, unsigned total)
+static void unpack_one(unsigned nr)
 {
 	unsigned shift;
 	unsigned char *pack, c;
@@ -286,20 +287,7 @@ static void unpack_one(unsigned nr, unsigned total)
 		size += (c & 0x7f) << shift;
 		shift += 7;
 	}
-	if (!quiet) {
-		static unsigned long last_sec;
-		static unsigned last_percent;
-		struct timeval now;
-		unsigned percentage = ((nr+1) * 100) / total;
-
-		gettimeofday(&now, NULL);
-		if (percentage != last_percent || now.tv_sec != last_sec) {
-			last_sec = now.tv_sec;
-			last_percent = percentage;
-			fprintf(stderr, "%4u%% (%u/%u) done\r",
-					percentage, (nr+1), total);
-		}
-	}
+
 	switch (type) {
 	case OBJ_COMMIT:
 	case OBJ_TREE:
@@ -323,6 +311,7 @@ static void unpack_one(unsigned nr, unsigned total)
 static void unpack_all(void)
 {
 	int i;
+	struct progress progress;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 	unsigned nr_objects = ntohl(hdr->hdr_entries);
 
@@ -330,12 +319,21 @@ static void unpack_all(void)
 		die("bad pack file");
 	if (!pack_version_ok(hdr->hdr_version))
 		die("unknown pack file version %d", ntohl(hdr->hdr_version));
-	fprintf(stderr, "Unpacking %d objects\n", nr_objects);
+	use(sizeof(struct pack_header));
 
+	if (!quiet) {
+		fprintf(stderr, "Unpacking %d objects\n", nr_objects);
+		start_progress(&progress, "", nr_objects);
+	}
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
-	use(sizeof(struct pack_header));
-	for (i = 0; i < nr_objects; i++)
-		unpack_one(i, nr_objects);
+	for (i = 0; i < nr_objects; i++) {
+		unpack_one(i);
+		if (!quiet)
+			display_progress(&progress, i + 1);
+	}
+	if (!quiet)
+		stop_progress(&progress);
+
 	if (delta_list)
 		die("unresolved deltas left after unpacking");
 }
@@ -404,7 +402,5 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	}
 
 	/* All done */
-	if (!quiet)
-		fprintf(stderr, "\n");
 	return has_errors;
 }
diff --git a/index-pack.c b/index-pack.c
index 7aad261..a49d03d 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include "progress.h"
 
 static const char index_pack_usage[] =
 "git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
@@ -47,40 +48,7 @@ static int nr_resolved_deltas;
 static int from_stdin;
 static int verbose;
 
-static volatile sig_atomic_t progress_update;
-
-static void progress_interval(int signum)
-{
-	progress_update = 1;
-}
-
-static void setup_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-
-}
-
-static unsigned display_progress(unsigned n, unsigned total, unsigned last_pc)
-{
-	unsigned percent = n * 100 / total;
-	if (percent != last_pc || progress_update) {
-		fprintf(stderr, "%4u%% (%u/%u) done\r", percent, n, total);
-		progress_update = 0;
-	}
-	return percent;
-}
+static struct progress progress;
 
 /* We always read in 4kB chunks. */
 static unsigned char input_buffer[4096];
@@ -428,7 +396,7 @@ static int compare_delta_entry(const void *a, const void *b)
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
-	int i, percent = -1;
+	int i;
 	struct delta_entry *delta = deltas;
 	void *data;
 	struct stat st;
@@ -439,8 +407,10 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - calculate SHA1 of all non-delta objects;
 	 * - remember base (SHA1 or offset) for all deltas.
 	 */
-	if (verbose)
+	if (verbose) {
 		fprintf(stderr, "Indexing %d objects.\n", nr_objects);
+		start_progress(&progress, "", nr_objects);
+	}
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
@@ -453,11 +423,11 @@ static void parse_pack_objects(unsigned char *sha1)
 			sha1_object(data, obj->size, obj->type, obj->sha1);
 		free(data);
 		if (verbose)
-			percent = display_progress(i+1, nr_objects, percent);
+			display_progress(&progress, i+1);
 	}
 	objects[i].offset = consumed_bytes;
 	if (verbose)
-		fputc('\n', stderr);
+		stop_progress(&progress);
 
 	/* Check pack integrity */
 	flush();
@@ -488,8 +458,10 @@ static void parse_pack_objects(unsigned char *sha1)
 	 *   recursively checking if the resulting object is used as a base
 	 *   for some more deltas.
 	 */
-	if (verbose)
+	if (verbose) {
 		fprintf(stderr, "Resolving %d deltas.\n", nr_deltas);
+		start_progress(&progress, "", nr_deltas);
+	}
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		union delta_base base;
@@ -521,11 +493,8 @@ static void parse_pack_objects(unsigned char *sha1)
 			}
 		free(data);
 		if (verbose)
-			percent = display_progress(nr_resolved_deltas,
-						   nr_deltas, percent);
+			display_progress(&progress, nr_resolved_deltas);
 	}
-	if (verbose && nr_resolved_deltas == nr_deltas)
-		fputc('\n', stderr);
 }
 
 static int write_compressed(int fd, void *in, unsigned int size, uint32_t *obj_crc)
@@ -587,7 +556,7 @@ static int delta_pos_compare(const void *_a, const void *_b)
 static void fix_unresolved_deltas(int nr_unresolved)
 {
 	struct delta_entry **sorted_by_pos;
-	int i, n = 0, percent = -1;
+	int i, n = 0;
 
 	/*
 	 * Since many unresolved deltas may well be themselves base objects
@@ -632,12 +601,9 @@ static void fix_unresolved_deltas(int nr_unresolved)
 		append_obj_to_pack(d->base.sha1, data, size, type);
 		free(data);
 		if (verbose)
-			percent = display_progress(nr_resolved_deltas,
-						   nr_deltas, percent);
+			display_progress(&progress, nr_resolved_deltas);
 	}
 	free(sorted_by_pos);
-	if (verbose)
-		fputc('\n', stderr);
 }
 
 static void readjust_pack_header_and_sha1(unsigned char *sha1)
@@ -980,10 +946,13 @@ int main(int argc, char **argv)
 	parse_pack_header();
 	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
 	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
-	if (verbose)
-		setup_progress_signal();
 	parse_pack_objects(sha1);
-	if (nr_deltas != nr_resolved_deltas) {
+	if (nr_deltas == nr_resolved_deltas) {
+		if (verbose)
+			stop_progress(&progress);
+		/* Flush remaining pack final 20-byte SHA1. */
+		flush();
+	} else {
 		if (fix_thin_pack) {
 			int nr_unresolved = nr_deltas - nr_resolved_deltas;
 			int nr_objects_initial = nr_objects;
@@ -993,17 +962,16 @@ int main(int argc, char **argv)
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
 			fix_unresolved_deltas(nr_unresolved);
-			if (verbose)
+			if (verbose) {
+				stop_progress(&progress);
 				fprintf(stderr, "%d objects were added to complete this thin pack.\n",
 					nr_objects - nr_objects_initial);
+			}
 			readjust_pack_header_and_sha1(sha1);
 		}
 		if (nr_deltas != nr_resolved_deltas)
 			die("pack has %d unresolved deltas",
 			    nr_deltas - nr_resolved_deltas);
-	} else {
-		/* Flush remaining pack final 20-byte SHA1. */
-		flush();
 	}
 	free(deltas);
 	curr_index = write_index_file(index_name, sha1);
diff --git a/progress.c b/progress.c
new file mode 100644
index 0000000..702e116
--- /dev/null
+++ b/progress.c
@@ -0,0 +1,68 @@
+#include "git-compat-util.h"
+#include "progress.h"
+
+static volatile sig_atomic_t progress_update;
+
+static void progress_interval(int signum)
+{
+	progress_update = 1;
+}
+
+static void set_progress_signal(void)
+{
+	struct sigaction sa;
+	struct itimerval v;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = progress_interval;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGALRM, &sa, NULL);
+
+	v.it_interval.tv_sec = 1;
+	v.it_interval.tv_usec = 0;
+	v.it_value = v.it_interval;
+	setitimer(ITIMER_REAL, &v, NULL);
+}
+
+static void clear_progress_signal(void)
+{
+	struct itimerval v = {{0,},};
+	setitimer(ITIMER_REAL, &v, NULL);
+	signal(SIGALRM, SIG_IGN);
+	progress_update = 0;
+}
+
+int display_progress(struct progress *progress, unsigned n)
+{
+	if (progress->total) {
+		unsigned percent = n * 100 / progress->total;
+		if (percent != progress->last_percent || progress_update) {
+			progress->last_percent = percent;
+			fprintf(stderr, "%s%4u%% (%u/%u) done\r",
+				progress->msg, percent, n, progress->total);
+			progress_update = 0;
+			return 1;
+		}
+	} else if (progress_update) {
+		fprintf(stderr, "%s%u\r", progress->msg, n);
+		progress_update = 0;
+		return 1;
+	}
+	return 0;
+}
+
+void start_progress(struct progress *progress, const char *msg, unsigned total)
+{
+	progress->msg = msg;
+	progress->total = total;
+	progress->last_percent = -1;
+	set_progress_signal();
+}
+
+void stop_progress(struct progress *progress)
+{
+	clear_progress_signal();
+	if (progress->total)
+		fputc('\n', stderr);
+}
diff --git a/progress.h b/progress.h
new file mode 100644
index 0000000..5fa4948
--- /dev/null
+++ b/progress.h
@@ -0,0 +1,14 @@
+#ifndef __progress_h__
+#define __progress_h__
+
+struct progress {
+	const char *msg;
+	unsigned total;
+	unsigned last_percent;
+};
+
+int display_progress(struct progress *progress, unsigned n);
+void start_progress(struct progress *progress, const char *msg, unsigned total);
+void stop_progress(struct progress *progress);
+
+#endif
diff --git a/unpack-trees.c b/unpack-trees.c
index 5139481..8a11622 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -4,6 +4,7 @@
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
+#include "progress.h"
 
 #define DBRT_DEBUG 1
 
@@ -288,36 +289,13 @@ static void unlink_entry(char *name)
 	}
 }
 
-static volatile sig_atomic_t progress_update;
-
-static void progress_interval(int signum)
-{
-	progress_update = 1;
-}
-
-static void setup_progress_signal(void)
-{
-	struct sigaction sa;
-	struct itimerval v;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_handler = progress_interval;
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_RESTART;
-	sigaction(SIGALRM, &sa, NULL);
-
-	v.it_interval.tv_sec = 1;
-	v.it_interval.tv_usec = 0;
-	v.it_value = v.it_interval;
-	setitimer(ITIMER_REAL, &v, NULL);
-}
-
 static struct checkout state;
 static void check_updates(struct cache_entry **src, int nr,
 		struct unpack_trees_options *o)
 {
 	unsigned short mask = htons(CE_UPDATE);
-	unsigned last_percent = 200, cnt = 0, total = 0;
+	unsigned cnt = 0, total = 0;
+	struct progress progress;
 
 	if (o->update && o->verbose_update) {
 		for (total = cnt = 0; cnt < nr; cnt++) {
@@ -332,8 +310,7 @@ static void check_updates(struct cache_entry **src, int nr,
 
 		if (total) {
 			fprintf(stderr, "Checking files out...\n");
-			setup_progress_signal();
-			progress_update = 1;
+			start_progress(&progress, "", total);
 		}
 		cnt = 0;
 	}
@@ -341,20 +318,9 @@ static void check_updates(struct cache_entry **src, int nr,
 	while (nr--) {
 		struct cache_entry *ce = *src++;
 
-		if (total) {
-			if (!ce->ce_mode || ce->ce_flags & mask) {
-				unsigned percent;
-				cnt++;
-				percent = (cnt * 100) / total;
-				if (percent != last_percent ||
-				    progress_update) {
-					fprintf(stderr, "%4u%% (%u/%u) done\r",
-						percent, cnt, total);
-					last_percent = percent;
-					progress_update = 0;
-				}
-			}
-		}
+		if (total)
+			if (!ce->ce_mode || ce->ce_flags & mask)
+				display_progress(&progress, ++cnt);
 		if (!ce->ce_mode) {
 			if (o->update)
 				unlink_entry(ce->name);
@@ -366,10 +332,8 @@ static void check_updates(struct cache_entry **src, int nr,
 				checkout_entry(ce, &state, NULL);
 		}
 	}
-	if (total) {
-		signal(SIGALRM, SIG_IGN);
-		fputc('\n', stderr);
-	}
+	if (total)
+		stop_progress(&progress);;
 }
 
 int unpack_trees(struct object_list *trees, struct unpack_trees_options *o)
-- 
1.5.1.1.873.g1ddf-dirty
