From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 6/6] commit: support alternate status formats
Date: Sat, 5 Sep 2009 04:59:56 -0400
Message-ID: <20090905085956.GF13157@coredump.intra.peff.net>
References: <20090905084809.GA13073@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 11:00:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjr7x-0003gj-5j
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 11:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757267AbZIEI77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756674AbZIEI76
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:59:58 -0400
Received: from peff.net ([208.65.91.99]:39026 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbZIEI76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:59:58 -0400
Received: (qmail 26177 invoked by uid 107); 5 Sep 2009 09:00:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 05:00:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:59:56 -0400
Content-Disposition: inline
In-Reply-To: <20090905084809.GA13073@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127805>

The status command recently grew "short" and "porcelain"
options for alternate output formats. Since status is no
longer "commit --dry-run", these formats are inaccessible to
people who do want to see a dry-run in a parseable form.

This patch makes those formats available to "git commit",
implying the "dry-run" option when they are used.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is very RFC, as it has a few problems/questions:

 - no tests yet, and it definitely should have some

 - should alternate formats imply dry-run? It makes no sense to _not_ do
   dry-run, since you would be putting cruft into the editor for the
   user to see. But the other option would be barfing and complaining
   about mismatched options.

 - the "committable" flag is set in wt_status_print, which means it will
   not be set correctly for short output. I can hack it into the short
   output format, but I think it is probably a mistake for it to be
   stuck with the printing routines in the first place (it is a
   historical artifact, I suspect, from before we always had a "collect"
   phase). So I think it should probably just be part of the "collect"
   phase.

 Documentation/git-commit.txt |   14 ++++++++++++++
 builtin-commit.c             |   39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 64f94cf..c45fbe4 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -75,6 +75,20 @@ OPTIONS
 	and paths that are untracked, similar to the one that is given
 	in the commit log editor.
 
+--short::
+	When doing a dry-run, give the output in the short-format. See
+	linkgit:git-status[1] for details. Implies `--dry-run`.
+
+--porcelain::
+	When doing a dry-run, give the output in a porcelain-ready
+	format. See linkgit:git-status[1] for details. Implies
+	`--dry-run`.
+
+-z::
+	When showing `short` or `porcelain` status output, terminate
+	entries in the status output with NUL, instead of LF. If no
+	format is given, implies the `--porcelain` output format.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
diff --git a/builtin-commit.c b/builtin-commit.c
index ffdee31..f2fd0a4 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -72,6 +72,15 @@ static int use_editor = 1, initial_commit, in_merge;
 static const char *only_include_assumed;
 static struct strbuf message;
 
+static int null_termination;
+static enum {
+	STATUS_FORMAT_LONG,
+	STATUS_FORMAT_SHORT,
+	STATUS_FORMAT_PORCELAIN,
+} status_format = STATUS_FORMAT_LONG;
+
+static void short_print(struct wt_status *s, int null_termination);
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -105,6 +114,12 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('o', "only", &only, "commit only specified files"),
 	OPT_BOOLEAN('n', "no-verify", &no_verify, "bypass pre-commit hook"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run, "show what would be committed"),
+	OPT_SET_INT(0, "short", &status_format, "show status concisely",
+		    STATUS_FORMAT_SHORT),
+	OPT_SET_INT(0, "porcelain", &status_format,
+		    "show porcelain output format", STATUS_FORMAT_PORCELAIN),
+	OPT_BOOLEAN('z', "null", &null_termination,
+		    "terminate entries with NUL"),
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty change"),
@@ -363,7 +378,18 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 
 	wt_status_collect(s);
-	wt_status_print(s);
+
+	switch (status_format) {
+	case STATUS_FORMAT_SHORT:
+		short_print(s, null_termination);
+		break;
+	case STATUS_FORMAT_PORCELAIN:
+		short_print(s, null_termination);
+		break;
+	case STATUS_FORMAT_LONG:
+		wt_status_print(s);
+		break;
+	}
 
 	return s->commitable;
 }
@@ -821,6 +847,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	else if (interactive && argc > 0)
 		die("Paths with --interactive does not make sense.");
 
+	if (null_termination && status_format == STATUS_FORMAT_LONG)
+		status_format = STATUS_FORMAT_PORCELAIN;
+	if (status_format != STATUS_FORMAT_LONG)
+		dry_run = 1;
+
 	return argc;
 }
 
@@ -991,12 +1022,6 @@ static void short_print(struct wt_status *s, int null_termination)
 int cmd_status(int argc, const char **argv, const char *prefix)
 {
 	struct wt_status s;
-	static int null_termination;
-	static enum {
-		STATUS_FORMAT_LONG,
-		STATUS_FORMAT_SHORT,
-		STATUS_FORMAT_PORCELAIN,
-	} status_format = STATUS_FORMAT_LONG;
 	unsigned char sha1[20];
 	static struct option builtin_status_options[] = {
 		OPT__VERBOSE(&verbose),
-- 
1.6.4.2.418.g1a1d3.dirty
