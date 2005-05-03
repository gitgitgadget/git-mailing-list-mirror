From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Short-cut error return path in git-local-pull.
Date: Mon, 02 May 2005 17:26:17 -0700
Message-ID: <7vll6xnoie.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 02:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSlAI-00039K-Dk
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVECA07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVECA07
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:26:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:51381 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261250AbVECA0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2005 20:26:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503002618.MHZQ1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 2 May 2005 20:26:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When git-local-pull with -l option gets ENOENT attempting to create
a hard link, there is no point falling back to other copy methods.
This patch implements a short-cut to detect that case.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

local-pull.c |   25 ++++++++++++++++---------
1 files changed, 16 insertions(+), 9 deletions(-)

--- a/local-pull.c
+++ b/local-pull.c
@@ -39,12 +39,19 @@ int fetch(unsigned char *sha1)
 	filename[object_name_start+1] = hex[1];
 	filename[object_name_start+2] = '/';
 	strcpy(filename + object_name_start + 3, hex + 2);
-	if (use_link && !link(filename, dest_filename)) {
-		say("Hardlinked %s.\n", hex);
-		return 0;
+	if (use_link) {
+		if (!link(filename, dest_filename)) {
+			say("link %s\n", hex);
+			return 0;
+		}
+		/* If we got ENOENT there is no point continuing. */
+		if (errno == ENOENT) {
+			fprintf(stderr, "does not exist %s\n", filename);
+			return -1;
+		}
 	}
 	if (use_symlink && !symlink(filename, dest_filename)) {
-		say("Symlinked %s.\n", hex);
+		say("symlink %s\n", hex);
 		return 0;
 	}
 	if (use_filecopy) {
@@ -54,13 +61,13 @@ int fetch(unsigned char *sha1)
 		ifd = open(filename, O_RDONLY);
 		if (ifd < 0 || fstat(ifd, &st) < 0) {
 			close(ifd);
-			fprintf(stderr, "Cannot open %s\n", filename);
+			fprintf(stderr, "cannot open %s\n", filename);
 			return -1;
 		}
 		map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, ifd, 0);
 		close(ifd);
 		if (-1 == (int)(long)map) {
-			fprintf(stderr, "Cannot mmap %s\n", filename);
+			fprintf(stderr, "cannot mmap %s\n", filename);
 			return -1;
 		}
 		ofd = open(dest_filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
@@ -69,13 +76,13 @@ int fetch(unsigned char *sha1)
 		munmap(map, st.st_size);
 		close(ofd);
 		if (status)
-			fprintf(stderr, "Cannot write %s (%ld bytes)\n",
+			fprintf(stderr, "cannot write %s (%ld bytes)\n",
 				dest_filename, st.st_size);
 		else
-			say("Copied %s.\n", hex);
+			say("copy %s\n", hex);
 		return status;
 	}
-	fprintf(stderr, "No copy method was provided to copy %s.\n", hex);
+	fprintf(stderr, "failed to copy %s with given copy methods.\n", hex);
 	return -1;
 }
 

