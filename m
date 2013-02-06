From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 3/4] grep: allow to use textconv filters
Date: Wed,  6 Feb 2013 16:08:52 +0100
Message-ID: <da8c01b918c94c84ab61859b1b1453885bff5b06.1360162813.git.git@drmicha.warpmail.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 16:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36cr-0003Fu-6K
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077Ab3BFPJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:09:01 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39872 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754869Ab3BFPI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:08:57 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 30220215DB;
	Wed,  6 Feb 2013 10:08:57 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 06 Feb 2013 10:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=73
	cnJ7D6IZoDT4LV3eg9y1xuKpM=; b=lpizZVy6hfmMoql9kpcHelpSA6cswjNkvR
	F+E9yvbkcuPP+qpsnCp1BNkrHzxFt80FTyaQW+8KvB2ex5qzEMqGcUMGRR5N1iHQ
	Y6gz8kK1l922ri/CHI5ecHMNC3mz8lRp2wPebtzZcll6OAB/NbXeYWxugYSU9+Bn
	EsA3CJM8w=
X-Sasl-enc: oKoboH6wCKGkrS7edFAkyjA5WN+25H89M6oLxl2TpIRM 1360163336
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9E9D58E0945;
	Wed,  6 Feb 2013 10:08:56 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
In-Reply-To: <20130205201106.GA29248@sigill.intra.peff.net>
In-Reply-To: <cover.1360162813.git.git@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215585>

From: Jeff King <peff@peff.net>

Recently and not so recently, we made sure that log/grep type operations
use textconv filters when a userfacing diff would do the same:

ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)

"git grep" currently does not use textconv filters at all, that is
neither for displaying the match and context nor for the actual grepping.

Introduce an option "--textconv" which makes git grep use any configured
textconv filters for grepping and output purposes. It is off by default.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c |   2 ++
 grep.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 grep.h         |   1 +
 3 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8025964..915c8ef 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -659,6 +659,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('I', NULL, &opt.binary,
 			N_("don't match patterns in binary files"),
 			GREP_BINARY_NOMATCH),
+		OPT_BOOL(0, "textconv", &opt.allow_textconv,
+			 N_("process binary files with textconv filters")),
 		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, N_("depth"),
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
diff --git a/grep.c b/grep.c
index 4bd1b8b..3880d64 100644
--- a/grep.c
+++ b/grep.c
@@ -2,6 +2,8 @@
 #include "grep.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
+#include "diff.h"
+#include "diffcore.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs);
@@ -1321,6 +1323,58 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
+static int fill_textconv_grep(struct userdiff_driver *driver,
+			      struct grep_source *gs)
+{
+	struct diff_filespec *df;
+	char *buf;
+	size_t size;
+
+	if (!driver || !driver->textconv)
+		return grep_source_load(gs);
+
+	/*
+	 * The textconv interface is intimately tied to diff_filespecs, so we
+	 * have to pretend to be one. If we could unify the grep_source
+	 * and diff_filespec structs, this mess could just go away.
+	 */
+	df = alloc_filespec(gs->path);
+	switch (gs->type) {
+	case GREP_SOURCE_SHA1:
+		fill_filespec(df, gs->identifier, 1, 0100644);
+		break;
+	case GREP_SOURCE_FILE:
+		fill_filespec(df, null_sha1, 0, 0100644);
+		break;
+	default:
+		die("BUG: attempt to textconv something without a path?");
+	}
+
+	/*
+	 * fill_textconv is not remotely thread-safe; it may load objects
+	 * behind the scenes, and it modifies the global diff tempfile
+	 * structure.
+	 */
+	grep_read_lock();
+	size = fill_textconv(driver, df, &buf);
+	grep_read_unlock();
+	free_filespec(df);
+
+	/*
+	 * The normal fill_textconv usage by the diff machinery would just keep
+	 * the textconv'd buf separate from the diff_filespec. But much of the
+	 * grep code passes around a grep_source and assumes that its "buf"
+	 * pointer is the beginning of the thing we are searching. So let's
+	 * install our textconv'd version into the grep_source, taking care not
+	 * to leak any existing buffer.
+	 */
+	grep_source_clear_data(gs);
+	gs->buf = buf;
+	gs->size = size;
+
+	return 0;
+}
+
 static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)
 {
 	char *bol;
@@ -1331,6 +1385,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	unsigned count = 0;
 	int try_lookahead = 0;
 	int show_function = 0;
+	struct userdiff_driver *textconv = NULL;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
@@ -1352,19 +1407,36 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	}
 	opt->last_shown = 0;
 
-	switch (opt->binary) {
-	case GREP_BINARY_DEFAULT:
-		if (grep_source_is_binary(gs))
-			binary_match_only = 1;
-		break;
-	case GREP_BINARY_NOMATCH:
-		if (grep_source_is_binary(gs))
-			return 0; /* Assume unmatch */
-		break;
-	case GREP_BINARY_TEXT:
-		break;
-	default:
-		die("bug: unknown binary handling mode");
+	if (opt->allow_textconv) {
+		grep_source_load_driver(gs);
+		/*
+		 * We might set up the shared textconv cache data here, which
+		 * is not thread-safe.
+		 */
+		grep_attr_lock();
+		textconv = userdiff_get_textconv(gs->driver);
+		grep_attr_unlock();
+	}
+
+	/*
+	 * We know the result of a textconv is text, so we only have to care
+	 * about binary handling if we are not using it.
+	 */
+	if (!textconv) {
+		switch (opt->binary) {
+		case GREP_BINARY_DEFAULT:
+			if (grep_source_is_binary(gs))
+				binary_match_only = 1;
+			break;
+		case GREP_BINARY_NOMATCH:
+			if (grep_source_is_binary(gs))
+				return 0; /* Assume unmatch */
+			break;
+		case GREP_BINARY_TEXT:
+			break;
+		default:
+			die("bug: unknown binary handling mode");
+		}
 	}
 
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -1372,7 +1444,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	try_lookahead = should_lookahead(opt);
 
-	if (grep_source_load(gs) < 0)
+	if (fill_textconv_grep(textconv, gs) < 0)
 		return 0;
 
 	bol = gs->buf;
diff --git a/grep.h b/grep.h
index 8fc854f..94a7ac2 100644
--- a/grep.h
+++ b/grep.h
@@ -106,6 +106,7 @@ struct grep_opt {
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
 	int binary;
+	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
 	int pcre;
-- 
1.8.1.2.752.g32d147e
