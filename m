From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 02/10] config.c: Escape backslashes in section names properly
Date: Sun,  4 May 2008 01:37:52 -0400
Message-ID: <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWxA-0004ce-QB
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYEDFi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbYEDFi6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:58 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37813 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbYEDFi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:58 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Mh-Uf; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvA-0004P9-Mb; Sun, 04 May 2008 01:38:00 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81144>

If an element of the configuration key name other than the first or last
contains a backslash, it is not escaped on output, but is treated as an escape
sequence on input. Thus, the backslash is lost when re-loading the
configuration.

This patch corrects this by having backslashes escaped properly, and
introduces a new test for this bug.

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 config.c                |    2 +-
 t/t1303-wacky-config.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index b0ada51..f0ac456 100644
--- a/config.c
+++ b/config.c
@@ -680,7 +680,7 @@ static int store_write_section(int fd, const char* key)
 	if (dot) {
 		strbuf_addf(&sb, "[%.*s \"", (int)(dot - key), key);
 		for (i = dot - key + 1; i < store.baselen; i++) {
-			if (key[i] == '"')
+			if (key[i] == '"' || key[i] == '\\')
 				strbuf_addch(&sb, '\\');
 			strbuf_addch(&sb, key[i]);
 		}
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 99985dc..f366b53 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -34,4 +34,10 @@ test_expect_success 'add key in different section' '
 	check section2.key bar
 '
 
+SECTION="test.q\"s\\sq'sp e.key"
+test_expect_success 'make sure git-config escapes section names properly' '
+	git config "$SECTION" bar &&
+	check "$SECTION" bar
+'
+
 test_done
-- 
1.5.5.1.128.g03a943
