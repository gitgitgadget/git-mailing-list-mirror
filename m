From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 08:49:48 -0400
Message-ID: <20100512124948.GA11761@coredump.intra.peff.net>
References: <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
 <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
 <20100508053025.GG14998@coredump.intra.peff.net>
 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
 <19429.3589.823244.270582@winooski.ccs.neu.edu>
 <20100512113855.GB23847@coredump.intra.peff.net>
 <19434.39095.448649.313537@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 12 14:49:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCBNt-0000Gr-8L
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 14:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266Ab0ELMtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 08:49:51 -0400
Received: from peff.net ([208.65.91.99]:41574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219Ab0ELMtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 08:49:50 -0400
Received: (qmail 3277 invoked by uid 107); 12 May 2010 12:49:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 08:49:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 08:49:48 -0400
Content-Disposition: inline
In-Reply-To: <19434.39095.448649.313537@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146943>

On Wed, May 12, 2010 at 08:01:59AM -0400, Eli Barzilay wrote:

> > I have no opinion on moving --follow around, but I definitely agree that
> > more clearly marking the diff-options (and including them after
> > revision traversal options) is much better.
> 
> Should I send that reorganization as a proper patch then?

Yes, please.

> > This ":git-log: 1" magic should probably follow the include. It sets up
> > an attribute for diff-options.txt to conditionally include some
> > log-specific bits.
> 
> It seemed like it's a definition that could be used elsewhere too (eg,
> in other includes that could be added in the future).

Yeah, I considered that, too. So maybe it is best at the top of the
options list (but in that case, perhaps it should go at the very top of
the file).

> > I really wonder if it would be that hard to just fix the code to follow
> > several files. [...]
> 
> That would obviously be a better solution...

It really wasn't too bad, actually. Here is a rough cut. Still to be
considered are:

 - the XXX comment below about proper pathspec limiting. Should be easy
   to fix, but I need to look into it.

 - I haven't tested it with --full-diff to see if there are funny
   interactions with the pathspec limiting.

 - The original --follow swapped the old single path to follow for the
   new one. This patch instead _appends_ to the list of pathspecs. We
   have to do this because the pathspecs may still be of interest. For
   example, consider "git log --follow subdir". When we see that
   "subdir/foo" came from "foo", we start following "foo", too. But we
   can't stop following "subdir", because there may be other files of
   interest in it.

   But this means if you have a history where the path "foo" is of
   interest for a while, then goes away, then you move something else
   into its place, you will see commits touching the old foo, even
   though its content is not connected with the new foo.

   We could special-case when we exactly match a file with a pathspec,
   since we know it is no longer of interest. But I am tempted to call
   the new behavior _more_ useful than the old. It means that "git log
   --follow <pathspec>" means we are interested in what has _ever_ been
   in <pathspec> (which is what it means without follow), in addition to
   the history of anything that got renamed into pathspec (ever).

Anyway, here is the patch. My testing so far has been very simple, so
please try it on a few repos and let me know if it does what you expect
in all cases. Note that is based on "next", as it has Bo's
find_copies_harder patch.

diff --git a/builtin/log.c b/builtin/log.c
index 976e16f..5a7611a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -88,9 +88,10 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
-		rev->always_show_header = 0;
-		if (rev->diffopt.nr_paths != 1)
-			usage("git logs can only follow renames on one pathname at a time");
+		if (!rev->diffopt.nr_paths)
+			DIFF_OPT_CLR(&rev->diffopt, FOLLOW_RENAMES);
+		else
+			rev->always_show_header = 0;
 	}
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/tree-diff.c b/tree-diff.c
index 1fb3e94..9467f27 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "dir.h"
 
 static char *malloc_base(const char *base, int baselen, const char *path, int pathlen)
 {
@@ -322,78 +323,75 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 }
 
 /*
- * Does it look like the resulting diff might be due to a rename?
- *  - single entry
- *  - not a valid previous file
+ * Does it look like the resulting diff might be due to a rename? If we have
+ * any files that appeared, then maybe.
  */
 static inline int diff_might_be_rename(void)
 {
-	return diff_queued_diff.nr == 1 &&
-		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
+	int i;
+	for (i = 0; i < diff_queued_diff.nr; i++)
+		if (!DIFF_FILE_VALID(diff_queued_diff.queue[i]->one))
+			return 1;
+	return 0;
 }
 
 static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
+	struct diff_queue_struct old_queue;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_filepair *choice;
-	const char *paths[1];
+	const char **new_paths;
+	int new_paths_num, new_paths_alloc;
 	int i;
 
-	/* Remove the file creation entry from the diff queue, and remember it */
-	choice = q->queue[0];
-	q->nr = 0;
+	/* The diff machinery operates on a global queue, so we need to save a
+	 * copy before doing another diff. */
+	old_queue = *q;
+	DIFF_QUEUE_CLEAR(q);
 
 	diff_setup(&diff_opts);
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow = opt->paths[0];
 	diff_opts.break_opt = opt->break_opt;
-	paths[0] = NULL;
-	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
 		die("unable to set up diff options to follow renames");
 	diff_tree(t1, t2, base, &diff_opts);
 	diffcore_std(&diff_opts);
-	diff_tree_release_paths(&diff_opts);
 
-	/* Go through the new set of filepairing, and see if we find a more interesting one */
+	new_paths_num = new_paths_alloc = opt->nr_paths;
+	new_paths = xmalloc(opt->nr_paths * sizeof(*new_paths));
+	for (i = 0; i < opt->nr_paths; i++)
+		new_paths[i] = opt->paths[i];
+
+	/* Go through the new set of filepairs, looking for renames. */
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 
-		/*
-		 * Found a source? Not only do we use that for the new
-		 * diff_queued_diff, we will also use that as the path in
-		 * the future!
-		 */
-		if ((p->status == 'R' || p->status == 'C') && !strcmp(p->two->path, opt->paths[0])) {
-			/* Switch the file-pairs around */
-			q->queue[i] = choice;
-			choice = p;
-
-			/* Update the path we use from now on.. */
-			diff_tree_release_paths(opt);
-			opt->paths[0] = xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->paths, opt);
-			break;
-		}
-	}
+		if (p->status != 'R' && p->status != 'C')
+			continue;
 
-	/*
-	 * Then, discard all the non-relevant file pairs...
-	 */
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		diff_free_filepair(p);
+		/* XXX actually this is the slightly different wildcarding
+		 * pathspec. We really want to check just prefixes. But
+		 * I wonder if we can convince the diff machinery to just
+		 * be interested in these paths as destinations, but use
+		 * the whole tree as sources */
+		if (!match_pathspec(opt->paths, p->two->path,
+				   strlen(p->two->path), 0, NULL))
+			continue;
+
+		ALLOC_GROW(new_paths, new_paths_num + 1, new_paths_alloc);
+		new_paths[new_paths_num++] = xstrdup(p->one->path);
 	}
 
-	/*
-	 * .. and re-instate the one we want (which might be either the
-	 * original one, or the rename/copy we found)
-	 */
-	q->queue[0] = choice;
-	q->nr = 1;
+	/* now finalize the new paths */
+	ALLOC_GROW(new_paths, new_paths_num + 1, new_paths_alloc);
+	new_paths[new_paths_num] = NULL;
+	diff_tree_setup_paths(new_paths, opt);
+
+	/* and restore our old queue */
+	free(q->queue);
+	*q = old_queue;
 }
 
 int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
-- 
1.7.1.258.ge9097.dirty
