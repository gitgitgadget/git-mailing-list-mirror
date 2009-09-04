From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] diff --whitespace=warn/error: fix blank-at-eof check
Date: Fri,  4 Sep 2009 03:55:17 -0700
Message-ID: <1252061718-11579-9-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:56:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWTJ-00041M-4q
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbZIDKzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756745AbZIDKzp
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726AbZIDKzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5658743D2F
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nAGU
	n1xDUhEHhBgev0iIyyYQw5M=; b=fUJa6bVWBPdE2sOZ0QclItxYZmB/90QK/65/
	/fF3G1vq45Zmh54iVcwu8nuMaJInZGbDoknRgQE02i04VgREZEeIycu4Hptk6w7Z
	fzWOIuZ4ccFRtFnR4BKdfCnJ5s0m+9WuU7/9TGnJWNHRWhvL/Dd6mV2H9w8X95TL
	tRdvp/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ANXufO
	J0C7j2OPkM672Y36df4AjVvsO1nX5X5tNV1X22dgkIoFQbeuAHkwOrldMmQkkCbR
	BNCbfawrVcHs+KzRUUwup/tMPUR0X6+EY+60Tx9mAmg00X8MEW4akglez7eyXCKw
	Le9iMZDSk09xDEcwDNh5hkJAzTFDMJ9hFYPDQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5282F43D2E
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 885E043D2D for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:39 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7C2BC0AA-9941-11DE-8BFF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127720>

The "diff --check" logic used to share the same issue as the one fixed for
"git apply" earlier in this series, in that a patch that adds new blank
lines at end could appear as

    @@ -l,5 +m,7 @@$
    _context$
    _context$
    -deleted$
    +$
    +$
    +$
    _$
    _$

where _ stands for SP and $ shows a end-of-line.  Instead of looking at
each line in the patch in the callback, simply count the blank lines from
the end in two versions, and notice the presence of new ones.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     |   64 +++++++++++++++++++++++++++++++++-----------
 t/t4015-diff-whitespace.sh |    7 +++++
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index a693d18..c19c476 100644
--- a/diff.c
+++ b/diff.c
@@ -1149,7 +1149,6 @@ struct checkdiff_t {
 	struct diff_options *o;
 	unsigned ws_rule;
 	unsigned status;
-	int trailing_blanks_start;
 };
 
 static int is_conflict_marker(const char *line, unsigned long len)
@@ -1193,10 +1192,6 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '+') {
 		unsigned bad;
 		data->lineno++;
-		if (!ws_blank_line(line + 1, len - 1, data->ws_rule))
-			data->trailing_blanks_start = 0;
-		else if (!data->trailing_blanks_start)
-			data->trailing_blanks_start = data->lineno;
 		if (is_conflict_marker(line + 1, len - 1)) {
 			data->status |= 1;
 			fprintf(data->o->file,
@@ -1216,14 +1211,12 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 			      data->o->file, set, reset, ws);
 	} else if (line[0] == ' ') {
 		data->lineno++;
-		data->trailing_blanks_start = 0;
 	} else if (line[0] == '@') {
 		char *plus = strchr(line, '+');
 		if (plus)
 			data->lineno = strtol(plus, NULL, 10) - 1;
 		else
 			die("invalid diff");
-		data->trailing_blanks_start = 0;
 	}
 }
 
@@ -1437,6 +1430,44 @@ static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_fi
 	return NULL;
 }
 
+static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
+{
+	char *ptr = mf->ptr;
+	long size = mf->size;
+	int cnt = 0;
+
+	if (!size)
+		return cnt;
+	ptr += size - 1; /* pointing at the very end */
+	if (*ptr != '\n')
+		; /* incomplete line */
+	else
+		ptr--; /* skip the last LF */
+	while (mf->ptr < ptr) {
+		char *prev_eol;
+		for (prev_eol = ptr; mf->ptr <= prev_eol; prev_eol--)
+			if (*prev_eol == '\n')
+				break;
+		if (!ws_blank_line(prev_eol + 1, ptr - prev_eol, ws_rule))
+			break;
+		cnt++;
+		ptr = prev_eol - 1;
+	}
+	return cnt;
+}
+
+static int adds_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2, unsigned ws_rule)
+{
+	int l1, l2, at;
+	l1 = count_trailing_blank(mf1, ws_rule);
+	l2 = count_trailing_blank(mf2, ws_rule);
+	if (l2 <= l1)
+		return 0;
+	/* starting where? */
+	at = count_lines(mf1->ptr, mf1->size);
+	return (at - l1) + 1; /* the line number counts from 1 */
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1650,15 +1681,16 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		ecb.priv = &data;
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 
-		if ((data.ws_rule & WS_BLANK_AT_EOF) &&
-		    data.trailing_blanks_start) {
-			static char *err;
-
-			if (!err)
-				err = whitespace_error_string(WS_BLANK_AT_EOF);
-			fprintf(o->file, "%s:%d: %s\n",
-				data.filename, data.trailing_blanks_start, err);
-			data.status = 1; /* report errors */
+		if (data.ws_rule & WS_BLANK_AT_EOF) {
+			int blank_at_eof = adds_blank_at_eof(&mf1, &mf2, data.ws_rule);
+			if (blank_at_eof) {
+				static char *err;
+				if (!err)
+					err = whitespace_error_string(WS_BLANK_AT_EOF);
+				fprintf(o->file, "%s:%d: %s.\n",
+					data.filename, blank_at_eof, err);
+				data.status = 1; /* report errors */
+			}
 		}
 	}
  free_and_return:
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index a5d4461..e0b481d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -341,6 +341,13 @@ test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 	git diff --check | grep "new blank line"
 '
 
+test_expect_success 'checkdiff detects new trailing blank lines (2)' '
+	{ echo a; echo b; echo; echo; } >x &&
+	git add x &&
+	{ echo a; echo; echo; echo; echo; } >x &&
+	git diff --check | grep "new blank line"
+'
+
 test_expect_success 'checkdiff allows new blank lines' '
 	git checkout x &&
 	mv x y &&
-- 
1.6.4.2.313.g0425f
