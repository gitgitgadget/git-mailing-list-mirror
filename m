From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] check_and_emit_line(): rename and refactor
Date: Thu, 26 Jun 2008 15:35:21 -0700
Message-ID: <7vbq1nq0ye.fsf_-_@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
 <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
 <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
 <7vk5gbq10p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC052-0003I5-MZ
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbYFZWfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYFZWfm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:35:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbYFZWfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:35:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D64023DB8;
	Thu, 26 Jun 2008 18:35:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 703BD23DB7; Thu, 26 Jun 2008 18:35:31 -0400 (EDT)
In-Reply-To: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 15:33:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 323673D6-43D0-11DD-AB43-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86496>

The function name was too bland and not explicit enough as to what it is
checking.  Split it into two, and call the one that checks if there is a
whitespace breakage "ws_check()", and call the other one that checks and
emits the line after color coding "ws_check_emit()".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |    5 ++---
 cache.h         |    5 ++---
 diff.c          |   13 ++++++-------
 ws.c            |   18 +++++++++++++++---
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..92f0047 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -979,8 +979,7 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 static void check_whitespace(const char *line, int len, unsigned ws_rule)
 {
 	char *err;
-	unsigned result = check_and_emit_line(line + 1, len - 1, ws_rule,
-	    NULL, NULL, NULL, NULL);
+	unsigned result = ws_check(line + 1, len - 1, ws_rule);
 	if (!result)
 		return;
 
@@ -991,7 +990,7 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
 	else {
 		err = whitespace_error_string(result);
 		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-		     patch_input_file, linenr, err, len - 2, line + 1);
+			patch_input_file, linenr, err, len - 2, line + 1);
 		free(err);
 	}
 }
diff --git a/cache.h b/cache.h
index 64ef86e..3dfa53c 100644
--- a/cache.h
+++ b/cache.h
@@ -819,9 +819,8 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
-extern unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
-    FILE *stream, const char *set,
-    const char *reset, const char *ws);
+extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
+extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
 extern char *whitespace_error_string(unsigned ws);
 extern int ws_fix_copy(char *, const char *, int, unsigned, int *);
 
diff --git a/diff.c b/diff.c
index c00d633..52a34ee 100644
--- a/diff.c
+++ b/diff.c
@@ -535,9 +535,9 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 	else {
 		/* Emit just the prefix, then the rest. */
 		emit_line(ecbdata->file, set, reset, line, ecbdata->nparents);
-		(void)check_and_emit_line(line + ecbdata->nparents,
-		    len - ecbdata->nparents, ecbdata->ws_rule,
-		    ecbdata->file, set, reset, ws);
+		ws_check_emit(line + ecbdata->nparents,
+			      len - ecbdata->nparents, ecbdata->ws_rule,
+			      ecbdata->file, set, reset, ws);
 	}
 }
 
@@ -1153,8 +1153,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
-		bad = check_and_emit_line(line + 1, len - 1,
-		    data->ws_rule, NULL, NULL, NULL, NULL);
+		bad = ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
 			return;
 		data->status |= bad;
@@ -1162,8 +1161,8 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		fprintf(data->file, "%s:%d: %s.\n", data->filename, data->lineno, err);
 		free(err);
 		emit_line(data->file, set, reset, line, 1);
-		(void)check_and_emit_line(line + 1, len - 1, data->ws_rule,
-		    data->file, set, reset, ws);
+		ws_check_emit(line + 1, len - 1, data->ws_rule,
+			      data->file, set, reset, ws);
 	} else if (line[0] == ' ')
 		data->lineno++;
 	else if (line[0] == '@') {
diff --git a/ws.c b/ws.c
index ba7e834..24d3e3d 100644
--- a/ws.c
+++ b/ws.c
@@ -117,9 +117,9 @@ char *whitespace_error_string(unsigned ws)
 }
 
 /* If stream is non-NULL, emits the line after checking. */
-unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
-			     FILE *stream, const char *set,
-			     const char *reset, const char *ws)
+static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
+				FILE *stream, const char *set,
+				const char *reset, const char *ws)
 {
 	unsigned result = 0;
 	int written = 0;
@@ -213,6 +213,18 @@ unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
 	return result;
 }
 
+void ws_check_emit(const char *line, int len, unsigned ws_rule,
+		   FILE *stream, const char *set,
+		   const char *reset, const char *ws)
+{
+	(void)ws_check_emit_1(line, len, ws_rule, stream, set, reset, ws);
+}
+
+unsigned ws_check(const char *line, int len, unsigned ws_rule)
+{
+	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL);
+}
+
 /* Copy the line to the buffer while fixing whitespaces */
 int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *error_count)
 {
-- 
1.5.6.1.78.gde8d9
