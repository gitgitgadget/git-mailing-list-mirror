From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [ALTERNATIVE PATCH] diff file1 file2: do not default to --no-index
 inside a git repository
Date: Fri, 23 May 2008 23:50:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805232349410.30431@racer>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com> <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org> <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org> <7vbq2wsxnk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805232309350.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 00:51:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzg6V-0000qK-OK
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 00:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337AbYEWWuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 18:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbYEWWuX
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 18:50:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:35711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753327AbYEWWuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 18:50:22 -0400
Received: (qmail invoked by alias); 23 May 2008 22:50:20 -0000
Received: from R06fc.r.pppool.de (EHLO racer.local) [89.54.6.252]
  by mail.gmx.net (mp041) with SMTP; 24 May 2008 00:50:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18P/MMi++gPiJxx1aZ57NY9RVlEvyQP6lRNOcGChH
	G0nSHa8Ld2CYv4
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0805232309350.30431@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82768>


When calling "diff -- a b" where a exists in the index, but b does not,
do not default to --no-index inside a git repository.

For example,

	git mv a b && git diff a b

would not have the expected result.

Noticed by Catalin Marinas, diagnosed by Linus.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 23 May 2008, Johannes Schindelin wrote:

	> 	Hey, but if you disagree, just rip it out.  Actually, I 
	> 	did that already, and will reply with that alternative patch.

	Here it goes.


 diff-lib.c                                         |   43 --------------------
 t/t4013-diff-various.sh                            |    3 +-
 t/t4013/diff.diff_--name-status_dir2_dir           |    1 -
 .../diff.diff_--no-index_--name-status_dir2_dir    |    3 +
 t/t4018-diff-funcname.sh                           |    8 ++--
 t/t5400-send-pack.sh                               |    2 +-
 6 files changed, 10 insertions(+), 50 deletions(-)
 create mode 100644 t/t4013/diff.diff_--no-index_--name-status_dir2_dir

diff --git a/diff-lib.c b/diff-lib.c
index fe2ccec..ee2c16a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -144,36 +144,6 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
-/*
- * Does the path name a blob in the working tree, or a directory
- * in the working tree?
- */
-static int is_in_index(const char *path)
-{
-	int len, pos;
-	struct cache_entry *ce;
-
-	len = strlen(path);
-	while (path[len-1] == '/')
-		len--;
-	if (!len)
-		return 1; /* "." */
-	pos = cache_name_pos(path, len);
-	if (0 <= pos)
-		return 1;
-	pos = -1 - pos;
-	while (pos < active_nr) {
-		ce = active_cache[pos++];
-		if (ce_namelen(ce) <= len ||
-		    strncmp(ce->name, path, len) ||
-		    (ce->name[len] > '/'))
-			break; /* path cannot be a prefix */
-		if (ce->name[len] == '/')
-			return 1;
-	}
-	return 0;
-}
-
 static int handle_diff_files_args(struct rev_info *revs,
 				  int argc, const char **argv,
 				  unsigned int *options)
@@ -201,19 +171,6 @@ static int handle_diff_files_args(struct rev_info *revs,
 		argv++; argc--;
 	}
 
-	if (revs->max_count == -1 && revs->diffopt.nr_paths == 2) {
-		/*
-		 * If two files are specified, and at least one is untracked,
-		 * default to no-index.
-		 */
-		read_cache();
-		if (!is_in_index(revs->diffopt.paths[0]) ||
-					!is_in_index(revs->diffopt.paths[1])) {
-			revs->max_count = -2;
-			DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
-		}
-	}
-
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * rev.max_count is reasonable (0 <= n <= 3),
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 6b4d1c5..1ce05da 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -112,7 +112,7 @@ do
 		} >"$actual" &&
 		if test -f "$expect"
 		then
-			git diff "$expect" "$actual" &&
+			git diff --no-index "$expect" "$actual" &&
 			rm -f "$actual"
 		else
 			# this is to help developing new tests.
@@ -257,6 +257,7 @@ diff --patch-with-raw initial..side
 diff --patch-with-stat -r initial..side
 diff --patch-with-raw -r initial..side
 diff --name-status dir2 dir
+diff --no-index --name-status dir2 dir
 EOF
 
 test_done
diff --git a/t/t4013/diff.diff_--name-status_dir2_dir b/t/t4013/diff.diff_--name-status_dir2_dir
index ef7fdb7..d0d96aa 100644
--- a/t/t4013/diff.diff_--name-status_dir2_dir
+++ b/t/t4013/diff.diff_--name-status_dir2_dir
@@ -1,3 +1,2 @@
 $ git diff --name-status dir2 dir
-A	dir/sub
 $
diff --git a/t/t4013/diff.diff_--no-index_--name-status_dir2_dir b/t/t4013/diff.diff_--no-index_--name-status_dir2_dir
new file mode 100644
index 0000000..6a47584
--- /dev/null
+++ b/t/t4013/diff.diff_--no-index_--name-status_dir2_dir
@@ -0,0 +1,3 @@
+$ git diff --no-index --name-status dir2 dir
+A	dir/sub
+$
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index f9db81d..6d3ef6c 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -33,13 +33,13 @@ EOF
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
 test_expect_success 'default behaviour' '
-	git diff Beer.java Beer-correct.java |
+	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public class Beer"
 '
 
 test_expect_success 'preset java pattern' '
 	echo "*.java diff=java" >.gitattributes &&
-	git diff Beer.java Beer-correct.java |
+	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public static void main("
 '
 
@@ -48,13 +48,13 @@ git config diff.java.funcname '!static
 [^ 	].*s.*'
 
 test_expect_success 'custom pattern' '
-	git diff Beer.java Beer-correct.java |
+	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ int special;$"
 '
 
 test_expect_success 'last regexp must not be negated' '
 	git config diff.java.funcname "!static" &&
-	! git diff Beer.java Beer-correct.java
+	! git diff --no-index Beer.java Beer-correct.java
 '
 
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index af8d5a3..846534e 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -110,7 +110,7 @@ test_expect_success \
 	cd .. &&
 	git update-ref refs/heads/master master^ || return 1
 	git-send-pack --force ./victim/.git/ master && return 1
-	! git diff .git/refs/heads/master victim/.git/refs/heads/master
+	! git diff --no-index .git/refs/heads/master victim/.git/refs/heads/master
 '
 
 test_expect_success \
-- 
1.5.5.1.553.ga1dd7.dirty
