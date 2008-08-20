From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] diff: vary default prefix depending on what are compared
Date: Wed, 20 Aug 2008 01:00:16 -0700
Message-ID: <7vljysru9b.fsf_-_@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
 <7vy72tit90.fsf@gitster.siamese.dyndns.org> <48AA4430.3060207@gmail.com>
 <7vmyj9h567.fsf@gitster.siamese.dyndns.org>
 <7viqtxh4gt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Marcus Griep <neoeinstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 10:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVidI-0004gL-QD
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 10:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYHTIA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 04:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbYHTIA0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 04:00:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYHTIAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 04:00:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 25E8D535DF;
	Wed, 20 Aug 2008 04:00:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EDBE7535DE; Wed, 20 Aug 2008 04:00:17 -0400 (EDT)
In-Reply-To: <7viqtxh4gt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Aug 2008 00:02:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09E5119C-6E8E-11DD-8535-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92970>

With a new configuration "diff.mnemonicprefix", "git diff" shows the
differences between various combinations of preimage and postimage trees
with prefixes different from the standard "a/" and "b/".  Hopefully this
will make the distinction stand out for some people.

    "git diff" compares the (i)ndex and the (w)ork tree;
    "git diff HEAD" compares a (c)ommit and the (w)ork tree;
    "git diff --cached" compares a (c)ommit and the (i)ndex;
    "git diff --no-index a b" compares two non-git things (1) and (2).

Because these mnemonics now have meanings, they are swapped when reverse
diff is in effect and this feature is enabled.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is much low impact mainly because it only affects "git diff" and
   Porcelains that use diff_ui_config().  As an added bonus, tests do not
   have to get fixed ;-)  I did have to fix --cc codepath, by the way.

   I'll run my git life with this enabled for two weeks to see if the "gut
   feeling" we discussed earlier changes in some way.

   Another thing we may want to do is to explicitly disable this for
   format-patch, as we may want to change the default for this
   configuration to true in some future.

 Documentation/config.txt |   14 ++++++++++++++
 builtin-diff.c           |    2 ++
 combine-diff.c           |    8 ++++++--
 diff-lib.c               |    3 +++
 diff-no-index.c          |    1 +
 diff.c                   |   46 ++++++++++++++++++++++++++++++++++++++++------
 diff.h                   |    2 ++
 7 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 676c39b..b125bf5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -576,6 +576,20 @@ diff.external::
 	you want to use an external diff program only on a subset of
 	your files, you	might want to use linkgit:gitattributes[5] instead.
 
+diff.mnemonicprefix::
+	If set, 'git-diff' uses a prefix pair that is different from the
+	standard "a/" and "b/" depending on what is being compared.  When
+	this configuration is in effect, reverse diff output also swaps
+	the order of the prefixes:
+'git-diff';;
+	compares the (i)ndex and the (w)ork tree;
+'git-diff HEAD';;
+	 compares a (c)ommit and the (w)ork tree;
+'git diff --cached';;
+	compares a (c)ommit and the (i)ndex;
+'git diff --no-index a b';;
+	compares two non-git things (1) and (2).
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the 'git-diff' option '-l'.
diff --git a/builtin-diff.c b/builtin-diff.c
index 7ffea97..266337b 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -74,6 +74,8 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
 		die("'%s': not a regular file or symlink", path);
 
+	diff_set_mnemonic_prefix(&revs->diffopt, "o/", "w/");
+
 	if (blob[0].mode == S_IFINVALID)
 		blob[0].mode = canon_mode(st.st_mode);
 
diff --git a/combine-diff.c b/combine-diff.c
index 9f80a1c..fe1970e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -675,9 +675,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	int i, show_hunks;
 	int working_tree_file = is_null_sha1(elem->sha1);
 	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
+	const char *a_prefix, *b_prefix;
 	mmfile_t result_file;
 
 	context = opt->context;
+	a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
+	b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
+
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, &result_size);
@@ -841,13 +845,13 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			dump_quoted_path("--- ", "", "/dev/null",
 					 c_meta, c_reset);
 		else
-			dump_quoted_path("--- ", opt->a_prefix, elem->path,
+			dump_quoted_path("--- ", a_prefix, elem->path,
 					 c_meta, c_reset);
 		if (deleted)
 			dump_quoted_path("+++ ", "", "/dev/null",
 					 c_meta, c_reset);
 		else
-			dump_quoted_path("+++ ", opt->b_prefix, elem->path,
+			dump_quoted_path("+++ ", b_prefix, elem->path,
 					 c_meta, c_reset);
 		dump_sline(sline, cnt, num_parent,
 			   DIFF_OPT_TST(opt, COLOR_DIFF));
diff --git a/diff-lib.c b/diff-lib.c
index e7eaff9..ae96c64 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -63,6 +63,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
 	char symcache[PATH_MAX];
 
+	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
+
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
@@ -469,6 +471,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	if (unpack_trees(1, &t, &opts))
 		exit(128);
 
+	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
diff --git a/diff-no-index.c b/diff-no-index.c
index 7d68b7f..b60d345 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -252,6 +252,7 @@ void diff_no_index(struct rev_info *revs,
 	if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
 		       revs->diffopt.paths[1]))
 		exit(1);
+	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 
diff --git a/diff.c b/diff.c
index bf5d5f1..2768bbb 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@ static int diff_rename_limit_default = 200;
 int diff_use_color_default = -1;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
+static int diff_mnemonic_prefix;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -149,6 +150,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		diff_auto_refresh_index = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.mnemonicprefix")) {
+		diff_mnemonic_prefix = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 	if (!prefixcmp(var, "diff.")) {
@@ -305,6 +310,15 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *new = diff_get_color(color_diff, DIFF_FILE_NEW);
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
+	const char *a_prefix, *b_prefix;
+
+	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
@@ -313,8 +327,8 @@ static void emit_rewrite_diff(const char *name_a,
 
 	strbuf_reset(&a_name);
 	strbuf_reset(&b_name);
-	quote_two_c_style(&a_name, o->a_prefix, name_a, 0);
-	quote_two_c_style(&b_name, o->b_prefix, name_b, 0);
+	quote_two_c_style(&a_name, a_prefix, name_a, 0);
+	quote_two_c_style(&b_name, b_prefix, name_b, 0);
 
 	diff_populate_filespec(one, 0);
 	diff_populate_filespec(two, 0);
@@ -1424,6 +1438,14 @@ static const char *diff_funcname_pattern(struct diff_filespec *one)
 	return NULL;
 }
 
+void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b)
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
@@ -1437,9 +1459,19 @@ static void builtin_diff(const char *name_a,
 	char *a_one, *b_two;
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
+	const char *a_prefix, *b_prefix;
+
+	diff_set_mnemonic_prefix(o, "a/", "b/");
+	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		a_prefix = o->b_prefix;
+		b_prefix = o->a_prefix;
+	} else {
+		a_prefix = o->a_prefix;
+		b_prefix = o->b_prefix;
+	}
 
-	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
-	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
+	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
+	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
@@ -2299,8 +2331,10 @@ void diff_setup(struct diff_options *options)
 		DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
 
-	options->a_prefix = "a/";
-	options->b_prefix = "b/";
+	if (!diff_mnemonic_prefix) {
+		options->a_prefix = "a/";
+		options->b_prefix = "b/";
+	}
 }
 
 int diff_setup_done(struct diff_options *options)
diff --git a/diff.h b/diff.h
index 50fb5dd..9a679f5 100644
--- a/diff.h
+++ b/diff.h
@@ -160,6 +160,8 @@ extern void diff_tree_combined(const unsigned char *sha1, const unsigned char pa
 
 extern void diff_tree_combined_merge(const unsigned char *sha1, int, struct rev_info *);
 
+void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
+
 extern void diff_addremove(struct diff_options *,
 			   int addremove,
 			   unsigned mode,
-- 
1.6.0.38.g002c7
