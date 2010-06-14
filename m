From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] pretty: Introduce ' ' modifier to add space if non-empty
Date: Mon, 14 Jun 2010 18:12:29 +0200
Message-ID: <4bb622edfd80b83fc5bd68d383887aec260a0b88.1276531906.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:13:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCHh-00047H-GF
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab0FNQNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:13:08 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59571 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751401Ab0FNQNG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 12:13:06 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 93154F8B3D;
	Mon, 14 Jun 2010 12:13:02 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 14 Jun 2010 12:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=PgnwU8rmMDnGUc+wOfPfyTGi+eY=; b=kOC1lcUEjkbD32rkMa++8VQtGwP5XPoHDkWhEMS+xpfMxE0OoEJzMaGjnfyQfZum0lOCO8jbUhM+Nx0CHVKTdP6z024Cucr2aIjE/keWCVkD18EZpxRF3/iCh/9Nq5/NhkVJtfixsB+hYeiCqi4GsLvSM1FFazwot4uaGZcHhvY=
X-Sasl-enc: SZnEWzzbdEbDoJLp/hnWyHoAH77XGQjEtAI/B76WcXYK 1276531981
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A5C4A4C12E8;
	Mon, 14 Jun 2010 12:13:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.511.gfbed4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149120>

We have the '+' modifiier which helps combine format specifiers which
may possibly be empty, e.g. '%s%+b%n'.

Introduce an analogous ' ' (space) modifier which adds a space before
non-empty items. This helps assemble "one line type" format specifiers.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/pretty-formats.txt |    4 ++++
 pretty.c                         |   13 ++++++++++---
 t/t6006-rev-list-format.sh       |   10 ++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 8c68ce9..561cc9f 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -159,6 +159,10 @@ If you add a `-` (minus sign) after '%' of a placeholder, line-feeds that
 immediately precede the expansion are deleted if and only if the
 placeholder expands to an empty string.
 
+If you add a ` ` (space) after '%' of a placeholder, a space
+is inserted immediately before the expansion if and only if the
+placeholder expands to a non-empty string.
+
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
diff --git a/pretty.c b/pretty.c
index 146320f..8b2fc71 100644
--- a/pretty.c
+++ b/pretty.c
@@ -946,6 +946,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		NO_MAGIC,
 		ADD_LF_BEFORE_NON_EMPTY,
 		DEL_LF_BEFORE_EMPTY,
+		ADD_SP_BEFORE_NON_EMPTY,
 	} magic = NO_MAGIC;
 
 	switch (placeholder[0]) {
@@ -955,6 +956,9 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case '+':
 		magic = ADD_LF_BEFORE_NON_EMPTY;
 		break;
+	case ' ':
+		magic = ADD_SP_BEFORE_NON_EMPTY;
+		break;
 	default:
 		break;
 	}
@@ -969,8 +973,11 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
 		while (sb->len && sb->buf[sb->len - 1] == '\n')
 			strbuf_setlen(sb, sb->len - 1);
-	} else if ((orig_len != sb->len) && magic == ADD_LF_BEFORE_NON_EMPTY) {
-		strbuf_insert(sb, orig_len, "\n", 1);
+	} else if (orig_len != sb->len) {
+		if (magic == ADD_LF_BEFORE_NON_EMPTY)
+			strbuf_insert(sb, orig_len, "\n", 1);
+		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
+			strbuf_insert(sb, orig_len, " ", 1);
 	}
 	return consumed + 1;
 }
@@ -980,7 +987,7 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
 {
 	struct userformat_want *w = context;
 
-	if (*placeholder == '+' || *placeholder == '-')
+	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
 		placeholder++;
 
 	switch (*placeholder) {
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 9b77073..cccacd4 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -200,6 +200,16 @@ test_expect_success 'add LF before non-empty (2)' '
 	grep "^$" actual
 '
 
+test_expect_success 'add SP before non-empty (1)' '
+	git show -s --pretty=format:"%s% bThanks" HEAD^^ >actual &&
+	test $(wc -w <actual) = 2
+'
+
+test_expect_success 'add SP before non-empty (2)' '
+	git show -s --pretty=format:"%s% sThanks" HEAD^^ >actual &&
+	test $(wc -w <actual) = 4
+'
+
 test_expect_success '--abbrev' '
 	echo SHORT SHORT SHORT >expect2 &&
 	echo LONG LONG LONG >expect3 &&
-- 
1.7.1.511.gfbed4
