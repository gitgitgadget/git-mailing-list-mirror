From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix rewrite_diff() name quoting.
Date: Wed, 26 Dec 2007 17:19:27 -0800
Message-ID: <7vir2lkk80.fsf_-_@gitster.siamese.dyndns.org>
References: <477109A5.9040000@gmail.com>
	<7vodcdkl82.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 02:20:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7hQA-0005Nc-W6
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 02:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbXL0BTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 20:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbXL0BTj
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 20:19:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbXL0BTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2007 20:19:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 110347D6F;
	Wed, 26 Dec 2007 20:19:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CF7A7D6E;
	Wed, 26 Dec 2007 20:19:34 -0500 (EST)
In-Reply-To: <7vodcdkl82.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 26 Dec 2007 16:57:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69254>

This moves the logic to quote two paths (prefix + path) in
C-style introduced in the previous commit from the
dump_quoted_path() in combine-diff.c to quote.c, and uses it to
fix rewrite_diff() that never C-quoted the pathnames correctly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 combine-diff.c |   11 +----------
 diff.c         |   12 +++++++++---
 quote.c        |   16 ++++++++++++++++
 quote.h        |    1 +
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 7d71033..0e19cba 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -656,16 +656,7 @@ static void dump_quoted_path(const char *head,
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, c_meta);
 	strbuf_addstr(&buf, head);
-	if (quote_c_style(prefix, NULL, NULL, 0) ||
-	    quote_c_style(path, NULL, NULL, 0)) {
-		strbuf_addch(&buf, '"');
-		quote_c_style(prefix, &buf, NULL, 1);
-		quote_c_style(path, &buf, NULL, 1);
-		strbuf_addch(&buf, '"');
-	} else {
-		strbuf_addstr(&buf, prefix);
-		strbuf_addstr(&buf, path);
-	}
+	quote_two_c_style(&buf, prefix, path, 0);
 	strbuf_addstr(&buf, c_reset);
 	puts(buf.buf);
 }
diff --git a/diff.c b/diff.c
index 61fd492..5bdc111 100644
--- a/diff.c
+++ b/diff.c
@@ -300,19 +300,25 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *old = diff_get_color(color_diff, DIFF_FILE_OLD);
 	const char *new = diff_get_color(color_diff, DIFF_FILE_NEW);
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
+	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
 	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
 	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
 
+	strbuf_reset(&a_name);
+	strbuf_reset(&b_name);
+	quote_two_c_style(&a_name, o->a_prefix, name_a, 0);
+	quote_two_c_style(&b_name, o->b_prefix, name_b, 0);
+
 	diff_populate_filespec(one, 0);
 	diff_populate_filespec(two, 0);
 	lc_a = count_lines(one->data, one->size);
 	lc_b = count_lines(two->data, two->size);
-	printf("%s--- %s%s%s%s\n%s+++ %s%s%s%s\n%s@@ -",
-	       metainfo, o->a_prefix, name_a, name_a_tab, reset,
-	       metainfo, o->b_prefix, name_b, name_b_tab, reset, fraginfo);
+	printf("%s--- %s%s%s\n%s+++ %s%s%s\n%s@@ -",
+	       metainfo, a_name.buf, name_a_tab, reset,
+	       metainfo, b_name.buf, name_b_tab, reset, fraginfo);
 	print_line_count(lc_a);
 	printf(" +");
 	print_line_count(lc_b);
diff --git a/quote.c b/quote.c
index 6986b44..d061626 100644
--- a/quote.c
+++ b/quote.c
@@ -213,6 +213,22 @@ size_t quote_c_style(const char *name, struct strbuf *sb, FILE *fp, int nodq)
 	return quote_c_style_counted(name, -1, sb, fp, nodq);
 }
 
+void quote_two_c_style(struct strbuf *sb, const char *prefix, const char *path, int nodq)
+{
+	if (quote_c_style(prefix, NULL, NULL, 0) ||
+	    quote_c_style(path, NULL, NULL, 0)) {
+		if (!nodq)
+			strbuf_addch(sb, '"');
+		quote_c_style(prefix, sb, NULL, 1);
+		quote_c_style(path, sb, NULL, 1);
+		if (!nodq)
+			strbuf_addch(sb, '"');
+	} else {
+		strbuf_addstr(sb, prefix);
+		strbuf_addstr(sb, path);
+	}
+}
+
 void write_name_quoted(const char *name, FILE *fp, int terminator)
 {
 	if (terminator) {
diff --git a/quote.h b/quote.h
index ab7596f..4da110e 100644
--- a/quote.h
+++ b/quote.h
@@ -41,6 +41,7 @@ extern char *sq_dequote(char *);
 
 extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
+extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 
 extern void write_name_quoted(const char *name, FILE *, int terminator);
 extern void write_name_quotedpfx(const char *pfx, size_t pfxlen,
-- 
1.5.4.rc1.23.g3a969
