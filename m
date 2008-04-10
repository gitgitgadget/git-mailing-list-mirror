From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 02/10] config.c: Escape backslashes in section names properly
Date: Thu, 10 Apr 2008 02:50:08 -0400
Message-ID: <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:51:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqdR-00031G-Kw
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbYDJGvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbYDJGvE
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:51:04 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34037 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbYDJGvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:51:03 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003w9-LA; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbw-0007Ft-Rr; Thu, 10 Apr 2008 02:50:16 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79175>

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
index 0624494..6c07245 100644
--- a/config.c
+++ b/config.c
@@ -672,7 +672,7 @@ static int store_write_section(int fd, const char* key)
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
1.5.5.33.gc0a39.dirty
