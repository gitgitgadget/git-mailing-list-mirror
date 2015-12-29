From: Jeff King <peff@peff.net>
Subject: [PATCH 11/14] shortlog: allow grouping by committer ident
Date: Tue, 29 Dec 2015 02:35:16 -0500
Message-ID: <20151229073515.GK8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:35:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDooV-0003tD-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbbL2HfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:35:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:46640 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546AbbL2HfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:35:18 -0500
Received: (qmail 18393 invoked by uid 102); 29 Dec 2015 07:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:35:18 -0600
Received: (qmail 19999 invoked by uid 107); 29 Dec 2015 07:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:35:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:35:16 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283102>

Shortlog always groups commits by the author field. It can
be interesting to group by other fields, as well. The
obvious other identity in each commit is the committer
field. This might be interesting if your project follows a
workflow where committers and authors are not the same and
where there is not simply one maintainer picking up all of
the patches.

For instance, you can use this in git.git to see interim and
subsystem maintainers. Likewise, you can see in linux.git
the patches picked up by lieutenants and merged into Linus's
tree.

This patch also provides some of the necessary
infrastructure for adding more ident types (e.g., from
trailers) in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  8 +++++++
 builtin/shortlog.c             | 51 +++++++++++++++++++++++++++++++++++++-----
 shortlog.h                     |  5 +++++
 t/t4201-shortlog.sh            | 13 +++++++++++
 4 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 31af7f2..a89a01e 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -47,6 +47,14 @@ OPTIONS
 
 	Each pretty-printed commit will be rewrapped before it is shown.
 
+--ident=<type>::
+	By default, `shortlog` collects and collates author identities;
+	using `--ident` will collect other types of identity. If
+	`<type>` is:
++
+ - `author`, commits are grouped by author (this is the default)
+ - `committer`, commits are grouped by committer
+
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
 	line of each entry is indented by `indent1` spaces, and the second
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d7eb0cb..39da2d4 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -115,12 +115,22 @@ static void insert_one_record(struct shortlog *log,
 
 static void read_from_stdin(struct shortlog *log)
 {
+	const char *ident_header = NULL;
 	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 
+	switch (log->ident_type) {
+	case SHORTLOG_IDENT_AUTHOR:
+		ident_header = "Author: ";
+		break;
+	case SHORTLOG_IDENT_COMMITTER:
+		ident_header = "Commit: ";
+		break;
+	}
+
 	while (strbuf_getline(&ident, stdin, '\n') != EOF) {
 		const char *v;
-		if (!skip_prefix_icase(ident.buf, "Author: ", &v))
+		if (!skip_prefix_icase(ident.buf, ident_header, &v))
 			continue;
 		while (strbuf_getline(&oneline, stdin, '\n') != EOF &&
 		       oneline.len)
@@ -147,11 +157,23 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
-	format_commit_message(commit, "%an <%ae>", &ident, &ctx);
-	if (ident.len <= 3) {
-		warning(_("Missing author: %s"),
-		    oid_to_hex(&commit->object.oid));
-		return;
+	switch (log->ident_type) {
+	case SHORTLOG_IDENT_AUTHOR:
+		format_commit_message(commit, "%an <%ae>", &ident, &ctx);
+		if (ident.len <= 3) {
+			warning(_("Missing author: %s"),
+				oid_to_hex(&commit->object.oid));
+			return;
+		}
+		break;
+	case SHORTLOG_IDENT_COMMITTER:
+		format_commit_message(commit, "%cn <%ce>", &ident, &ctx);
+		if (ident.len <= 3) {
+			warning(_("Missing committer: %s"),
+				oid_to_hex(&commit->object.oid));
+			return;
+		}
+		break;
 	}
 
 	if (!log->summary) {
@@ -223,6 +245,21 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_ident_option(const struct option *opt, const char *arg, int unset)
+{
+	struct shortlog *log = opt->value;
+
+	if (unset || !strcasecmp(arg, "author"))
+		log->ident_type = SHORTLOG_IDENT_AUTHOR;
+	else if (!strcasecmp(arg, "committer"))
+		log->ident_type = SHORTLOG_IDENT_COMMITTER;
+	else
+		die("unknown ident type: %s", arg);
+
+	return 0;
+}
+
+
 void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
@@ -250,6 +287,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			 N_("Show the email address of each author")),
 		{ OPTION_CALLBACK, 'w', NULL, &log, N_("w[,i1[,i2]]"),
 			N_("Linewrap output"), PARSE_OPT_OPTARG, &parse_wrap_args },
+		{ OPTION_CALLBACK, 0, "ident", &log, N_("field"),
+			N_("Use ident from field"), 0, parse_ident_option },
 		OPT_END(),
 	};
 
diff --git a/shortlog.h b/shortlog.h
index de4f86f..a365620 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -14,6 +14,11 @@ struct shortlog {
 	int user_format;
 	int abbrev;
 
+	enum {
+		SHORTLOG_IDENT_AUTHOR = 0,
+		SHORTLOG_IDENT_COMMITTER
+	} ident_type;
+
 	char *common_repo_prefix;
 	int email;
 	struct string_list mailmap;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7600a3e..867a7ae 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -194,4 +194,17 @@ test_expect_success 'shortlog with revision pseudo options' '
 	git shortlog --exclude=refs/heads/m* --all
 '
 
+test_expect_success 'shortlog --ident=committer (internal)' '
+	cat >expect <<-\EOF &&
+	     5	C O Mitter
+	EOF
+	git shortlog -ns --ident=committer HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'shortlog --ident=committer (external)' '
+	git log --format=full | git shortlog -ns --ident=committer >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.rc3.367.g09631da
