From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [WIP/RFH/RFD/PATCH] grep: allow to use textconv filters
Date: Mon,  4 Feb 2013 16:27:31 +0100
Message-ID: <2c0641ea4df6a872a4466efe0c0124f304f44c3e.1359991521.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 16:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Nxa-00060H-Mz
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 16:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab3BDP1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 10:27:31 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51844 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754255Ab3BDP1a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2013 10:27:30 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 61F1320D6C;
	Mon,  4 Feb 2013 10:27:29 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 04 Feb 2013 10:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=IYhLM42ispk2AlJHUgov42lpI2g=; b=lqHWBdLNi3CcytdHTMQP
	QyZ9bQh+RG6w7/3FOaPEVYOWNXMbdDKIKyJBbfjC19QCBvuGsMFlUt5yI1gEVJv3
	bA/oenhelOwYFVJgcLVcJ98AxX2pHLtUWYG2WPBSVy7uLU/e4fNcCi3o+btw4suV
	g+n/O61Th7KQZzKo48hr4eE=
X-Sasl-enc: dDtdx6Q4GUpund3ZALwwmwz7KC36ktygpEHulJ/Ijies 1359991648
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C4CFC4827A4;
	Mon,  4 Feb 2013 10:27:28 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.718.g9d378fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215385>

Recently and not so recently, we made sure that log/grep type operations
use textconv filters when a userfacing diff would do the same:

ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)

"git grep" currently does not use textconv filters at all, that is
neither for displaying the match and context nor for the actual grepping.

Introduce a binary mode "--textconv" (in addition to "--text" and "-I")
which makes git grep use any configured textconv filters for grepping
and output purposes.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    I'm somehow stuck in textconv/filespec/... hell, so I'm sending this out
    in request for help. I'm sure there are people for whom it's a breeze to
    get this right.
    
    The difficulty is in getting the different cases (blob/sha1 vs.
    worktree) right, and in making the changes minimally invasive. It seems
    that some more refactoring could help: "git show --textconv" does not
    use textconv filters when used on blobs either. (It does for diffs, of
    course.) Most existing helper functions are tailored for diffs.

    Nota bene: --textconv does not affect "diff --stat" either...

 builtin/grep.c |  5 ++++-
 grep.c         | 47 +++++++++++++++++++++++++++++------------------
 grep.h         |  3 ++-
 3 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8025964..2181c22 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -96,7 +96,7 @@ static void add_work(struct grep_opt *opt, enum grep_source_type type,
 
 	grep_source_init(&todo[todo_end].source, type, name, path, id);
 	if (opt->binary != GREP_BINARY_TEXT)
-		grep_source_load_driver(&todo[todo_end].source);
+		grep_source_load_driver(&todo[todo_end].source, opt);
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
@@ -659,6 +659,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('I', NULL, &opt.binary,
 			N_("don't match patterns in binary files"),
 			GREP_BINARY_NOMATCH),
+		OPT_SET_INT(0, "textconv", &opt.binary,
+			N_("process binary files with textconv filters"),
+			GREP_BINARY_TEXTCONV),
 		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
diff --git a/grep.c b/grep.c
index 4bd1b8b..410b7b8 100644
--- a/grep.c
+++ b/grep.c
@@ -1,10 +1,12 @@
 #include "cache.h"
+#include "diff.h"
+#include "diffcore.h"
 #include "grep.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
 
-static int grep_source_load(struct grep_source *gs);
-static int grep_source_is_binary(struct grep_source *gs);
+static int grep_source_load(struct grep_source *gs, struct grep_opt *opt);
+static int grep_source_is_binary(struct grep_source *gs, struct grep_opt *opt);
 
 static struct grep_opt grep_defaults;
 
@@ -1174,7 +1176,7 @@ static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bo
 {
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
-		grep_source_load_driver(gs);
+		grep_source_load_driver(gs, opt);
 		if (gs->driver->funcname.pattern) {
 			const struct userdiff_funcname *pe = &gs->driver->funcname;
 			xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
@@ -1354,14 +1356,15 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (grep_source_is_binary(gs))
+		if (grep_source_is_binary(gs, opt))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
-		if (grep_source_is_binary(gs))
+		if (grep_source_is_binary(gs, opt))
 			return 0; /* Assume unmatch */
 		break;
 	case GREP_BINARY_TEXT:
+	case GREP_BINARY_TEXTCONV:
 		break;
 	default:
 		die("bug: unknown binary handling mode");
@@ -1372,7 +1375,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	try_lookahead = should_lookahead(opt);
 
-	if (grep_source_load(gs) < 0)
+	if (grep_source_load(gs, opt) < 0)
 		return 0;
 
 	bol = gs->buf;
@@ -1610,12 +1613,17 @@ void grep_source_clear_data(struct grep_source *gs)
 	}
 }
 
-static int grep_source_load_sha1(struct grep_source *gs)
+static int grep_source_load_sha1(struct grep_source *gs, struct grep_opt *opt)
 {
 	enum object_type type;
-
 	grep_read_lock();
-	gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
+	if (opt->binary == GREP_BINARY_TEXTCONV) {
+		struct diff_filespec *df = alloc_filespec(gs->name);
+		gs->size = fill_textconv(gs->driver, df, &gs->buf);
+		free_filespec(df);
+	} else {
+		gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
+	}
 	grep_read_unlock();
 
 	if (!gs->buf)
@@ -1625,7 +1633,7 @@ static int grep_source_load_sha1(struct grep_source *gs)
 	return 0;
 }
 
-static int grep_source_load_file(struct grep_source *gs)
+static int grep_source_load_file(struct grep_source *gs, struct grep_opt *opt)
 {
 	const char *filename = gs->identifier;
 	struct stat st;
@@ -1660,42 +1668,45 @@ static int grep_source_load_file(struct grep_source *gs)
 	return 0;
 }
 
-static int grep_source_load(struct grep_source *gs)
+static int grep_source_load(struct grep_source *gs, struct grep_opt *opt)
 {
 	if (gs->buf)
 		return 0;
 
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
-		return grep_source_load_file(gs);
+		return grep_source_load_file(gs, opt);
 	case GREP_SOURCE_SHA1:
-		return grep_source_load_sha1(gs);
+		return grep_source_load_sha1(gs, opt);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
 	}
 	die("BUG: invalid grep_source type");
 }
 
-void grep_source_load_driver(struct grep_source *gs)
+void grep_source_load_driver(struct grep_source *gs, struct grep_opt *opt)
 {
 	if (gs->driver)
 		return;
 
-	grep_attr_lock();
+	grep_attr_lock(); //TODO
+	printf("Looking up userdiff driver for: %s", gs->path);
 	if (gs->path)
 		gs->driver = userdiff_find_by_path(gs->path);
 	if (!gs->driver)
 		gs->driver = userdiff_find_by_name("default");
+	if (opt->binary == GREP_BINARY_TEXTCONV)
+		gs->driver = userdiff_get_textconv(gs->driver);
 	grep_attr_unlock();
 }
 
-static int grep_source_is_binary(struct grep_source *gs)
+static int grep_source_is_binary(struct grep_source *gs, struct grep_opt *opt)
 {
-	grep_source_load_driver(gs);
+	grep_source_load_driver(gs, opt);
 	if (gs->driver->binary != -1)
 		return gs->driver->binary;
 
-	if (!grep_source_load(gs))
+	if (!grep_source_load(gs, opt))
 		return buffer_is_binary(gs->buf, gs->size);
 
 	return 0;
diff --git a/grep.h b/grep.h
index 8fc854f..d272d25 100644
--- a/grep.h
+++ b/grep.h
@@ -105,6 +105,7 @@ struct grep_opt {
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
+#define GREP_BINARY_TEXTCONV	3
 	int binary;
 	int extended;
 	int use_reflog_filter;
@@ -173,7 +174,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		      const void *identifier);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
-void grep_source_load_driver(struct grep_source *gs);
+void grep_source_load_driver(struct grep_source *gs, struct grep_opt *opt);
 
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
-- 
1.8.1.2.718.g9d378fc
