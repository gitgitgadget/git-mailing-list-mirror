From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/3] builtin/apply: tighten (dis)similarity index parsing
Date: Sun,  3 Feb 2013 14:37:11 +0000
Message-ID: <2cac21192f79f9fbb5822417775954eba29064fa.1359901732.git.john@keeping.me.uk>
References: <cover.1359901732.git.john@keeping.me.uk>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 15:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U20ht-0000JE-R7
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 15:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3BCOh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 09:37:27 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55514 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab3BCOhY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 09:37:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9D3B11FFC0;
	Sun,  3 Feb 2013 14:37:24 +0000 (GMT)
X-Quarantine-ID: <BcYa6QJuaWcF>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BcYa6QJuaWcF; Sun,  3 Feb 2013 14:37:24 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id BFC9421F21;
	Sun,  3 Feb 2013 14:37:18 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
References: <cover.1359901732.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215313>

This was prompted by an incorrect warning issued by clang [1], and a
suggestion by Linus to restrict the range to check for values greater
than INT_MAX since these will give bogus output after casting to int.

In fact the (dis)similarity index is a percentage, so reject values
greater than 100.

[1] http://article.gmane.org/gmane.comp.version-control.git/213857

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/apply.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 6c11e8b..4745e75 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1041,15 +1041,17 @@ static int gitdiff_renamedst(const char *line, struct patch *patch)
 
 static int gitdiff_similarity(const char *line, struct patch *patch)
 {
-	if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
-		patch->score = 0;
+	unsigned long val = strtoul(line, NULL, 10);
+	if (val <= 100)
+		patch->score = val;
 	return 0;
 }
 
 static int gitdiff_dissimilarity(const char *line, struct patch *patch)
 {
-	if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
-		patch->score = 0;
+	unsigned long val = strtoul(line, NULL, 10);
+	if (val <= 100)
+		patch->score = val;
 	return 0;
 }
 
-- 
1.8.1.2
