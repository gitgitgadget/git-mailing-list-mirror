From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Finally implement "git log --follow"
Date: Tue, 19 Jun 2007 14:22:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 19 23:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0lAA-0007J5-OG
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 23:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXFSVW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 17:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbXFSVW5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 17:22:57 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41042 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbXFSVW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2007 17:22:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5JLMqNc007026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Jun 2007 14:22:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5JLMkOm021516;
	Tue, 19 Jun 2007 14:22:46 -0700
X-Spam-Status: No, hits=-5.506 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50512>


Ok, I've really held off doing this too damn long, because I'm lazy, and I 
was always hoping that somebody else would do it.

But no, people keep asking for it, but nobody actually did anything, so I 
decided I might as well bite the bullet, and instead of telling people 
they could add a "--follow" flag to "git log" to do what they want to do, 
I decided that it looks like I just have to do it for them..

The code wasn't actually that complicated, in that the diffstat for this 
patch literally says "70 insertions(+), 1 deletions(-)", but I will have 
to admit that in order to get to this fairly simple patch, you did have to 
know and understand the internal git diff generation machinery pretty 
well, and had to really be able to follow how commit generation interacts 
with generating patches and generating the log.

So I suspect that while I was right that it wasn't that hard, I might have 
been expecting too much of random people - this patch does seem to be 
firmly in the core "Linus or Junio" territory.

To make a long story short: I'm sorry for it taking so long until I just 
did it.

I'm not going to guarantee that this works for everybody, but you really 
can just look at the patch, and after the appropriate appreciative noises 
("Ooh, aah") over how clever I am, you can then just notice that the code 
itself isn't really that complicated.

All the real new code is in the new "try_to_follow_renames()" function. It 
really isn't rocket science: we notice that the pathname we were looking 
at went away, so we start a full tree diff and try to see if we can 
instead make that pathname be a rename or a copy from some other previous 
pathname. And if we can, we just continue, except we show *that* 
particular diff, and ever after we use the _previous_ pathname.

One thing to look out for: the "rename detection" is considered to be a 
singular event in the _linear_ "git log" output! That's what people want 
to do, but I just wanted to point out that this patch is *not* carrying 
around a "commit,pathname" kind of pair and it's *not* going to be able to 
notice the file coming from multiple *different* files in earlier history.

IOW, if you use "git log --follow", then you get the stupid CVS/SVN kind 
of "files have single identities" kind of semantics, and git log will just 
pick the identity based on the normal move/copy heuristics _as_if_ the 
history could be linearized.

Put another way: I think the model is broken, but given the broken model, 
I think this patch does just about as well as you can do. If you have 
merges with the same "file" having different filenames over the two 
branches, git will just end up picking _one_ of the pathnames at the point 
where the newer one goes away. It never looks at multiple pathnames in 
parallel.

And if you understood all that, you probably didn't need it explained, and 
if you didn't understand the above blathering, it doesn't really mtter to 
you. What matters to you is that you can now do

	git log -p --follow builtin-rev-list.c

and it will find the point where the old "rev-list.c" got renamed to 
"builtin-rev-list.c" and show it as such.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
----

NOTE! For obvious enough reasons, I limited the rename following to just 
*one* pathname. If somebody wants to extend it to any more, be my guest.

Also, I really might have some silly bug somewhere.

"It Works For Me(tm)", and I tested it with both the git archive and the 
kernel (block/ll_rw_block.c) and it worked beautifully, but I'll also 
admit that the patch is a bit _too_ clever for my taste normally. The 
patch actually looks more straightforward than it really is: that "hook 
directly into diff_tree_sha1()" thing is just too damn clever for words.

People who want to improve on it should get rid of the memory leak I 
introduced - I decided to not bother cleaning up the whole rename diff 
queue, I just reset it. I'm lazy, and I'm a *man*. I do the rough manly 
stuff, others can clean up after me.

*Burp*. That hit the spot. *Scratch*

		Linus

---
 builtin-log.c |    5 ++++
 diff.c        |    2 +
 diff.h        |    1 +
 revision.c    |    4 ++-
 tree-diff.c   |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 0aede76..a26a010 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -58,6 +58,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
+	if (rev->diffopt.follow_renames) {
+		rev->always_show_header = 0;
+		if (rev->diffopt.nr_paths != 1)
+			usage("git logs can only follow renames on one pathname at a time");
+	}
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
diff --git a/diff.c b/diff.c
index 4aa9bbc..9938969 100644
--- a/diff.c
+++ b/diff.c
@@ -2210,6 +2210,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--find-copies-harder"))
 		options->find_copies_harder = 1;
+	else if (!strcmp(arg, "--follow"))
+		options->follow_renames = 1;
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (!prefixcmp(arg, "--abbrev=")) {
diff --git a/diff.h b/diff.h
index a7ee6d8..9fd6d44 100644
--- a/diff.h
+++ b/diff.h
@@ -55,6 +55,7 @@ struct diff_options {
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1,
+		 follow_renames:1,
 		 color_diff:1,
 		 color_diff_words:1,
 		 has_changes:1,
diff --git a/revision.c b/revision.c
index 1f4590b..7834bb1 100644
--- a/revision.c
+++ b/revision.c
@@ -1230,7 +1230,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 	if (revs->prune_data) {
 		diff_tree_setup_paths(revs->prune_data, &revs->pruning);
-		revs->prune_fn = try_to_simplify_commit;
+		/* Can't prune commits with rename following: the paths change.. */
+		if (!revs->diffopt.follow_renames)
+			revs->prune_fn = try_to_simplify_commit;
 		if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 	}
diff --git a/tree-diff.c b/tree-diff.c
index 852498e..42924e9 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "tree.h"
 
 static char *malloc_base(const char *base, int baselen, const char *path, int pathlen)
@@ -290,6 +291,59 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 	return 0;
 }
 
+/*
+ * Does it look like the resulting diff might be due to a rename?
+ *  - single entry
+ *  - not a valid previous file
+ */
+static inline int diff_might_be_rename(void)
+{
+	return diff_queued_diff.nr == 1 &&
+		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
+}
+
+static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
+{
+	struct diff_options diff_opts;
+	const char *paths[2];
+	int i;
+
+	diff_setup(&diff_opts);
+	diff_opts.recursive = 1;
+	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_opts.single_follow = opt->paths[0];
+	paths[0] = NULL;
+	diff_tree_setup_paths(paths, &diff_opts);
+	if (diff_setup_done(&diff_opts) < 0)
+		die("unable to set up diff options to follow renames");
+	diff_tree(t1, t2, base, &diff_opts);
+	diffcore_std(&diff_opts);
+
+	/* NOTE! Ignore the first diff! That was the old one! */
+	for (i = 1; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p = diff_queued_diff.queue[i];
+
+		/*
+		 * Found a source? Not only do we use that for the new
+		 * diff_queued_diff, we also use that as the path in
+		 * the future!
+		 */
+		if ((p->status == 'R' || p->status == 'C') && !strcmp(p->two->path, opt->paths[0])) {
+			diff_queued_diff.queue[0] = p;
+			opt->paths[0] = xstrdup(p->one->path);
+			diff_tree_setup_paths(opt->paths, opt);
+			break;
+		}
+	}
+
+	/*
+	 * Then, ignore any but the first entry! It might be the old one,
+	 * or it might be the rename/copy we found
+	 */
+	diff_queued_diff.nr = 1;
+}
+
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
 {
 	void *tree1, *tree2;
@@ -306,6 +360,11 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
 	retval = diff_tree(&t1, &t2, base, opt);
+	if (opt->follow_renames && diff_might_be_rename()) {
+		init_tree_desc(&t1, tree1, size1);
+		init_tree_desc(&t2, tree2, size2);
+		try_to_follow_renames(&t1, &t2, base, opt);
+	}
 	free(tree1);
 	free(tree2);
 	return retval;
