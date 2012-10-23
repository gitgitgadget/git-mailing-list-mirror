From: Peter Krefting <peter@softwolves.pp.se>
Subject: [RFC PATCH 2/2] Localize diff and log output
Date: Tue, 23 Oct 2012 13:25:11 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1210231325060.705@ds9.cixit.se>
References: <alpine.DEB.2.00.1210231323480.602@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 14:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQdY1-0002Z8-8d
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 14:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab2JWMZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 08:25:14 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:41810 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756299Ab2JWMZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 08:25:12 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9NCPBkx000736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 23 Oct 2012 14:25:11 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9NCPBjw000733
	for <git@vger.kernel.org>; Tue, 23 Oct 2012 14:25:11 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.1210231323480.602@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 23 Oct 2012 14:25:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208226>

The output of "git diff --stat", "git show --stat" and "git log" should be
translated to the local user language. The output of "git format-patch"
should not, however. Add localization where needed, and add a flag for
making sure that "format-patch"'s output remains in English.

This partially reverts commit 218adaaaa064c436115dbcd5705a0e2c42e90a25 (Revert
diffstat back to English; 2012-09-13).
---
  builtin/apply.c  |  2 +-
  builtin/commit.c |  4 +--
  builtin/log.c    |  6 ++--
  commit.h         |  3 +-
  diff.c           | 22 +++++++++-----
  diff.h           |  5 +++-
  log-tree.c       | 11 +++++--
  pretty.c         | 87 +++++++++++++++++++++++++++++++++++++++++++-------------
  8 files changed, 104 insertions(+), 36 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 156b3ce..9ead305 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3644,7 +3644,7 @@ static void stat_patch_list(struct patch *patch)
  		show_stats(patch);
  	}

-	print_stat_summary(stdout, files, adds, dels);
+	print_stat_summary(stdout, files, adds, dels, NULL);
  }

  static void numstat_patch_list(struct patch *patch)
diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..406346e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1248,11 +1248,11 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
  	format_commit_message(commit, "%an <%ae>", &author_ident, &pctx);
  	format_commit_message(commit, "%cn <%ce>", &committer_ident, &pctx);
  	if (strbuf_cmp(&author_ident, &committer_ident)) {
-		strbuf_addstr(&format, "\n Author: ");
+		strbuf_addstr(&format, _("\n Author: "));
  		strbuf_addbuf_percentquote(&format, &author_ident);
  	}
  	if (!user_ident_sufficiently_given()) {
-		strbuf_addstr(&format, "\n Committer: ");
+		strbuf_addstr(&format, _("\n Committer: "));
  		strbuf_addbuf_percentquote(&format, &committer_ident);
  		if (advice_implicit_identity) {
  			strbuf_addch(&format, '\n');
diff --git a/builtin/log.c b/builtin/log.c
index 09cf43e..0c579d7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -381,7 +381,7 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)

  	pp.fmt = rev->commit_format;
  	pp.date_mode = rev->date_mode;
-	pp_user_info(&pp, "Tagger", &out, buf, get_log_output_encoding());
+	pp_user_info(&pp, _("Tagger"), _("TaggerDate"), 0, &out, buf, get_log_output_encoding());
  	printf("%s", out.buf);
  	strbuf_release(&out);
  }
@@ -804,7 +804,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
  	msg = body;
  	pp.fmt = CMIT_FMT_EMAIL;
  	pp.date_mode = DATE_RFC2822;
-	pp_user_info(&pp, NULL, &sb, committer, encoding);
+	pp_user_info(&pp, NULL, NULL, 0, &sb, committer, encoding);
  	pp_title_line(&pp, &msg, &sb, encoding, need_8bit_cte);
  	pp_remainder(&pp, &msg, &sb, 0);
  	add_branch_description(&sb, branch_name);
@@ -1222,6 +1222,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)

  	/* Always generate a patch */
  	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+	/* Never translate format-patch output */
+	rev.diffopt.output_format |= DIFF_FORMAT_ENGLISH;

  	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
  		DIFF_OPT_SET(&rev.diffopt, BINARY);
diff --git a/commit.h b/commit.h
index 9f21313..2a9ac6a 100644
--- a/commit.h
+++ b/commit.h
@@ -114,7 +114,8 @@ extern void pretty_print_commit(const struct pretty_print_context *pp,
  extern void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
  			   struct strbuf *sb);
  void pp_user_info(const struct pretty_print_context *pp,
-		  const char *what, struct strbuf *sb,
+		  const char *what, const char *whatdate, int extra_padding,
+		  struct strbuf *sb,
  		  const char *line, const char *encoding);
  void pp_title_line(const struct pretty_print_context *pp,
  		   const char **msg_p,
diff --git a/diff.c b/diff.c
index 35d3f07..ef655d1 100644
--- a/diff.c
+++ b/diff.c
@@ -1391,18 +1391,22 @@ static void fill_print_name(struct diffstat_file *file)
  	file->print_name = pname;
  }

-int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
+int print_stat_summary(FILE *fp, int files, int insertions, int deletions, struct diff_options *options)
  {
  	struct strbuf sb = STRBUF_INIT;
  	int ret;

+	int english = options && !!(options->output_format & DIFF_FORMAT_ENGLISH);
+
  	if (!files) {
  		assert(insertions == 0 && deletions == 0);
-		return fprintf(fp, "%s\n", " 0 files changed");
+		return fprintf(fp, "%s\n", english ? " 0 files changed"
+		                                   : _(" 0 files changed"));
  	}

  	strbuf_addf(&sb,
-		    (files == 1) ? " %d file changed" : " %d files changed",
+		    english ? ((files == 1) ? " %d file changed" : " %d files changed")
+		            : Q_(" %d file changed", " %d files changed", files),
  		    files);

  	/*
@@ -1419,7 +1423,9 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
  		 * do not translate it.
  		 */
  		strbuf_addf(&sb,
-			    (insertions == 1) ? ", %d insertion(+)" : ", %d insertions(+)",
+			    english ? ((insertions == 1) ? ", %d insertion(+)" : ", %d insertions(+)")
+			            : Q_(", %d insertion(+)", ", %d insertions(+)",
+			                 insertions),
  			    insertions);
  	}

@@ -1429,7 +1435,9 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
  		 * do not translate it.
  		 */
  		strbuf_addf(&sb,
-			    (deletions == 1) ? ", %d deletion(-)" : ", %d deletions(-)",
+			    english ? ((deletions == 1) ? ", %d deletion(-)" : ", %d deletions(-)")
+			            : Q_(", %d deletion(-)", ", %d deletions(-)",
+			                 deletions),
  			    deletions);
  	}
  	strbuf_addch(&sb, '\n');
@@ -1681,7 +1689,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
  		extra_shown = 1;
  	}
  	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary(options->file, total_files, adds, dels, options);
  }

  static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
@@ -1710,7 +1718,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
  				options->output_prefix_data);
  		fprintf(options->file, "%s", msg->buf);
  	}
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary(options->file, total_files, adds, dels, options);
  }

  static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index a658f85..73684f7 100644
--- a/diff.h
+++ b/diff.h
@@ -54,6 +54,9 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)

  #define DIFF_FORMAT_CALLBACK	0x1000

+/* Never output translated content, used by format-patch et.al */
+#define DIFF_FORMAT_ENGLISH		0x2000
+
  #define DIFF_OPT_RECURSIVE           (1 <<  0)
  #define DIFF_OPT_TREE_IN_RECURSIVE   (1 <<  1)
  #define DIFF_OPT_BINARY              (1 <<  2)
@@ -334,6 +337,6 @@ extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
  extern int parse_rename_score(const char **cp_p);

  extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+			      int insertions, int deletions, struct diff_options *options);

  #endif /* DIFF_H */
diff --git a/log-tree.c b/log-tree.c
index c894930..0f68413 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -601,8 +601,12 @@ void show_log(struct rev_info *opt)
  					&ctx.need_8bit_cte);
  	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
  		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
+		/*
+		 * TRANSLATORS: This string precedes the commit identifier in git log
+		 * output.
+		 */
  		if (opt->commit_format != CMIT_FMT_ONELINE)
-			fputs("commit ", stdout);
+			fputs(_("commit "), stdout);

  		if (!opt->graph)
  			put_revision_mark(opt, commit);
@@ -612,8 +616,11 @@ void show_log(struct rev_info *opt)
  			show_parents(commit, abbrev_commit);
  		if (opt->children.name)
  			show_children(opt, commit, abbrev_commit);
+		/*
+		 * TRANSLATORS: %s is a commit identifier.
+		 */
  		if (parent)
-			printf(" (from %s)",
+			printf(_(" (from %s)"),
  			       find_unique_abbrev(parent->object.sha1,
  						  abbrev_commit));
  		show_decorations(opt, commit);
diff --git a/pretty.c b/pretty.c
index 8b1ea9f..8623bbd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -320,7 +320,8 @@ needquote:
  }

  void pp_user_info(const struct pretty_print_context *pp,
-		  const char *what, struct strbuf *sb,
+		  const char *what, const char *whatdate, int extra_padding,
+		  struct strbuf *sb,
  		  const char *line, const char *encoding)
  {
  	char *date;
@@ -365,24 +366,37 @@ void pp_user_info(const struct pretty_print_context *pp,
  		}
  		strbuf_add(sb, name_tail, namelen - display_name_length);
  		strbuf_addch(sb, '\n');
-	} else {
-		strbuf_addf(sb, "%s: %.*s%.*s\n", what,
-			      (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0,
-			      "    ", namelen, line);
-	}
-	switch (pp->fmt) {
-	case CMIT_FMT_MEDIUM:
-		strbuf_addf(sb, "Date:   %s\n", show_date(time, tz, pp->date_mode));
-		break;
-	case CMIT_FMT_EMAIL:
  		strbuf_addf(sb, "Date: %s\n", show_date(time, tz, DATE_RFC2822));
-		break;
-	case CMIT_FMT_FULLER:
-		strbuf_addf(sb, "%sDate: %s\n", what, show_date(time, tz, pp->date_mode));
-		break;
-	default:
-		/* notin' */
-		break;
+	} else {
+		/*
+		 * Calculate the padding to use to get the two fields we are outputting
+		 * here aligned. We are passed the padding we need to get these fields
+		 * aligned with whatever fields are output in other calls to
+		 * pp_user_info().
+		 *
+		 * FIXME: strlen() used to measure string width; should use mblen()
+		 * or similar, but since that is expensive, it should be done further
+		 * up the callstack, not on each commit. */
+		int datelen = 0, whatlen = 0;
+
+		if (pp->fmt != CMIT_FMT_FULLER)
+			whatdate = _("Date");
+		if (pp->fmt == CMIT_FMT_MEDIUM || pp->fmt == CMIT_FMT_FULLER) {
+			datelen = whatdate ? strlen(whatdate) : 0;
+			whatlen = what ? strlen(what) : 0;
+		}
+
+		strbuf_addf(sb, "%s: %.*s%.*s%.*s\n", what,
+		            (datelen > whatlen ? datelen - whatlen : 0), "                ",
+		            extra_padding, "                ",
+			        namelen, line);
+
+ 		if (pp->fmt == CMIT_FMT_MEDIUM || pp->fmt == CMIT_FMT_FULLER) {
+			strbuf_addf(sb, "%s: %.*s%.*s%s\n", whatdate,
+				        (whatlen > datelen ? whatlen - datelen : 0), "                ",
+			            extra_padding, "                ",
+			            show_date(time, tz, pp->date_mode));
+		}
  	}
  }

@@ -1218,6 +1232,39 @@ static void pp_header(const struct pretty_print_context *pp,
  		      struct strbuf *sb)
  {
  	int parents_shown = 0;
+	const char *author_label = _("Author");
+	const char *authordate_label = _("AuthorDate");
+	const char *commit_label = _("Commit");
+	const char *commitdate_label = _("CommitDate");
+	int extra_padding_author = 0, extra_padding_commit = 0;
+
+	/*
+	 * Calculate the padding to use to get all the fields aligned.
+	 *
+	 * pp_user_info() makes sure to align the Author and Date strings, but
+	 * we aso need to align between the Author and Commit block (if outputting
+	 * FULL or FULLER
+	 *
+	 * FIXME: strlen() used to measure string width; should use mblen()
+	 * or similar, but since that is expensive, it should be done further
+	 * up the callstack, not on each commit. */
+	if (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER) {
+		int author_label_width = strlen(author_label);
+		int commit_label_width = strlen(commit_label);
+
+		if (pp->fmt == CMIT_FMT_FULLER) {
+			int authordate_label_width = strlen(authordate_label);
+			int commitdate_label_width = strlen(commitdate_label);
+			if (authordate_label_width > author_label_width)
+				author_label_width = authordate_label_width;
+			if (commitdate_label_width > commit_label_width)
+				commit_label_width = commitdate_label_width;
+		}
+		extra_padding_author = commit_label_width > author_label_width
+			? commit_label_width - author_label_width : 0; 
+		extra_padding_commit = author_label_width > commit_label_width
+			? author_label_width - commit_label_width : 0; 
+	}

  	for (;;) {
  		const char *line = *msg_p;
@@ -1262,12 +1309,12 @@ static void pp_header(const struct pretty_print_context *pp,
  		 */
  		if (!memcmp(line, "author ", 7)) {
  			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Author", sb, line + 7, encoding);
+			pp_user_info(pp, author_label, authordate_label, extra_padding_author, sb, line + 7, encoding);
  		}
  		if (!memcmp(line, "committer ", 10) &&
  		    (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER)) {
  			strbuf_grow(sb, linelen + 80);
-			pp_user_info(pp, "Commit", sb, line + 10, encoding);
+			pp_user_info(pp, commit_label, commitdate_label, extra_padding_commit, sb, line + 10, encoding);
  		}
  	}
  }
-- 
1.8.0
