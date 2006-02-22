From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] also adds progress when actually writing a pack
Date: Wed, 22 Feb 2006 17:41:32 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602221737160.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:41:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC2fx-00038k-08
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 23:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWBVWle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 17:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWBVWle
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 17:41:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42401 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932288AbWBVWld
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 17:41:33 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV400NC31P834H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Feb 2006 17:41:32 -0500 (EST)
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16621>

If that pack is big, it takes significant time to write and might 
benefit from some more eye candies as well.  This is however disabled 
when the pack is written to stdout since in that case the output is 
usually piped into unpack_objects which already does its own progress 
reporting.

Signed-off-by: Nicolas Pitre <nico@cam.org>

---

diff --git a/pack-objects.c b/pack-objects.c
index 7c89dc7..7784d32 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -53,6 +53,7 @@ static int nr_objects = 0, nr_alloc = 0;
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
+static volatile int progress_update = 0;
 
 /*
  * The object names in objects array are hashed with this hashtable,
@@ -333,8 +334,14 @@ static void write_pack_file(void)
 	hdr.hdr_entries = htonl(nr_objects);
 	sha1write(f, &hdr, sizeof(hdr));
 	offset = sizeof(hdr);
-	for (i = 0; i < nr_objects; i++)
+	for (i = 0; i < nr_objects; i++) {
 		offset = write_one(f, objects + i, offset);
+		if (progress_update) {
+			fprintf(stderr, "Writing (%d %d%%)\r",
+				i+1, (i+1) * 100/nr_objects);
+			progress_update = 0;
+		}
+	}
 
 	sha1close(f, pack_file_sha1, 1);
 }
@@ -661,7 +668,6 @@ static int try_delta(struct unpacked *cu
 	return 0;
 }
 
-static volatile int progress_update = 0;
 static void progress_interval(int signum)
 {
 	signal(SIGALRM, progress_interval);
@@ -734,7 +740,6 @@ static void prepare_pack(int window, int
 	sorted_by_type = create_sorted_list(type_size_sort);
 	if (window && depth)
 		find_deltas(sorted_by_type, window+1, depth);
-	write_pack_file();
 }
 
 static int reuse_cached_pack(unsigned char *sha1, int pack_to_stdout)
@@ -904,6 +909,14 @@ int main(int argc, char **argv)
 		;
 	else {
 		prepare_pack(window, depth);
+		if (progress && pack_to_stdout) {
+			/* the other end usually displays progress itself */
+			struct itimerval v = {{0,},};
+			setitimer(ITIMER_REAL, &v, NULL);
+			signal(SIGALRM, SIG_IGN );
+			progress_update = 0;
+		}
+		write_pack_file();
 		if (!pack_to_stdout) {
 			write_index_file();
 			puts(sha1_to_hex(object_list_sha1));
