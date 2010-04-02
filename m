From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] diff: cache textconv output
Date: Thu, 1 Apr 2010 20:12:15 -0400
Message-ID: <20100402001215.GF16462@coredump.intra.peff.net>
References: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:12:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUV1-0002Gz-T5
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab0DBAMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:12:31 -0400
Received: from peff.net ([208.65.91.99]:46465 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643Ab0DBAMa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:12:30 -0400
Received: (qmail 5249 invoked by uid 107); 2 Apr 2010 00:13:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:13:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:12:15 -0400
Content-Disposition: inline
In-Reply-To: <20100402000159.GA15101@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143767>

Running a textconv filter can take a long time. It's
particularly bad for a large file which needs to be spooled
to disk, but even for small files, the fork+exec overhead
can add up for something like "git log -p".

This patch uses the notes-cache mechanism to keep a fast
cache of textconv output. Caches are stored in
refs/notes/textconv/$x, where $x is the userdiff driver
defined in gitattributes.

Caching is enabled only if diff.$x.cachetextconv is true.

In my test repo, on a commit with 45 jpg and avi files
changed and a textconv to show their exif tags:

  [before]
  $ time git show >/dev/null
  real    0m13.724s
  user    0m12.057s
  sys     0m1.624s

  [after, first run]
  $ git config diff.mfo.cachetextconv true
  $ time git show >/dev/null
  real    0m14.252s
  user    0m12.197s
  sys     0m1.800s

  [after, subsequent runs]
  $ time git show >/dev/null
  real    0m0.352s
  user    0m0.148s
  sys     0m0.200s

So for a slight (3.8%) cost on the first run, we achieve an
almost 40x speed up on subsequent runs.

Signed-off-by: Jeff King <peff@peff.net>
---
The moral equivalent of what I posted earlier, but most of the heavy
lifting is in notes-cache.[ch] from earlier in the series.

It's off by default. I think it should probably swithc to on by default,
but I figured we could let the feature mature a bit first.

 Documentation/gitattributes.txt  |   20 +++++++
 diff.c                           |   52 +++++++++++++++---
 t/t4042-diff-textconv-caching.sh |  109 ++++++++++++++++++++++++++++++++++++++
 userdiff.c                       |    9 +++
 userdiff.h                       |    4 ++
 5 files changed, 185 insertions(+), 9 deletions(-)
 create mode 100755 t/t4042-diff-textconv-caching.sh

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d892e64..a8500d1 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -414,6 +414,26 @@ because it quickly conveys the changes you have made), you
 should generate it separately and send it as a comment _in
 addition to_ the usual binary diff that you might send.
 
+Because text conversion can be slow, especially when doing a
+large number of them with `git log -p`, git provides a mechanism
+to cache the output and use it in future diffs.  To enable
+caching, set the "cachetextconv" variable in your diff driver's
+config. For example:
+
+------------------------
+[diff "jpg"]
+	textconv = exif
+	cachetextconv = true
+------------------------
+
+This will cache the result of running "exif" on each blob
+indefinitely. If you change the textconv config variable for a
+diff driver, git will automatically invalidate the cache entries
+and re-run the textconv filter. If you want to invalidate the
+cache manually (e.g., because your version of "exif" was updated
+and now produces better output), you can remove the cache
+manually with `git update-ref -d refs/notes/textconv/jpg` (where
+"jpg" is the name of the diff driver, as in the example above).
 
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/diff.c b/diff.c
index 9665d6d..72d8503 100644
--- a/diff.c
+++ b/diff.c
@@ -43,7 +43,7 @@ static char diff_colors[][COLOR_MAXLEN] = {
 };
 
 static void diff_filespec_load_driver(struct diff_filespec *one);
-static size_t fill_textconv(const char *cmd,
+static size_t fill_textconv(struct userdiff_driver *driver,
 			    struct diff_filespec *df, char **outbuf);
 
 static int parse_diff_color_slot(const char *var, int ofs)
@@ -466,8 +466,8 @@ static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
 			      struct diff_filespec *two,
-			      const char *textconv_one,
-			      const char *textconv_two,
+			      struct userdiff_driver *textconv_one,
+			      struct userdiff_driver *textconv_two,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
@@ -1569,14 +1569,26 @@ void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const
 		options->b_prefix = b;
 }
 
-static const char *get_textconv(struct diff_filespec *one)
+static struct userdiff_driver *get_textconv(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
 	if (!S_ISREG(one->mode))
 		return NULL;
 	diff_filespec_load_driver(one);
-	return one->driver->textconv;
+	if (!one->driver->textconv)
+		return NULL;
+
+	if (one->driver->textconv_want_cache && !one->driver->textconv_cache) {
+		struct notes_cache *c = xmalloc(sizeof(*c));
+		struct strbuf name = STRBUF_INIT;
+
+		strbuf_addf(&name, "textconv/%s", one->driver->name);
+		notes_cache_init(c, name.buf, one->driver->textconv);
+		one->driver->textconv_cache = c;
+	}
+
+	return one->driver;
 }
 
 static void builtin_diff(const char *name_a,
@@ -1593,7 +1605,8 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 	const char *a_prefix, *b_prefix;
-	const char *textconv_one = NULL, *textconv_two = NULL;
+	struct userdiff_driver *textconv_one = NULL;
+	struct userdiff_driver *textconv_two = NULL;
 	struct strbuf header = STRBUF_INIT;
 
 	if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
@@ -3888,13 +3901,13 @@ static char *run_textconv(const char *pgm, struct diff_filespec *spec,
 	return strbuf_detach(&buf, outsize);
 }
 
-static size_t fill_textconv(const char *cmd,
+static size_t fill_textconv(struct userdiff_driver *driver,
 			    struct diff_filespec *df,
 			    char **outbuf)
 {
 	size_t size;
 
-	if (!cmd) {
+	if (!driver || !driver->textconv) {
 		if (!DIFF_FILE_VALID(df)) {
 			*outbuf = "";
 			return 0;
@@ -3905,8 +3918,29 @@ static size_t fill_textconv(const char *cmd,
 		return df->size;
 	}
 
-	*outbuf = run_textconv(cmd, df, &size);
+	if (driver->textconv_cache) {
+		*outbuf = notes_cache_get(driver->textconv_cache, df->sha1,
+					  &size);
+		if (*outbuf)
+			return size;
+	}
+
+	*outbuf = run_textconv(driver->textconv, df, &size);
 	if (!*outbuf)
 		die("unable to read files to diff");
+
+	if (driver->textconv_cache) {
+		/* ignore errors, as we might be in a readonly repository */
+		notes_cache_put(driver->textconv_cache, df->sha1, *outbuf,
+				size);
+		/*
+		 * we could save up changes and flush them all at the end,
+		 * but we would need an extra call after all diffing is done.
+		 * Since generating a cache entry is the slow path anyway,
+		 * this extra overhead probably isn't a big deal.
+		 */
+		notes_cache_write(driver->textconv_cache);
+	}
+
 	return size;
 }
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
new file mode 100755
index 0000000..91f8198
--- /dev/null
+++ b/t/t4042-diff-textconv-caching.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description='test textconv caching'
+. ./test-lib.sh
+
+cat >helper <<'EOF'
+#!/bin/sh
+sed 's/^/converted: /' "$@" >helper.out
+cat helper.out
+EOF
+chmod +x helper
+
+test_expect_success 'setup' '
+	echo foo content 1 >foo.bin &&
+	echo bar content 1 >bar.bin &&
+	git add . &&
+	git commit -m one &&
+	echo foo content 2 >foo.bin &&
+	echo bar content 2 >bar.bin &&
+	git commit -a -m two &&
+	echo "*.bin diff=magic" >.gitattributes &&
+	git config diff.magic.textconv ./helper &&
+	git config diff.magic.cachetextconv true
+'
+
+cat >expect <<EOF
+diff --git a/bar.bin b/bar.bin
+index fcf9166..28283d5 100644
+--- a/bar.bin
++++ b/bar.bin
+@@ -1 +1 @@
+-converted: bar content 1
++converted: bar content 2
+diff --git a/foo.bin b/foo.bin
+index d5b9fe3..1345db2 100644
+--- a/foo.bin
++++ b/foo.bin
+@@ -1 +1 @@
+-converted: foo content 1
++converted: foo content 2
+EOF
+
+test_expect_success 'first textconv works' '
+	git diff HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cached textconv produces same output' '
+	git diff HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cached textconv does not run helper' '
+	rm -f helper.out &&
+	git diff HEAD^ HEAD >actual &&
+	test_cmp expect actual &&
+	! test -r helper.out
+'
+
+cat >expect <<EOF
+diff --git a/bar.bin b/bar.bin
+index fcf9166..28283d5 100644
+--- a/bar.bin
++++ b/bar.bin
+@@ -1,2 +1,2 @@
+ converted: other
+-converted: bar content 1
++converted: bar content 2
+diff --git a/foo.bin b/foo.bin
+index d5b9fe3..1345db2 100644
+--- a/foo.bin
++++ b/foo.bin
+@@ -1,2 +1,2 @@
+ converted: other
+-converted: foo content 1
++converted: foo content 2
+EOF
+test_expect_success 'changing textconv invalidates cache' '
+	echo other >other &&
+	git config diff.magic.textconv "./helper other" &&
+	git diff HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
+diff --git a/bar.bin b/bar.bin
+index fcf9166..28283d5 100644
+--- a/bar.bin
++++ b/bar.bin
+@@ -1,2 +1,2 @@
+ converted: other
+-converted: bar content 1
++converted: bar content 2
+diff --git a/foo.bin b/foo.bin
+index d5b9fe3..1345db2 100644
+--- a/foo.bin
++++ b/foo.bin
+@@ -1 +1 @@
+-converted: foo content 1
++converted: foo content 2
+EOF
+test_expect_success 'switching diff driver produces correct results' '
+	git config diff.moremagic.textconv ./helper &&
+	echo foo.bin diff=moremagic >>.gitattributes &&
+	git diff HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/userdiff.c b/userdiff.c
index df99249..67003fb 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "userdiff.h"
 #include "cache.h"
 #include "attr.h"
@@ -167,6 +168,12 @@ static int parse_tristate(int *b, const char *k, const char *v)
 	return 1;
 }
 
+static int parse_bool(int *b, const char *k, const char *v)
+{
+	*b = git_config_bool(k, v);
+	return 1;
+}
+
 int userdiff_config(const char *k, const char *v)
 {
 	struct userdiff_driver *drv;
@@ -181,6 +188,8 @@ int userdiff_config(const char *k, const char *v)
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
 		return parse_string(&drv->textconv, k, v);
+	if ((drv = parse_driver(k, v, "cachetextconv")))
+		return parse_bool(&drv->textconv_want_cache, k, v);
 	if ((drv = parse_driver(k, v, "wordregex")))
 		return parse_string(&drv->word_regex, k, v);
 
diff --git a/userdiff.h b/userdiff.h
index c315159..942d594 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -1,6 +1,8 @@
 #ifndef USERDIFF_H
 #define USERDIFF_H
 
+#include "notes-cache.h"
+
 struct userdiff_funcname {
 	const char *pattern;
 	int cflags;
@@ -13,6 +15,8 @@ struct userdiff_driver {
 	struct userdiff_funcname funcname;
 	const char *word_regex;
 	const char *textconv;
+	struct notes_cache *textconv_cache;
+	int textconv_want_cache;
 };
 
 int userdiff_config(const char *k, const char *v);
-- 
1.7.0.4.299.gba9d4
