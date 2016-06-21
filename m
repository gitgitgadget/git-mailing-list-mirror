Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118D920189
	for <e@80x24.org>; Tue, 21 Jun 2016 10:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbcFUKlA (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:41:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:63212 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568AbcFUKgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqzIJ-1btInt3qBn-00eZ5p; Tue, 21 Jun 2016 12:34:47
 +0200
Date:	Tue, 21 Jun 2016 12:34:44 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 0/9] Let log-tree and friends respect diffopt's `file`
 field
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1466505222.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oJM6O7UzyGDFrrRSy5tA8/qD/plY65VyWXxallLMxLvh8aTlJEv
 VEI/rK1W5Xwehi/6W7F3gh1fYDQ0ly7boxiw57DDwX7pfBUdcfTSJRWT2YVO5mJY0Mq3lL3
 k9QSPvZaPBnYzOcA9exICocoXnp6R9XWX+Qn/jmtSlfqoyvWMOa9iN8ev26epVOHzHUUXSx
 fdlo2vCzq8XnbDYag7bVg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TkAowan4nYw=:ptroy4n9kjFWgPwNIb+352
 06qesXEaKZwBbP6EEL4irTS12kRBal4cCCwkaD5j4YmiiIoZ7DdenQccSEZ7zv0sxuRBwl5kf
 T/x55TvmBozcKIU17meoX3u6OL6kVY/wmGXHEFwXIp0bk2pbv98UKN6oz4+3YIxxsXKYfMUHq
 q5ERUxNPgIdIYdkj984BPILijo3pCrqMg5AznKPqUoBUap73qjxdEtFsRubQ1JoRxPqiNela8
 J0TLean2PGRTto+XDIq4b7QcGSKgo0pRtmaZipTebHI/mEngKOFmR5T/Z8PgTmDAWFO9Kywfn
 UcUCWKD656NZqWREpVzIPw+r9NaVAUDga20irRIMhzIO4MXelpGym6GqWjsidk1M2kTb2CESy
 kq3ppZbEGroNeTo0POXhH4mXhTHIGxwg5pn2TKxGhZXkyAu/Vs6OfAQflQdhWbpAhEWfHdg1n
 3k9e0qv9w95jZhQhLL2w+NiGpWs1D0VRpCJFLmCoNZluvytWjJo2wm+FqGbqQkqPIiSuOK+Ql
 HrApmgr2FRQ/Xh+Mi2gEX/jV0+vBBXSNqy6DDpW+NJkLgVPB4o6+SP+M/ofQERFJBU+A0EK0l
 exJ+StKdMDWPCus9yjdgTRwEshA2UNCThauu9T0ZAl/nV86/1XvfVinuy3/4VUoqW/D4fhCbk
 c9QGlEnK0M60WI0yAeU1BFJmDYUXiwAO/YeI4snTBZwQOe9r6MNztEI2lE7UmNCcI1EJYjyxn
 6EAjXccUVQ94HdM5k5H3EjGk7Ls6QRfsoF5RH6eLpUSs4qSPCsd4EKtbMHUPm2ygfV8vtQLMi
 XSTbv0B
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

As mentioned earlier, the `use_color = 0` setting is still kept
unconditional because format-patch explicitly ignores the ui.color
setting.

This iteration has the following changes with regards to the previous
one:

- putchar() is replaced with putc(), not fputc()

- the maybe_flush_or_die() function is now called by log_tree_commit()
  even if outputting to a file stream different from stdout

- this uncovered a problem with builtin am, where it asked the diff
  machinery to close the file stream, but actually called the log_tree
  machinery (which might mean that this patch series inadvertently fixes
  a bug where `git am --rebasing` would write the commit message to
  stdout instead of the `patch` file when erroring out)

This last point is a bigger issue, actually. There seem to be quite a
few function calls in builtin/am.c whose return values that might
indicate errors are flatly ignored. I see two calls to run_diff_index()
whose return value then goes poof unchecked, and several calls to
write_state_text() and write_state_bool() with the same issue. And I did
not even try to review the code to that end, all I wanted was to verify
that builtin am only has the close_file issue once (it does use it a
second time, but that one is okay because it then calls
run_diff_index(), i.e. the diff machinery).

I am embarrassed to admit that these builtin am problems demonstrate
that I, as a mentor of the builtin am project, failed to help make the
patches as good as I expected myself to do.


Johannes Schindelin (9):
  am: stop ignoring errors reported by log_tree_diff()
  Disallow diffopt.close_file when using the log_tree machinery
  log-tree: respect diffopt's configured output file stream
  line-log: respect diffopt's configured output file stream
  graph: respect the diffopt.file setting
  shortlog: support outputting to streams other than stdout
  format-patch: explicitly switch off color when writing to files
  format-patch: avoid freopen()
  format-patch: use stdout directly

 builtin/am.c       | 18 +++++++++-----
 builtin/log.c      | 71 +++++++++++++++++++++++++++---------------------------
 builtin/shortlog.c | 13 ++++++----
 graph.c            | 30 +++++++++++++----------
 line-log.c         | 34 +++++++++++++-------------
 log-tree.c         | 67 +++++++++++++++++++++++++++------------------------
 shortlog.h         |  1 +
 7 files changed, 125 insertions(+), 109 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/diffopt.file-v3
Interdiff vs v2:

 diff --git a/builtin/am.c b/builtin/am.c
 index 3dfe70b..47d78aa 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1433,12 +1433,16 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
  /**
   * Writes `commit` as a patch to the state directory's "patch" file.
   */
 -static void write_commit_patch(const struct am_state *state, struct commit *commit)
 +static int write_commit_patch(const struct am_state *state, struct commit *commit)
  {
  	struct rev_info rev_info;
  	FILE *fp;
 +	int res;
  
 -	fp = xfopen(am_path(state, "patch"), "w");
 +	fp = fopen(am_path(state, "patch"), "w");
 +	if (!fp)
 +		return error(_("Could not open %s for writing"),
 +			am_path(state, "patch"));
  	init_revisions(&rev_info, NULL);
  	rev_info.diff = 1;
  	rev_info.abbrev = 0;
 @@ -1450,10 +1454,11 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
  	DIFF_OPT_SET(&rev_info.diffopt, FULL_INDEX);
  	rev_info.diffopt.use_color = 0;
  	rev_info.diffopt.file = fp;
 -	rev_info.diffopt.close_file = 1;
  	add_pending_object(&rev_info, &commit->object, "");
  	diff_setup_done(&rev_info.diffopt);
 -	log_tree_commit(&rev_info, commit);
 +	res = log_tree_commit(&rev_info, commit);
 +	fclose(fp);
 +	return res;
  }
  
  /**
 @@ -1501,13 +1506,14 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
  
  	if (get_mail_commit_sha1(commit_sha1, mail) < 0)
 -		die(_("could not parse %s"), mail);
 +		return error(_("could not parse %s"), mail);
  
  	commit = lookup_commit_or_die(commit_sha1, mail);
  
  	get_commit_info(state, commit);
  
 -	write_commit_patch(state, commit);
 +	if (write_commit_patch(state, commit) < 0)
 +		return -1;
  
  	hashcpy(state->orig_commit, commit_sha1);
  	write_state_text(state, "original-commit", sha1_to_hex(commit_sha1));
 diff --git a/builtin/log.c b/builtin/log.c
 index 5a889d5..2bfcc43 100644
 --- a/builtin/log.c
 +++ b/builtin/log.c
 @@ -889,8 +889,8 @@ static void print_signature(FILE *file)
  
  	fprintf(file, "-- \n%s", signature);
  	if (signature[strlen(signature)-1] != '\n')
 -		fputc('\n', file);
 -	fputc('\n', file);
 +		putc('\n', file);
 +	putc('\n', file);
  }
  
  static void add_branch_description(struct strbuf *buf, const char *branch_name)
 diff --git a/builtin/shortlog.c b/builtin/shortlog.c
 index 4c68ba7..39d74fe 100644
 --- a/builtin/shortlog.c
 +++ b/builtin/shortlog.c
 @@ -328,7 +328,7 @@ void shortlog_output(struct shortlog *log)
  				else
  					fprintf(log->file, "      %s\n", msg);
  			}
 -			fputc('\n', log->file);
 +			putc('\n', log->file);
  			onelines->strdup_strings = 1;
  			string_list_clear(onelines, 0);
  			free(onelines);
 diff --git a/graph.c b/graph.c
 index 8ae56bc..8ad8ba3 100644
 --- a/graph.c
 +++ b/graph.c
 @@ -1196,7 +1196,7 @@ void graph_show_commit(struct git_graph *graph)
  		fwrite(msgbuf.buf, sizeof(char), msgbuf.len,
  			graph->revs->diffopt.file);
  		if (!shown_commit_line)
 -			fputc('\n', graph->revs->diffopt.file);
 +			putc('\n', graph->revs->diffopt.file);
  		strbuf_setlen(&msgbuf, 0);
  	}
  
 @@ -1246,7 +1246,7 @@ int graph_show_remainder(struct git_graph *graph)
  		shown = 1;
  
  		if (!graph_is_commit_finished(graph))
 -			fputc('\n', graph->revs->diffopt.file);
 +			putc('\n', graph->revs->diffopt.file);
  		else
  			break;
  	}
 @@ -1322,7 +1322,7 @@ void graph_show_commit_msg(struct git_graph *graph,
  		 * new line.
  		 */
  		if (!newline_terminated)
 -			fputc('\n', graph->revs->diffopt.file);
 +			putc('\n', graph->revs->diffopt.file);
  
  		graph_show_remainder(graph);
  
 @@ -1330,6 +1330,6 @@ void graph_show_commit_msg(struct git_graph *graph,
  		 * If sb ends with a newline, our output should too.
  		 */
  		if (newline_terminated)
 -			fputc('\n', graph->revs->diffopt.file);
 +			putc('\n', graph->revs->diffopt.file);
  	}
  }
 diff --git a/line-log.c b/line-log.c
 index c3b8563..e62a7f4 100644
 --- a/line-log.c
 +++ b/line-log.c
 @@ -854,10 +854,10 @@ static void print_line(const char *prefix, char first,
  
  	fputs(prefix, file);
  	fputs(color, file);
 -	fputc(first, file);
 +	putc(first, file);
  	fwrite(begin, 1, end-begin, file);
  	fputs(reset, file);
 -	fputc('\n', file);
 +	putc('\n', file);
  	if (!had_nl)
  		fputs("\\ No newline at end of file\n", file);
  }
 diff --git a/log-tree.c b/log-tree.c
 index 968428a..530297d 100644
 --- a/log-tree.c
 +++ b/log-tree.c
 @@ -560,10 +560,10 @@ void show_log(struct rev_info *opt)
  			show_children(opt, commit, abbrev_commit);
  		show_decorations(opt, commit);
  		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
 -			fputc('\n', opt->diffopt.file);
 +			putc('\n', opt->diffopt.file);
  			graph_show_remainder(opt->graph);
  		}
 -		fputc(opt->diffopt.line_termination, opt->diffopt.file);
 +		putc(opt->diffopt.line_termination, opt->diffopt.file);
  		return;
  	}
  
 @@ -589,7 +589,7 @@ void show_log(struct rev_info *opt)
  		if (opt->diffopt.line_termination == '\n' &&
  		    !opt->missing_newline)
  			graph_show_padding(opt->graph);
 -		fputc(opt->diffopt.line_termination, opt->diffopt.file);
 +		putc(opt->diffopt.line_termination, opt->diffopt.file);
  	}
  	opt->shown_one = 1;
  
 @@ -626,9 +626,9 @@ void show_log(struct rev_info *opt)
  		fputs(diff_get_color_opt(&opt->diffopt, DIFF_RESET), opt->diffopt.file);
  		show_decorations(opt, commit);
  		if (opt->commit_format == CMIT_FMT_ONELINE) {
 -			fputc(' ', opt->diffopt.file);
 +			putc(' ', opt->diffopt.file);
  		} else {
 -			fputc('\n', opt->diffopt.file);
 +			putc('\n', opt->diffopt.file);
  			graph_show_oneline(opt->graph);
  		}
  		if (opt->reflog_info) {
 @@ -722,7 +722,7 @@ void show_log(struct rev_info *opt)
  	if (opt->use_terminator && !commit_format_is_empty(opt->commit_format)) {
  		if (!opt->missing_newline)
  			graph_show_padding(opt->graph);
 -		fputc(opt->diffopt.line_termination, opt->diffopt.file);
 +		putc(opt->diffopt.line_termination, opt->diffopt.file);
  	}
  
  	strbuf_release(&msgbuf);
 @@ -775,7 +775,7 @@ int log_tree_diff_flush(struct rev_info *opt)
  			if (!opt->shown_dashes &&
  			    (pch & opt->diffopt.output_format) == pch)
  				fprintf(opt->diffopt.file, "---");
 -			fputc('\n', opt->diffopt.file);
 +			putc('\n', opt->diffopt.file);
  		}
  	}
  	diff_flush(&opt->diffopt);
 @@ -864,6 +864,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
  	struct log_info log;
  	int shown;
  
 +	if (opt->diffopt.close_file)
 +		die("BUG: close_file is incompatible with log_tree_commit()");
 +
  	log.commit = commit;
  	log.parent = NULL;
  	opt->loginfo = &log;
 @@ -882,7 +885,6 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
  	if (opt->track_linear && !opt->linear && opt->reverse_output_stage)
  		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
  	opt->loginfo = NULL;
 -	if (opt->diffopt.file == stdout)
 -		maybe_flush_or_die(stdout, "stdout");
 +	maybe_flush_or_die(opt->diffopt.file, "stdout");
  	return shown;
  }

-- 
2.9.0.118.g0e1a633

base-commit: ab7797dbe95fff38d9265869ea367020046db118
