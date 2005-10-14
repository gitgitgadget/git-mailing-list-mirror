From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Ignore funny refname sent from remote
Date: Thu, 13 Oct 2005 23:03:43 -0700
Message-ID: <7virw0ws74.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 14 08:04:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQIfk-0003RF-UL
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 08:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVJNGDp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 02:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVJNGDp
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 02:03:45 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23025 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932211AbVJNGDp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2005 02:03:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051014060323.NDGF776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Oct 2005 02:03:23 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10101>

This allows the remote side (most notably, upload-pack) to show
additional information without affecting the downloader.  Peek-remote
does not ignore them -- this is to make it useful for Pasky's
automatic tag following.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is a preparation for the next one, which starts sending
   out extra "refs" from upload-pack.  Normal client side should
   not get affected by those extra info.

 cache.h       |    2 +-
 clone-pack.c  |    2 +-
 connect.c     |    8 +++++++-
 fetch-pack.c  |    2 +-
 peek-remote.c |    2 +-
 send-pack.c   |    2 +-
 6 files changed, 12 insertions(+), 6 deletions(-)

applies-to: c0f2aa6e25a9291830ddd86acfc569fd33077ec6
60b2e010ba8dd4c24fe6ef7bfc1ee3185ac2cf52
diff --git a/cache.h b/cache.h
index 3286582..8aa63cc 100644
--- a/cache.h
+++ b/cache.h
@@ -339,7 +339,7 @@ extern int path_match(const char *path, 
 extern int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 		      int nr_refspec, char **refspec, int all);
 extern int get_ack(int fd, unsigned char *result_sha1);
-extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match);
+extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, int ignore_funny);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1);
 extern struct packed_git *parse_pack_index_file(const unsigned char *sha1,
diff --git a/clone-pack.c b/clone-pack.c
index 0ea7e7f..f9b263a 100644
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -287,7 +287,7 @@ static int clone_pack(int fd[2], int nr_
 	struct ref *refs;
 	int status;
 
-	get_remote_heads(fd[0], &refs, nr_match, match);
+	get_remote_heads(fd[0], &refs, nr_match, match, 1);
 	if (!refs) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
diff --git a/connect.c b/connect.c
index b157cf1..b6732f6 100644
--- a/connect.c
+++ b/connect.c
@@ -10,7 +10,8 @@
 /*
  * Read all the refs from the other end
  */
-struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match)
+struct ref **get_remote_heads(int in, struct ref **list,
+			      int nr_match, char **match, int ignore_funny)
 {
 	*list = NULL;
 	for (;;) {
@@ -29,6 +30,11 @@ struct ref **get_remote_heads(int in, st
 		if (len < 42 || get_sha1_hex(buffer, old_sha1) || buffer[40] != ' ')
 			die("protocol error: expected sha/ref, got '%s'", buffer);
 		name = buffer + 41;
+
+		if (ignore_funny && 45 < len && !memcmp(name, "refs/", 5) &&
+		    check_ref_format(name + 5))
+			continue;
+
 		if (nr_match && !path_match(name, nr_match, match))
 			continue;
 		ref = xcalloc(1, sizeof(*ref) + len - 40);
diff --git a/fetch-pack.c b/fetch-pack.c
index 582f967..953c0cf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -81,7 +81,7 @@ static int fetch_pack(int fd[2], int nr_
 	int status;
 	pid_t pid;
 
-	get_remote_heads(fd[0], &ref, nr_match, match);
+	get_remote_heads(fd[0], &ref, nr_match, match, 1);
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
diff --git a/peek-remote.c b/peek-remote.c
index 4b1d0d5..ee49bf3 100644
--- a/peek-remote.c
+++ b/peek-remote.c
@@ -11,7 +11,7 @@ static int peek_remote(int fd[2])
 {
 	struct ref *ref;
 
-	get_remote_heads(fd[0], &ref, 0, NULL);
+	get_remote_heads(fd[0], &ref, 0, NULL, 0);
 	packet_flush(fd[1]);
 
 	while (ref) {
diff --git a/send-pack.c b/send-pack.c
index 55d8ff7..9f9a6e7 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -181,7 +181,7 @@ static int send_pack(int in, int out, in
 	int new_refs;
 
 	/* No funny business with the matcher */
-	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL);
+	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, 1);
 	get_local_heads();
 
 	/* match them up */
---
@@GIT_VERSION@@
