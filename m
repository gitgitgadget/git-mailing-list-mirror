From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] diffcore-break: don't divide by zero
Date: Tue,  2 Apr 2013 20:50:31 +0100
Message-ID: <a2b6c61371ac6ff1e180c6600e57499ff94b2fd2.1364931627.git.john@keeping.me.uk>
References: <cover.1364931627.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7Em-0005Im-F8
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab3DBTut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:50:49 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57685 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab3DBTut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:50:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D3B7621445;
	Tue,  2 Apr 2013 20:50:48 +0100 (BST)
X-Quarantine-ID: <L5BZ8rlZNPpH>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5BZ8rlZNPpH; Tue,  2 Apr 2013 20:50:48 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id E8A4522BB5;
	Tue,  2 Apr 2013 20:50:42 +0100 (BST)
X-Mailer: git-send-email 1.8.2.540.gf023cfe
In-Reply-To: <cover.1364931627.git.john@keeping.me.uk>
In-Reply-To: <cover.1364931627.git.john@keeping.me.uk>
References: <cover.1364931627.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219868>

When the source file is empty, the calculation of the merge score
results in a division by zero.  Since the merge score is initialized to
zero, it makes sense to just leave it as it is if the source size is
zero.  This means that we still use the extent of damage metric to
decide whether to break the filepair.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 diffcore-break.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 44f8678..37d8d05 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -90,7 +90,8 @@ static int should_break(struct diff_filespec *src,
 	 * merge the surviving pair together if the score is
 	 * less than the minimum, after rename/copy runs.
 	 */
-	*merge_score_p = (int)(src_removed * MAX_SCORE / src->size);
+	if (src->size)
+		*merge_score_p = (int)(src_removed * MAX_SCORE / src->size);
 	if (*merge_score_p > break_score)
 		return 1;
 
-- 
1.8.2.540.gf023cfe
