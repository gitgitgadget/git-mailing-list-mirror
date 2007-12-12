From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 3/3] Make "diff --check" use shared whitespace functions
Date: Wed, 12 Dec 2007 17:23:01 +0100
Message-ID: <1197476582-18956-4-git-send-email-win@wincent.com>
References: <1197476582-18956-1-git-send-email-win@wincent.com>
 <1197476582-18956-2-git-send-email-win@wincent.com>
 <1197476582-18956-3-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 12 17:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UOv-0003CQ-Bf
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbXLLQZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXLLQZN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:25:13 -0500
Received: from wincent.com ([72.3.236.74]:44682 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbXLLQZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:25:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBCGN3CJ026521;
	Wed, 12 Dec 2007 10:23:09 -0600
X-Mailer: git-send-email 1.5.3.7.1159.g2f071-dirty
In-Reply-To: <1197476582-18956-3-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68070>

Use the logic refactored into ws.c rather than duplicating it.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 diff.c |   49 +++++++++++--------------------------------------
 1 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/diff.c b/diff.c
index c9b3884..7ad3c63 100644
--- a/diff.c
+++ b/diff.c
@@ -996,7 +996,7 @@ struct checkdiff_t {
 	const char *filename;
 	int lineno, color_diff;
 	unsigned ws_rule;
-	int status;
+	unsigned status;
 };
 
 static void checkdiff_consume(void *priv, char *line, unsigned long len)
@@ -1005,45 +1005,18 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 	const char *ws = diff_get_color(data->color_diff, DIFF_WHITESPACE);
 	const char *reset = diff_get_color(data->color_diff, DIFF_RESET);
 	const char *set = diff_get_color(data->color_diff, DIFF_FILE_NEW);
+	char *err;
 
 	if (line[0] == '+') {
-		int i, spaces = 0, space_before_tab = 0, white_space_at_end = 0;
-
-		/* check space before tab */
-		for (i = 1; i < len; i++) {
-			if (line[i] == ' ')
-				spaces++;
-			else if (line[i] == '\t') {
-				if (spaces) {
-					space_before_tab = 1;
-					break;
-				}
-			}
-			else
-				break;
-		}
-
-		/* check whitespace at line end */
-		if (line[len - 1] == '\n')
-			len--;
-		if (isspace(line[len - 1]))
-			white_space_at_end = 1;
-
-		if (space_before_tab || white_space_at_end) {
-			data->status = 1;
-			printf("%s:%d: %s", data->filename, data->lineno, ws);
-			if (space_before_tab) {
-				printf("space before tab");
-				if (white_space_at_end)
-					putchar(',');
-			}
-			if (white_space_at_end)
-				printf("whitespace at end");
-			printf(":%s ", reset);
-			emit_line_with_ws(1, set, reset, ws, line, len,
-					  data->ws_rule);
-		}
-
+		data->status = check_whitespace(line, len, data->ws_rule);
+		if (!data->status)
+			return;
+		err = whitespace_error_string(data->status);
+		printf("%s:%d: %s%s:%s ", data->filename, data->lineno,
+		    ws, err, reset);
+		free(err);
+		emit_line_with_ws(1, set, reset, ws, line, len,
+		    data->ws_rule);
 		data->lineno++;
 	} else if (line[0] == ' ')
 		data->lineno++;
-- 
1.5.3.7.1159.g2f071-dirty
