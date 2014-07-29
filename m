From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] add --simplify-combined-diff option
Date: Tue, 29 Jul 2014 09:00:27 -0400
Message-ID: <20140729130026.GA29912@peff.net>
References: <20140729115334.GA8976@peff.net>
 <20140729120056.GA9175@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC71F-0008Gn-T8
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbaG2NAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 09:00:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:42444 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752670AbaG2NAa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:00:30 -0400
Received: (qmail 16928 invoked by uid 102); 29 Jul 2014 13:00:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 08:00:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 09:00:27 -0400
Content-Disposition: inline
In-Reply-To: <20140729120056.GA9175@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254428>

On Tue, Jul 29, 2014 at 08:00:56AM -0400, Jeff King wrote:

> The implementation just cuts the number of parents down to 1, but
> otherwise runs through the same combined-diff code.  The resulting
> pairwise combined-diff differs from a normal diff in a few ways:
> 
>   1. The header line is still "diff --combined" (or "--cc") instead of
>      "diff --git", and it mentions the filename only once.
> 
>   2. The index lines do not contain the file mode; for combined diffs,
>      we generate a separate mode line (but only when it has something
>      interesting to show).
> 
>   3. The hunk header for a single-line change says "-1" in the regular
>      code path, but "-1,1" in the combined code path.
> 
> Is there any value in keeping this as a pseudo-combined diff (i.e., with
> the combined header, but only a single parent)? It should not be too
> hard to just punt to the regular builtin_diff code path when
> "num_parents == 1".

It's not too hard; mostly we just have to massage the data into a
diff_filepair. Patch is below (I'd squash it, and the further commits
will need fixups to their tests, too).

---
 combine-diff.c           | 32 +++++++++++++++++++++++++++++---
 diff.c                   |  2 +-
 diff.h                   |  2 ++
 t/t4038-diff-combined.sh | 18 +++++++++---------
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 60e54a7..0588c86 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -965,6 +965,28 @@ static int simplify_parents(struct combine_diff_path *p, int nr)
 	return 1;
 }
 
+static void show_single_parent_patch(struct combine_diff_path *elem,
+				     int working_tree_file,
+				     struct rev_info *rev)
+{
+	struct diff_filepair pair;
+
+	memset(&pair, 0, sizeof(pair));
+	pair.one = alloc_filespec(elem->path);
+	pair.two = alloc_filespec(elem->path);
+	pair.status = elem->parent[0].status;
+
+	fill_filespec(pair.one, elem->parent[0].sha1, 1, elem->parent[0].mode);
+	if (working_tree_file)
+		fill_filespec(pair.two, null_sha1, 0, elem->mode);
+	else
+		fill_filespec(pair.two, elem->sha1, 1, elem->mode);
+
+	run_diff(&pair, &rev->diffopt);
+	free_filespec(pair.one);
+	free_filespec(pair.two);
+}
+
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			    int dense, int working_tree_file,
 			    struct rev_info *rev)
@@ -982,6 +1004,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	int is_binary;
 	const char *line_prefix = diff_line_prefix(opt);
 
+	if (rev->simplify_combined_diff)
+		num_parent = simplify_parents(elem, num_parent);
+	if (num_parent == 1) {
+		show_single_parent_patch(elem, working_tree_file, rev);
+		return;
+	}
+
 	context = opt->context;
 	userdiff = userdiff_find_by_path(elem->path);
 	if (!userdiff)
@@ -989,9 +1018,6 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV))
 		textconv = userdiff_get_textconv(userdiff);
 
-	if (rev->simplify_combined_diff)
-		num_parent = simplify_parents(elem, num_parent);
-
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, elem->mode, &result_size,
diff --git a/diff.c b/diff.c
index 867f034..558a520 100644
--- a/diff.c
+++ b/diff.c
@@ -3089,7 +3089,7 @@ static void strip_prefix(int prefix_length, const char **namep, const char **oth
 	}
 }
 
-static void run_diff(struct diff_filepair *p, struct diff_options *o)
+void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *pgm = external_diff();
 	struct strbuf msg;
diff --git a/diff.h b/diff.h
index b4a624d..a669be0 100644
--- a/diff.h
+++ b/diff.h
@@ -356,4 +356,6 @@ extern int print_stat_summary(FILE *fp, int files,
 			      int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
+extern void run_diff(struct diff_filepair *p, struct diff_options *o);
+
 #endif /* DIFF_H */
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index d522474..29cdb45 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -455,11 +455,11 @@ test_expect_success 'simplify combined --patch' '
 	merge=$(mkcommit new new $side1 $side2) &&
 	cat >expect <<-\EOF &&
 
-	diff --combined one
-	index df967b9..3e75765
+	diff --git a/one b/one
+	index df967b9..3e75765 100644
 	--- a/one
 	+++ b/one
-	@@ -1,1 +1,1 @@
+	@@ -1 +1 @@
 	-base
 	+new
 	diff --combined two
@@ -485,11 +485,11 @@ test_expect_success 'do not simplify unless all parents are identical' '
 	merge=$(mkcommit new new $side1 $side2 $side3) &&
 	cat >expect <<-\EOF &&
 
-	diff --combined one
-	index df967b9..3e75765
+	diff --git a/one b/one
+	index df967b9..3e75765 100644
 	--- a/one
 	+++ b/one
-	@@ -1,1 +1,1 @@
+	@@ -1 +1 @@
 	-base
 	+new
 	diff --combined two
@@ -513,11 +513,11 @@ test_expect_success 'do not simplify away mode changes' '
 	merge=$(mkcommit new new $side1 $side2) &&
 	cat >expect <<-\EOF &&
 
-	diff --combined one
-	index df967b9..3e75765
+	diff --git a/one b/one
+	index df967b9..3e75765 100644
 	--- a/one
 	+++ b/one
-	@@ -1,1 +1,1 @@
+	@@ -1 +1 @@
 	-base
 	+new
 	diff --combined two
-- 
2.1.0.rc0.286.g5c67d74
