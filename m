From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Let umask do its work upon filesystem object creation.
Date: Wed, 06 Jul 2005 01:21:46 -0700
Message-ID: <7v3bqsxs2t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 10:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq5Db-00088G-6K
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 10:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVGFIYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVGFIYe
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 04:24:34 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61907 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262226AbVGFIVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 04:21:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706082145.KZGY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 04:21:45 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

IIRC our strategy was to let the users' umask take care of the
final mode bits.  This patch fixes places that deviate from it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 apply.c        |    2 +-
 csum-file.c    |    2 +-
 entry.c        |    4 ++--
 init-db.c      |    2 +-
 receive-pack.c |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

ccb441ce2e7be11fcab19f385332c530bff132f0
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1237,7 +1237,7 @@ static void create_subdirectories(const 
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
-		if (mkdir(buf, 0755) < 0) {
+		if (mkdir(buf, 0777) < 0) {
 			if (errno != EEXIST)
 				break;
 		}
diff --git a/csum-file.c b/csum-file.c
--- a/csum-file.c
+++ b/csum-file.c
@@ -86,7 +86,7 @@ struct sha1file *sha1create(const char *
 		die("you wascally wabbit, you");
 	f->namelen = len;
 
-	fd = open(f->name, O_CREAT | O_EXCL | O_WRONLY, 0644);
+	fd = open(f->name, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0)
 		die("unable to open %s (%s)", f->name, strerror(errno));
 	f->fd = fd;
diff --git a/entry.c b/entry.c
--- a/entry.c
+++ b/entry.c
@@ -12,10 +12,10 @@ static void create_directories(const cha
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
-		if (mkdir(buf, 0755)) {
+		if (mkdir(buf, 0777)) {
 			if (errno == EEXIST) {
 				struct stat st;
-				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0755))
+				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
 					continue;
 				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
 					continue; /* ok */
diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -7,7 +7,7 @@
 
 static void safe_create_dir(const char *dir)
 {
-	if (mkdir(dir, 0755) < 0) {
+	if (mkdir(dir, 0777) < 0) {
 		if (errno != EEXIST) {
 			perror(dir);
 			exit(1);
diff --git a/receive-pack.c b/receive-pack.c
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -70,7 +70,7 @@ static void update(const char *name, uns
 	if (!has_sha1_file(new_sha1))
 		die("unpack should have generated %s, but I can't find it!", new_hex);
 
-	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0644);
+	newfd = open(lock_name, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (newfd < 0)
 		die("unable to create %s (%s)", lock_name, strerror(errno));
 
