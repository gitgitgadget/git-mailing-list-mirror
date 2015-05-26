From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] diff.c: --ws-check-deleted option
Date: Tue, 26 May 2015 12:46:24 -0700
Message-ID: <1432669584-342-5-git-send-email-gitster@pobox.com>
References: <xmqq1ti3kz5v.fsf@gitster.dls.corp.google.com>
 <1432669584-342-1-git-send-email-gitster@pobox.com>
Cc: Christian Brabandt <cblists@256bit.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 21:46:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKoF-0001ob-BL
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbbEZTqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:46:38 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37072 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbEZTqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:46:32 -0400
Received: by igbsb11 with SMTP id sb11so62034789igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2n9WY53a40yMzItpgfJODTjZSNKNSfq6dDXePXn8slQ=;
        b=KTASwuj6It2TDj7xzLxKFmW7rxm2KyiKLoIyLlfI94vM48hGRcngkaUOH+MVBND1ET
         F37iC98jDgZ2YUS0wg8U9d75s6ocffln9YjshfOEupf0ufms3sSXzlJzCFHmxN2bE2Si
         PXxZWo9dkoJd/J6viefCiKA0USW7NXBQB/uXXS7KB3vcMRCE17EViqsPQZa6+5f0p5FD
         ipIuZ+VOuU/gse/L7hpeXj8UoiVg8xhllLsG+xkztzt9qF5PNlu6OC1HQt2IF6IJ6pU0
         Eu8NL4lnh9XgMNXJ748VsCgVNw3iGZKxFTDvUQEMchPmR/JbfnX2UEDS2kbtVq2E92dw
         02MA==
X-Received: by 10.42.81.6 with SMTP id x6mr32330130ick.89.1432669591726;
        Tue, 26 May 2015 12:46:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id q78sm11719365ioe.9.2015.05.26.12.46.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 12:46:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.1-511-gc1146d5
In-Reply-To: <1432669584-342-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269969>

Traditionally, we only cared about whitespace breakages introduced
in new lines.  Some people want to paint whitespace breakages on old
lines, too.  When they see a whitespace breakage on a new line, they
can spot the same kind of whitespace breakage on the corresponding
old line and want to say "Ah, those breakages are there but they
were inherited from the original, so let's not touch them for now."

Enable such use case with the new option, "--ws-check-deleted".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  7 +++++
 diff.c                         | 21 +++++++++++++-
 diff.h                         |  1 +
 t/t4015-diff-whitespace.sh     | 62 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6cb083a..701c087 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -278,6 +278,13 @@ ifndef::git-format-patch[]
 	initial indent of the line are considered whitespace errors.
 	Exits with non-zero status if problems are found. Not compatible
 	with --exit-code.
+
+--ws-check-deleted::
+--no-ws-check-deleted::
+	Highlight whitespace errors in deleted lines in the color
+	specified by `color.diff.whitespace`, as well as in added
+	lines.
+
 endif::git-format-patch[]
 
 --full-index::
diff --git a/diff.c b/diff.c
index 75b1342..30eeaea 100644
--- a/diff.c
+++ b/diff.c
@@ -503,8 +503,22 @@ static void emit_del_line(const char *reset,
 			  const char *line, int len)
 {
 	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD);
+	const char *ws = NULL;
 
-	emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+	if (ecbdata->opt->ws_check_deleted) {
+		ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+		if (!*ws)
+			ws = NULL;
+	}
+
+	if (!ws)
+		emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(ecbdata->opt, set, reset, '-', "", 0);
+		ws_check_emit(line, len, ecbdata->ws_rule,
+			      ecbdata->opt->file, set, reset, ws);
+	}
 }
 
 static void emit_hunk_header(struct emit_callback *ecbdata,
@@ -3823,6 +3837,11 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (skip_prefix(arg, "--submodule=", &arg))
 		return parse_submodule_opt(options, arg);
 
+	else if (!strcmp(arg, "--ws-check-deleted"))
+		options->ws_check_deleted = 1;
+	else if (!strcmp(arg, "--no-ws-check-deleted"))
+		options->ws_check_deleted = 0;
+
 	/* misc options */
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
diff --git a/diff.h b/diff.h
index b4a624d..ba6cf1a 100644
--- a/diff.h
+++ b/diff.h
@@ -137,6 +137,7 @@ struct diff_options {
 	int dirstat_permille;
 	int setup;
 	int abbrev;
+	int ws_check_deleted;
 	const char *prefix;
 	int prefix_length;
 	const char *stat_sep;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 4da30e5..8f35475 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -838,4 +838,66 @@ test_expect_success 'diff that introduces a line with only tabs' '
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
+test_expect_success 'the same with --ws-check-deleted' '
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
+	git -c color.diff=always diff --ws-check-deleted |
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
+	test_cmp expected current
+'
+
 test_done
-- 
2.4.1-511-gc1146d5
