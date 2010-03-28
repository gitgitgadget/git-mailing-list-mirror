From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] diff: add "fasttextconv" config option
Date: Sun, 28 Mar 2010 10:54:21 -0400
Message-ID: <20100328145421.GC27970@coredump.intra.peff.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 16:54:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvtsq-0001LU-5q
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 16:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab0C1Oyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 10:54:31 -0400
Received: from peff.net ([208.65.91.99]:60646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab0C1Oya (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 10:54:30 -0400
Received: (qmail 24195 invoked by uid 107); 28 Mar 2010 14:55:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 10:55:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 10:54:21 -0400
Content-Disposition: inline
In-Reply-To: <20100328145301.GA26213@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143392>

The normal textconv procedure is to dump the binary file to
a tempfile (optionally using a working tree file if
available), then run the textconv helper to produce a
textual version on stdout. This is a very convenient
interface, as helpers don't need to be aware of git at all
and many standard commands can be used without wrappers.

Unfortunately, it can be slow for large binary files. We
spool the file to disk before invoking the textconv helper,
so the helper has no way to do any optimizations. For
example, the helper may need only part of the file (e.g.,
when showing metadata at the beginning of a media file), or
it may implement a caching scheme to avoid repeating
expensive conversions.

This patch introduces diff.*.fasttextconv, which invokes the
textconv helper with the sha1 of the blob to be converted.
The helper can then retrieve the file with git-cat-file if
necessary.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitattributes.txt |   11 +++++++++++
 diff.c                          |   32 ++++++++++++++++++++++++++++++++
 t/t4030-diff-textconv.sh        |   15 +++++++++++++++
 userdiff.c                      |    8 +++++---
 userdiff.h                      |    1 +
 5 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index d892e64..6066256 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -414,6 +414,17 @@ because it quickly conveys the changes you have made), you
 should generate it separately and send it as a comment _in
 addition to_ the usual binary diff that you might send.
 
+The `fasttextconv` config option is similar to `textconv`, but
+uses a different interface that provides more opporunity for
+optimization at the cost of increased complexity. The program
+specified by `fasttextconv` receives on the command line the sha1
+of the blob to be converted and the pathname, if any, from which
+the blob was accessed. It is the responsibility of the invoked
+program to retrieve the blob's contents (e.g., using `git
+cat-file blob $sha1`). This allows the helper program to avoid
+looking at the blob contents in some situations (e.g., if it
+implements a caching layer keyed by sha1).
+
 
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/diff.c b/diff.c
index 0d31320..5208d4d 100644
--- a/diff.c
+++ b/diff.c
@@ -3883,6 +3883,36 @@ static char *run_textconv_simple(const char *pgm, struct diff_filespec *spec,
 	return strbuf_detach(&buf, outsize);
 }
 
+static char *run_textconv_fast(const char *pgm, struct diff_filespec *spec,
+		size_t *outsize)
+{
+	const char *argv[4];
+	const char **arg = argv;
+	struct child_process child;
+	struct strbuf buf = STRBUF_INIT;
+
+	*arg++ = pgm;
+	*arg++ = sha1_to_hex(spec->sha1);
+	*arg++ = spec->path;
+	*arg = NULL;
+
+	memset(&child, 0, sizeof(child));
+	child.use_shell = 1;
+	child.argv = argv;
+	child.out = -1;
+	if (start_command(&child) != 0 ||
+	    strbuf_read(&buf, child.out, 0) < 0 ||
+	    finish_command(&child) != 0) {
+		close(child.out);
+		strbuf_release(&buf);
+		error("error running textconv command '%s'", pgm);
+		return NULL;
+	}
+	close(child.out);
+
+	return strbuf_detach(&buf, outsize);
+}
+
 static size_t fill_textconv(struct userdiff_extcmd *cmd,
 			    struct diff_filespec *df,
 			    char **outbuf)
@@ -3896,6 +3926,8 @@ static size_t fill_textconv(struct userdiff_extcmd *cmd,
 
 	if (cmd->interface == USERDIFF_EXTCMD_SIMPLE)
 		*outbuf = run_textconv_simple(cmd->cmd, df, &size);
+	else if (cmd->interface == USERDIFF_EXTCMD_FAST)
+		*outbuf = run_textconv_fast(cmd->cmd, df, &size);
 	else
 		die("BUG: invalid internal textconv type");
 
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 88c5619..4b62434 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -25,6 +25,13 @@ perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
 EOF
 chmod +x hexdump
 
+cat >hexdump.fast <<'EOF'
+#!/bin/sh
+git cat-file blob "$1" |
+perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_'
+EOF
+chmod +x hexdump.fast
+
 test_expect_success 'setup binary file with history' '
 	printf "\\0\\n" >file &&
 	git add file &&
@@ -49,6 +56,7 @@ test_expect_success 'file is considered binary by plumbing' '
 test_expect_success 'setup textconv filters' '
 	echo file diff=foo >.gitattributes &&
 	git config diff.foo.textconv "\"$(pwd)\""/hexdump &&
+	git config diff.fast.fasttextconv "\"$(pwd)\""/hexdump.fast &&
 	git config diff.fail.textconv false
 '
 
@@ -84,6 +92,13 @@ test_expect_success 'status -v produces text' '
 	git reset --soft HEAD@{1}
 '
 
+test_expect_success 'fast textconv works' '
+	echo file diff=fast >.gitattributes &&
+	git diff HEAD^ HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.text actual
+'
+
 cat >expect.stat <<'EOF'
  file |  Bin 2 -> 4 bytes
  1 files changed, 0 insertions(+), 0 deletions(-)
diff --git a/userdiff.c b/userdiff.c
index 6850f21..c913dc2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -159,9 +159,9 @@ static int parse_string(const char **d, const char *k, const char *v)
 }
 
 static int parse_extcmd(struct userdiff_extcmd *e, const char *k,
-		const char *v)
+		const char *v, enum userdiff_extcmd_interface type)
 {
-	e->interface = USERDIFF_EXTCMD_SIMPLE;
+	e->interface = type;
 	return parse_string(&e->cmd, k, v);
 }
 
@@ -187,7 +187,9 @@ int userdiff_config(const char *k, const char *v)
 	if ((drv = parse_driver(k, v, "command")))
 		return parse_string(&drv->external, k, v);
 	if ((drv = parse_driver(k, v, "textconv")))
-		return parse_extcmd(&drv->textconv, k, v);
+		return parse_extcmd(&drv->textconv, k, v, USERDIFF_EXTCMD_SIMPLE);
+	if ((drv = parse_driver(k, v, "fasttextconv")))
+		return parse_extcmd(&drv->textconv, k, v, USERDIFF_EXTCMD_FAST);
 	if ((drv = parse_driver(k, v, "wordregex")))
 		return parse_string(&drv->word_regex, k, v);
 
diff --git a/userdiff.h b/userdiff.h
index 0c1ac06..84fd3df 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -9,6 +9,7 @@ struct userdiff_funcname {
 enum userdiff_extcmd_interface {
 	USERDIFF_EXTCMD_NONE = 0,
 	USERDIFF_EXTCMD_SIMPLE,
+	USERDIFF_EXTCMD_FAST,
 };
 
 struct userdiff_extcmd {
-- 
1.7.0.3.294.g8e730.dirty
