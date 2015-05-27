From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] diff.c: --ws-error-highlight=<kind> option
Date: Tue, 26 May 2015 23:30:32 -0700
Message-ID: <1432708232-29892-5-git-send-email-gitster@pobox.com>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
 <1432708232-29892-1-git-send-email-gitster@pobox.com>
Cc: Christian Brabandt <cblists@256bit.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 08:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxUrf-0001eY-1S
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbbE0Gaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:30:46 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35535 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbE0Gak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:30:40 -0400
Received: by igbyr2 with SMTP id yr2so77275916igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fc/xllEpJmIzPBmjXhGM9rApvlu+4pJ5o/kK1A7qeyo=;
        b=Ex2Hp2jjxE1QYSRSS0jFD4PFZhL4UuUoltP8OCcKjIR8wkLYq8ChoAHhMc5qZcy4Et
         9FfdLMeINvUT2HUfPJ/cASNo+Whd4UPbaCQy7oo7mStGNWF7NbtYCKYJ98wRiyQu6AMB
         nk2BpMZHSUGQ4cEG3NFnlXVmQxGUkPEAl+Kg0LLVzwO5nzsnhqmkCt5uTX5q4Suo52UU
         9psTFQoDdOjA6dtY5e6of7ICz1lHfA0cpolrqZFo+f6/XKyFBdFQ4gaMGfgsT+gMKU6V
         vp2Bvm2IhVErGnfMrOKgDu+2s6uMDpN97aBwJstYmCUVh1qTtHQY+sdFwBOuy73G/cDe
         V73w==
X-Received: by 10.50.27.6 with SMTP id p6mr34447981igg.46.1432708239448;
        Tue, 26 May 2015 23:30:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id g1sm12863604iog.4.2015.05.26.23.30.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 23:30:39 -0700 (PDT)
X-Mailer: git-send-email 2.4.2-503-g2442661
In-Reply-To: <1432708232-29892-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270021>

Traditionally, we only cared about whitespace breakages introduced
in new lines.  Some people want to paint whitespace breakages on old
lines, too.  When they see a whitespace breakage on a new line, they
can spot the same kind of whitespace breakage on the corresponding
old line and want to say "Ah, those breakages are there but they
were inherited from the original, so let's not touch them for now."

Introduce `--ws-error-highlight=<kind>` option, that lets them pass
a comma separated list of `old`, `new`, and `context` to specify
what lines to highlight whitespace errors on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 10 +++++
 diff.c                         | 84 +++++++++++++++++++++++++++++-------
 diff.h                         |  5 +++
 t/t4015-diff-whitespace.sh     | 96 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 16 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6cb083a..85a6547 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -278,6 +278,16 @@ ifndef::git-format-patch[]
 	initial indent of the line are considered whitespace errors.
 	Exits with non-zero status if problems are found. Not compatible
 	with --exit-code.
+
+--ws-error-highlight=<kind>::
+	Highlight whitespace errors on lines specified by <kind>
+	in the color specified by `color.diff.whitespace`.  <kind>
+	is a comma separated list of `old`, `new`, `context`.  When
+	this option is not given, only whitespace errors in `new`
+	lines are highlighted.  E.g. `--ws-error-highlight=new,old`
+	highlights whitespace errors on both deleted and added lines.
+	`all` can be used as a short-hand for `old,new,context`.
+
 endif::git-format-patch[]
 
 --full-index::
diff --git a/diff.c b/diff.c
index c575c45..34012b4 100644
--- a/diff.c
+++ b/diff.c
@@ -478,42 +478,57 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
 	return ws_blank_line(line, len, ecbdata->ws_rule);
 }
 
-static void emit_add_line(const char *reset,
-			  struct emit_callback *ecbdata,
-			  const char *line, int len)
+static void emit_line_checked(const char *reset,
+			      struct emit_callback *ecbdata,
+			      const char *line, int len,
+			      enum color_diff color,
+			      unsigned ws_error_highlight,
+			      char sign)
 {
-	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
-	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
+	const char *set = diff_get_color(ecbdata->color_diff, color);
+	const char *ws = NULL;
 
-	if (!*ws)
-		emit_line_0(ecbdata->opt, set, reset, '+', line, len);
-	else if (new_blank_line_at_eof(ecbdata, line, len))
+	if (ecbdata->opt->ws_error_highlight & ws_error_highlight) {
+		ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+		if (!*ws)
+			ws = NULL;
+	}
+
+	if (!ws)
+		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, '+', line, len);
+		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, '+', "", 0);
+		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->opt->file, set, reset, ws);
 	}
 }
 
-static void emit_del_line(const char *reset,
+static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
-	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD);
+	emit_line_checked(reset, ecbdata, line, len,
+			  DIFF_FILE_NEW, WSEH_NEW, '+');
+}
 
-	emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+static void emit_del_line(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
+{
+	emit_line_checked(reset, ecbdata, line, len,
+			  DIFF_FILE_OLD, WSEH_OLD, '-');
 }
 
 static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
-	const char *set = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
-
-	emit_line_0(ecbdata->opt, set, reset, ' ', line, len);
+	emit_line_checked(reset, ecbdata, line, len,
+			  DIFF_PLAIN, WSEH_CONTEXT, ' ');
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -3250,6 +3265,7 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = diff_context_default;
+	options->ws_error_highlight = WSEH_NEW;
 	DIFF_OPT_SET(options, RENAME_EMPTY);
 
 	/* pathchange left =NULL by default */
@@ -3636,6 +3652,40 @@ static void enable_patch_output(int *fmt) {
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
+static int parse_one_token(const char **arg, const char *token)
+{
+	return skip_prefix(*arg, token, arg) && (!**arg || **arg == ',');
+}
+
+static int parse_ws_error_highlight(struct diff_options *opt, const char *arg)
+{
+	const char *orig_arg = arg;
+	unsigned val = 0;
+	while (*arg) {
+		if (parse_one_token(&arg, "none"))
+			val = 0;
+		else if (parse_one_token(&arg, "default"))
+			val = WSEH_NEW;
+		else if (parse_one_token(&arg, "all"))
+			val = WSEH_NEW | WSEH_OLD | WSEH_CONTEXT;
+		else if (parse_one_token(&arg, "new"))
+			val |= WSEH_NEW;
+		else if (parse_one_token(&arg, "old"))
+			val |= WSEH_OLD;
+		else if (parse_one_token(&arg, "context"))
+			val |= WSEH_CONTEXT;
+		else {
+			error("unknown value after ws-error-highlight=%.*s",
+			      (int)(arg - orig_arg), orig_arg);
+			return 0;
+		}
+		if (*arg)
+			arg++;
+	}
+	opt->ws_error_highlight = val;
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3833,6 +3883,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, SUBMODULE_LOG);
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
+	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
+		return parse_ws_error_highlight(options, arg);
 
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
diff --git a/diff.h b/diff.h
index b4a624d..90c7cd6 100644
--- a/diff.h
+++ b/diff.h
@@ -137,6 +137,11 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+/* white-space error highlighting */
+#define WSEH_NEW 1
+#define WSEH_CONTEXT 2
+#define WSEH_OLD 4
+	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 4da30e5..2434157 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -838,4 +838,100 @@ test_expect_success 'diff that introduces a line with only tabs' '
 	test_cmp expected current
 '
 
+test_expect_success 'diff that introduces and removes ws breakages' '
+	git reset --hard &&
+	{
+		echo "0. blank-at-eol " &&
+		echo "1. blank-at-eol "
+	} >x &&
+	git commit -a --allow-empty -m preimage &&
+	{
+		echo "0. blank-at-eol " &&
+		echo "1. still-blank-at-eol " &&
+		echo "2. and a new line "
+	} >x &&
+
+	git -c color.diff=always diff |
+	test_decode_color >current &&
+
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/x b/x<RESET>
+	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>--- a/x<RESET>
+	<BOLD>+++ b/x<RESET>
+	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	 0. blank-at-eol <RESET>
+	<RED>-1. blank-at-eol <RESET>
+	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	EOF
+
+	test_cmp expected current
+'
+
+test_expect_success 'the same with --ws-error-highlight' '
+	git reset --hard &&
+	{
+		echo "0. blank-at-eol " &&
+		echo "1. blank-at-eol "
+	} >x &&
+	git commit -a --allow-empty -m preimage &&
+	{
+		echo "0. blank-at-eol " &&
+		echo "1. still-blank-at-eol " &&
+		echo "2. and a new line "
+	} >x &&
+
+	git -c color.diff=always diff --ws-error-highlight=default,old |
+	test_decode_color >current &&
+
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/x b/x<RESET>
+	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>--- a/x<RESET>
+	<BOLD>+++ b/x<RESET>
+	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	 0. blank-at-eol <RESET>
+	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	EOF
+
+	test_cmp expected current &&
+
+	git -c color.diff=always diff --ws-error-highlight=all |
+	test_decode_color >current &&
+
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/x b/x<RESET>
+	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>--- a/x<RESET>
+	<BOLD>+++ b/x<RESET>
+	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	 <RESET>0. blank-at-eol<RESET><BLUE> <RESET>
+	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	EOF
+
+	test_cmp expected current &&
+
+	git -c color.diff=always diff --ws-error-highlight=none |
+	test_decode_color >current &&
+
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/x b/x<RESET>
+	<BOLD>index d0233a2..700886e 100644<RESET>
+	<BOLD>--- a/x<RESET>
+	<BOLD>+++ b/x<RESET>
+	<CYAN>@@ -1,2 +1,3 @@<RESET>
+	 0. blank-at-eol <RESET>
+	<RED>-1. blank-at-eol <RESET>
+	<GREEN>+1. still-blank-at-eol <RESET>
+	<GREEN>+2. and a new line <RESET>
+	EOF
+
+	test_cmp expected current
+'
+
 test_done
-- 
2.4.2-503-g3e4528a
