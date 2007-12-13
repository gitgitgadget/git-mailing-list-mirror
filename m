From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 4/5] Make "diff --check" output match "git apply"
Date: Thu, 13 Dec 2007 14:32:30 +0100
Message-ID: <1197552751-53480-5-git-send-email-win@wincent.com>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
 <1197552751-53480-2-git-send-email-win@wincent.com>
 <1197552751-53480-3-git-send-email-win@wincent.com>
 <1197552751-53480-4-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 14:34:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oDF-0004Mm-Ey
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725AbXLMNeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756654AbXLMNeO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:34:14 -0500
Received: from wincent.com ([72.3.236.74]:47249 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbXLMNeM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:34:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBDDWZ4b019847;
	Thu, 13 Dec 2007 07:32:42 -0600
X-Mailer: git-send-email 1.5.4.rc0.4.g50348
In-Reply-To: <1197552751-53480-4-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68149>

For consistency, make the two tools report whitespace errors in the
same way (the output of "diff --check" has been tweaked to match
that of "git apply").

Note that although the textual content is basically the same only
"git diff --check" provides a colorized version of the problematic
lines; making "git apply" do colorization will require more extensive
changes (figuring out the diff colorization preferences of the user)
and so that will be a subject for another commit.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 builtin-apply.c |    4 ++--
 diff.c          |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index ab393f3..2edd83b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -912,8 +912,8 @@ static void check_whitespace(const char *line, int len, unsigned ws_rule)
 		;
 	else {
 		err = whitespace_error_string(result);
-		fprintf(stderr, "%s.\n%s:%d:%.*s\n",
-		     err, patch_input_file, linenr, len - 2, line + 1);
+		fprintf(stderr, "%s:%d: %s.\n%.*s\n",
+		     patch_input_file, linenr, err, len - 2, line + 1);
 		free(err);
 	}
 }
diff --git a/diff.c b/diff.c
index d96a4ac..73a723d 100644
--- a/diff.c
+++ b/diff.c
@@ -973,8 +973,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		if (!data->status)
 			return;
 		err = whitespace_error_string(data->status);
-		printf("%s:%d: %s%s:%s ", data->filename, data->lineno,
-		    ws, err, reset);
+		printf("%s:%d: %s.\n", data->filename, data->lineno, err);
 		free(err);
 		emit_line(set, reset, line, 1);
 		(void)check_and_emit_line(line + 1, len - 1, data->ws_rule,
-- 
1.5.4.rc0.4.g50348
