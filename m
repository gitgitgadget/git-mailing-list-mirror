From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/3] fix clang -Wtautological-compare with unsigned enum
Date: Sun,  3 Feb 2013 14:37:09 +0000
Message-ID: <a9fe675ed9b34d3c15f4678ee13e90cddaa36055.1359901732.git.john@keeping.me.uk>
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
	id 1U20hs-0000JE-Py
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 15:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab3BCOhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 09:37:12 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55379 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab3BCOhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 09:37:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9D50D22B51;
	Sun,  3 Feb 2013 14:37:06 +0000 (GMT)
X-Quarantine-ID: <E8djPZud6TFG>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E8djPZud6TFG; Sun,  3 Feb 2013 14:37:06 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 7106C21F21;
	Sun,  3 Feb 2013 14:36:59 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
References: <cover.1359901732.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215312>

From: Antoine Pelisse <apelisse@gmail.com>

Create a GREP_HEADER_FIELD_MIN so we can check that the field value is
sane and silent the clang warning.

Clang warning happens because the enum is unsigned (this is
implementation-defined, and there is no negative fields) and the check
is then tautological.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 grep.c | 3 ++-
 grep.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 4bd1b8b..bb548ca 100644
--- a/grep.c
+++ b/grep.c
@@ -625,7 +625,8 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-		if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
+		if (p->field < GREP_HEADER_FIELD_MIN ||
+		    GREP_HEADER_FIELD_MAX <= p->field)
 			die("bug: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
diff --git a/grep.h b/grep.h
index 8fc854f..e4a1df5 100644
--- a/grep.h
+++ b/grep.h
@@ -28,7 +28,8 @@ enum grep_context {
 };
 
 enum grep_header_field {
-	GREP_HEADER_AUTHOR = 0,
+	GREP_HEADER_FIELD_MIN = 0,
+	GREP_HEADER_AUTHOR = GREP_HEADER_FIELD_MIN,
 	GREP_HEADER_COMMITTER,
 	GREP_HEADER_REFLOG,
 
-- 
1.8.1.2
