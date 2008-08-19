From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 20:22:19 -0700
Message-ID: <7vy72tit90.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 05:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVHqT-00029f-Uz
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 05:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbYHSDW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 23:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYHSDW1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 23:22:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYHSDW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 23:22:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 204725E0B6;
	Mon, 18 Aug 2008 23:22:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B28645E0B1; Mon, 18 Aug 2008 23:22:21 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808181839390.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Aug 2008 19:12:43 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B327B7A-6D9E-11DD-963C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92807>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Actually, this weekend I was trying to cherry-pick the aggregated changes 
> to certain files from one branch onto another, and was repeatedly confused 
> by the fact that the only available diffs are backwards and there're no 
> clues in the output. (That is, you can't get the difference between (---) 
> the {index,working tree} and (+++) some commit, and when you've done "git 
> diff messy", the resulting diff doesn't give any clues that you're 
> deciding whether to add the - lines and remove the + lines.)

I do not know if I like the end result, but here is a patch to make the
traditional a/ and b/ prefix more mnemonic.

A lot of existing tests and documentation need to be updated, if we were
to do this, though.    The first test to fail is t1200-tutorial.sh.

Obviously not tested except for creating this patch that pretends to be a
format-patch output.  You can tell that I just did this only in the work
tree now.

-- >8 --
diff: vary default prefix depending on what are compared

This implements Daniel's idea to indicate what are compared by using
prefix different from the traditional a/ and b/ in the textual diff
header:

    "git diff" compares the (i)ndex and the (w)ork tree;
    "git diff HEAD" compares a (c)ommit and the (w)ork tree;
    "git diff --cached" compares a (c)ommit and the (i)ndex;
    "git diff HEAD:f /tmp/f" compares an (o)bject and (w)ork tree.

Because these mnemonics now have meanings, they are swapped when reverse
diff is in effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-diff.c |    2 ++
 diff-lib.c     |    3 +++
 diff.c         |   38 +++++++++++++++++++++++++++++++-------
 diff.h         |    2 ++
 4 files changed, 38 insertions(+), 7 deletions(-)

diff --git i/builtin-diff.c w/builtin-diff.c
index 7ffea97..ecec753 100644
--- i/builtin-diff.c
+++ w/builtin-diff.c
@@ -74,6 +74,8 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
 		die("'%s': not a regular file or symlink", path);
 
+	diff_set_default_prefix(&revs->diffopt, "o/", "w/");
+
 	if (blob[0].mode == S_IFINVALID)
 		blob[0].mode = canon_mode(st.st_mode);
 
diff --git i/diff-lib.c w/diff-lib.c
index e7eaff9..969f8c1 100644
--- i/diff-lib.c
+++ w/diff-lib.c
@@ -63,6 +63,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	char symcache[PATH_MAX];
 
+	diff_set_default_prefix(&revs->diffopt, "i/", "w/");
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
@@ -469,6 +471,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	if (unpack_trees(1, &t, &opts))
 		exit(128);
 
+	diff_set_default_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
diff --git i/diff.c w/diff.c
index bf5d5f1..1c518c6 100644
--- i/diff.c
+++ w/diff.c
@@ -305,6 +305,15 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *new = diff_get_color(color_diff, DIFF_FILE_NEW);
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
+	const char *a_prefix, *b_prefix;
+
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
@@ -313,8 +322,8 @@ static void emit_rewrite_diff(const char *name_a,
 
 	strbuf_reset(&a_name);
 	strbuf_reset(&b_name);
-	quote_two_c_style(&a_name, o->a_prefix, name_a, 0);
-	quote_two_c_style(&b_name, o->b_prefix, name_b, 0);
+	quote_two_c_style(&a_name, a_prefix, name_a, 0);
+	quote_two_c_style(&b_name, b_prefix, name_b, 0);
 
 	diff_populate_filespec(one, 0);
 	diff_populate_filespec(two, 0);
@@ -1424,6 +1433,14 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	return NULL;
 }
 
+void diff_set_default_prefix(struct diff_options *options, const char *a, const char *b)
+{
+	if (!options->a_prefix)
+		options->a_prefix = a;
+	if (!options->b_prefix)
+		options->b_prefix = b;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1437,9 +1454,19 @@ static void builtin_diff(const char *name_a,
 	char *a_one, *b_two;
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
+	const char *a_prefix, *b_prefix;
 
-	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
-	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
+	diff_set_default_prefix(o, "a/", "b/");
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
+
+	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
+	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
@@ -2298,9 +2325,6 @@ void diff_setup(struct diff_options *options)
 	else
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
-
-	options->a_prefix = "a/";
-	options->b_prefix = "b/";
 }
 
 int diff_setup_done(struct diff_options *options)
diff --git i/diff.h w/diff.h
index 50fb5dd..5782fef 100644
--- i/diff.h
+++ w/diff.h
@@ -160,6 +160,8 @@ extern void diff_tree_combined(const unsigned char *sha1, const unsigned char pa
 
 extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_info *);
 
+void diff_set_default_prefix(struct diff_options *options, const char *a, const char *b);
+
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
