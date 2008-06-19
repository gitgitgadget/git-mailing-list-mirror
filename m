From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Wed, 18 Jun 2008 21:55:45 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806181949160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 03:57:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K99Om-0008PD-N0
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 03:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbYFSB4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 21:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbYFSB4J
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 21:56:09 -0400
Received: from iabervon.org ([66.92.72.58]:42555 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbYFSBzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 21:55:46 -0400
Received: (qmail 9741 invoked by uid 1000); 19 Jun 2008 01:55:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 01:55:45 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85441>

Once we find the absolute paths for git_dir and work_tree, we can make
git_dir a relative path since we know pwd will be work_tree. This should
save the kernel some time traversing the path to work_tree all the time
if git_dir is inside work_tree.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I think this should do what Linus wanted without losing the ability to 
have unrelated work tree and git dir locations. I'm not entirely sure if 
there's any meaningful difference between this and setting git_dir to an 
absolute path if it or work_tree is provided, and otherwise just using 
".git", but this is a relatively small and obvious change that should also 
help if the user, for some reason, specifies the directories explicitly 
such that they're in the usual relationship.

 cache.h |    1 +
 path.c  |   14 ++++++++++++++
 setup.c |    9 ++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

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
index b7c24a2..8066bbc 100644
--- a/path.c
+++ b/path.c
@@ -294,6 +294,20 @@ int adjust_shared_perm(const char *path)
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
 
+const char *make_relative_path(const char *abs, const char *base)
+{
+	static char buf[PATH_MAX + 1];
+	int baselen = strlen(base);
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
index d630e37..a4ceae9 100644
--- a/setup.c
+++ b/setup.c
@@ -284,18 +284,21 @@ static const char *set_work_tree(const char *dir)
 
 void setup_work_tree(void)
 {
-	const char *work_tree, *git_dir;
+	const char *git_dir;
+	char *work_tree;
 	static int initialized = 0;
 
 	if (initialized)
 		return;
-	work_tree = get_git_work_tree();
+	work_tree = xstrdup(make_absolute_path(get_git_work_tree()));
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
-		set_git_dir(make_absolute_path(git_dir));
+		set_git_dir(make_relative_path(make_absolute_path(git_dir),
+					       work_tree));
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
 	initialized = 1;
+	free(work_tree);
 }
 
 static int check_repository_format_gently(int *nongit_ok)
-- 
1.5.4.5
