From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fetch-clone progress: finishing touches.
Date: Sat, 11 Feb 2006 17:58:21 -0800
Message-ID: <7vslqpjq2q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602111041430.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 02:58:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F86VW-0001hR-FJ
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 02:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBLB6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 20:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBLB6Z
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 20:58:25 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56473 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932127AbWBLB6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 20:58:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212015716.UXKS3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 20:57:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602111041430.3691@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 11 Feb 2006 10:43:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15969>

This makes fetch-pack also report the progress of packing part.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * While we are doing eye-candy, this makes the silence after
   "Generating pack..." part a bit more bearable.

   Likes, dislikes, too-much's?

   BTW, don't you mean 512 down there???

        -	msecs += (int)(tv.tv_usec - prev_tv.tv_usec) >> 10;
        +	msecs += usec_to_binarymsec(tv.tv_usec - prev_tv.tv_usec);
        +
                if (msecs > 500) {
                        prev_tv = tv;

 clone-pack.c   |    4 ++--
 pack-objects.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

21fcd1bdea2440236aea1713ea42a66bc2da5563
diff --git a/clone-pack.c b/clone-pack.c
index 719e1c4..a4370f5 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -125,9 +125,9 @@ static int clone_pack(int fd[2], int nr_
 	}
 	clone_handshake(fd, refs);
 
-	if (!quiet)
-		fprintf(stderr, "Generating pack ...\r");
 	status = receive_keep_pack(fd, "git-clone-pack", quiet);
+	if (!quiet)
+		fprintf(stderr, "\n");
 
 	if (!status) {
 		if (nr_match == 0)
diff --git a/pack-objects.c b/pack-objects.c
index c3f2531..2135e9a 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -3,6 +3,7 @@
 #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
+#include <sys/time.h>
 
 static const char pack_usage[] = "git-pack-objects [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
 
@@ -26,6 +27,7 @@ static struct object_entry *objects = NU
 static int nr_objects = 0, nr_alloc = 0;
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
+static int progress = 0;
 
 static void *delta_against(void *buf, unsigned long size, struct object_entry *entry)
 {
@@ -362,10 +364,13 @@ static void find_deltas(struct object_en
 	int i, idx;
 	unsigned int array_size = window * sizeof(struct unpacked);
 	struct unpacked *array = xmalloc(array_size);
+	int eye_candy;
 
 	memset(array, 0, array_size);
 	i = nr_objects;
 	idx = 0;
+	eye_candy = i - (nr_objects / 20);
+
 	while (--i >= 0) {
 		struct object_entry *entry = list[i];
 		struct unpacked *n = array + idx;
@@ -373,6 +378,10 @@ static void find_deltas(struct object_en
 		char type[10];
 		int j;
 
+		if (progress && i <= eye_candy) {
+			eye_candy -= nr_objects / 20;
+			fputc('.', stderr);
+		}
 		free(n->data);
 		n->entry = entry;
 		n->data = read_sha1_file(entry->sha1, type, &size);
@@ -404,11 +413,13 @@ static void prepare_pack(int window, int
 {
 	get_object_details();
 
-	fprintf(stderr, "Packing %d objects\n", nr_objects);
-
+	if (progress)
+		fprintf(stderr, "Packing %d objects", nr_objects);
 	sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
 		find_deltas(sorted_by_type, window+1, depth);
+	if (progress)
+		fputc('\n', stderr);
 	write_pack_file();
 }
 
@@ -472,6 +483,10 @@ int main(int argc, char **argv)
 	int window = 10, depth = 10, pack_to_stdout = 0;
 	struct object_entry **list;
 	int i;
+	struct timeval prev_tv;
+	int eye_candy = 0;
+	int eye_candy_incr = 500;
+
 
 	setup_git_directory();
 
@@ -519,12 +534,34 @@ int main(int argc, char **argv)
 	if (pack_to_stdout != !base_name)
 		usage(pack_usage);
 
+	progress = isatty(2);
+
 	prepare_packed_git();
+	if (progress) {
+		fprintf(stderr, "Generating pack...\n");
+		gettimeofday(&prev_tv, NULL);
+	}
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		unsigned int hash;
 		char *p;
 		unsigned char sha1[20];
 
+		if (progress && (eye_candy <= nr_objects)) {
+			fprintf(stderr, "Counting objects...%d\r", nr_objects);
+			if (eye_candy && (50 <= eye_candy_incr)) {
+				struct timeval tv;
+				int time_diff;
+				gettimeofday(&tv, NULL);
+				time_diff = (tv.tv_sec - prev_tv.tv_sec);
+				time_diff <<= 10;
+				time_diff += (tv.tv_usec - prev_tv.tv_usec);
+				if ((1 << 9) < time_diff)
+					eye_candy_incr += 50;
+				else if (50 < eye_candy_incr)
+					eye_candy_incr -= 50;
+			}
+			eye_candy += eye_candy_incr;
+		}
 		if (get_sha1_hex(line, sha1))
 			die("expected sha1, got garbage:\n %s", line);
 		hash = 0;
@@ -537,6 +574,8 @@ int main(int argc, char **argv)
 		}
 		add_object_entry(sha1, hash);
 	}
+	if (progress)
+		fprintf(stderr, "Done counting %d objects.\n", nr_objects);
 	if (non_empty && !nr_objects)
 		return 0;
 
-- 
1.1.6.g69c5
