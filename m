X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] add progress status to index-pack
Date: Wed, 25 Oct 2006 23:32:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610252332300.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 03:33:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30135>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcvzO-0004XM-3L for gcvg-git@gmane.org; Thu, 26 Oct
 2006 05:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751724AbWJZDdC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 23:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWJZDdC
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 23:33:02 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42475 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1751724AbWJZDdA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 23:33:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Q005P94IZ9OA4@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 25 Oct 2006 23:33:00 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is more interesting to look at when performing a big fetch.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-index-pack.txt |    7 +++-
 index-pack.c                     |   74 +++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index c58287d..9fa4847 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -8,8 +8,8 @@ git-index-pack - Build pack index file f
 
 SYNOPSIS
 --------
-'git-index-pack' [-o <index-file>] <pack-file>
-'git-index-pack' --stdin [--fix-thin] [-o <index-file>] [<pack-file>]
+'git-index-pack' [-v] [-o <index-file>] <pack-file>
+'git-index-pack' --stdin [--fix-thin] [-v] [-o <index-file>] [<pack-file>]
 
 
 DESCRIPTION
@@ -22,6 +22,9 @@ objects/pack/ directory of a git reposit
 
 OPTIONS
 -------
+-v::
+	Be verbose about what is going on, including progress status.
+
 -o <index-file>::
 	Write the generated pack index into the specified
 	file.  Without this option the name of pack index
diff --git a/index-pack.c b/index-pack.c
index 9086bbf..2046b37 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -6,9 +6,11 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree.h"
+#include <sys/time.h>
+#include <signal.h>
 
 static const char index_pack_usage[] =
-"git-index-pack [-o <index-file>] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git-index-pack [-v] [-o <index-file>] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
@@ -44,6 +46,42 @@ static int nr_deltas;
 static int nr_resolved_deltas;
 
 static int from_stdin;
+static int verbose;
+
+static volatile sig_atomic_t progress_update;
+
+static void progress_interval(int signum)
+{
+	progress_update = 1;
+}
+
+static void setup_progress_signal(void)
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
+
+}
+
+static unsigned display_progress(unsigned n, unsigned total, unsigned last_pc)
+{
+	unsigned percent = n * 100 / total;
+	if (percent != last_pc || progress_update) {
+		fprintf(stderr, "%4u%% (%u/%u) done\r", percent, n, total);
+		progress_update = 0;
+	}
+	return percent;
+}
 
 /* We always read in 4kB chunks. */
 static unsigned char input_buffer[4096];
@@ -135,7 +173,6 @@ static void parse_pack_header(void)
 
 	nr_objects = ntohl(hdr->hdr_entries);
 	use(sizeof(struct pack_header));
-	/*fprintf(stderr, "Indexing %d objects\n", nr_objects);*/
 }
 
 static void bad_object(unsigned long offset, const char *format,
@@ -383,7 +420,7 @@ static int compare_delta_entry(const voi
 /* Parse all objects and return the pack content SHA1 hash */
 static void parse_pack_objects(unsigned char *sha1)
 {
-	int i;
+	int i, percent = -1;
 	struct delta_entry *delta = deltas;
 	void *data;
 	struct stat st;
@@ -394,6 +431,8 @@ static void parse_pack_objects(unsigned
 	 * - calculate SHA1 of all non-delta objects;
 	 * - remember base SHA1 for all deltas.
 	 */
+	if (verbose)
+		fprintf(stderr, "Indexing %d objects.\n", nr_objects);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		data = unpack_raw_entry(obj, &delta->base);
@@ -405,8 +444,12 @@ static void parse_pack_objects(unsigned
 		} else
 			sha1_object(data, obj->size, obj->type, obj->sha1);
 		free(data);
+		if (verbose)
+			percent = display_progress(i+1, nr_objects, percent);
 	}
 	objects[i].offset = consumed_bytes;
+	if (verbose)
+		fputc('\n', stderr);
 
 	/* Check pack integrity */
 	flush();
@@ -420,6 +463,9 @@ static void parse_pack_objects(unsigned
 	if (S_ISREG(st.st_mode) && st.st_size != consumed_bytes + 20)
 		die("pack has junk at the end");
 
+	if (!nr_deltas)
+		return;
+
 	/* Sort deltas by base SHA1/offset for fast searching */
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
 	      compare_delta_entry);
@@ -432,6 +478,8 @@ static void parse_pack_objects(unsigned
 	 *   recursively checking if the resulting object is used as a base
 	 *   for some more deltas.
 	 */
+	if (verbose)
+		fprintf(stderr, "Resolving %d deltas.\n", nr_deltas);
 	for (i = 0; i < nr_objects; i++) {
 		struct object_entry *obj = &objects[i];
 		union delta_base base;
@@ -462,7 +510,12 @@ static void parse_pack_objects(unsigned
 						      obj->size, obj->type);
 			}
 		free(data);
+		if (verbose)
+			percent = display_progress(nr_resolved_deltas,
+						   nr_deltas, percent);
 	}
+	if (verbose && nr_resolved_deltas == nr_deltas)
+		fputc('\n', stderr);
 }
 
 static int write_compressed(int fd, void *in, unsigned int size)
@@ -521,7 +574,7 @@ static int delta_pos_compare(const void
 static void fix_unresolved_deltas(int nr_unresolved)
 {
 	struct delta_entry **sorted_by_pos;
-	int i, n = 0;
+	int i, n = 0, percent = -1;
 
 	/*
 	 * Since many unresolved deltas may well be themselves base objects
@@ -570,8 +623,13 @@ static void fix_unresolved_deltas(int nr
 
 		append_obj_to_pack(data, size, obj_type);
 		free(data);
+		if (verbose)
+			percent = display_progress(nr_resolved_deltas,
+						   nr_deltas, percent);
 	}
 	free(sorted_by_pos);
+	if (verbose)
+		fputc('\n', stderr);
 }
 
 static void readjust_pack_header_and_sha1(unsigned char *sha1)
@@ -747,6 +805,8 @@ int main(int argc, char **argv)
 				from_stdin = 1;
 			} else if (!strcmp(arg, "--fix-thin")) {
 				fix_thin_pack = 1;
+			} else if (!strcmp(arg, "-v")) {
+				verbose = 1;
 			} else if (!strcmp(arg, "-o")) {
 				if (index_name || (i+1) >= argc)
 					usage(index_pack_usage);
@@ -780,16 +840,22 @@ int main(int argc, char **argv)
 	parse_pack_header();
 	objects = xmalloc((nr_objects + 1) * sizeof(struct object_entry));
 	deltas = xmalloc(nr_objects * sizeof(struct delta_entry));
+	if (verbose)
+		setup_progress_signal();
 	parse_pack_objects(sha1);
 	if (nr_deltas != nr_resolved_deltas) {
 		if (fix_thin_pack) {
 			int nr_unresolved = nr_deltas - nr_resolved_deltas;
+			int nr_objects_initial = nr_objects;
 			if (nr_unresolved <= 0)
 				die("confusion beyond insanity");
 			objects = xrealloc(objects,
 					   (nr_objects + nr_unresolved + 1)
 					   * sizeof(*objects));
 			fix_unresolved_deltas(nr_unresolved);
+			if (verbose)
+				fprintf(stderr, "%d objects were added to complete this thin pack.\n",
+					nr_objects - nr_objects_initial);
 			readjust_pack_header_and_sha1(sha1);
 		}
 		if (nr_deltas != nr_resolved_deltas)
-- 
1.4.3.3.g10cf-dirty
