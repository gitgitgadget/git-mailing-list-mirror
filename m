From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 2/2] interpret-trailers: add option for in-place editing
Date: Mon, 11 Jan 2016 14:33:33 +0100
Message-ID: <1452519213-1819-3-git-send-email-tklauser@distanz.ch>
References: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 14:33:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIcbR-0000lV-D0
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 14:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759619AbcAKNdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 08:33:41 -0500
Received: from mail.zhinst.com ([212.126.164.98]:52494 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759566AbcAKNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 08:33:39 -0500
Received: from ziws06.zhinst.com ([10.42.0.7])
	by mail.zhinst.com (Kerio Connect 9.0.1) with ESMTP;
	Mon, 11 Jan 2016 14:33:33 +0100
X-Mailer: git-send-email 2.7.0.1.g5e091f5
In-Reply-To: <1452519213-1819-1-git-send-email-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283646>

Add a command line option --in-place to support in-place editing akin to
sed -i.  This allows to write commands like the following:

  git interpret-trailers --trailer "X: Y" a.txt > b.txt && mv b.txt a.txt

in a more concise way:

  git interpret-trailers --trailer "X: Y" --in-place a.txt

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 Documentation/git-interpret-trailers.txt | 24 +++++++++++++++++++++-
 builtin/interpret-trailers.c             | 13 ++++++++----
 t/t7513-interpret-trailers.sh            | 32 +++++++++++++++++++++++++++++
 trailer.c                                | 35 +++++++++++++++++++++++++++++++-
 trailer.h                                |  3 ++-
 5 files changed, 100 insertions(+), 7 deletions(-)

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
index 176fac213450..a52bd045be8d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -2,6 +2,7 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
+#include "tempfile.h"
 #include "trailer.h"
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
@@ -843,7 +844,9 @@ static void free_all(struct trailer_item **first)
 	}
 }
 
-void process_trailers(const char *file, int trim_empty, struct string_list *trailers)
+static struct tempfile trailers_tempfile;
+
+void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
 {
 	struct trailer_item *in_tok_first = NULL;
 	struct trailer_item *in_tok_last = NULL;
@@ -858,6 +861,31 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 
 	lines = read_input_file(file);
 
+	if (in_place) {
+		struct stat st;
+		struct strbuf template = STRBUF_INIT;
+		const char *tail;
+
+		if (stat(file, &st))
+			die_errno(_("could not stat %s"), file);
+		if (!S_ISREG(st.st_mode))
+			die(_("file %s is not a regular file"), file);
+		if (!(st.st_mode & S_IWUSR))
+			die(_("file %s is not writable by user"), file);
+
+		/* Create temporary file in the same directory as the original */
+		tail = strrchr(file, '/');
+		if (tail != NULL)
+			strbuf_add(&template, file, tail - file + 1);
+		strbuf_addstr(&template, "git-interpret-trailers-XXXXXX");
+
+		xmks_tempfile_m(&trailers_tempfile, template.buf, st.st_mode);
+		strbuf_release(&template);
+		outfile = fdopen_tempfile(&trailers_tempfile, "w");
+		if (!outfile)
+			die_errno(_("could not fdopen tempfile"));
+	}
+
 	/* Print the lines before the trailers */
 	trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
 
@@ -872,5 +900,10 @@ void process_trailers(const char *file, int trim_empty, struct string_list *trai
 	/* Print the lines after the trailers as is */
 	print_lines(outfile, lines, trailer_end, INT_MAX);
 
+	if (in_place) {
+		if (rename_tempfile(&trailers_tempfile, file))
+			die_errno(_("could not rename tempfile"));
+	}
+
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
2.7.0.1.g5e091f5
