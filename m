From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/4] builtin/interpret-trailers: suppress blank line
Date: Thu, 7 Apr 2016 18:23:10 +0300
Message-ID: <1460042563-32741-3-git-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 17:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoBmC-0004xb-Td
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbcDGPXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756500AbcDGPXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:23:13 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 294F3C0D4706;
	Thu,  7 Apr 2016 15:23:13 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37FNAF4032526;
	Thu, 7 Apr 2016 11:23:11 -0400
Content-Disposition: inline
In-Reply-To: <1460042563-32741-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290918>

it's sometimes useful to be able to pass output message of
git-mailinfo through git-interpret-trailers,
but that creates problems since that does not
include the subject and an empty line after that,
making interpret-trailers add an empty line.

Add a flag to bypass adding the blank line.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 trailer.h                    |  2 +-
 builtin/interpret-trailers.c |  9 +++++++--
 trailer.c                    | 10 +++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/trailer.h b/trailer.h
index 36b40b8..afcf680 100644
--- a/trailer.h
+++ b/trailer.h
@@ -2,6 +2,6 @@
 #define TRAILER_H
 
 void process_trailers(const char *file, int in_place, int trim_empty,
-		      struct string_list *trailers);
+		      int suppress_blank_line, struct string_list *trailers);
 
 #endif /* TRAILER_H */
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 18cf640..4a92788 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -18,11 +18,14 @@ static const char * const git_interpret_trailers_usage[] = {
 
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
+	int suppress_blank_line = 0;
 	int in_place = 0;
 	int trim_empty = 0;
 	struct string_list trailers = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
+		OPT_BOOL(0, "suppress-blank-line", &suppress_blank_line,
+			 N_("suppress prefixing tailer(s) with a blank line ")),
 		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
 		OPT_STRING_LIST('t', "trailer", &trailers, N_("trailer"),
@@ -36,11 +39,13 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		int i;
 		for (i = 0; i < argc; i++)
-			process_trailers(argv[i], in_place, trim_empty, &trailers);
+			process_trailers(argv[i], in_place, trim_empty,
+					 suppress_blank_line, &trailers);
 	} else {
 		if (in_place)
 			die(_("no input file given for in-place editing"));
-		process_trailers(NULL, in_place, trim_empty, &trailers);
+		process_trailers(NULL, in_place, trim_empty,
+				 suppress_blank_line, &trailers);
 	}
 
 	string_list_clear(&trailers, 0);
diff --git a/trailer.c b/trailer.c
index 8e48a5c..8e5be91 100644
--- a/trailer.c
+++ b/trailer.c
@@ -805,6 +805,7 @@ static void print_lines(FILE *outfile, struct strbuf **lines, int start, int end
 
 static int process_input_file(FILE *outfile,
 			      struct strbuf **lines,
+			      int suppress_blank_line,
 			      struct trailer_item **in_tok_first,
 			      struct trailer_item **in_tok_last)
 {
@@ -822,7 +823,8 @@ static int process_input_file(FILE *outfile,
 	/* Print lines before the trailers as is */
 	print_lines(outfile, lines, 0, trailer_start);
 
-	if (!has_blank_line_before(lines, trailer_start - 1))
+	if (!suppress_blank_line &&
+	    !has_blank_line_before(lines, trailer_start - 1))
 		fprintf(outfile, "\n");
 
 	/* Parse trailer lines */
@@ -875,7 +877,8 @@ static FILE *create_in_place_tempfile(const char *file)
 	return outfile;
 }
 
-void process_trailers(const char *file, int in_place, int trim_empty, struct string_list *trailers)
+void process_trailers(const char *file, int in_place, int trim_empty,
+		      int suppress_blank_line, struct string_list *trailers)
 {
 	struct trailer_item *in_tok_first = NULL;
 	struct trailer_item *in_tok_last = NULL;
@@ -894,7 +897,8 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
 		outfile = create_in_place_tempfile(file);
 
 	/* Print the lines before the trailers */
-	trailer_end = process_input_file(outfile, lines, &in_tok_first, &in_tok_last);
+	trailer_end = process_input_file(outfile, lines, suppress_blank_line,
+					 &in_tok_first, &in_tok_last);
 
 	arg_tok_first = process_command_line_args(trailers);
 
-- 
MST
