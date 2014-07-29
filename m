From: Jeff King <peff@peff.net>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 05:23:02 -0400
Message-ID: <20140729092301.GA13134@peff.net>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
 <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
 <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Michael Migdol <michael-spam@migdol.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 11:23:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC3cp-00011s-H3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 11:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbaG2JXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 05:23:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:42350 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753088AbaG2JXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 05:23:04 -0400
Received: (qmail 5735 invoked by uid 102); 29 Jul 2014 09:23:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 04:23:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 05:23:02 -0400
Content-Disposition: inline
In-Reply-To: <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254407>

On Tue, Jul 29, 2014 at 02:59:40AM +0000, brian m. carlson wrote:

> On Mon, Jul 28, 2014 at 05:56:28PM -0700, Michael Migdol wrote:
> > Sorry for error -- I meant: git stash list -p, not git stash -p.
> > 
> > On Mon, Jul 28, 2014 at 5:38 PM, Michael Migdol <michael-spam@migdol.net> wrote:
> > > I recently upgraded from Ubuntu 13.10 to Ubuntu 14.04.  After doing so,
> > > "git stash -p" stopped working.  (It apparently is ignoring the -p
> > > parameter).  I'm not sure what version I was using previously, but after
> > > some experimentation, I see that:
> > >
> > > version 1.7.12.2 : stash -p DOES work
> > > version 1.9.3 : doesn't work
> > > version 2.0.3 : doesn't work
> 
> Under the hood, we do:
> 
>   git log --format="%gd: %gs" -g "$@" refs/stash --
> 
> But it looks like git log ignores -p if -g is provided.

Almost. It's not ignored, but rather it is a noop on merge commits
without "-c" or "--cc". And every stash is a merge commit (between the
base commit and the index content).

So why did it work in v1.7.12.2? It didn't. It just looked like it
worked. :)

When we do a reflog walk, we replace the parents of each commit with the
prior reflog entry, simulating a linear string of development, moving
from one reflog entry to another.  Prior to 838f9a1 (log: use true
parents for diff when walking reflogs, 2013-08-03), we used those "fake"
parents when diffing, too. But that doesn't make much sense. It will
show the diff between two adjacent reflog entries, which may not even be
related (especially for stashes!). What the user is generally after is
to walk the reflog, but to show each commit in isolation as a diff
against its parents.

So v1.7.12.2 showed _a_ diff, but it was the diff against the prior
stash, which was generally nonsensical.  After 838f9a1, we actually show
the diff against the real parents, but you need "-p --cc" to see
anything, because each stash is a merge.

Unfortunately, the resulting diff is often a bit uglier than necessary.
Here's an example:

    git init
    echo one >file && git add file && git commit -m one
    echo two >>file
    git stash
    git stash list -p --cc

yields:

    stash@{0}: WIP on master: d0e237c one
    
    diff --cc file
    index 5626abf,5626abf..814f4a4
    --- a/file
    +++ b/file
    @@@ -1,1 -1,1 +1,2 @@@
      one
    ++two

It's a combined-diff, because we are showing the changes from both the
original base commit and the index. But the index was the same as the
base, so each changed line gets two "++" markers (and two "--", and two
spaces for context lines). And in many cases, I'd guess the index is
untouched (in fact, "git stash show" explicitly shows _only_ the diff
between the working tree and the base!).

When we create the stash, we could notice that the trees for the index
and base are identical, and just skip making the index commit (and
therefore make the stash itself a regular commit rather than a merge).
That might break later users of the stash, though, who would want to
check "stash@{0}" against "stash@{0}^2" to see what was in the index
(they could infer from the lack of a second parent that it was empty,
but that is not backwards compatible).

So perhaps we could do something better on the viewing side, and
"simplify" combined merges for files with all-identical parents. With
the patch below, these commands (on top of the earlier ones):

   echo two >>file && git add file
   echo three >>file
   git stash
   git stash list -p --cc --simplify-combined-diff

yields:

    stash@{0}: WIP on master: d0e237c one
    
    diff --cc file
    index 5626abf,814f4a4..4cb29ea
    --- a/file
    +++ b/file
    @@@ -1,1 -1,2 +1,3 @@@
      one
    + two
    ++three
    stash@{1}: WIP on master: d0e237c one
    
    diff --git file
    index 5626abf..814f4a4
    --- a/file
    +++ b/file
    @@ -1,1 +1,2 @@
     one
    +two


I.e., we show the combined diff when it is relevant (in the first stash,
where the index actually had something interesting), and a normal diff
otherwise. And then we could make "--cc --simplify-combined-diff" the default
for "stash list" (which would only trigger if you provided "--raw" or
"-p" yourself).

The patch for --simplify-combined-diff is below. Note that it either
simplifies to a single parent, or does not simplification at all. In
theory we could simplify an octopus merge of "A,B,A" into "A,B", but I
think that just ends up being more confusing (and ambiguous; you don't
know which parent was dropped).

-Peff

---
diff --git a/combine-diff.c b/combine-diff.c
index 6c00c4b..6a27436 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -900,7 +900,11 @@ static void show_combined_header(struct combine_diff_path *elem,
 	if (rev->loginfo && !rev->no_commit_id)
 		show_log(rev);
 
-	dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
+	dump_quoted_path(num_parent == 1 ?
+			   "diff --git " :
+			   dense ?
+			     "diff --cc " :
+			     "diff --combined ",
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
@@ -955,6 +959,15 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 line_prefix, c_meta, c_reset);
 }
 
+static int simplify_parents(struct combine_diff_path *p, int nr)
+{
+	int i;
+	for (i = 1; i < nr; i++)
+		if (hashcmp(p->parent[i].sha1, p->parent[i-1].sha1))
+			return nr;
+	return 1;
+}
+
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			    int dense, int working_tree_file,
 			    struct rev_info *rev)
@@ -979,6 +992,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV))
 		textconv = userdiff_get_textconv(userdiff);
 
+	if (rev->simplify_combined_diffs)
+		num_parent = simplify_parents(elem, num_parent);
+
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, elem->mode, &result_size,
@@ -1181,6 +1197,8 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 	if (rev->loginfo && !rev->no_commit_id)
 		show_log(rev);
 
+	if (rev->simplify_combined_diffs)
+		num_parent = simplify_parents(p, num_parent);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
 		printf("%s", line_prefix);
@@ -1247,12 +1265,16 @@ static void free_combined_pair(struct diff_filepair *pair)
  * but currently nobody uses it, so this should suffice for now.
  */
 static struct diff_filepair *combined_pair(struct combine_diff_path *p,
-					   int num_parent)
+					   int num_parent,
+					   struct rev_info *rev)
 {
 	int i;
 	struct diff_filepair *pair;
 	struct diff_filespec *pool;
 
+	if (rev->simplify_combined_diffs)
+		num_parent = simplify_parents(p, num_parent);
+
 	pair = xcalloc(1, sizeof(*pair));
 	pool = xcalloc(num_parent + 1, sizeof(struct diff_filespec));
 	pair->one = pool + 1;
@@ -1277,7 +1299,8 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
 static void handle_combined_callback(struct diff_options *opt,
 				     struct combine_diff_path *paths,
 				     int num_parent,
-				     int num_paths)
+				     int num_paths,
+				     struct rev_info *rev)
 {
 	struct combine_diff_path *p;
 	struct diff_queue_struct q;
@@ -1287,7 +1310,8 @@ static void handle_combined_callback(struct diff_options *opt,
 	q.alloc = num_paths;
 	q.nr = num_paths;
 	for (i = 0, p = paths; p; p = p->next)
-		q.queue[i++] = combined_pair(p, num_parent);
+		q.queue[i++] = combined_pair(p, num_parent, rev);
+
 	opt->format_callback(&q, opt, opt->format_callback_data);
 	for (i = 0; i < num_paths; i++)
 		free_combined_pair(q.queue[i]);
@@ -1498,7 +1522,8 @@ void diff_tree_combined(const unsigned char *sha1,
 			 (DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT))
 			needsep = 1;
 		else if (opt->output_format & DIFF_FORMAT_CALLBACK)
-			handle_combined_callback(opt, paths, num_parent, num_paths);
+			handle_combined_callback(opt, paths, num_parent,
+						 num_paths, rev);
 
 		if (opt->output_format & DIFF_FORMAT_PATCH) {
 			if (needsep)
diff --git a/revision.c b/revision.c
index b8b0ea3..27eba77 100644
--- a/revision.c
+++ b/revision.c
@@ -1820,6 +1820,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->diff = 1;
 		revs->dense_combined_merges = 1;
 		revs->combine_merges = 1;
+	} else if (!strcmp(arg, "--simplify-combined-diffs")) {
+		revs->simplify_combined_diffs = 1;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
diff --git a/revision.h b/revision.h
index a620530..29689a1 100644
--- a/revision.h
+++ b/revision.h
@@ -122,6 +122,7 @@ struct rev_info {
 			ignore_merges:1,
 			combine_merges:1,
 			dense_combined_merges:1,
+			simplify_combined_diffs:1,
 			always_show_header:1;
 
 	/* Format info */
