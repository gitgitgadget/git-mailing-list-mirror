From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Sat, 12 Jan 2008 20:04:22 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kristian H?gsberg <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 05:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDu6b-00085n-Dq
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 05:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbYAMEFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 23:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYAMEFJ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 23:05:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56249 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752968AbYAMEFH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 23:05:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0D44Qr7019185
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jan 2008 20:04:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0D44NfX027906;
	Sat, 12 Jan 2008 20:04:25 -0800
In-Reply-To: <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.12 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_42,J_CHICKENPOX_45,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70366>



On Sat, 12 Jan 2008, Linus Torvalds wrote:
> 
> HOWEVER. When that logic was converted from that shell-script into a 
> builtin-commit.c, that conversion was not done correctly. The old "git 
> read-tree -i -m" was not translated as a "unpack_trees()" call, but as 
> this in prepare_index():
> 
> 	discard_cache()
> 	..
> 	tree = parse_tree_indirect(head_sha1);
> 	..
> 	read_tree(tree, 0, NULL)
> 
> which is very wrong, because it replaces the old index entirely, and 
> doesn't do that stat information merging.

This patch may or may not fix it.

It makes builtin-commit.c use the same logic that "git read-tree -i -m" 
does (which is what the old shell script did), and it seems to pass the 
test-suite, and it looks pretty obvious.

It also brings down the number of open/mmap/munmap/close calls to where it 
should be, although it still does *way* too many "lstat()" operations (ie 
it does 4*lstat for each file in the index - one more than the 
non-filename one does).

With that fixed, performance is also roughly where it should be (ie the 
17-18s for the cold-cache case), because it no longer needs to rehash all 
the files!

HOWEVER. This was just a quick hack, and while it all looks sane, this is 
some damn core code. Somebody else should double- and triple-check this.

[ That 4x lstat thing bothers me. I think we should add a flag to the 
  index saying "we checked this once already, it's clean", so that if we 
  do multiple passes over the index, we can still do just a single lstat() 
  on just the first pass. But that's a separate issue.

  On Linux, a cached lstat() is almost free. Well, at least compared to 
  all the crap operating systems out there. And obviously, if you do 
  multiple lstat's per file, all but the first one *will* be cached.

  However, "almost free" still isn't zero, and with the kernel having 23k 
  files in it, doing almost a hundred thousand lstat's is still something 
  that only takes about half a second or so for me. We _really_ should do 
  only ~23k or so of them, and the cached cache should take on the order 
  of 0.15s, rather than half a second!

  So this is worth optimizing. With bigger repositories, it's going to be 
  more noticeable, and with other operating systems, all those lstat()'s 
  will cost much _much_ more. Of course, any IO overhead will be much 
  bigger, so this is mostly a cached-case issue, but cached-case is still 
  important.. ]

Anyway, consider this being conditionally signed-off-by: me, assuming 
a few other people spend a bit of time double-checking all my logic.

Please?

			Linus

---
 builtin-commit.c |   37 ++++++++++++++++++++++++++++---------
 1 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..cc5134e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -21,6 +21,7 @@
 #include "utf8.h"
 #include "parse-options.h"
 #include "path-list.h"
+#include "unpack-trees.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git-commit [options] [--] <filepattern>...",
@@ -177,10 +178,34 @@ static void add_remove_files(struct path_list *list)
 	}
 }
 
+static void create_base_index(void)
+{
+	struct tree *tree;
+	struct unpack_trees_options opts;
+	struct tree_desc t;
+
+	if (initial_commit) {
+		discard_cache();
+		return;
+	}
+
+	memset(&opts, 0, sizeof(opts));
+	opts.head_idx = 1;
+	opts.index_only = 1;
+	opts.merge = 1;
+	
+	opts.fn = oneway_merge;
+	tree = parse_tree_indirect(head_sha1);
+	if (!tree)
+		die("failed to unpack HEAD tree object");
+	parse_tree(tree);
+	init_tree_desc(&t, tree->buffer, tree->size);
+	unpack_trees(1, &t, &opts);
+}
+
 static char *prepare_index(int argc, const char **argv, const char *prefix)
 {
 	int fd;
-	struct tree *tree;
 	struct path_list partial;
 	const char **pathspec = NULL;
 
@@ -278,14 +303,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 
 	fd = hold_lock_file_for_update(&false_lock,
 				       git_path("next-index-%d", getpid()), 1);
-	discard_cache();
-	if (!initial_commit) {
-		tree = parse_tree_indirect(head_sha1);
-		if (!tree)
-			die("failed to unpack HEAD tree object");
-		if (read_tree(tree, 0, NULL))
-			die("failed to read HEAD tree object");
-	}
+
+	create_base_index();
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 
