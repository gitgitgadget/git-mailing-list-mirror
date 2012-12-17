From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] log --format: teach %C(auto,black) to respect color
 config
Date: Mon, 17 Dec 2012 17:56:49 -0500
Message-ID: <20121217225649.GC1653@sigill.intra.peff.net>
References: <20121217225516.GA1408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Srb, Michal" <michal.srb11@imperial.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkjcT-0005sw-LF
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab2LQW4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:56:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57102 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab2LQW4v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 17:56:51 -0500
Received: (qmail 10882 invoked by uid 107); 17 Dec 2012 22:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Dec 2012 17:57:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2012 17:56:49 -0500
Content-Disposition: inline
In-Reply-To: <20121217225516.GA1408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211715>

From: Junio C Hamano <gitster@pobox.com>

Traditionally, %C(color attr) always emitted the ANSI color
sequence; it was up to the scripts that wanted to conditionally
color their output to omit %C(...) specifier when they do not want
colors.

Optionally allow "auto," to be prefixed to the color, so that the
output is colored iff we would color regular "log" output
(e.g., taking into account color.* and --color command line
options).

Tests and pretty_context bits by Jeff King <peff@peff.net>.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt |  6 ++++-
 commit.h                         |  1 +
 log-tree.c                       |  1 +
 pretty.c                         | 13 +++++++---
 t/t6006-rev-list-format.sh       | 55 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d9edded..105f18a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -144,7 +144,11 @@ The placeholders are:
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
 - '%Creset': reset color
-- '%C(...)': color specification, as described in color.branch.* config option
+- '%C(...)': color specification, as described in color.branch.* config option;
+  adding `auto,` at the beginning will emit color only when colors are
+  enabled for log output (by `color.diff`, `color.ui`, or `--color`, and
+  respecting the `auto` settings of the former if we are going to a
+  terminal)
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/commit.h b/commit.h
index b6ad8f3..0f469e5 100644
--- a/commit.h
+++ b/commit.h
@@ -89,6 +89,7 @@ struct pretty_print_context {
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
 	const char *output_encoding;
+	int color;
 };
 
 struct userformat_want {
diff --git a/log-tree.c b/log-tree.c
index 4f86def..8876c73 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -671,6 +671,7 @@ void show_log(struct rev_info *opt)
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
+	ctx.color = opt->diffopt.use_color;
 	pretty_print_commit(&ctx, commit, &msgbuf);
 
 	if (opt->add_signoff)
diff --git a/pretty.c b/pretty.c
index 5bdc2e7..e6a2886 100644
--- a/pretty.c
+++ b/pretty.c
@@ -960,12 +960,19 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	switch (placeholder[0]) {
 	case 'C':
 		if (placeholder[1] == '(') {
-			const char *end = strchr(placeholder + 2, ')');
+			const char *begin = placeholder + 2;
+			const char *end = strchr(begin, ')');
 			char color[COLOR_MAXLEN];
+
 			if (!end)
 				return 0;
-			color_parse_mem(placeholder + 2,
-					end - (placeholder + 2),
+			if (!memcmp(begin, "auto,", 5)) {
+				if (!want_color(c->pretty_ctx->color))
+					return end - placeholder + 1;
+				begin += 5;
+			}
+			color_parse_mem(begin,
+					end - begin,
 					"--pretty format", color);
 			strbuf_addstr(sb, color);
 			return end - placeholder + 1;
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index c0c62c9..3fc3b74 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -3,6 +3,7 @@ test_description='git rev-list --pretty=format test'
 test_description='git rev-list --pretty=format test'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_tick
 test_expect_success 'setup' '
@@ -19,6 +20,18 @@ test_format () {
 	"
 }
 
+# Feed to --format to provide predictable colored sequences.
+AUTO_COLOR='%C(auto,red)foo%C(auto,reset)'
+has_color () {
+	printf '\033[31mfoo\033[m\n' >expect &&
+	test_cmp expect "$1"
+}
+
+has_no_color () {
+	echo foo >expect &&
+	test_cmp expect "$1"
+}
+
 test_format percent %%h <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
 %h
@@ -124,6 +137,48 @@ EOF
 [1;31;43mfoo[m
 EOF
 
+test_expect_success '%C(auto) does not enable color by default' '
+	git log --format=$AUTO_COLOR -1 >actual &&
+	has_no_color actual
+'
+
+test_expect_success '%C(auto) enables colors for color.diff' '
+	git -c color.diff=always log --format=$AUTO_COLOR -1 >actual &&
+	has_color actual
+'
+
+test_expect_success '%C(auto) enables colors for color.ui' '
+	git -c color.ui=always log --format=$AUTO_COLOR -1 >actual &&
+	has_color actual
+'
+
+test_expect_success '%C(auto) respects --color' '
+	git log --format=$AUTO_COLOR -1 --color >actual &&
+	has_color actual
+'
+
+test_expect_success '%C(auto) respects --no-color' '
+	git -c color.ui=always log --format=$AUTO_COLOR -1 --no-color >actual &&
+	has_no_color actual
+'
+
+test_expect_success TTY '%C(auto) respects --color=auto (stdout is tty)' '
+	(
+		TERM=vt100 && export TERM &&
+		test_terminal \
+			git log --format=$AUTO_COLOR -1 --color=auto >actual &&
+		has_color actual
+	)
+'
+
+test_expect_success '%C(auto) respects --color=auto (stdout not tty)' '
+	(
+		TERM=vt100 && export TERM &&
+		git log --format=$AUTO_COLOR -1 --color=auto >actual &&
+		has_no_color actual
+	)
+'
+
 cat >commit-msg <<'EOF'
 Test printing of complex bodies
 
-- 
1.8.1.rc2.28.gce0611a
