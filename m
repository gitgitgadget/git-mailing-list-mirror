From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 6/7] grep: allow to use textconv filters
Date: Fri, 10 May 2013 17:10:15 +0200
Message-ID: <576deff3929c68083ed87251dc5bb5e4dbe1b7e0.1368197380.git.git@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaozC-0007Em-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3EJPLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:11:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34479 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754618Ab3EJPLm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:11:42 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id ED60F20B77;
	Fri, 10 May 2013 11:11:40 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 10 May 2013 11:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=x8
	d+OklajzGR/GzaRtf2yj7WhUo=; b=uR16xiINfeFRR2Wz3cqU9Bv7QWMVyRrNIH
	LxzZexBKoW1311uqadL2utanhg+Ix2bFOeRiwaCGzDIvugx+otTW6p9vO6LuIPpa
	os9fEPxEGpYix8eUaqL8bKiu35+U4zWkQ1rR+rWjaafLHIrB2A2xaYIEN9tSdn7T
	4d0w3Y3es=
X-Sasl-enc: LAvVc35fw1M3noBcGygfYV7Bq7hlbGIXhA0eUqA0Rk7d 1368198699
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7803AC8000A;
	Fri, 10 May 2013 11:11:38 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
In-Reply-To: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1368197380.git.git@drmicha.warpmail.net>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223869>

From: Jeff King <peff@peff.net>

Recently and not so recently, we made sure that log/grep type operations
use textconv filters when a userfacing diff would do the same:

ef90ab6 (pickaxe: use textconv for -S counting, 2012-10-28)
b1c2f57 (diff_grep: use textconv buffers for add/deleted files, 2012-10-28)
0508fe5 (combine-diff: respect textconv attributes, 2011-05-23)

"git grep" currently does not use textconv filters at all, that is
neither for displaying the match and context nor for the actual grepping,
even when requested by --textconv.

Introduce an option "--textconv" which makes git grep use any configured
textconv filters for grepping and output purposes. It is off by default.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-grep.txt |   9 +++-
 builtin/grep.c             |   2 +
 grep.c                     | 100 ++++++++++++++++++++++++++++++++++++++-------
 grep.h                     |   1 +
 t/t7008-grep-binary.sh     |   6 ++-
 5 files changed, 102 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 50d46e1..a5c5a27 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -9,7 +9,7 @@ git-grep - Print lines matching a pattern
 SYNOPSIS
 --------
 [verse]
-'git grep' [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
+'git grep' [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
@@ -80,6 +80,13 @@ OPTIONS
 --text::
 	Process binary files as if they were text.
 
+--textconv::
+	Honor textconv filter settings.
+
+--no-textconv::
+	Do not honor textconv filter settings.
+	This is the default.
+
 -i::
 --ignore-case::
 	Ignore case differences between the patterns and the
diff --git a/builtin/grep.c b/builtin/grep.c
index 159e65d..00ee57d 100644
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
index bb548ca..c668034 100644
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
@@ -1322,6 +1324,58 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
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
@@ -1332,6 +1386,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	unsigned count = 0;
 	int try_lookahead = 0;
 	int show_function = 0;
+	struct userdiff_driver *textconv = NULL;
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
@@ -1353,19 +1408,36 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
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
@@ -1373,7 +1445,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	try_lookahead = should_lookahead(opt);
 
-	if (grep_source_load(gs) < 0)
+	if (fill_textconv_grep(textconv, gs) < 0)
 		return 0;
 
 	bol = gs->buf;
diff --git a/grep.h b/grep.h
index e4a1df5..eaaced1 100644
--- a/grep.h
+++ b/grep.h
@@ -107,6 +107,7 @@ struct grep_opt {
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
 	int binary;
+	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
 	int pcre;
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 1c0946f..a91260a 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -160,7 +160,7 @@ test_expect_success 'grep does not honor textconv' '
 	test_must_fail git grep Qfile
 '
 
-test_expect_failure 'grep --textconv honors textconv' '
+test_expect_success 'grep --textconv honors textconv' '
 	echo "a:binaryQfile" >expect &&
 	git grep --textconv Qfile >actual &&
 	test_cmp expect actual
@@ -176,4 +176,8 @@ test_expect_failure 'grep --textconv blob honors textconv' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep --no-textconv blob does not honor textconv' '
+	test_must_fail git grep --no-textconv Qfile HEAD:a
+'
+
 test_done
-- 
1.8.3.rc1.406.gf4dce7e
