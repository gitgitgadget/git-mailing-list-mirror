From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] git add: do not add files from a submodule
Date: Mon, 21 Jul 2008 02:58:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com> <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKjjl-0007ra-E1
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbYGUA5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755999AbYGUA5u
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:57:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:44629 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755657AbYGUA5u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:57:50 -0400
Received: (qmail invoked by alias); 21 Jul 2008 00:57:48 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp003) with SMTP; 21 Jul 2008 02:57:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p3D5WW6vprPGt85bv5fIPOBAMXBLEflMHQIaLrq
	GdfQfs9+Ic/7sU
X-X-Sender: user@eeepc-johanness
In-Reply-To: <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89284>


It comes quite as a surprise to an unsuspecting Git user that calling
"git add submodule/file" (which is a mistake, alright) _removes_
the submodule in the index, and adds the file.  Instead, complain loudly.

While at it, be nice when the user said "git add submodule/" which is
most likely the consequence of tab-completion, and stage the submodule,
instead of trying to add the contents of that directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This would need a companion patch for "git diff submodule/",
	obviously.  However, revision.c does not need a valid cache,
	usually.  So I am hesitant.

	Oh, and I am sure somebody will come up with a more elegant 
	solution to this problem.  I sure do not, having smashed my head 
	against the wall for a few hours.

 builtin-add.c              |   42 +++++++++++++++++++++++++++++++++++++++---
 t/t7400-submodule-basic.sh |   18 ++++++++++++++++++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 6f5672a..9453557 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -50,6 +50,33 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
         free(seen);
 }
 
+static void treat_gitlinks(const char **pathspec, struct index_state *index)
+{
+	int i;
+
+	if (!pathspec || !*pathspec)
+		return;
+
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+		if (S_ISGITLINK(ce->ce_mode)) {
+			int len = ce_namelen(ce), j;
+			for (j = 0; pathspec[j]; j++) {
+				int len2 = strlen(pathspec[j]);
+				if (len2 <= len || pathspec[j][len] != '/' ||
+				    memcmp(ce->name, pathspec[j], len))
+					continue;
+				if (len2 == len + 1)
+					/* strip trailing slash */
+					pathspec[j] = xstrndup(ce->name, len);
+				else
+					die ("Path '%s' is in submodule '%.*s'",
+						pathspec[j], len, ce->name);
+			}
+		}
+	}
+}
+
 static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		int ignored_too)
 {
@@ -245,6 +272,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int flags;
 	int add_new_files;
 	int require_pathspec;
+	struct index_state index;
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
@@ -283,12 +311,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	 * If we are adding new files, we need to scan the working
 	 * tree to find the ones that match pathspecs; this needs
 	 * to be done before we read the index.
+	 *
+	 * However, to avoid adding files from submodules, we have to
+	 * read the index first.  So read the index into a local
+	 * variable, and set the global index after fill_directory().
 	 */
-	if (add_new_files)
-		fill_directory(&dir, pathspec, ignored_too);
 
-	if (read_cache() < 0)
+	memset(&index, 0, sizeof(index));
+	if (read_index(&index) < 0)
 		die("index file corrupt");
+	treat_gitlinks(pathspec, &index);
+
+	if (add_new_files)
+		fill_directory(&dir, pathspec, ignored_too);
+	the_index = index;
 
 	if (refresh_only) {
 		refresh(verbose, pathspec);
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cbc0c34..6da2545 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -209,4 +209,22 @@ test_expect_success 'update --init' '
 
 '
 
+test_expect_success 'do not add files from a submodule' '
+
+	git reset --hard &&
+	test_must_fail git add init/a
+
+'
+
+test_expect_success 'gracefully add submodule with a trailing slash' '
+
+	commit=$(cd init &&
+	 echo b > a &&
+	 git commit -m update a >/dev/null &&
+	 git rev-parse HEAD) &&
+	git add init/ &&
+	test_must_fail git diff --exit-code --cached init
+
+'
+
 test_done
-- 
1.5.6.2.516.g22071
