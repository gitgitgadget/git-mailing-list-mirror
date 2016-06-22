Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FFF52018B
	for <e@80x24.org>; Wed, 22 Jun 2016 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcFVPDE (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:03:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:65229 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbcFVPCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:07 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MEnX8-1b8Yvv0Les-00G5EP; Wed, 22 Jun 2016 17:01:25
 +0200
Date:	Wed, 22 Jun 2016 17:01:22 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 00/10] Let log-tree and friends respect diffopt's `file`
 field
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rckI8Xsv0/E4TqdUxQEYzAk1iGck21Gku+Fg9XN4cn2QgC5PN1c
 fiiEXQD/jkih6fMG1PqMetWZEksKEIhYgHYJFwFdQo6gxGHTjlX/CKviKFEiv3WKd6ov2jH
 tB9zcH87RdwdI0ZliwImcrGaouSyx13XfkQP9M57GbWNdXvopVlbcL31/kAJtb/ZRcNy0NL
 LFIvZpVlpQo9Rfc3SYX8A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:OydStnSXn40=:qkNIqH4C99JNv5LYwB3QXR
 uOheiaccgj3lwryV1SdYYD5XIsx3Nv5aboPdQLBv/qT3L5nDNiQwk7IhCsbF00Vlm1ECg1360
 EGits7IOlwnFlHwFTgQBnxm3pCP1GEuFMqlkAZ8/AUlohDb3qQkcXuB248318XEVc4xzP+zkr
 zRMqMJId9Q6vLrTMzwsaX4OrpneP0Kl6cK7O3IW2ZOkIlETtOQQuf0LWZm9SG8p61LTCufDru
 EeZh+JwUC7yOcMZ1P3+Wzr3qa5IS2Xuv7Ex+QGSkhku+YIM7GKZLD/uv/vrdAKudRGQuO0N68
 QgdAHPvyfuc/P5q1BsGAYidP+l3vQ7Eif1aNvPhBqVOSAAyXAb3HS8OVnr6lMBP/7ckkQs1Qz
 lLM7FdEKmgeJc3qQ/9XzAmX02qyOwnnU73GseSouW3BfYMBZ2rjjJFla5Bk9ME+cQD3O1zz84
 mDJGCcd0WmbXryPV8Gw+P31Z8rmPXn34HddbK9cb/la2quzGvV0L6WgDmpRvOPtBZMhyzirc8
 +GIxADk8lCU8ugXtttvm9mBg+/ZX1s07jLdgHF5uyj9G7kHXOoZIr3SH5H+rd/hKJ1HQ97LNb
 QTiAtYQnNZGiDXJ50ojBUCcqBZpm+2595bV5qdvNnCT/VH30+S+6QS3SoA9Qt12goqIG27YoH
 GRM/FriKJ7cs72bhDKG3aexZCIyuiXIPgC1dARHNcn95P1sReb04wOkQAWnbptnT1SE413QBk
 ikQmH1TS1tnOi3C+FMmXZiBjv8goPUaPA7w9ZKK2Io+4qcQPe7lCHMLmehFiS8YPWxRSBYqd8
 d1ZB6m0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The idea is to allow callers to redirect log-tree's output to a file
without having to freopen() stdout (which would modify global state,
a big no-no-no for library functions).

I reviewed log-tree.c, graph.c, line-log.c, builtin/shortlog.c and
builtin/log.c line by line to ensure that all calls that assumed stdout
previously now use the `file` field instead, of course. I would
welcome additional eyes to go over the code to confirm that I did not
miss anything.

This patch series ends up removing the freopen() call in the
format-patch command, but that is only a by-product. The ulterior motive
behind this series is to allow the sequencer to write a `patch` file as
part of my endeavor to move large chunks of rebase -i into a builtin.

In contrast to the previous iteration of this patch series,

- the use_color = 0 setting was made contingent on use_color != ALWAYS

- close_file = 1 was made to work in more circumstances, most notably
  when calling log_commit_tree() (and in builtin/log.c, where this
  function is called in a loop)

- the changes to builtin/am.c were backed out completely (this is a can
  of worms I am not prepared to open for now)

- I also taught shortlog to respect the --output=<file> option, because
  it was so easy to do

- I added a test case to ensure that `log --output=<file>` works


Johannes Schindelin (10):
  Prepare log/log-tree to reuse the diffopt.close_file attribute
  log-tree: respect diffopt's configured output file stream
  line-log: respect diffopt's configured output file stream
  graph: respect the diffopt.file setting
  shortlog: support outputting to streams other than stdout
  format-patch: explicitly switch off color when writing to files
  format-patch: avoid freopen()
  format-patch: use stdout directly
  shortlog: respect the --output=<file> setting
  Ensure that log respects --output=<file>

 builtin/log.c       | 87 +++++++++++++++++++++++++++++------------------------
 builtin/shortlog.c  | 15 ++++++---
 graph.c             | 30 ++++++++++--------
 line-log.c          | 34 ++++++++++-----------
 log-tree.c          | 69 ++++++++++++++++++++++--------------------
 shortlog.h          |  1 +
 t/t4201-shortlog.sh |  6 ++++
 t/t4211-line-log.sh |  7 +++++
 8 files changed, 142 insertions(+), 107 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/diffopt.file-v4
Interdiff vs v3:

 diff --git a/builtin/am.c b/builtin/am.c
 index 47d78aa..3dfe70b 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1433,16 +1433,12 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
  /**
   * Writes `commit` as a patch to the state directory's "patch" file.
   */
 -static int write_commit_patch(const struct am_state *state, struct commit *commit)
 +static void write_commit_patch(const struct am_state *state, struct commit *commit)
  {
  	struct rev_info rev_info;
  	FILE *fp;
 -	int res;
  
 -	fp = fopen(am_path(state, "patch"), "w");
 -	if (!fp)
 -		return error(_("Could not open %s for writing"),
 -			am_path(state, "patch"));
 +	fp = xfopen(am_path(state, "patch"), "w");
  	init_revisions(&rev_info, NULL);
  	rev_info.diff = 1;
  	rev_info.abbrev = 0;
 @@ -1454,11 +1450,10 @@ static int write_commit_patch(const struct am_state *state, struct commit *commi
  	DIFF_OPT_SET(&rev_info.diffopt, FULL_INDEX);
  	rev_info.diffopt.use_color = 0;
  	rev_info.diffopt.file = fp;
 +	rev_info.diffopt.close_file = 1;
  	add_pending_object(&rev_info, &commit->object, "");
  	diff_setup_done(&rev_info.diffopt);
 -	res = log_tree_commit(&rev_info, commit);
 -	fclose(fp);
 -	return res;
 +	log_tree_commit(&rev_info, commit);
  }
  
  /**
 @@ -1506,14 +1501,13 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
  
  	if (get_mail_commit_sha1(commit_sha1, mail) < 0)
 -		return error(_("could not parse %s"), mail);
 +		die(_("could not parse %s"), mail);
  
  	commit = lookup_commit_or_die(commit_sha1, mail);
  
  	get_commit_info(state, commit);
  
 -	if (write_commit_patch(state, commit) < 0)
 -		return -1;
 +	write_commit_patch(state, commit);
  
  	hashcpy(state->orig_commit, commit_sha1);
  	write_state_text(state, "original-commit", sha1_to_hex(commit_sha1));
 diff --git a/builtin/log.c b/builtin/log.c
 index 2bfcc43..2a42216 100644
 --- a/builtin/log.c
 +++ b/builtin/log.c
 @@ -243,9 +243,10 @@ static struct itimerval early_output_timer;
  
  static void log_show_early(struct rev_info *revs, struct commit_list *list)
  {
 -	int i = revs->early_output;
 +	int i = revs->early_output, close_file = revs->diffopt.close_file;
  	int show_header = 1;
  
 +	revs->diffopt.close_file = 0;
  	sort_in_topological_order(&list, revs->sort_order);
  	while (list && i) {
  		struct commit *commit = list->item;
 @@ -262,14 +263,19 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
  		case commit_ignore:
  			break;
  		case commit_error:
 +			if (close_file)
 +				fclose(revs->diffopt.file);
  			return;
  		}
  		list = list->next;
  	}
  
  	/* Did we already get enough commits for the early output? */
 -	if (!i)
 +	if (!i) {
 +		if (close_file)
 +			fclose(revs->diffopt.file);
  		return;
 +	}
  
  	/*
  	 * ..if no, then repeat it twice a second until we
 @@ -331,7 +337,7 @@ static int cmd_log_walk(struct rev_info *rev)
  {
  	struct commit *commit;
  	int saved_nrl = 0;
 -	int saved_dcctc = 0;
 +	int saved_dcctc = 0, close_file = rev->diffopt.close_file;
  
  	if (rev->early_output)
  		setup_early_output(rev);
 @@ -347,6 +353,7 @@ static int cmd_log_walk(struct rev_info *rev)
  	 * and HAS_CHANGES being accumulated in rev->diffopt, so be careful to
  	 * retain that state information if replacing rev->diffopt in this loop
  	 */
 +	rev->diffopt.close_file = 0;
  	while ((commit = get_revision(rev)) != NULL) {
  		if (!log_tree_commit(rev, commit) && rev->max_count >= 0)
  			/*
 @@ -367,6 +374,8 @@ static int cmd_log_walk(struct rev_info *rev)
  	}
  	rev->diffopt.degraded_cc_to_c = saved_dcctc;
  	rev->diffopt.needed_rename_limit = saved_nrl;
 +	if (close_file)
 +		fclose(rev->diffopt.file);
  
  	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
  	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
 @@ -1570,7 +1579,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
  		setup_pager();
  
  	if (output_directory) {
 -		rev.diffopt.use_color = 0;
 +		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
 +			rev.diffopt.use_color = 0;
  		if (use_stdout)
  			die(_("standard output, or directory, which one?"));
  		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 diff --git a/builtin/shortlog.c b/builtin/shortlog.c
 index 39d74fe..be80547 100644
 --- a/builtin/shortlog.c
 +++ b/builtin/shortlog.c
 @@ -229,7 +229,6 @@ void shortlog_init(struct shortlog *log)
  	log->wrap = DEFAULT_WRAPLEN;
  	log->in1 = DEFAULT_INDENT1;
  	log->in2 = DEFAULT_INDENT2;
 -	log->file = stdout;
  }
  
  int cmd_shortlog(int argc, const char **argv, const char *prefix)
 @@ -277,6 +276,7 @@ parse_done:
  
  	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
  	log.abbrev = rev.abbrev;
 +	log.file = rev.diffopt.file;
  
  	/* assume HEAD if from a tty */
  	if (!nongit && !rev.pending.nr && isatty(0))
 @@ -290,6 +290,8 @@ parse_done:
  		get_from_rev(&rev, &log);
  
  	shortlog_output(&log);
 +	if (log.file != stdout)
 +		fclose(log.file);
  	return 0;
  }
  
 diff --git a/log-tree.c b/log-tree.c
 index 530297d..cf24027 100644
 --- a/log-tree.c
 +++ b/log-tree.c
 @@ -862,14 +862,12 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
  int log_tree_commit(struct rev_info *opt, struct commit *commit)
  {
  	struct log_info log;
 -	int shown;
 -
 -	if (opt->diffopt.close_file)
 -		die("BUG: close_file is incompatible with log_tree_commit()");
 +	int shown, close_file = opt->diffopt.close_file;
  
  	log.commit = commit;
  	log.parent = NULL;
  	opt->loginfo = &log;
 +	opt->diffopt.close_file = 0;
  
  	if (opt->line_level_traverse)
  		return line_log_print(opt, commit);
 @@ -886,5 +884,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
  		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
  	opt->loginfo = NULL;
  	maybe_flush_or_die(opt->diffopt.file, "stdout");
 +	if (close_file)
 +		fclose(opt->diffopt.file);
  	return shown;
  }
 diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
 index a977365..bd699e1 100755
 --- a/t/t4201-shortlog.sh
 +++ b/t/t4201-shortlog.sh
 @@ -184,4 +184,10 @@ test_expect_success 'shortlog with revision pseudo options' '
  	git shortlog --exclude=refs/heads/m* --all
  '
  
 +test_expect_success 'shortlog with --output=<file>' '
 +	git shortlog --output=shortlog master >output &&
 +	test ! -s output &&
 +	test_line_count = 7 shortlog
 +'
 +
  test_done
 diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
 index 4451127..9d87777 100755
 --- a/t/t4211-line-log.sh
 +++ b/t/t4211-line-log.sh
 @@ -99,4 +99,11 @@ test_expect_success '-L with --first-parent and a merge' '
  	git log --first-parent -L 1,1:b.c
  '
  
 +test_expect_success '-L with --output' '
 +	git checkout parallel-change &&
 +	git log --output=log -L :main:b.c >output &&
 +	test ! -s output &&
 +	test_line_count = 70 log
 +'
 +
  test_done

-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
