From: Pavel Roskin <proski@gnu.org>
Subject: Re: [WIP] Status update on merge-recursive in C
Date: Sun, 09 Jul 2006 01:00:30 -0400
Message-ID: <1152421230.2103.31.camel@dv>
References: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 07:00:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzRPJ-0008Bj-Gh
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 07:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWGIFAe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 01:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWGIFAe
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 01:00:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:21206 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964976AbWGIFAd
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 01:00:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FzRPE-0004WM-C5
	for git@vger.kernel.org; Sun, 09 Jul 2006 01:00:32 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FzRPC-0001XF-4q; Sun, 09 Jul 2006 01:00:30 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23521>

Hello, Dscho!

On Sat, 2006-07-08 at 18:42 +0200, Johannes Schindelin wrote:
> This is just an update for people being interested. Alex and me were
> busy with that project for a few days now. While it has progressed nicely,
> there are quite a couple TODOs in merge-recursive.c, just search for "TODO".

That's great.  Just a few notes regarding the patch.

Why do you list "recur" twice in all_strategies in the git-merge.sh?
The second "recur" should probably be "recursive".

Test for Python in the git-rebase.sh is probably wrong.  "recur" doesn't
need Python - that's the whole point.  In fact, if I build git with
NO_PYTHON, TEST fails in t3401-rebase-partial.sh

Apart from that, the tests pass on i386, x86_64 and PowerPC, all running
Fedora Core 5.

I tries to run sparse of the C files, and it complains about two things
- variable declarations in the middle of the code (allowed by c99 but
not by ANSI C) and incomplete function declarations (no "void").  It's
not C++, let's stick to the C standards.

I'm attaching a patch that fixes everything except variable
declarations.  There are so many of them that it could be done once the
code stabilizes a bit.

It would be great to have a patch that actually removes the old
"recursive" and makes the new strategy "recursive".  I understand it's
the plan, right?

---

 git-merge.sh      |    2 +-
 git-rebase.sh     |    2 +-
 merge-recursive.c |    9 +++++----
 read-cache.c      |    2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index b26ca14..240e5ee 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -9,7 +9,7 @@ USAGE='[-n] [--no-commit] [--squash] [-s
 LF='
 '
 
-all_strategies='recur recur octopus resolve stupid ours'
+all_strategies='recur recursive octopus resolve stupid ours'
 default_twohead_strategies='recur'
 default_octopus_strategies='octopus'
 no_trivial_merge_strategies='ours'
diff --git a/git-rebase.sh b/git-rebase.sh
index 5d4c7d2..6472970 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -292,7 +292,7 @@ then
 	exit $?
 fi
 
-if test "@@NO_PYTHON@@" && test "$strategy" = "recur"
+if test "@@NO_PYTHON@@" && test "$strategy" = "recursive"
 then
 	die 'The recursive merge strategy currently relies on Python,
 which this installation of git was not configured with.  Please
consider
diff --git a/merge-recursive.c b/merge-recursive.c
index 07a2b38..1cae804 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -61,7 +61,8 @@ static void show_ce_entry(const char *ta
 	fputc('\n', stderr);
 }
 
-static void ls_files() {
+static void ls_files(void)
+{
 	int i;
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
@@ -207,7 +208,7 @@ static const char *original_index_file;
 static const char *temporary_index_file;
 static int cache_dirty = 0;
 
-static int flush_cache()
+static int flush_cache(void)
 {
 	/* flush temporary index */
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
@@ -331,7 +332,7 @@ #endif
 /*
  * TODO: this can be streamlined by refactoring builtin-write-tree.c
  */
-static struct tree *git_write_tree()
+static struct tree *git_write_tree(void)
 {
 #if 0
 	fprintf(stderr, "GIT_INDEX_FILE='%s' git-write-tree\n",
@@ -467,7 +468,7 @@ static void free_index_entries(struct pa
  * Create a dictionary mapping file names to CacheEntry objects. The
  * dictionary contains one entry for every path with a non-zero stage
entry.
  */
-static struct path_list *get_unmerged()
+static struct path_list *get_unmerged(void)
 {
 	struct path_list *unmerged = xcalloc(1, sizeof(struct path_list));
 	int i;
diff --git a/read-cache.c b/read-cache.c
index f6e1b70..0ef89a9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -797,7 +797,7 @@ unmap:
 	die("index file corrupt");
 }
 
-int discard_cache()
+int discard_cache(void)
 {
 	int ret;
 	


-- 
Regards,
Pavel Roskin
