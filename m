From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] diff.c: add emit_del_line() and update callers of emit_line_0()
Date: Tue, 26 May 2015 12:46:23 -0700
Message-ID: <1432669584-342-4-git-send-email-gitster@pobox.com>
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
	id 1YxKoE-0001ob-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbbEZTqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:46:36 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34727 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbEZTqb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:46:31 -0400
Received: by ieczm2 with SMTP id zm2so100620327iec.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=azJC6bcBDaZ3TBD5gBi4gwr+IBngKFizgZotTYCNFV8=;
        b=eLf6J9xbifTD2vETYRMAEyr+UhAZxJ9YOeGCROc+XG4rmjhVFbB1JU2kU3oQTfqjMl
         FIuXcIfpLa2/eKkRrCTeSA+wIKVh3gFtfKbQ4teeX8AOb/GpUN5aHqDXY/VyS1XZmM7z
         0CYG+fPMJkmvuM/SDLEj7OLVKw0XyB1Q+rvY2uoINMxndfYc2x2dln5gz34iV9ypk+Sz
         3XHlYLvp8kYevBmRwhSm0Kn0xTSdHLDJRlFwFRukvPgkss5RA/rQKx5LSULH5UYnmMMe
         JGnhunWr6EuKXxPfBzfcIFiWROcBY0sDh7ZmpO7hZJOb5hnEiCMjQjXediefbWcDQ2f5
         shRw==
X-Received: by 10.42.85.207 with SMTP id r15mr435367icl.94.1432669590520;
        Tue, 26 May 2015 12:46:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id x10sm41474igl.0.2015.05.26.12.46.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 12:46:30 -0700 (PDT)
X-Mailer: git-send-email 2.4.1-511-gc1146d5
In-Reply-To: <1432669584-342-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269968>

Traditionally, we only had emit_add_line() helper, which knows how
to find and paint whitespace breakages on the given line, because we
only care about whitespace breakages introduced in new lines.  The
context lines and old (i.e. deleted) lines are emitted with a
simpler emit_line_0() that paints the entire line in plain or old
colors.

Identify callers of emit_line_0() that show deleted lines and
have them call a new helper, emit_del_line(), so that we can later
tweak what is done to deleted lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index d1bd534..75b1342 100644
--- a/diff.c
+++ b/diff.c
@@ -498,6 +498,15 @@ static void emit_add_line(const char *reset,
 	}
 }
 
+static void emit_del_line(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
+{
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD);
+
+	emit_line_0(ecbdata->opt, set, reset, '-', line, len);
+}
+
 static void emit_hunk_header(struct emit_callback *ecbdata,
 			     const char *line, int len)
 {
@@ -603,7 +612,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 {
 	const char *endp = NULL;
 	static const char *nneof = " No newline at end of file\n";
-	const char *old = diff_get_color(ecb->color_diff, DIFF_FILE_OLD);
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -613,8 +621,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_line_0(ecb->opt, old, reset, '-',
-				    data, len);
+			emit_del_line(reset, ecb, data, len);
 		} else {
 			ecb->lno_in_postimage++;
 			emit_add_line(reset, ecb, data, len);
@@ -1250,17 +1257,25 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		return;
 	}
 
-	if (line[0] != '+') {
-		const char *color =
-			diff_get_color(ecbdata->color_diff,
-				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
-		ecbdata->lno_in_preimage++;
-		if (line[0] == ' ')
-			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->opt, color, reset, line, len);
-	} else {
+	switch (line[0]) {
+	case '+':
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
+		break;
+	case '-':
+		ecbdata->lno_in_preimage++;
+		emit_del_line(reset, ecbdata, line + 1, len - 1);
+		break;
+	case ' ':
+		ecbdata->lno_in_postimage++;
+		/* fallthru */
+	default:
+		/* ' ' and incomplete line */
+		ecbdata->lno_in_preimage++;
+		emit_line(ecbdata->opt,
+			  diff_get_color(ecbdata->color_diff, DIFF_PLAIN),
+			  reset, line, len);
+		break;
 	}
 }
 
-- 
2.4.1-511-gc1146d5
