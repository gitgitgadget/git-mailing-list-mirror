From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] nicer eye candies for pack-objects
Date: Wed, 22 Feb 2006 16:00:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602221549250.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 22:00:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC15s-0004Ia-Us
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 22:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWBVVAM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 16:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWBVVAL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 16:00:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:51686 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751449AbWBVVAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 16:00:09 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV300N66X083A50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Feb 2006 16:00:09 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16614>

This provides a stable and simpler progress reporting mechanism that 
updates progress as often as possible but accurately not updating more 
than once a second.  The deltification phase is also made more 
interesting to watch (since repacking a big repository and only seeing a 
dot appear once every many seconds is rather boring and doesn't provide 
much food for anticipation).

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/pack-objects.c b/pack-objects.c
index 0c9f4c9..7c89dc7 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -4,6 +4,7 @@
 #include "pack.h"
 #include "csum-file.h"
 #include <sys/time.h>
+#include <signal.h>
 
 static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
 
@@ -661,17 +661,22 @@ static int try_delta(struct unpacked *cu
 	return 0;
 }
 
+static volatile int progress_update = 0;
+static void progress_interval(int signum)
+{
+	signal(SIGALRM, progress_interval);
+	progress_update = 1;
+}
+
 static void find_deltas(struct object_entry **list, int window, int depth)
 {
 	int i, idx;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array = xmalloc(array_size);
-	int eye_candy;
 
 	memset(array, 0, array_size);
 	i = nr_objects;
 	idx = 0;
-	eye_candy = i - (nr_objects / 20);
 
 	while (--i >= 0) {
 		struct object_entry *entry = list[i];
@@ -680,9 +685,10 @@ static void find_deltas(struct object_en
 		char type[10];
 		int j;
 
-		if (progress && i <= eye_candy) {
-			eye_candy -= nr_objects / 20;
-			fputc('.', stderr);
+		if (progress_update || i == 0) {
+			fprintf(stderr, "Deltifying (%d %d%%)\r",
+				nr_objects-i, (nr_objects-i) * 100/nr_objects);
+			progress_update = 0;
 		}
 
 		if (entry->delta)
@@ -714,6 +720,9 @@ static void find_deltas(struct object_en
 			idx = 0;
 	}
 
+	if (progress)
+		fputc('\n', stderr);
+
 	for (i = 0; i < window; ++i)
 		free(array[i].data);
 	free(array);
@@ -721,17 +730,10 @@ static void find_deltas(struct object_en
 
 static void prepare_pack(int window, int depth)
 {
-	if (progress)
-		fprintf(stderr, "Packing %d objects", nr_objects);
 	get_object_details();
-	if (progress)
-		fputc('.', stderr);
-
 	sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
 		find_deltas(sorted_by_type, window+1, depth);
-	if (progress)
-		fputc('\n', stderr);
 	write_pack_file();
 }
 
@@ -796,10 +798,6 @@ int main(int argc, char **argv)
 	int window = 10, depth = 10, pack_to_stdout = 0;
 	struct object_entry **list;
 	int i;
-	struct timeval prev_tv;
-	int eye_candy = 0;
-	int eye_candy_incr = 500;
-
 
 	setup_git_directory();
 
@@ -856,30 +854,25 @@ int main(int argc, char **argv)
 		usage(pack_usage);
 
 	prepare_packed_git();
+
 	if (progress) {
+		struct itimerval v;
+		v.it_interval.tv_sec = 1;
+		v.it_interval.tv_usec = 0;
+		v.it_value = v.it_interval;
+		signal(SIGALRM, progress_interval);
+		setitimer(ITIMER_REAL, &v, NULL);
 		fprintf(stderr, "Generating pack...\n");
-		gettimeofday(&prev_tv, NULL);
 	}
+
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		unsigned int hash;
 		char *p;
 		unsigned char sha1[20];
 
-		if (progress && (eye_candy <= nr_objects)) {
+		if (progress_update) {
 			fprintf(stderr, "Counting objects...%d\r", nr_objects);
-			if (eye_candy && (50 <= eye_candy_incr)) {
-				struct timeval tv;
-				int time_diff;
-				gettimeofday(&tv, NULL);
-				time_diff = (tv.tv_sec - prev_tv.tv_sec);
-				time_diff <<= 10;
-				time_diff += (tv.tv_usec - prev_tv.tv_usec);
-				if ((1 << 9) < time_diff)
-					eye_candy_incr += 50;
-				else if (50 < eye_candy_incr)
-					eye_candy_incr -= 50;
-			}
-			eye_candy += eye_candy_incr;
+			progress_update = 0;
 		}
 		if (get_sha1_hex(line, sha1))
 			die("expected sha1, got garbage:\n %s", line);
