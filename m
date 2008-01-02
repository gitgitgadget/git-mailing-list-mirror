From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 2/2] diff: do not chomp hunk-header in the middle of a character
Date: Wed, 02 Jan 2008 01:50:11 -0800
Message-ID: <7vy7b8y2ss.fsf@gitster.siamese.dyndns.org>
References: <20080102.082014.02281301.tshibata@ab.jp.nec.com>
	<7v1w904x29.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA0FJ-0004Nj-P3
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 10:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287AbYABJuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 04:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757249AbYABJuU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 04:50:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756860AbYABJuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 04:50:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1E91B26B;
	Wed,  2 Jan 2008 04:50:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E80AB26A;
	Wed,  2 Jan 2008 04:50:13 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69467>

We truncate hunk-header line at 80 bytes, but that 80th byte
could be in the middle of a character, which is bad.  This uses
utf8_width() function to make sure we do not cut a character in
the middle.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this implements the sane_truncate_line() that
   unconditionally assumes UTF-8.

   The 80-byte cutoff is meant to chomp at 80 display columns,
   and in many encodings including UTF-8 80 cols are usually
   more than 80 bytes.  To implement 80 column chomping, we
   would need to tweak the low level xdl_find_func() interface
   further so that it gives us back more than 80-bytes.  Ideally
   that layer should not be doing any chomping.

   Another thing I noticed but did not bother to fix was that
   the emit_line() interface is doing bad things with color.
   It emits:

	start-color text (= line, len) reset-color

   and the text often ends with LF.  We should emit reset-color
   before the terminating LF instead.

 diff.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 5bdc111..b9159bc 100644
--- a/diff.c
+++ b/diff.c
@@ -10,6 +10,7 @@
 #include "color.h"
 #include "attr.h"
 #include "run-command.h"
+#include "utf8.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -465,10 +466,13 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	}
 }
 
+typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
+
 struct emit_callback {
 	struct xdiff_emit_state xm;
 	int nparents, color_diff;
 	unsigned ws_rule;
+	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
 	int *found_changesp;
@@ -521,6 +525,27 @@ static void emit_add_line(const char *reset, struct emit_callback *ecbdata, cons
 	}
 }
 
+static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, unsigned long len)
+{
+	const char *cp;
+	unsigned long width, allot;
+
+	if (ecb->truncate)
+		return ecb->truncate(line, len);
+	cp = line;
+	width = 0;
+	allot = len;
+	while (0 < len) {
+		int w = utf8_width(&cp, &len);
+		if (!cp)
+			break; /* truncated in the middle? */
+		width += w;
+		if (allot <= width)
+			break;
+	}
+	return allot - len;
+}
+
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	int i;
@@ -551,8 +576,11 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		;
 	if (2 <= i && i < len && line[i] == ' ') {
 		ecbdata->nparents = i - 1;
+		len = sane_truncate_line(ecbdata, line, len);
 		emit_line(diff_get_color(ecbdata->color_diff, DIFF_FRAGINFO),
 			  reset, line, len);
+		if (line[len-1] != '\n')
+			putchar('\n');
 		return;
 	}
 
-- 
1.5.4.rc2.13.g690bd
