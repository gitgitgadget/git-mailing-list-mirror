From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/6] more compact progress display
Date: Tue, 16 Oct 2007 21:55:45 -0400
Message-ID: <1192586150-13743-2-git-send-email-nico@cam.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 03:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihy9P-0003Wi-VI
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 03:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936196AbXJQB4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 21:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936199AbXJQBz4
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 21:55:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8510 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936196AbXJQBzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 21:55:54 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ10063X9D2E630@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 21:55:52 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1212.gdb015
In-reply-to: <1192586150-13743-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61307>

Each progress can be on a single line instead of two.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |   16 ++++---------
 builtin-unpack-objects.c |    2 +-
 index-pack.c             |    4 +-
 progress.c               |   53 +++++++++++++++++++++------------------------
 progress.h               |   10 +++-----
 unpack-trees.c           |    4 +-
 6 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 0be539e..df69abd 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -606,7 +606,7 @@ static void write_pack_file(void)
 	uint32_t nr_remaining = nr_result;
 
 	if (do_progress)
-		start_progress(&progress_state, "Writing %u objects...", "", nr_result);
+		start_progress(&progress_state, "Writing objects", nr_result);
 	written_list = xmalloc(nr_objects * sizeof(struct object_entry *));
 
 	do {
@@ -1717,9 +1717,8 @@ static void prepare_pack(int window, int depth)
 	if (nr_deltas) {
 		unsigned nr_done = 0;
 		if (progress)
-			start_progress(&progress_state,
-				       "Deltifying %u objects...", "",
-				       nr_deltas);
+			start_progress(&progress_state, "Deltifying objects",
+					nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
 		if (progress)
@@ -2135,23 +2134,18 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	prepare_packed_git();
 
 	if (progress)
-		start_progress(&progress_state, "Generating pack...",
-			       "Counting objects: ", 0);
+		start_progress(&progress_state, "Counting objects", 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
 		rp_av[rp_ac] = NULL;
 		get_object_list(rp_ac, rp_av);
 	}
-	if (progress) {
+	if (progress)
 		stop_progress(&progress_state);
-		fprintf(stderr, "Done counting %u objects.\n", nr_objects);
-	}
 
 	if (non_empty && !nr_result)
 		return 0;
-	if (progress && (nr_objects != nr_result))
-		fprintf(stderr, "Result has %u objects.\n", nr_result);
 	if (nr_result)
 		prepare_pack(window, depth);
 	write_pack_file();
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index a6ff62f..2317b8f 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -322,7 +322,7 @@ static void unpack_all(void)
 	use(sizeof(struct pack_header));
 
 	if (!quiet)
-		start_progress(&progress, "Unpacking %u objects...", "", nr_objects);
+		start_progress(&progress, "Unpacking objects", nr_objects);
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
diff --git a/index-pack.c b/index-pack.c
index db58e05..c784dec 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -406,7 +406,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - remember base (SHA1 or offset) for all deltas.
 	 */
 	if (verbose)
-		start_progress(&progress, "Indexing %u objects...", "", nr_objects);
+		start_progress(&progress, "Indexing objects", nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
@@ -455,7 +455,7 @@ static void parse_pack_objects(unsigned char *sha1)
 	 *   for some more deltas.
 	 */
 	if (verbose)
-		start_progress(&progress, "Resolving %u deltas...", "", nr_deltas);
+		start_progress(&progress, "Resolving deltas", nr_deltas);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		union delta_base base;
diff --git a/progress.c b/progress.c
index 4344f4e..7629e05 100644
--- a/progress.c
+++ b/progress.c
@@ -35,10 +35,11 @@ static void clear_progress_signal(void)
 	progress_update = 0;
 }
 
-int display_progress(struct progress *progress, unsigned n)
+static int display(struct progress *progress, unsigned n, int done)
 {
+	char *eol;
+
 	if (progress->delay) {
-		char buf[80];
 		if (!progress_update || --progress->delay)
 			return 0;
 		if (progress->total) {
@@ -51,60 +52,56 @@ int display_progress(struct progress *progress, unsigned n)
 				return 0;
 			}
 		}
-		if (snprintf(buf, sizeof(buf),
-			     progress->delayed_title, progress->total))
-			fprintf(stderr, "%s\n", buf);
 	}
+
+	progress->last_value = n;
+	eol = done ? ", done.   \n" : "   \r";
 	if (progress->total) {
 		unsigned percent = n * 100 / progress->total;
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
-			fprintf(stderr, "%s%4u%% (%u/%u) done\r",
-				progress->prefix, percent, n, progress->total);
+			fprintf(stderr, "%s: %3u%% (%u/%u)%s", progress->title,
+				percent, n, progress->total, eol);
 			progress_update = 0;
-			progress->need_lf = 1;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s%u\r", progress->prefix, n);
+		fprintf(stderr, "%s: %u%s", progress->title, n, eol);
 		progress_update = 0;
-		progress->need_lf = 1;
 		return 1;
 	}
+
 	return 0;
 }
 
-void start_progress(struct progress *progress, const char *title,
-		    const char *prefix, unsigned total)
+int display_progress(struct progress *progress, unsigned n)
 {
-	char buf[80];
-	progress->prefix = prefix;
-	progress->total = total;
-	progress->last_percent = -1;
-	progress->delay = 0;
-	progress->need_lf = 0;
-	if (snprintf(buf, sizeof(buf), title, total))
-		fprintf(stderr, "%s\n", buf);
-	set_progress_signal();
+	return display(progress, n, 0);
 }
 
 void start_progress_delay(struct progress *progress, const char *title,
-			  const char *prefix, unsigned total,
-			  unsigned percent_treshold, unsigned delay)
+			  unsigned total, unsigned percent_treshold, unsigned delay)
 {
-	progress->prefix = prefix;
+	progress->title = title;
 	progress->total = total;
+	progress->last_value = -1;
 	progress->last_percent = -1;
 	progress->delayed_percent_treshold = percent_treshold;
-	progress->delayed_title = title;
 	progress->delay = delay;
-	progress->need_lf = 0;
 	set_progress_signal();
 }
 
+void start_progress(struct progress *progress, const char *title, unsigned total)
+{
+	start_progress_delay(progress, title, total, 0, 0);
+}
+
 void stop_progress(struct progress *progress)
 {
+	if (progress->last_value != -1) {
+		/* Force the last update */
+		progress_update = 1;
+		display(progress, progress->last_value, 1);
+	}
 	clear_progress_signal();
-	if (progress->need_lf)
-		fputc('\n', stderr);
 }
diff --git a/progress.h b/progress.h
index a7c17ca..07b56bd 100644
--- a/progress.h
+++ b/progress.h
@@ -2,21 +2,19 @@
 #define PROGRESS_H
 
 struct progress {
-	const char *prefix;
+	const char *title;
+	int last_value;
 	unsigned total;
 	unsigned last_percent;
 	unsigned delay;
 	unsigned delayed_percent_treshold;
-	const char *delayed_title;
-	int need_lf;
 };
 
 int display_progress(struct progress *progress, unsigned n);
 void start_progress(struct progress *progress, const char *title,
-		    const char *prefix, unsigned total);
+		    unsigned total);
 void start_progress_delay(struct progress *progress, const char *title,
-			  const char *prefix, unsigned total,
-			  unsigned percent_treshold, unsigned delay);
+			  unsigned total, unsigned percent_treshold, unsigned delay);
 void stop_progress(struct progress *progress);
 
 #endif
diff --git a/unpack-trees.c b/unpack-trees.c
index ccfeb6e..e083898 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -307,8 +307,8 @@ static void check_updates(struct cache_entry **src, int nr,
 				total++;
 		}
 
-		start_progress_delay(&progress, "Checking %u files out...",
-				     "", total, 50, 2);
+		start_progress_delay(&progress, "Checking files out",
+				     total, 50, 2);
 		cnt = 0;
 	}
 
-- 
1.5.3.4.1212.gdb015
