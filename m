From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 5/9] pack-objects: get rid of reuse_cached_pack
Date: Mon, 16 Apr 2007 12:30:15 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704161229590.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdU60-0000T6-IV
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 18:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030844AbXDPQaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 12:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030866AbXDPQaS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 12:30:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61433 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030844AbXDPQaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 12:30:16 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGL00HMXN6F00G0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Apr 2007 12:30:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44670>

This capability is practically never useful, and therefore never tested,
because it is fairly unlikely that the requested pack will be already
available.  Furthermore it is of little gain over the ability to reuse
existing pack data.

In fact the ability to change delta type on the fly when reusing delta
data is a nice thing that has almost no cost and allows greater backward
compatibility with a client's capabilities than if the client is blindly
sent a whole pack without any discrimination.

And this "feature" is simply in the way of other cleanups.
Let's get rid of it.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-pack-objects.c |   86 ++++++++----------------------------------------
 1 files changed, 14 insertions(+), 72 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 15119d6..c2f7c30 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1445,60 +1445,6 @@ static void prepare_pack(int window, int depth)
 	free(delta_list);
 }
 
-static int reuse_cached_pack(unsigned char *sha1)
-{
-	static const char cache[] = "pack-cache/pack-%s.%s";
-	char *cached_pack, *cached_idx;
-	int ifd, ofd, ifd_ix = -1;
-
-	cached_pack = git_path(cache, sha1_to_hex(sha1), "pack");
-	ifd = open(cached_pack, O_RDONLY);
-	if (ifd < 0)
-		return 0;
-
-	if (!pack_to_stdout) {
-		cached_idx = git_path(cache, sha1_to_hex(sha1), "idx");
-		ifd_ix = open(cached_idx, O_RDONLY);
-		if (ifd_ix < 0) {
-			close(ifd);
-			return 0;
-		}
-	}
-
-	if (progress)
-		fprintf(stderr, "Reusing %u objects pack %s\n", nr_objects,
-			sha1_to_hex(sha1));
-
-	if (pack_to_stdout) {
-		if (copy_fd(ifd, 1))
-			exit(1);
-		close(ifd);
-	}
-	else {
-		char name[PATH_MAX];
-		snprintf(name, sizeof(name),
-			 "%s-%s.%s", base_name, sha1_to_hex(sha1), "pack");
-		ofd = open(name, O_CREAT | O_EXCL | O_WRONLY, 0666);
-		if (ofd < 0)
-			die("unable to open %s (%s)", name, strerror(errno));
-		if (copy_fd(ifd, ofd))
-			exit(1);
-		close(ifd);
-
-		snprintf(name, sizeof(name),
-			 "%s-%s.%s", base_name, sha1_to_hex(sha1), "idx");
-		ofd = open(name, O_CREAT | O_EXCL | O_WRONLY, 0666);
-		if (ofd < 0)
-			die("unable to open %s (%s)", name, strerror(errno));
-		if (copy_fd(ifd_ix, ofd))
-			exit(1);
-		close(ifd_ix);
-		puts(sha1_to_hex(sha1));
-	}
-
-	return 1;
-}
-
 static void progress_interval(int signum)
 {
 	progress_update = 1;
@@ -1618,6 +1564,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	SHA_CTX ctx;
 	int depth = 10;
 	struct object_entry **list;
+	off_t last_obj_offset;
 	int use_internal_rev_list = 0;
 	int thin = 0;
 	uint32_t i;
@@ -1779,24 +1726,19 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && (nr_objects != nr_result))
 		fprintf(stderr, "Result has %u objects.\n", nr_result);
 
-	if (reuse_cached_pack(object_list_sha1))
-		;
-	else {
-		off_t last_obj_offset;
-		if (nr_result)
-			prepare_pack(window, depth);
-		if (progress == 1 && pack_to_stdout) {
-			/* the other end usually displays progress itself */
-			struct itimerval v = {{0,},};
-			setitimer(ITIMER_REAL, &v, NULL);
-			signal(SIGALRM, SIG_IGN );
-			progress_update = 0;
-		}
-		last_obj_offset = write_pack_file();
-		if (!pack_to_stdout) {
-			write_index_file(last_obj_offset);
-			puts(sha1_to_hex(object_list_sha1));
-		}
+	if (nr_result)
+		prepare_pack(window, depth);
+	if (progress == 1 && pack_to_stdout) {
+		/* the other end usually displays progress itself */
+		struct itimerval v = {{0,},};
+		setitimer(ITIMER_REAL, &v, NULL);
+		signal(SIGALRM, SIG_IGN );
+		progress_update = 0;
+	}
+	last_obj_offset = write_pack_file();
+	if (!pack_to_stdout) {
+		write_index_file(last_obj_offset);
+		puts(sha1_to_hex(object_list_sha1));
 	}
 	if (progress)
 		fprintf(stderr, "Total %u (delta %u), reused %u (delta %u)\n",
-- 
1.5.1.1.781.g65e8
