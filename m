From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] shortlog: add '--sort-key' and '--sort-key-regexp'
 options
Date: Wed, 15 Jul 2009 13:17:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907151316320.4410@intel-tinevez-2-302>
References: <alpine.LFD.2.01.0907141852400.13838@localhost.localdomain> <7v8wiqfj60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 13:18:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR2Uq-0008Bn-E6
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 13:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbZGOLRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 07:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbZGOLRb
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 07:17:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:60117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753500AbZGOLRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 07:17:30 -0400
Received: (qmail invoked by alias); 15 Jul 2009 11:17:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 15 Jul 2009 13:17:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iSuUiKOGiwtwT5HJOzbflwgpgSYV5ulzu+LafOr
	XyEv0HvtRLueiy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v8wiqfj60.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123298>


Instead of always sorting by author, allow to sort by either
a whitespace-delimited field or by a regular expression (first group)
on the oneline.

For example, this will give you an overview of the weekday/commit
distribution:

	git shortlog -k 1 --pretty=%cD -s -n

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Pretty obviously, in git.git this shows that Saturday and
	Wednesday, your designated Git days, are on top of the list, but
	what is interesting to me is that the difference between Wednesday 
	and Sunday is not all that much.

	Sorry, no time for tests, maybe somebody else can help out?

 Documentation/git-shortlog.txt |   13 +++++++-
 builtin-shortlog.c             |   64 +++++++++++++++++++++++++++++++++++++--
 shortlog.h                     |    1 +
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 42463a9..3155361 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 git log --pretty=short | 'git shortlog' [-h] [-n] [-s] [-e] [-w]
-git shortlog [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [<committish>...]
+git shortlog [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [(-K|--sort-key-regexp) <regexp>] [(-k|--sort-key) <n>] [<committish>...]
 
 DESCRIPTION
 -----------
@@ -45,6 +45,17 @@ OPTIONS
 	and subsequent lines are indented by `indent2` spaces. `width`,
 	`indent1`, and `indent2` default to 76, 6 and 9 respectively.
 
+-K <regexp>::
+--sort-key-regexp <regexp>::
+	Instead of sorting by author, sort by a regular expression on the
+	commit subject (or whatever you specified using --pretty)
+
+-k <number>::
+--sort-key <number>::
+	Instead of sorting by author, sort by a given whitespace-delimited
+	field of the commit subject (or whatever you specified using
+	--pretty).  The first field is 1.
+
 
 MAPPING AUTHORS
 ---------------
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index a684422..2cab5e4 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -145,9 +145,37 @@ static void read_from_stdin(struct shortlog *log)
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
+	struct strbuf buf = STRBUF_INIT;
+	char *key = NULL;
 	const char *author = NULL, *buffer;
 
 	buffer = commit->buffer;
+	if (log->user_format)
+		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf,
+			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
+
+	if (log->sort_key) {
+		const char *p = buf.buf;
+		regmatch_t match[2];
+
+		if (!log->user_format) {
+			p = strstr(buffer, "\n\n");
+			if (!p)
+				return;
+			p += 2;
+		}
+
+		if (!regexec(log->sort_key, p, 2, match, 0) &&
+				match[1].rm_so >= 0)
+			author = key = xstrndup(p + match[1].rm_so,
+				match[1].rm_eo - match[1].rm_so);
+		else
+			author = "<null>";
+		insert_one_record1(log, key, p);
+		strbuf_release(&buf);
+		return;
+	}
+
 	while (*buffer && *buffer != '\n') {
 		const char *eol = strchr(buffer, '\n');
 
@@ -164,10 +192,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 		die("Missing author: %s",
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
-		struct strbuf buf = STRBUF_INIT;
-
-		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf,
-			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
 		insert_one_record(log, author, buf.buf);
 		strbuf_release(&buf);
 		return;
@@ -175,6 +199,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	if (*buffer)
 		buffer++;
 	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
+	free(key);
 }
 
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
@@ -250,6 +275,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
 	static struct shortlog log;
 	static struct rev_info rev;
+	static const char *sort_key_regexp = NULL;
+	static int sort_key_field = 0;
 	int nongit;
 
 	static const struct option options[] = {
@@ -261,6 +288,11 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			    "Show the email address of each author"),
 		{ OPTION_CALLBACK, 'w', NULL, &log, "w[,i1[,i2]]",
 			"Linewrap output", PARSE_OPT_OPTARG, &parse_wrap_args },
+		OPT_STRING('K', "sort-key-regexp", &sort_key_regexp, "<regexp>",
+			"Sort shortlog by the given regular expression"),
+		OPT_INTEGER('k', "sort-key", &sort_key_field,
+			"Sort shortlog by the given field "
+			"(whitespace-delimited)"),
 		OPT_END(),
 	};
 
@@ -285,6 +317,27 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	if (sort_key_regexp && sort_key_field > 0)
+		die ("--sort-key-regexp and --sort-key-field are incompatible");
+
+	if (sort_key_regexp) {
+		log.sort_key = xmalloc(sizeof(*log.sort_key));
+		if (regcomp(log.sort_key, sort_key_regexp, 0))
+			die ("Invalid regular expression: '%s'",
+					sort_key_regexp);
+	}
+	if (sort_key_field > 0) {
+		struct strbuf regexp = STRBUF_INIT;
+		strbuf_addstr(&regexp, "^[ \t\n]*");
+		while (--sort_key_field)
+			strbuf_addstr(&regexp, "[^ \t\n]*[ \t\n]*");
+		strbuf_addstr(&regexp, "\\([^ \t\n]*\\)[ \t\n]*.*$");
+		log.sort_key = xmalloc(sizeof(*log.sort_key));
+		if (regcomp(log.sort_key, regexp.buf, 0))
+			die ("Invalid regular expression: '%s'", regexp.buf);
+		strbuf_release(&regexp);
+	}
+
 	if (setup_revisions(argc, argv, &rev, NULL) != 1) {
 		error("unrecognized argument: %s", argv[1]);
 		usage_with_options(shortlog_usage, options);
@@ -296,6 +349,9 @@ parse_done:
 	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
 	if (rev.pending.nr == 0) {
+		if (log.sort_key)
+			die ("Specifying a sort key is incompatible with "
+				"reading from stdin.");
 		read_from_stdin(&log);
 	}
 	else
diff --git a/shortlog.h b/shortlog.h
index bc02cc2..9dedaf6 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -16,6 +16,7 @@ struct shortlog {
 	char *common_repo_prefix;
 	int email;
 	struct string_list mailmap;
+	regex_t *sort_key;
 };
 
 void shortlog_init(struct shortlog *log);
-- 
1.6.3.284.g6fecc
