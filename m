From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] diff.c: add emit_del_line() and emit_context_line()
Date: Tue, 26 May 2015 23:30:31 -0700
Message-ID: <1432708232-29892-4-git-send-email-gitster@pobox.com>
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
	id 1YxUre-0001eY-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbE0Gap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:30:45 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33568 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbbE0Gai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:30:38 -0400
Received: by igbpi8 with SMTP id pi8so78638126igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcNzpO8Ip5kNksSVVLl1aTNGnsHFQjDzBx8KHT2lNDM=;
        b=XPw20FlqOoGc4MEGSJdeLug5c76N2Y4uM9YjjQYDzq8TTZMte9J+ZAz1KcBp4auviv
         JCjzEnK5q65oQqW+1iB0M3TahGp59eQLSo/2N2VWqffdQi36utEzPboTjjwYCNDp0BoA
         lTDG6wgd9Mzp/Hvh859Ax4JY1AmrBwPcDrUaXb6kjMOCba957JFs6FBQs5V+hdXSbRf/
         rGonXqPqczbDLUKCadhK/zXuI6BBNjOsG8GIZE0hr3XCCnZb/4/pC9hbMXRiT6mFWcjs
         jTJNKyo2/jqNhipLJHTFOXICMhS34JLXZqPs8M4umpQCk+tl2LY5Zw1/em+0Qm/RqdMN
         2wbw==
X-Received: by 10.50.164.138 with SMTP id yq10mr1821168igb.29.1432708238219;
        Tue, 26 May 2015 23:30:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id z195sm12841027iod.33.2015.05.26.23.30.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 23:30:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2-503-g2442661
In-Reply-To: <1432708232-29892-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270022>

Traditionally, we only had emit_add_line() helper, which knows how
to find and paint whitespace breakages on the given line, because we
only care about whitespace breakages introduced in new lines.  The
context lines and old (i.e. deleted) lines are emitted with a
simpler emit_line_0() that paints the entire line in plain or old
colors.

Identify callers of emit_line_0() that show deleted lines and
context lines, have them call new helpers, emit_del_line() and
emit_context_line(), so that we can later tweak what is done to
these two classes of lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index d1bd534..c575c45 100644
--- a/diff.c
+++ b/diff.c
@@ -498,6 +498,24 @@ static void emit_add_line(const char *reset,
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
+static void emit_context_line(const char *reset,
+			      struct emit_callback *ecbdata,
+			      const char *line, int len)
+{
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
+
+	emit_line_0(ecbdata->opt, set, reset, ' ', line, len);
+}
+
 static void emit_hunk_header(struct emit_callback *ecbdata,
 			     const char *line, int len)
 {
@@ -603,7 +621,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 {
 	const char *endp = NULL;
 	static const char *nneof = " No newline at end of file\n";
-	const char *old = diff_get_color(ecb->color_diff, DIFF_FILE_OLD);
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -613,8 +630,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_line_0(ecb->opt, old, reset, '-',
-				    data, len);
+			emit_del_line(reset, ecb, data, len);
 		} else {
 			ecb->lno_in_postimage++;
 			emit_add_line(reset, ecb, data, len);
@@ -1250,17 +1266,27 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
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
+		ecbdata->lno_in_preimage++;
+		emit_context_line(reset, ecbdata, line + 1, len - 1);
+		break;
+	default:
+		/* incomplete line at the end */
+		ecbdata->lno_in_preimage++;
+		emit_line(ecbdata->opt,
+			  diff_get_color(ecbdata->color_diff, DIFF_PLAIN),
+			  reset, line, len);
+		break;
 	}
 }
 
-- 
2.4.2-503-g3e4528a
