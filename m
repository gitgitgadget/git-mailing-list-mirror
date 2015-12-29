From: Jeff King <peff@peff.net>
Subject: [PATCH 14/14] shortlog: match commit trailers with --ident
Date: Tue, 29 Dec 2015 02:38:32 -0500
Message-ID: <20151229073832.GN8842@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:38:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDorf-00076P-EL
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbbL2Hig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:38:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:46649 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752074AbbL2Hie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:38:34 -0500
Received: (qmail 18526 invoked by uid 102); 29 Dec 2015 07:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:38:34 -0600
Received: (qmail 20051 invoked by uid 107); 29 Dec 2015 07:38:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:38:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:38:32 -0500
Content-Disposition: inline
In-Reply-To: <20151229071847.GA8726@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283105>

If a project uses commit trailers, this patch lets you use
shortlog to see who is performing each action. For example,
running:

  git shortlog -ns --ident=reviewed-by

in git.git shows who has reviewed. You can even use a custom
format to see things like who has helped whom:

  git shortlog --format="...helped %an (%ad)" --ident=helped-by

This does run a bit more slowly than a normal
author-grouping (about 33% slower in my tests). Some of that
is natural, because we have to spend time parsing the
trailers. But I suspect a fair bit of that could be cut off
by optimizing the trailer code, which involves quite a few
more copies of the data than we actually need.

Still, it is certainly fast enough to be usable, and
optimization can come later.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  9 +++++++++
 builtin/shortlog.c             | 38 +++++++++++++++++++++++++++++++++++---
 shortlog.h                     |  4 +++-
 t/t4201-shortlog.sh            |  9 +++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index a89a01e..16080c4 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -54,6 +54,15 @@ OPTIONS
 +
  - `author`, commits are grouped by author (this is the default)
  - `committer`, commits are grouped by committer
+ - any other value, the `<type>` is interpreted as a case-insensitive
+   commit message trailer (see linkgit:git-interpret-trailers[1]). For
+   example, if your project uses `Reviewed-by` trailers, you might want
+   to see who has been reviewing with
+   `git shortlog -ns --ident=reviewed-by`.
++
+Note that commits that do not include the trailer will not be counted.
+Likewise, commits with multiple trailers (e.g., multiple signoffs) may
+count more than once.
 
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 39da2d4..f774c84 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -8,6 +8,7 @@
 #include "mailmap.h"
 #include "shortlog.h"
 #include "parse-options.h"
+#include "trailer.h"
 
 static char const * const shortlog_usage[] = {
 	N_("git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"),
@@ -126,6 +127,8 @@ static void read_from_stdin(struct shortlog *log)
 	case SHORTLOG_IDENT_COMMITTER:
 		ident_header = "Commit: ";
 		break;
+	case SHORTLOG_IDENT_TRAILER:
+		die(_("sorry, using a trailer --ident with stdin is not supported"));
 	}
 
 	while (strbuf_getline(&ident, stdin, '\n') != EOF) {
@@ -149,6 +152,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
+	char *oneline_str;
 
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
@@ -174,6 +178,12 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 			return;
 		}
 		break;
+	case SHORTLOG_IDENT_TRAILER:
+		/*
+		 * We might have multiple matches, so deal with it in the loop
+		 * below.
+		 */
+		break;
 	}
 
 	if (!log->summary) {
@@ -183,7 +193,26 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 			format_commit_message(commit, "%s", &oneline, &ctx);
 	}
 
-	insert_one_record(log, ident.buf, oneline.len ? oneline.buf : "<none>");
+	oneline_str = oneline.len ? oneline.buf : "<none>";
+	if (log->ident_type != SHORTLOG_IDENT_TRAILER)
+		insert_one_record(log, ident.buf, oneline_str);
+	else {
+		struct strbuf msg = STRBUF_INIT;
+		struct trailer_parse_context tp;
+		int i;
+
+		format_commit_message(commit, "%B", &msg, &ctx);
+		trailer_parse_init(&tp, &msg);
+		for (i = tp.start; i < tp.end; i++) {
+			const char *v = trailer_parse_match(&tp, i, log->trailer);
+			if (!v)
+				continue;
+			insert_one_record(log, v, oneline_str);
+		}
+		trailer_parse_clear(&tp);
+		strbuf_release(&msg);
+	}
+
 	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
@@ -253,8 +282,11 @@ static int parse_ident_option(const struct option *opt, const char *arg, int uns
 		log->ident_type = SHORTLOG_IDENT_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
 		log->ident_type = SHORTLOG_IDENT_COMMITTER;
-	else
-		die("unknown ident type: %s", arg);
+	else {
+		log->ident_type = SHORTLOG_IDENT_TRAILER;
+		free(log->trailer);
+		log->trailer = xstrdup(arg);
+	}
 
 	return 0;
 }
diff --git a/shortlog.h b/shortlog.h
index a365620..718b49d 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -16,8 +16,10 @@ struct shortlog {
 
 	enum {
 		SHORTLOG_IDENT_AUTHOR = 0,
-		SHORTLOG_IDENT_COMMITTER
+		SHORTLOG_IDENT_COMMITTER,
+		SHORTLOG_IDENT_TRAILER,
 	} ident_type;
+	char *trailer;
 
 	char *common_repo_prefix;
 	int email;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 867a7ae..9c00ccb 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -207,4 +207,13 @@ test_expect_success 'shortlog --ident=committer (external)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog --ident=signed-off-by' '
+	git commit --allow-empty -m foo -s &&
+	cat >expect <<-\EOF &&
+	     1	C O Mitter
+	EOF
+	git shortlog -ns --ident=signed-off-by HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.7.0.rc3.367.g09631da
