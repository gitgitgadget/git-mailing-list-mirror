From: Jeff King <peff@peff.net>
Subject: [PATCH v3 5/8] userdiff: require explicitly allowing textconv
Date: Sun, 26 Oct 2008 00:45:55 -0400
Message-ID: <20081026044555.GE21047@coredump.intra.peff.net>
References: <20081026043802.GA14530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:47:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxWz-0005Rw-2A
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbYJZEp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYJZEp6
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:45:58 -0400
Received: from peff.net ([208.65.91.99]:2247 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbYJZEp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:45:58 -0400
Received: (qmail 4990 invoked by uid 111); 26 Oct 2008 04:45:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:45:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:45:55 -0400
Content-Disposition: inline
In-Reply-To: <20081026043802.GA14530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99145>

Diffs that have been produced with textconv almost certainly
cannot be applied, so we want to be careful not to generate
them in things like format-patch.

This introduces a new diff options, ALLOW_TEXTCONV, which
controls this behavior. It is off by default, but is
explicitly turned on for the "log" family of commands, as
well as the "diff" porcelain (but not diff-* plumbing).

Because both text conversion and external diffing are
controlled by these diff options, we can get rid of the
"plumbing versus porcelain" distinction when reading the
config. This was an attempt to control the same thing, but
suffered from being too coarse-grained.

Signed-off-by: Jeff King <peff@peff.net>
---
The new changes in 4/8 make this even cleaner than before.

 builtin-diff.c           |    1 +
 builtin-log.c            |    1 +
 diff.c                   |   26 +++++++++++---------------
 diff.h                   |    1 +
 t/t4030-diff-textconv.sh |    2 +-
 userdiff.c               |   10 +---------
 userdiff.h               |    3 +--
 7 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 9c8c295..2de5834 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -300,6 +300,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
 
 	/*
 	 * If the user asked for our exit code then don't start a
diff --git a/builtin-log.c b/builtin-log.c
index a0944f7..75d698f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -59,6 +59,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		} else
 			die("unrecognized argument: %s", arg);
 	}
+	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 }
 
 /*
diff --git a/diff.c b/diff.c
index 6f01595..608223a 100644
--- a/diff.c
+++ b/diff.c
@@ -93,12 +93,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
 
-	switch (userdiff_config_porcelain(var, value)) {
-		case 0: break;
-		case -1: return -1;
-		default: return 0;
-	}
-
 	return git_diff_basic_config(var, value, cb);
 }
 
@@ -109,6 +103,12 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	switch (userdiff_config(var, value)) {
+		case 0: break;
+		case -1: return -1;
+		default: return 0;
+	}
+
 	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
 		if (!value)
@@ -123,12 +123,6 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	switch (userdiff_config_basic(var, value)) {
-		case 0: break;
-		case -1: return -1;
-		default: return 0;
-	}
-
 	return git_color_default_config(var, value, cb);
 }
 
@@ -1335,7 +1329,7 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
-	const char *textconv_one, *textconv_two;
+	const char *textconv_one = NULL, *textconv_two = NULL;
 
 	diff_set_mnemonic_prefix(o, "a/", "b/");
 	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
@@ -1389,8 +1383,10 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	textconv_one = get_textconv(one);
-	textconv_two = get_textconv(two);
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		textconv_one = get_textconv(one);
+		textconv_two = get_textconv(two);
+	}
 
 	if (!DIFF_OPT_TST(o, TEXT) &&
 	    ( (diff_filespec_is_binary(one) && !textconv_one) ||
diff --git a/diff.h b/diff.h
index a49d865..42582ed 100644
--- a/diff.h
+++ b/diff.h
@@ -65,6 +65,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_OPT_IGNORE_SUBMODULES   (1 << 18)
 #define DIFF_OPT_DIRSTAT_CUMULATIVE  (1 << 19)
 #define DIFF_OPT_DIRSTAT_BY_FILE     (1 << 20)
+#define DIFF_OPT_ALLOW_TEXTCONV      (1 << 21)
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
 #define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 090a21d..1df48ae 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -70,7 +70,7 @@ test_expect_success 'log produces text' '
 	test_cmp expect.text actual
 '
 
-test_expect_failure 'format-patch produces binary' '
+test_expect_success 'format-patch produces binary' '
 	git format-patch --no-binary --stdout HEAD^ >patch &&
 	find_diff <patch >actual &&
 	test_cmp expect.binary actual
diff --git a/userdiff.c b/userdiff.c
index d95257a..3681062 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -120,7 +120,7 @@ static int parse_tristate(int *b, const char *k, const char *v)
 	return 1;
 }
 
-int userdiff_config_basic(const char *k, const char *v)
+int userdiff_config(const char *k, const char *v)
 {
 	struct userdiff_driver *drv;
 
@@ -130,14 +130,6 @@ int userdiff_config_basic(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
 	if ((drv = parse_driver(k, v, "binary")))
 		return parse_tristate(&drv->binary, k, v);
-
-	return 0;
-}
-
-int userdiff_config_porcelain(const char *k, const char *v)
-{
-	struct userdiff_driver *drv;
-
 	if ((drv = parse_driver(k, v, "command")))
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
diff --git a/userdiff.h b/userdiff.h
index f29c18f..ba29457 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -14,8 +14,7 @@ struct userdiff_driver {
 	const char *textconv;
 };
 
-int userdiff_config_basic(const char *k, const char *v);
-int userdiff_config_porcelain(const char *k, const char *v);
+int userdiff_config(const char *k, const char *v);
 struct userdiff_driver *userdiff_find_by_name(const char *name);
 struct userdiff_driver *userdiff_find_by_path(const char *path);
 
-- 
1.6.0.3.524.ge8b2e.dirty
