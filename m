From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Wed, 18 Jun 2008 23:28:27 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806182327090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 05:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Apw-0002vi-12
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 05:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbYFSD23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 23:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYFSD23
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 23:28:29 -0400
Received: from iabervon.org ([66.92.72.58]:54553 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbYFSD22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 23:28:28 -0400
Received: (qmail 30172 invoked by uid 1000); 19 Jun 2008 03:28:27 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 03:28:27 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85445>

Once we find the absolute paths for git_dir and work_tree, we can make
git_dir a relative path since we know pwd will be work_tree. This should
save the kernel some time traversing the path to work_tree all the time
if git_dir is inside work_tree.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Not only was work_tree potentially NULL, it was also already a copied 
canonical path. So this simpler patch should be better.

 cache.h |    1 +
 path.c  |   17 +++++++++++++++++
 setup.c |    3 ++-
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index eab1a17..3465c94 100644
--- a/cache.h
+++ b/cache.h
@@ -524,6 +524,7 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 const char *make_absolute_path(const char *path);
+const char *make_relative_path(const char *abs, const char *base);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index b7c24a2..790d8d4 100644
--- a/path.c
+++ b/path.c
@@ -294,6 +294,23 @@ int adjust_shared_perm(const char *path)
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
 
+const char *make_relative_path(const char *abs, const char *base)
+{
+	static char buf[PATH_MAX + 1];
+	int baselen;
+	if (!base)
+		return abs;
+	baselen = strlen(base);
+	if (prefixcmp(abs, base))
+		return abs;
+	if (abs[baselen] == '/')
+		baselen++;
+	else if (base[baselen - 1] != '/')
+		return abs;
+	strcpy(buf, abs + baselen);
+	return buf;
+}
+
 const char *make_absolute_path(const char *path)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
diff --git a/setup.c b/setup.c
index d630e37..1643ee4 100644
--- a/setup.c
+++ b/setup.c
@@ -292,7 +292,8 @@ void setup_work_tree(void)
 	work_tree = get_git_work_tree();
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
-		set_git_dir(make_absolute_path(git_dir));
+		set_git_dir(make_relative_path(make_absolute_path(git_dir),
+					       work_tree));
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
 	initialized = 1;
-- 
1.5.4.5
