From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 2/2] combine-diff: speed it up, by using multiparent
 diff tree-walker directly
Date: Fri, 14 Feb 2014 16:16:04 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140214121604.GC3416@tugrik.mns.mnsspb.ru>
References: <cover.1392299516.git.kirr@mns.spb.ru>
 <f74c494d4afd0f7428288ce1099a91c9d2ae2125.1392299516.git.kirr@mns.spb.ru>
 <xmqq7g8ylrdv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 13:14:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEHew-0004Oh-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 13:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbaBNMOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 07:14:18 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:50303 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbaBNMOR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 07:14:17 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WEHep-000081-Kt; Fri, 14 Feb 2014 16:14:15 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WEHga-0007Ee-1L; Fri, 14 Feb 2014 16:16:04 +0400
Content-Disposition: inline
In-Reply-To: <xmqq7g8ylrdv.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242098>

On Thu, Feb 13, 2014 at 11:55:08AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > +	if (need_generic_pathscan) {
> > +		/* NOTE generic case also handles --stat, as it computes
> > +		 * diff(sha1,parent_i) for all i to do the job, specifically
> > +		 * for parent0.
> > +		 */
> > +		paths = find_paths_generic(sha1, parents, &diffopts);
> > +	}
> > +	else {
> > +		paths = find_paths_multitree(sha1, parents, &diffopts);
> > +
> > +		/* show stat against the first parent even
> > +		 * when doing combined diff.
> > +		 */
> > +		int stat_opt = (opt->output_format &
> > +				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
> 
> /*
>  * We see decl-after-stmt here.
>  * Also please have slash-asterisk and asterisk-slash
>  * at the beginning and the end of a multi-line comment
>  * block on their own line.
>  */

Sorry, and thanks for noticing. I usually compile with -Wall, but it
seems it is not enough without explicitly specifying -std=c89.

Comments corrected and the decl-after-stmt fixed, and this time I've
compiled with `-std=c89 -pedantic -Wall -Wextra` to assure no new
warnings are introduced.

Please apply and thanks beforehand,
Kirill

---- 8< ----
From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH v2 2/2] combine-diff: speed it up, by using multiparent diff
 tree-walker directly

As was recently shown (c839f1bd "combine-diff: optimize
combine_diff_path sets intersection"), combine-diff runs very slowly. In
that commit we optimized paths sets intersection, but that accounted
only for ~ 25% of the slowness, and as my tracing showed, for linux.git
v3.10..v3.11, for merges a lot of time is spent computing
diff(commit,commit^2) just to only then intersect that huge diff to
almost small set of files from diff(commit,commit^1).

In previous commit, we described the problem in more details, and
reworked the diff tree-walker to be general one - i.e. to work in
multiple parent case too. Now is the time to take advantage of it for
finding paths for combine diff.

The implementation is straightforward - if we know, we can get generated
diff paths directly, and at present that means no diff filtering or
rename/copy detection was requested(*), we can call multiparent tree-walker
directly and get ready paths.

(*) because e.g. at present, all diffcore transformations work on
    diff_filepair queues, but in the future, that limitation can be
    lifted, if filters would operate directly on combine_diff_paths.

Timings for `git log --raw --no-abbrev --no-renames` without `-c` ("git log")
and with `-c` ("git log -c") and with `-c --merges` ("git log -c --merges")
before and after the patch are as follows:

                linux.git v3.10..v3.11

            log     log -c     log -c --merges

    before  1.9s    16.4s      15.2s
    after   1.9s     2.4s       1.1s

The result stayed the same.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 combine-diff.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 diff.c         |  1 +
 2 files changed, 84 insertions(+), 5 deletions(-)

Chages since v1:

    - fixed declaration-after-statement, and reworked multiline comments to
      start and end with /* and */ on separate lines.

diff --git a/combine-diff.c b/combine-diff.c
index 1732dfd..12764fb 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1303,7 +1303,7 @@ static const char *path_path(void *obj)
 
 
 /* find set of paths that every parent touches */
-static struct combine_diff_path *find_paths(const unsigned char *sha1,
+static struct combine_diff_path *find_paths_generic(const unsigned char *sha1,
 	const struct sha1_array *parents, struct diff_options *opt)
 {
 	struct combine_diff_path *paths = NULL;
@@ -1316,6 +1316,7 @@ static struct combine_diff_path *find_paths(const unsigned char *sha1,
 	/* tell diff_tree to emit paths in sorted (=tree) order */
 	opt->orderfile = NULL;
 
+	/* D(A,P1...Pn) = D(A,P1) ^ ... ^ D(A,Pn)  (wrt paths) */
 	for (i = 0; i < num_parent; i++) {
 		/*
 		 * show stat against the first parent even when doing
@@ -1346,6 +1347,35 @@ static struct combine_diff_path *find_paths(const unsigned char *sha1,
 }
 
 
+/*
+ * find set of paths that everybody touches, assuming diff is run without
+ * rename/copy detection, etc, comparing all trees simultaneously (= faster).
+ */
+static struct combine_diff_path *find_paths_multitree(
+	const unsigned char *sha1, const struct sha1_array *parents,
+	struct diff_options *opt)
+{
+	int i, nparent = parents->nr;
+	const unsigned char **parents_sha1;
+	struct combine_diff_path paths_head;
+	struct strbuf base;
+
+	parents_sha1 = xmalloc(nparent * sizeof(parents_sha1[0]));
+	for (i = 0; i < nparent; i++)
+		parents_sha1[i] = parents->sha1[i];
+
+	/* fake list head, so worker can assume it is non-NULL */
+	paths_head.next = NULL;
+
+	strbuf_init(&base, PATH_MAX);
+	diff_tree_paths(&paths_head, sha1, parents_sha1, nparent, &base, opt);
+
+	strbuf_release(&base);
+	free(parents_sha1);
+	return paths_head.next;
+}
+
+
 void diff_tree_combined(const unsigned char *sha1,
 			const struct sha1_array *parents,
 			int dense,
@@ -1355,6 +1385,7 @@ void diff_tree_combined(const unsigned char *sha1,
 	struct diff_options diffopts;
 	struct combine_diff_path *p, *paths;
 	int i, num_paths, needsep, show_log_first, num_parent = parents->nr;
+	int need_generic_pathscan;
 
 	/* nothing to do, if no parents */
 	if (!num_parent)
@@ -1377,11 +1408,58 @@ void diff_tree_combined(const unsigned char *sha1,
 
 	/* find set of paths that everybody touches
 	 *
-	 * NOTE find_paths() also handles --stat, as it computes
-	 * diff(sha1,parent_i) for all i to do the job, specifically
-	 * for parent0.
+	 * NOTE
+	 *
+	 * Diffcore transformations are bound to diff_filespec and logic
+	 * comparing two entries - i.e. they do not apply directly to combine
+	 * diff.
+	 *
+	 * If some of such transformations is requested - we launch generic
+	 * path scanning, which works significantly slower compared to
+	 * simultaneous all-trees-in-one-go scan in find_paths_multitree().
+	 *
+	 * TODO some of the filters could be ported to work on
+	 * combine_diff_paths - i.e. all functionality that skips paths, so in
+	 * theory, we could end up having only multitree path scanning.
+	 *
+	 * NOTE please keep this semantically in sync with diffcore_std()
 	 */
-	paths = find_paths(sha1, parents, &diffopts);
+	need_generic_pathscan = opt->skip_stat_unmatch	||
+			DIFF_OPT_TST(opt, FOLLOW_RENAMES)	||
+			opt->break_opt != -1	||
+			opt->detect_rename	||
+			opt->pickaxe		||
+			opt->filter;
+
+
+	if (need_generic_pathscan) {
+		/*
+		 * NOTE generic case also handles --stat, as it computes
+		 * diff(sha1,parent_i) for all i to do the job, specifically
+		 * for parent0.
+		 */
+		paths = find_paths_generic(sha1, parents, &diffopts);
+	}
+	else {
+		int stat_opt;
+		paths = find_paths_multitree(sha1, parents, &diffopts);
+
+		/*
+		 * show stat against the first parent even
+		 * when doing combined diff.
+		 */
+		stat_opt = (opt->output_format &
+				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
+		if (stat_opt) {
+			diffopts.output_format = stat_opt;
+
+			diff_tree_sha1(parents->sha1[0], sha1, "", &diffopts);
+			diffcore_std(&diffopts);
+			if (opt->orderfile)
+				diffcore_order(opt->orderfile);
+			diff_flush(&diffopts);
+		}
+	}
 
 	/* find out number of surviving paths */
 	for (num_paths = 0, p = paths; p; p = p->next)
diff --git a/diff.c b/diff.c
index cda4aa8..f2fff46 100644
--- a/diff.c
+++ b/diff.c
@@ -4764,6 +4764,7 @@ void diffcore_fix_diff_index(struct diff_options *options)
 
 void diffcore_std(struct diff_options *options)
 {
+	/* NOTE please keep the following in sync with diff_tree_combined() */
 	if (options->skip_stat_unmatch)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
-- 
1.9.rc1.181.g641f458
