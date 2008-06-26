From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] Teach "diff --check" about a new blank lines at end
Date: Thu, 26 Jun 2008 15:36:59 -0700
Message-ID: <7v1w2jq0vo.fsf_-_@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Fri Jun 27 00:38:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC06U-0003g1-J4
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 00:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbYFZWhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 18:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756743AbYFZWhN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 18:37:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675AbYFZWhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 18:37:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5EF8223DE2;
	Thu, 26 Jun 2008 18:37:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 630F623DDE; Thu, 26 Jun 2008 18:37:06 -0400 (EDT)
In-Reply-To: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 15:33:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A20ADE8-43D0-11DD-AE78-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86498>

When a patch adds new blank lines at the end, "git apply --whitespace"
warns.  This teaches "diff --check" to do the same.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                    |    1 +
 diff.c                     |   17 +++++++++++++++--
 t/t4015-diff-whitespace.sh |    6 ++++++
 ws.c                       |   15 +++++++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 3dfa53c..188428d 100644
--- a/cache.h
+++ b/cache.h
@@ -823,6 +823,7 @@ extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
 extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
 extern char *whitespace_error_string(unsigned ws);
 extern int ws_fix_copy(char *, const char *, int, unsigned, int *);
+extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 
 /* ls-files */
 int pathspec_match(const char **spec, char *matched, const char *filename, int skiplen);
diff --git a/diff.c b/diff.c
index 6bcbe20..f31c721 100644
--- a/diff.c
+++ b/diff.c
@@ -1140,6 +1140,7 @@ struct checkdiff_t {
 	struct diff_options *o;
 	unsigned ws_rule;
 	unsigned status;
+	int trailing_blanks_start;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
@@ -1154,6 +1155,10 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
+		if (!ws_blank_line(line + 1, len - 1, data->ws_rule))
+			data->trailing_blanks_start = 0;
+		else if (!data->trailing_blanks_start)
+			data->trailing_blanks_start = data->lineno;
 		bad = ws_check(line + 1, len - 1, data->ws_rule);
 		if (!bad)
 			return;
@@ -1165,14 +1170,16 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		emit_line(data->o->file, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
 			      data->o->file, set, reset, ws);
-	} else if (line[0] == ' ')
+	} else if (line[0] == ' ') {
 		data->lineno++;
-	else if (line[0] == '@') {
+		data->trailing_blanks_start = 0;
+	} else if (line[0] == '@') {
 		char *plus = strchr(line, '+');
 		if (plus)
 			data->lineno = strtol(plus, NULL, 10) - 1;
 		else
 			die("invalid diff");
+		data->trailing_blanks_start = 0;
 	}
 }
 
@@ -1584,6 +1591,12 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		ecb.outf = xdiff_outf;
 		ecb.priv = &data;
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+
+		if (data.trailing_blanks_start) {
+			fprintf(o->file, "%s:%d: ends with blank lines.\n",
+				data.filename, data.trailing_blanks_start);
+			data.status = 1; /* report errors */
+		}
 	}
  free_and_return:
 	diff_free_filespec_data(one);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b7cc6b2..0922c70 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -335,4 +335,10 @@ test_expect_success 'line numbers in --check output are correct' '
 
 '
 
+test_expect_success 'checkdiff detects trailing blank lines' '
+	echo "foo();" >x &&
+	echo "" >>x &&
+	git diff --check | grep "ends with blank"
+'
+
 test_done
diff --git a/ws.c b/ws.c
index 24d3e3d..7a7ff13 100644
--- a/ws.c
+++ b/ws.c
@@ -225,6 +225,21 @@ unsigned ws_check(const char *line, int len, unsigned ws_rule)
 	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL);
 }
 
+int ws_blank_line(const char *line, int len, unsigned ws_rule)
+{
+	/*
+	 * We _might_ want to treat CR differently from other
+	 * whitespace characters when ws_rule has WS_CR_AT_EOL, but
+	 * for now we just use this stupid definition.
+	 */
+	while (len-- > 0) {
+		if (!isspace(*line))
+			return 0;
+		line++;
+	}
+	return 1;
+}
+
 /* Copy the line to the buffer while fixing whitespaces */
 int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *error_count)
 {
-- 
1.5.6.1.78.gde8d9
