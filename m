From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 17:15:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 14 02:16:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0nIm-000573-80
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 02:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbYKNBPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 20:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYKNBPc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 20:15:32 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49790 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353AbYKNBPb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 20:15:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAE1FDsM028530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 17:15:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAE1FCSl012009;
	Thu, 13 Nov 2008 17:15:12 -0800
In-Reply-To: <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100942>



On Thu, 13 Nov 2008, Linus Torvalds wrote:
> 
> I'll clean it up a bit and make a less hacky version. And I'll try to make 
> it work for "git status" and friends too.

Ok, this is a no-longer-totally-hacky thing, which also adds support for 
doing the same for "git status". I haven't actually done any timings, but 
the preload algorithm is all the same. The interface is just a much more 
natural one.

NOTE NOTE NOTE! It may not be totally hacky, but it's still not 
"finished". There's a few more things to look at:

 - maybe there are other users of "read_cache()" that want to do the 
   preloading. I just did "git diff" and "git status" (where the stuff 
   that "git commit" does falls out of the status changes)

 - I do think the thing should be more configurable. The "ten threads" 
   approach makes no sense for people who have single-core CPU's and tend 
   to have their trees cached - it will just slow things down for that 
   case. So there should probably be some config option to turn this on 
   and off.

 - It would be really cool to find some way to automatically notice when 
   the tree is hot-cached and we might as well just be linear. I don't 
   know exactly what it might be, but one of the nice things is that the 
   preloading is _entirely_ optimistic, and we could just stop it in the 
   middle if we notice that there's no upside.

 - Somebody else should take a look at it in general. It may work, but 
   maybe there's something stupid I'm doing, or maybe somebody else can 
   come up with a clever thing.

So I think this is probably my last version for now, and let's see if 
others can find improvements. I'm not ashamed of it any more. There's 
still a "Hacky hack start" comment, it's about the whole config thing. 

			Linus

---
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Nov 2008 16:36:30 -0800
Subject: [PATCH] Add cache preload facility

This can do the lstat() storm in parallel, giving potentially much
improved performance for cold-cache cases or things like NFS that have
weak metadata caching.

Just use "read_cache_preload()" instead of "read_cache()" to force an
optimistic preload of the index stat data.  The function takes a
pathspec as its argument, allowing us to preload only the relevant
portion of the index.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 Makefile             |    1 +
 builtin-commit.c     |    8 ++--
 builtin-diff-files.c |    4 +-
 builtin-diff.c       |    8 ++--
 cache.h              |    2 +
 preload-index.c      |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 920cb42..8387005 100644
--- a/Makefile
+++ b/Makefile
@@ -495,6 +495,7 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += preload-index.o
 
 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
diff --git a/builtin-commit.c b/builtin-commit.c
index 93ca496..90b976e 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -225,18 +225,18 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 
 	if (interactive) {
 		interactive_add(argc, argv, prefix);
-		if (read_cache() < 0)
+		if (read_cache_preload(NULL) < 0)
 			die("index file corrupt");
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
 
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	if (*argv)
 		pathspec = get_pathspec(prefix, argv);
 
+	if (read_cache_preload(pathspec) < 0)
+		die("index file corrupt");
+
 	/*
 	 * Non partial, non as-is commit.
 	 *
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 2b578c7..5b64011 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -59,8 +59,8 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges = rev.dense_combined_merges = 1;
 
-	if (read_cache() < 0) {
-		perror("read_cache");
+	if (read_cache_preload(rev.diffopt.paths) < 0) {
+		perror("read_cache_preload");
 		return -1;
 	}
 	result = run_diff_files(&rev, options);
diff --git a/builtin-diff.c b/builtin-diff.c
index 82d4dda..b9a2b37 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -134,8 +134,8 @@ static int builtin_diff_index(struct rev_info *revs,
 	    revs->max_count != -1 || revs->min_age != -1 ||
 	    revs->max_age != -1)
 		usage(builtin_diff_usage);
-	if (read_cache() < 0) {
-		perror("read_cache");
+	if (read_cache_preload(revs->diffopt.paths) < 0) {
+		perror("read_cache_preload");
 		return -1;
 	}
 	return run_diff_index(revs, cached);
@@ -234,8 +234,8 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		revs->combine_merges = revs->dense_combined_merges = 1;
 
 	setup_work_tree();
-	if (read_cache() < 0) {
-		perror("read_cache");
+	if (read_cache_preload(revs->diffopt.paths) < 0) {
+		perror("read_cache_preload");
 		return -1;
 	}
 	result = run_diff_files(revs, options);
diff --git a/cache.h b/cache.h
index 6be60ea..c7b69e8 100644
--- a/cache.h
+++ b/cache.h
@@ -262,6 +262,7 @@ static inline void remove_name_hash(struct cache_entry *ce)
 
 #define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
+#define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
 #define write_cache(newfd, cache, entries) write_index(&the_index, (newfd))
@@ -368,6 +369,7 @@ extern int init_db(const char *template_dir, unsigned int flags);
 
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
+extern int read_index_preload(struct index_state *, const char **pathspec);
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
diff --git a/preload-index.c b/preload-index.c
new file mode 100644
index 0000000..e322c27
--- /dev/null
+++ b/preload-index.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2008 Linus Torvalds
+ */
+#include <pthread.h>
+#include "cache.h"
+
+/* Hacky hack-hack start */
+#define MAX_PARALLEL (100)
+int parallel_lstats = 1;
+
+struct thread_data {
+	pthread_t pthread;
+	struct index_state *index;
+	const char **pathspec;
+	int offset, nr;
+};
+
+static void *preload_thread(void *_data)
+{
+	int nr;
+	struct thread_data *p = _data;
+	struct index_state *index = p->index;
+	struct cache_entry **cep = index->cache + p->offset;
+
+	nr = p->nr;
+	if (nr + p->offset > index->cache_nr)
+		nr = index->cache_nr - p->offset;
+
+	do {
+		struct cache_entry *ce = *cep++;
+		struct stat st;
+
+		if (ce_stage(ce))
+			continue;
+		if (ce_uptodate(ce))
+			continue;
+		if (!ce_path_match(ce, p->pathspec))
+			continue;
+		if (lstat(ce->name, &st))
+			continue;
+		if (ie_match_stat(index, ce, &st, 0))
+			continue;
+		ce_mark_uptodate(ce);
+	} while (--nr > 0);
+	return NULL;
+}
+
+static void preload_index(struct index_state *index, const char **pathspec)
+{
+	int i, work, offset;
+	int threads = index->cache_nr / 100;
+	struct thread_data data[MAX_PARALLEL];
+
+	if (threads < 2)
+		return;
+	if (threads > MAX_PARALLEL)
+		threads = MAX_PARALLEL;
+	offset = 0;
+	work = (index->cache_nr + threads - 1) / threads;
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		p->index = index;
+		p->pathspec = pathspec;
+		p->offset = offset;
+		p->nr = work;
+		offset += work;
+		if (pthread_create(&p->pthread, NULL, preload_thread, p))
+			die("unable to create threaded lstat");
+	}
+	for (i = 0; i < threads; i++) {
+		struct thread_data *p = data+i;
+		if (pthread_join(p->pthread, NULL))
+			die("unable to join threaded lstat");
+	}
+}
+
+int read_index_preload(struct index_state *index, const char **pathspec)
+{
+	int retval = read_index(index);
+
+	preload_index(index, pathspec);
+	return retval;
+}
