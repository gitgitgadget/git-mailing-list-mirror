From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] userdiff: require explicitly allowing textconv
Date: Fri, 24 Oct 2008 20:54:39 -0400
Message-ID: <20081025005438.GE23903@coredump.intra.peff.net>
References: <20081025004815.GA23851@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 02:55:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtXRa-00043p-Vt
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 02:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbYJYAym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 20:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYJYAym
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 20:54:42 -0400
Received: from peff.net ([208.65.91.99]:1794 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbYJYAyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 20:54:41 -0400
Received: (qmail 25873 invoked by uid 111); 25 Oct 2008 00:54:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 20:54:40 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 20:54:39 -0400
Content-Disposition: inline
In-Reply-To: <20081025004815.GA23851@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99089>

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
Same idea as before, but adapted to the new calling convention for
fill_mmfile. It makes the "did we textconv this?" test a little bit
more hairy. We could perhaps just set a "we did a textconv" flag on the
mmfile, but I am also fine with it as-is (especially since there is only
one call-site).

 builtin-diff.c           |    1 +
 builtin-log.c            |    1 +
 diff.c                   |   27 ++++++++++++---------------
 diff.h                   |    1 +
 t/t4030-diff-textconv.sh |    2 +-
 userdiff.c               |   10 +---------
 userdiff.h               |    3 +--
 7 files changed, 18 insertions(+), 27 deletions(-)

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
index fcdfd7b..e3bb1ed 100644
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
 
@@ -1397,12 +1391,15 @@ static void builtin_diff(const char *name_a,
 		}
 	}
 
-	if (fill_mmfile(&mf1, one, 1) < 0 || fill_mmfile(&mf2, two, 1) < 0)
+	if (fill_mmfile(&mf1, one, DIFF_OPT_TST(o, ALLOW_TEXTCONV)) < 0 ||
+	    fill_mmfile(&mf2, two, DIFF_OPT_TST(o, ALLOW_TEXTCONV)) < 0)
 		die("unable to read files to diff");
 
 	if (!DIFF_OPT_TST(o, TEXT) &&
-	    ( (diff_filespec_is_binary(one) && !get_textconv(one)) ||
-	      (diff_filespec_is_binary(two) && !get_textconv(two)) )) {
+	    ( (diff_filespec_is_binary(one) &&
+	       !(DIFF_OPT_TST(o, ALLOW_TEXTCONV) && get_textconv(one))) ||
+	      (diff_filespec_is_binary(two) &&
+	       !(DIFF_OPT_TST(o, ALLOW_TEXTCONV) && get_textconv(two))) )) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
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
1.6.0.3.523.g38597.dirty
