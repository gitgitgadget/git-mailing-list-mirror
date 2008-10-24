From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] userdiff: require explicitly allowing textconv
Date: Thu, 23 Oct 2008 22:55:54 -0400
Message-ID: <20081024025553.GD2831@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:57:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtCrP-00057p-Jf
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYJXCz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYJXCz5
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:55:57 -0400
Received: from peff.net ([208.65.91.99]:3803 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYJXCz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:55:56 -0400
Received: (qmail 12921 invoked by uid 111); 24 Oct 2008 02:55:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 22:55:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 22:55:54 -0400
Content-Disposition: inline
In-Reply-To: <20081024024631.GA20365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99004>

Diffs that have been produced with textconv almost certainly
cannot be applied, so we want to be careful not to generate
them in things like format-patch.

This introduces a new diff options, ALLOW_TEXTCONV, which
controls this behavior. It is off by default, but is
explicitly turned on for the "log" family of commands, as
well as the "diff" porcelain.

Because both text conversion and external diffing are
controlled by these diff options, we can get rid of the
"plumbing versus porcelain" distinction when reading the
config. This was an attempt to control the same thing, but
suffered from being too coarse-grained.

Signed-off-by: Jeff King <peff@peff.net>
---
This gives us a nice run-time knob to tweak. There was a lot of
discussion last time around about exactly when text conversion should
happen. The more I think about it, I'm wondering if perhaps this should
be disabled by default, and require "git log --textconv" to activate.

Johannes, you had mentioned some heuristics. Maybe you would like to
take a stab at implementing them on top of this?

 builtin-diff.c           |    1 +
 builtin-log.c            |    1 +
 diff.c                   |   24 ++++++++++--------------
 diff.h                   |    1 +
 t/t4030-diff-textconv.sh |    2 +-
 userdiff.c               |   10 +---------
 userdiff.h               |    3 +--
 7 files changed, 16 insertions(+), 26 deletions(-)

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
index 89bd2ff..52feba7 100644
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
 
@@ -1409,9 +1403,11 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
-	if (diff_filespec_textconv(one) < 0 ||
-	    diff_filespec_textconv(two) < 0)
+	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+		if (diff_filespec_textconv(one) < 0 ||
+		    diff_filespec_textconv(two) < 0)
 			die("unable to read files to diff");
+	}
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
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
index 28d3640..e456746 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -69,7 +69,7 @@ test_expect_success 'log produces text' '
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
1.6.0.3.518.gdb328.dirty
