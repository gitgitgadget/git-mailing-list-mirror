From: Junio C Hamano <junkio@cox.net>
Subject: Use the same move_temp_to_file in git-http-fetch.
Date: Sun, 09 Oct 2005 03:42:28 -0700
Message-ID: <7vd5mfezu3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org>
	<Pine.LNX.4.63.0510072124290.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 12:42:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOYdV-0005xE-0E
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 12:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVJIKma (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 06:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVJIKma
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 06:42:30 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64691 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932256AbVJIKm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2005 06:42:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051009104230.WJVR9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Oct 2005 06:42:30 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9862>

The http commit walker cannot use the same temporary file
creation code because it needs to use predictable temporary
filename for partial fetch continuation purposes, but the code
to move the temporary file to the final location should be
usable from the ordinary object creation case.

Export move_temp_to_file from sha1_file.c and use it, while
losing the custom relink_or_rename function from http-fetch.c.

Also the temporary object file creation part needs to make sure
the leading path exists, in preparation of the really lazy
fan-out directory creation.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Daniel Barkalow <barkalow@iabervon.org> writes:

    > This looks right to me, but it would be nice to also split out and 
    > share the temp file creation. Also, http-fetch.c writes object files and 
    > needs at least move_temp_to_file() if it's going to do special stuff.

    I agree.  The proposed updates branch has this patch.

 cache.h      |    1 +
 http-fetch.c |   47 ++++++++++++++++++-----------------------------
 sha1_file.c  |    2 +-
 3 files changed, 20 insertions(+), 30 deletions(-)

applies-to: f3741b89b850db8d343d3cde58416e076964c952
07d374bffd6fcd0c67c671902dde9402335776f5
diff --git a/cache.h b/cache.h
index 5987d4c..28077fc 100644
--- a/cache.h
+++ b/cache.h
@@ -221,6 +221,7 @@ extern int read_tree(void *buffer, unsig
 extern int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 			      size_t bufsize, size_t *bufposn);
 extern int write_sha1_to_fd(int fd, const unsigned char *sha1);
+extern int move_temp_to_file(const char *tmpfile, char *filename);
 
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
diff --git a/http-fetch.c b/http-fetch.c
index 5d0e3e3..c617583 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -138,25 +138,6 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
-int relink_or_rename(char *old, char *new) {
-	int ret;
-
-	ret = link(old, new);
-	if (ret < 0) {
-		/* Same Coda hack as in write_sha1_file(sha1_file.c) */
-		ret = errno;
-		if (ret == EXDEV && !rename(old, new))
-			return 0;
-	}
-	unlink(old);
-	if (ret) {
-		if (ret != EEXIST)
-			return ret;
-	}
-
-	return 0;
-}
-
 #ifdef USE_CURL_MULTI
 void process_curl_messages();
 void process_request_queue();
@@ -295,6 +276,20 @@ void start_request(struct transfer_reque
 
 	request->local = open(request->tmpfile,
 			      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	/* This could have failed due to the "lazy directory creation";
+	 * try to mkdir the last path component.
+	 */
+	if (request->local < 0 && errno == ENOENT) {
+		char *dir = strrchr(request->tmpfile, '/');
+		if (dir) {
+			*dir = 0;
+			mkdir(request->tmpfile, 0777);
+			*dir = '/';
+		}
+		request->local = open(request->tmpfile,
+				      O_WRONLY | O_CREAT | O_EXCL, 0666);
+	}
+
 	if (request->local < 0) {
 		request->state = ABORTED;
 		error("Couldn't create temporary file %s for %s: %s\n",
@@ -408,7 +403,7 @@ void finish_request(struct transfer_requ
 		return;
 	}
 	request->rename =
-		relink_or_rename(request->tmpfile, request->filename);
+		move_temp_to_file(request->tmpfile, request->filename);
 
 	if (request->rename == 0)
 		pull_say("got %s\n", sha1_to_hex(request->sha1));
@@ -599,12 +594,7 @@ static int fetch_index(struct alt_base *
 
 	fclose(indexfile);
 
-	ret = relink_or_rename(tmpfile, filename);
-	if (ret)
-		return error("unable to write index filename %s: %s",
-			     filename, strerror(ret));
-
-	return 0;
+	return move_temp_to_file(tmpfile, filename);
 }
 
 static int setup_index(struct alt_base *repo, unsigned char *sha1)
@@ -869,10 +859,9 @@ static int fetch_pack(struct alt_base *r
 
 	fclose(packfile);
 
-	ret = relink_or_rename(tmpfile, filename);
+	ret = move_temp_to_file(tmpfile, filename);
 	if (ret)
-		return error("unable to write pack filename %s: %s",
-			     filename, strerror(ret));
+		return ret;
 
 	lst = &repo->packs;
 	while (*lst != target)
diff --git a/sha1_file.c b/sha1_file.c
index baaa4c0..6e3ea23 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1287,7 +1287,7 @@ static int link_temp_to_file(const char 
 /*
  * Move the just written object into its final resting place
  */
-static int move_temp_to_file(const char *tmpfile, char *filename)
+int move_temp_to_file(const char *tmpfile, char *filename)
 {
 	int ret = link_temp_to_file(tmpfile, filename);
 	if (ret) {
---
0.99.8.GIT
