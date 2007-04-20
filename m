From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/3] make progress "title" part of the common progress interface
Date: Fri, 20 Apr 2007 14:10:07 -0400
Message-ID: <S1767212AbXDTTaS/20070420193018Z+119@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Apr 20 21:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeyoJ-0007Kn-Eb
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 21:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767204AbXDTTaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 15:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767212AbXDTTaS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 15:30:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23025 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767204AbXDTTaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 15:30:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGT005MAA6E8SH0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Apr 2007 15:30:15 -0400 (EDT)
Apparently-To: <nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45125>

If the progress bar ends up in a box, better provide a title for it too.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c   |   19 +++++++------------
 builtin-unpack-objects.c |    6 ++----
 index-pack.c             |   12 ++++--------
 progress.c               |   12 ++++++++----
 progress.h               |    5 +++--
 unpack-trees.c           |    7 +++----
 6 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 150f56c..233f506 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -588,10 +588,8 @@ static off_t write_pack_file(void)
 		f = sha1fd(fd, pack_tmp_name);
 	}
 
-	if (do_progress) {
-		fprintf(stderr, "Writing %u objects.\n", nr_result);
-		start_progress(&progress_state, "", nr_result);
-	}
+	if (do_progress)
+		start_progress(&progress_state, "Writing %u objects...", "", nr_result);
 
 	hdr.hdr_signature = htonl(PACK_SIGNATURE);
 	hdr.hdr_version = htonl(PACK_VERSION);
@@ -1397,10 +1395,8 @@ static void find_deltas(struct object_entry **list, int window, int depth)
 		return;
 	array = xmalloc(array_size);
 	memset(array, 0, array_size);
-	if (progress) {
-		fprintf(stderr, "Deltifying %u objects.\n", nr_result);
-		start_progress(&progress_state, "", nr_result);
-	}
+	if (progress)
+		start_progress(&progress_state, "Deltifying %u objects...", "", nr_result);
 
 	do {
 		struct object_entry *entry = list[--i];
@@ -1723,10 +1719,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	prepare_packed_git();
 
-	if (progress) {
-		fprintf(stderr, "Generating pack...\n");
-		start_progress(&progress_state, "Counting objects: ", 0);
-	}
+	if (progress)
+		start_progress(&progress_state, "Generating pack...",
+			       "Counting objects: ", 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index c370c7f..2bbda67 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -321,10 +321,8 @@ static void unpack_all(void)
 		die("unknown pack file version %d", ntohl(hdr->hdr_version));
 	use(sizeof(struct pack_header));
 
-	if (!quiet) {
-		fprintf(stderr, "Unpacking %d objects\n", nr_objects);
-		start_progress(&progress, "", nr_objects);
-	}
+	if (!quiet)
+		start_progress(&progress, "Unpacking %u objects...", "", nr_objects);
 	obj_list = xmalloc(nr_objects * sizeof(*obj_list));
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
diff --git a/index-pack.c b/index-pack.c
index a49d03d..824004f 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -407,10 +407,8 @@ static void parse_pack_objects(unsigned char *sha1)
 	 * - calculate SHA1 of all non-delta objects;
 	 * - remember base (SHA1 or offset) for all deltas.
 	 */
-	if (verbose) {
-		fprintf(stderr, "Indexing %d objects.\n", nr_objects);
-		start_progress(&progress, "", nr_objects);
-	}
+	if (verbose)
+		start_progress(&progress, "Indexing %u objects...", "", nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
@@ -458,10 +456,8 @@ static void parse_pack_objects(unsigned char *sha1)
 	 *   recursively checking if the resulting object is used as a base
 	 *   for some more deltas.
 	 */
-	if (verbose) {
-		fprintf(stderr, "Resolving %d deltas.\n", nr_deltas);
-		start_progress(&progress, "", nr_deltas);
-	}
+	if (verbose)
+		start_progress(&progress, "Resolving %u deltas...", "", nr_deltas);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		union delta_base base;
diff --git a/progress.c b/progress.c
index 702e116..478134b 100644
--- a/progress.c
+++ b/progress.c
@@ -40,23 +40,27 @@ int display_progress(struct progress *progress, unsigned n)
 		if (percent != progress->last_percent || progress_update) {
 			progress->last_percent = percent;
 			fprintf(stderr, "%s%4u%% (%u/%u) done\r",
-				progress->msg, percent, n, progress->total);
+				progress->prefix, percent, n, progress->total);
 			progress_update = 0;
 			return 1;
 		}
 	} else if (progress_update) {
-		fprintf(stderr, "%s%u\r", progress->msg, n);
+		fprintf(stderr, "%s%u\r", progress->prefix, n);
 		progress_update = 0;
 		return 1;
 	}
 	return 0;
 }
 
-void start_progress(struct progress *progress, const char *msg, unsigned total)
+void start_progress(struct progress *progress, const char *title,
+		    const char *prefix, unsigned total)
 {
-	progress->msg = msg;
+	char buf[80];
+	progress->prefix = prefix;
 	progress->total = total;
 	progress->last_percent = -1;
+	if (snprintf(buf, sizeof(buf), title, total))
+		fprintf(stderr, "%s\n", buf);
 	set_progress_signal();
 }
 
diff --git a/progress.h b/progress.h
index 5fa4948..1f2661e 100644
--- a/progress.h
+++ b/progress.h
@@ -2,13 +2,14 @@
 #define __progress_h__
 
 struct progress {
-	const char *msg;
+	const char *prefix;
 	unsigned total;
 	unsigned last_percent;
 };
 
 int display_progress(struct progress *progress, unsigned n);
-void start_progress(struct progress *progress, const char *msg, unsigned total);
+void start_progress(struct progress *progress, const char *title,
+		    const char *prefix, unsigned total);
 void stop_progress(struct progress *progress);
 
 #endif
diff --git a/unpack-trees.c b/unpack-trees.c
index 8a11622..cefc404 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -308,10 +308,9 @@ static void check_updates(struct cache_entry **src, int nr,
 		if (total < 250)
 			total = 0;
 
-		if (total) {
-			fprintf(stderr, "Checking files out...\n");
-			start_progress(&progress, "", total);
-		}
+		if (total)
+			start_progress(&progress, "Checking %u files out...",
+				       "", total);
 		cnt = 0;
 	}
 
-- 
1.5.1.1.874.g4f52f-dirty
