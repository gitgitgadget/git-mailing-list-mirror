From: Kevin Ballard <kevin@sb.org>
Subject: [PATCH v2 2/2] diff: handle lines containing only whitespace and tabs better
Date: Wed, 20 Oct 2010 15:17:26 -0700
Message-ID: <1287613046-61804-2-git-send-email-kevin@sb.org>
References: <7v4ocgx2we.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nazri Ramliy <ayiehere@gmail.com>, Kevin Ballard <kevin@sb.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 00:18:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8gz6-0001Ic-KO
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab0JTWSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 18:18:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62467 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab0JTWR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 18:17:59 -0400
Received: by pwj9 with SMTP id 9so91524pwj.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 15:17:59 -0700 (PDT)
Received: by 10.142.203.17 with SMTP id a17mr38795wfg.361.1287613079122;
        Wed, 20 Oct 2010 15:17:59 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm1109430wfd.7.2010.10.20.15.17.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 15:17:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.220.g19a98
In-Reply-To: <7v4ocgx2we.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159443>

When a line contains nothing but whitespace with at least one tab
and the core.whitespace config option contains blank-at-eol, the
whitespace on the line is being printed twice, once unhighlighted
(unless otherwise matched by one of the other core.whitespace values),
and a second time highlighted for blank-at-eol.

Update the leading indentation check to stop checking when it reaches
the trailing whitespace.

Signed-off-by: Kevin Ballard <kevin@sb.org>
---
 t/t4015-diff-whitespace.sh |   37 +++++++++++++++++++++++++++++++++++++
 ws.c                       |    7 ++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 935d101..a8736f7 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -491,4 +491,41 @@ test_expect_success 'combined diff with autocrlf conversion' '
 
 '
 
+# Start testing the colored format for whitespace checks
+
+test_expect_success 'setup diff colors' '
+	git config color.diff always &&
+	git config color.diff.plain normal &&
+	git config color.diff.meta bold &&
+	git config color.diff.frag cyan &&
+	git config color.diff.func normal &&
+	git config color.diff.old red &&
+	git config color.diff.new green &&
+	git config color.diff.commit yellow &&
+	git config color.diff.whitespace "normal red" &&
+
+	git config core.autocrlf false
+'
+cat >expected <<\EOF
+<BOLD>diff --git a/x b/x<RESET>
+<BOLD>index 9daeafb..2874b91 100644<RESET>
+<BOLD>--- a/x<RESET>
+<BOLD>+++ b/x<RESET>
+<CYAN>@@ -1 +1,4 @@<RESET>
+ test<RESET>
+<GREEN>+<RESET><GREEN>{<RESET>
+<GREEN>+<RESET><BRED>	<RESET>
+<GREEN>+<RESET><GREEN>}<RESET>
+EOF
+
+test_expect_success 'diff that introduces a line with only tabs' '
+	git config core.whitespace blank-at-eol &&
+	git reset --hard &&
+	echo "test" > x &&
+	git commit -m "initial" x &&
+	echo "{NTN}" | tr "NT" "\n\t" >> x &&
+	git -c color.diff=always diff | test_decode_color >current &&
+	test_cmp expected current
+'
+
 test_done
diff --git a/ws.c b/ws.c
index d7b8c33..7302f8f 100644
--- a/ws.c
+++ b/ws.c
@@ -174,8 +174,11 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		}
 	}
 
+	if (trailing_whitespace == -1)
+		trailing_whitespace = len;
+
 	/* Check indentation */
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < trailing_whitespace; i++) {
 		if (line[i] == ' ')
 			continue;
 		if (line[i] != '\t')
@@ -218,8 +221,6 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		 * Now the rest of the line starts at "written".
 		 * The non-highlighted part ends at "trailing_whitespace".
 		 */
-		if (trailing_whitespace == -1)
-			trailing_whitespace = len;
 
 		/* Emit non-highlighted (middle) segment. */
 		if (trailing_whitespace - written > 0) {
-- 
1.7.3.1.220.g19a98
