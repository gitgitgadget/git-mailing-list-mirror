From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] clone-pack.c:write_one_ref() - Create leading directories.
Date: Wed, 06 Jul 2005 01:11:52 -0700
Message-ID: <7vfyusxsjb.fsf@assigned-by-dhcp.cox.net>
References: <7voe9gxw7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 10:14:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq52p-0006o2-Ur
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 10:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVGFINh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 04:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVGFINC
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 04:13:02 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:52452 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262157AbVGFIL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 04:11:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706081152.GVWY23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 04:11:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7voe9gxw7y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue, 05 Jul 2005 23:52:17 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The function write_one_ref() is passed the list of refs received
from the other end, which was obtained by directory traversal
under $GIT_DIR/refs; this can contain paths other than what
git-init-db prepares and would fail to clone when there is
such.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 cache.h      |    2 ++
 clone-pack.c |    5 ++++-
 sha1_file.c  |   19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletions(-)

dfad9e5e585c1c9e1eaf599878f040f7ae519b18
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -161,6 +161,8 @@ extern void rollback_index_file(struct c
 extern char *git_path(const char *fmt, ...);
 extern char *sha1_file_name(const unsigned char *sha1);
 
+int safe_create_leading_directories(char *path);
+
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern void * map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(z_stream *stream, void *map, unsigned long mapsize, void *buffer, unsigned long size);
diff --git a/clone-pack.c b/clone-pack.c
--- a/clone-pack.c
+++ b/clone-pack.c
@@ -68,9 +68,12 @@ static int is_master(struct ref *ref)
 static void write_one_ref(struct ref *ref)
 {
 	char *path = git_path(ref->name);
-	int fd = open(path, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	int fd;
 	char *hex;
 
+	if (safe_create_leading_directories(path))
+		die("unable to create leading directory for %s", ref->name);
+	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0)
 		die("unable to create ref %s", ref->name);
 	hex = sha1_to_hex(ref->sha1);
diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -130,6 +130,25 @@ char *git_path(const char *fmt, ...)
 	return ret;
 }
 
+int safe_create_leading_directories(char *path)
+{
+	char *pos = path;
+
+	while (pos) {
+		pos = strchr(pos, '/');
+		if (!pos)
+			break;
+		*pos = 0;
+		if (mkdir(path, 0777) < 0)
+			if (errno != EEXIST) {
+				*pos = '/';
+				return -1;
+			}
+		*pos++ = '/';
+	}
+	return 0;
+}
+
 int get_sha1(const char *str, unsigned char *sha1)
 {
 	static const char *prefix[] = {
