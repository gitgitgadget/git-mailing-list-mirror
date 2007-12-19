From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Wed, 19 Dec 2007 13:40:27 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712191334460.23902@racer.site>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> 
 <20071218204623.GC2875@steel.home>  <200712182224.28152.jnareb@gmail.com> 
 <20071218222032.GH2875@steel.home>  <Pine.LNX.4.64.0712182239500.23902@racer.site>
  <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com> 
 <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
 <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 14:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4zAg-0003cy-Iv
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 14:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbXLSNkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 08:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbXLSNkq
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 08:40:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:39942 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752442AbXLSNkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 08:40:45 -0500
Received: (qmail invoked by alias); 19 Dec 2007 13:40:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 19 Dec 2007 14:40:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NsiErNifNJrfSuZ2FGxHNXKDYPcEAiAqvnspARp
	pR09pep6S8EZB2
X-X-Sender: gene099@racer.site
In-Reply-To: <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68905>


When you are in a deeply-nested directory structure, and just want
to reference a blob in a past revision, it can be pretty slow to
type out "HEAD~29:/bla/blub/.../that-file".

This patch makes "HEAD~29:./that-file" substitute the current prefix
for "./".  If there is not working directory, the prefix is empty.

Note that this patch does not handle "../", and neither do I plan to.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 18 Dec 2007, Dana How wrote:

	> On Dec 18, 2007 5:16 PM, Linus Torvalds 
	>			<torvalds@linux-foundation.org> wrote:
	> > On Tue, 18 Dec 2007, Dana How wrote:
	> >
	> > > The cases we are talking about are all subtrees of the 
	> > > working tree. There is a useful cwd suffix.
	> >
	> > No.
	> >
	> > The cases we're talking of are *not* subtrees of the working 
	> > tree.
	> >
	> > The SHA1 of a commit may well be a totally disjoint tree. Try 
	> > it in the git repository with something like
	> 
	> Agreed,  but note you wrote *may*.

	Okay, this is a proposed patch.  It leaves the existing 
	"HEAD:<path>" handling alone, and only touches "HEAD:./<path>", 
	which would have been invalid anyway (except if you hacked your 
	objects database to include a tree named ".").

	Note: this patch is not meant for application directly.  It should 
	be split into get_current_prefix() as one patch, and the 
	sha1_name.c stuff as the second.  (Not only to boost my ohloh 
	statistics, but because they are logically two separate things.)

	Note, too: this is a quick and little-bit-dirty patch, not well 
	tested.  Particularly, I was unable to trigger the "No <path> in 
	<rev>" error path, so I am not confident that this handling is 
	correct.

	Note also: in contrast to Alex' approach, this will not only work 
	for git-show, but for all callers of get_sha1().

 cache.h     |    1 +
 setup.c     |   16 +++++++++++++---
 sha1_name.c |   17 ++++++++++++++---
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..83a2c31 100644
--- a/cache.h
+++ b/cache.h
@@ -225,6 +225,7 @@ extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern const char *get_git_work_tree(void);
+extern const char *get_current_prefix(void);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/setup.c b/setup.c
index b59dbe7..fb9b680 100644
--- a/setup.c
+++ b/setup.c
@@ -3,6 +3,12 @@
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
+static const char *current_prefix;
+
+const char *get_current_prefix()
+{
+	return current_prefix;
+}
 
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
@@ -267,6 +273,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				/* config may override worktree */
 				if (check_repository_format_gently(nongit_ok))
 					return NULL;
+				current_prefix = retval;
 				return retval;
 			}
 			if (check_repository_format_gently(nongit_ok))
@@ -279,7 +286,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			if (chdir(work_tree_env) < 0)
 				die ("Could not chdir to %s", work_tree_env);
 			strcat(buffer, "/");
-			return retval;
+			current_prefix = retval;
+			return current_prefix;
 		}
 		if (nongit_ok) {
 			*nongit_ok = 1;
@@ -339,7 +347,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	offset++;
 	cwd[len++] = '/';
 	cwd[len] = 0;
-	return cwd + offset;
+	current_prefix = cwd + offset;
+	return current_prefix;
 }
 
 int git_config_perm(const char *var, const char *value)
@@ -396,7 +405,8 @@ const char *setup_git_directory(void)
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
 		rel = get_relative_cwd(buffer, PATH_MAX, get_git_work_tree());
-		return rel && *rel ? strcat(rel, "/") : NULL;
+		current_prefix = rel && *rel ? strcat(rel, "/") : NULL;
+		return current_prefix;
 	}
 
 	return retval;
diff --git a/sha1_name.c b/sha1_name.c
index 13e1164..6f61d26 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -712,9 +712,20 @@ int get_sha1_with_mode(const char *name, unsigned char *sha1, unsigned *mode)
 	}
 	if (*cp == ':') {
 		unsigned char tree_sha1[20];
-		if (!get_sha1_1(name, cp-name, tree_sha1))
-			return get_tree_entry(tree_sha1, cp+1, sha1,
-					      mode);
+		if (!get_sha1_1(name, cp-name, tree_sha1)) {
+			const char *prefix;
+			if (!prefixcmp(cp + 1, "./") &&
+					(prefix = get_current_prefix())) {
+				unsigned char subtree_sha1[20];
+				if (get_tree_entry(tree_sha1, prefix,
+							subtree_sha1, mode))
+					return error("No '%s' in '%.*s'",
+							prefix, cp-name, name);
+				memcpy(tree_sha1, subtree_sha1, 20);
+				cp += 2;
+			}
+			return get_tree_entry(tree_sha1, cp+1, sha1, mode);
+		}
 	}
 	return ret;
 }
-- 
1.5.4.rc0.72.g536e9
