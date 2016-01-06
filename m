From: Tobias Klauser <tobias.klauser@zhinst.com>
Subject: [PATCH] interpret-trailers: add option for in-place editing
Date: Wed,  6 Jan 2016 14:34:18 +0100
Message-ID: <1452087258-3893-1-git-send-email-tobias.klauser@zhinst.com>
Cc: git@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 14:34:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGoEV-0004wp-GX
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 14:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbcAFNe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 08:34:27 -0500
Received: from mail.zhinst.com ([212.126.164.98]:48815 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbcAFNeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 08:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=zhinst.com; s=mail;
	h=from:subject:date:message-id:to:cc;
	bh=pNWLGFguD1IDt2L0Oi+qsXx4mepPjerXA+FvEf5A/0k=;
	b=V67Dq/iR8vzUwlaPuIX3Z43bMvwP//cYBeDuB6XGlcPkJ3nL2IQYQfyuwO42zg0w5jjYiWLhLDjAu
	 AGZ9WDTb0cMrsbKgEJxL/vKEmChhwdrhGEdUkpcL6NQYiSXNEgDfAcPHz1Yhe2rWLGOPiB9ctBfA2s
	 tNFTGKWsGaz2lyEDp9we52MhunkHONdJ02GNPkp5atjZVPZBD7yoKa+PP+3GO/OU9DApu2kqX3jOou
	 I2Fyif74Lu2wTWr5v0rxo/z1pFF4rVePTUpwc/FejngMBO99lqo/OaOVAtYGIF/f5ml51eDmf2paH3
	 AVs5/qimKcqi/NWEHpMjBgyf2a5/+9A==
X-Footer: emhpbnN0LmNvbQ==
Received: from ziws06.zhinst.com ([10.42.0.7])
	by mail.zhinst.com (Kerio Connect 9.0.1) with ESMTP;
	Wed, 6 Jan 2016 14:34:18 +0100
X-Mailer: git-send-email 2.6.3.368.gf34be46.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283445>

From: Tobias Klauser <tklauser@distanz.ch>

Add a command line option --in-place to support in-place editing akin to
sed -i.  This allows to write commands like the following:

  git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt

in a more concise way:

  git interpret-trailers --trailer "X: Y" --in-place a.txt

Also add the corresponding documentation and tests.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 Documentation/git-interpret-trailers.txt | 24 +++++++++++++++++++-
 builtin/interpret-trailers.c             | 13 +++++++----
 t/t7513-interpret-trailers.sh            | 32 ++++++++++++++++++++++++++
 trailer.c                                | 39 ++++++++++++++++++++------------
 trailer.h                                |  3 ++-
 5 files changed, 91 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 0ecd497c4de7..a77b901f1d7b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -8,7 +8,7 @@ git-interpret-trailers - help add structured information into commit messages
 SYNOPSIS
 --------
 [verse]
-'git interpret-trailers' [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
+'git interpret-trailers' [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]
 
 DESCRIPTION
 -----------
@@ -64,6 +64,9 @@ folding rules, the encoding rules and probably many other rules.
 
 OPTIONS
 -------
+--in-place::
+	Edit the files in place.
+
 --trim-empty::
 	If the <value> part of any trailer contains only whitespace,
 	the whole trailer will be removed from the resulting message.
@@ -216,6 +219,25 @@ Signed-off-by: Alice <alice@example.com>
 Signed-off-by: Bob <bob@example.com>
 ------------
 
+* Use the '--in-place' option to edit a message file in place:
++
+------------
+$ cat msg.txt
+subject
+
+message
+
+Signed-off-by: Bob <bob@example.com>
+$ git interpret-trailers --trailer 'Acked-by: Alice <alice@example.com>' --in-place msg.txt
+$ cat msg.txt
+subject
+
+message
+
+Signed-off-by: Bob <bob@example.com>
+Acked-by: Alice <alice@example.com>
+------------
+
 * Extract the last commit as a patch, and add a 'Cc' and a
   'Reviewed-by' trailer to it:
 +
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 46838d24a90a..b99ae4be8875 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -12,16 +12,18 @@
 #include "trailer.h"
 
 static const char * const git_interpret_trailers_usage[] = {
-	N_("git interpret-trailers [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
+	N_("git interpret-trailers [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
 	NULL
 };
 
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
+	int in_place = 0;
 	int trim_empty = 0;
 	struct string_list trailers = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
+		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
 		OPT_STRING_LIST(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add")),
@@ -34,9 +36,12 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], trim_empty, &trailers);
-	} else
-		process_trailers(NULL, trim_empty, &trailers);
+			process_trailers(argv[i], in_place, trim_empty, &trailers);
+	} else {
+		if (in_place)
+			die(_("no input file given for in-place editing"));
+		process_trailers(NULL, in_place, trim_empty, &trailers);
+	}
 
 	string_list_clear(&trailers, 0);
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 322c436a494c..1103a4838b5c 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -326,6 +326,38 @@ test_expect_success 'with complex patch, args and --trim-empty' '
 	test_cmp expected actual
 '
 
+test_expect_success 'in-place editing with basic patch' '
+	cat basic_message >message &&
+	cat basic_patch >>message &&
+	cat basic_message >expected &&
+	echo >>expected &&
+	cat basic_patch >>expected &&
+	git interpret-trailers --in-place message &&
+	test_cmp expected message
+'
+
+test_expect_success 'in-place editing with additional trailer' '
+	cat basic_message >message &&
+	cat basic_patch >>message &&
+	cat basic_message >expected &&
+	echo >>expected &&
+	cat >>expected <<-\EOF &&
+		Reviewed-by: Alice
+	EOF
+	cat basic_patch >>expected &&
+	git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
+	test_cmp expected message
+'
+
+test_expect_success 'in-place editing on stdin' '
+	test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place < basic_message
+'
+
+test_expect_success 'in-place editing on non-existing file' '
+	test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place nonexisting &&
+	test_path_is_missing nonexisting
+'
+
 test_expect_success 'using "where = before"' '
 	git config trailer.bug.where "before" &&
 	cat complex_message_body >expected &&
diff --git a/trailer.c b/trailer.c
index 6f3416febaba..e05fa0e9ce93 100644
--- a/trailer.c
+++ b/trailer.c
@@ -108,23 +108,23 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(const char *tok, const char *val)
+static void print_tok_val(FILE *fp, const char *tok, const char *val)
 {
 	char c = last_non_space_char(tok);
 	if (!c)
 		return;
 	if (strchr(separators, c))
-		printf("%s%s\n", tok, val);
+		fprintf(fp, "%s%s\n", tok, val);
 	else
-		printf("%s%c %s\n", tok, separators[0], val);
+		fprintf(fp, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void print_all(struct trailer_item *first, int trim_empty)
+static void print_all(FILE *fp, struct trailer_item *first, int trim_empty)
 {
 	struct trailer_item *item;
 	for (item = first; item; item = item->next) {
 		if (!trim_empty || strlen(item->value) > 0)
-			print_tok_val(item->token, item->value);
+			print_tok_val(fp, item->token, item->value);
 	}
 }
 
@@ -795,14 +795,15 @@ static int has_blank_line_before(struct strbuf **lines, int start)
 	return 0;
 }
 
-static void print_lines(struct strbuf **lines, int start, int end)
+static void print_lines(FILE *fp, struct strbuf **lines, int start, int end)
 {
 	int i;
 	for (i = start; lines[i] && i < end; i++)
-		printf("%s", lines[i]->buf);
+		fprintf(fp, "%s", lines[i]->buf);
 }
 
-static int process_input_file(struct strbuf **lines,
+static int process_input_file(FILE *fp,
+			      struct strbuf **lines,
 			      struct trailer_item **in_tok_first,
 			      struct trailer_item **in_tok_last)
 {
@@ -818,10 +819,10 @@ static int process_input_file(struct strbuf **lines,
 	trailer_start = find_trailer_start(lines, trailer_end);
 
 	/* Print lines before the trailers as is */
-	print_lines(lines, 0, trailer_start);
+	print_lines(fp, lines, 0, trailer_start);
 
 	if (!has_blank_line_before(lines, trailer_start - 1))
-		printf("\n");
+		fprintf(fp, "\n");
 
 	/* Parse trailer lines */
 	for (i = trailer_start; i < trailer_end; i++) {
@@ -842,13 +843,14 @@ static void free_all(struct trailer_item **first)
 	}
 }
 
-void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
 {
 	struct trailer_item *in_tok_first = NULL;
 	struct trailer_item *in_tok_last = NULL;
 	struct trailer_item *arg_tok_first;
 	struct strbuf **lines;
 	int trailer_end;
+	FILE *fp = stdout;
 
 	/* Default config must be setup first */
 	git_config(git_trailer_default_config, NULL);
@@ -856,19 +858,28 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 
 	lines = read_input_file(file);
 
+	if (in_place) {
+		fp = fopen(file, "w");
+		if (!fp)
+			die_errno(_("could not open file '%s' for writing"), file);
+	}
+
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(lines, &in_tok_first, &in_tok_last);
+	trailer_end = process_input_file(fp, lines, &in_tok_first, &in_tok_last);
 
 	arg_tok_first = process_command_line_args(trailers);
 
 	process_trailers_lists(&in_tok_first, &in_tok_last, &arg_tok_first);
 
-	print_all(in_tok_first, trim_empty);
+	print_all(fp, in_tok_first, trim_empty);
 
 	free_all(&in_tok_first);
 
 	/* Print the lines after the trailers as is */
-	print_lines(lines, trailer_end, INT_MAX);
+	print_lines(fp, lines, trailer_end, INT_MAX);
+
+	if (in_place)
+		fclose(fp);
 
 	strbuf_list_free(lines);
 }
diff --git a/trailer.h b/trailer.h
index 8eb25d565e28..36b40b81761f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -1,6 +1,7 @@
 #ifndef TRAILER_H
 #define TRAILER_H
 
-void process_trailers(const char *file, int trim_empty, struct string_list *trailers);
+void process_trailers(const char *file, int in_place, int trim_empty,
+		      struct string_list *trailers);
 
 #endif /* TRAILER_H */
-- 
2.6.3.368.gf34be46.dirty
