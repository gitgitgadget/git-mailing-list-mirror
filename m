From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH v3] git cherry-pick: Add NULL check to sequencer parsing of HEAD
Date: Thu,  3 May 2012 10:09:19 -0400
Message-ID: <1336054159-5123-1-git-send-email-nhorman@tuxdriver.com>
References: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
Cc: mmueller@vigilantsw.com, rene.scharfe@lsrfire.ath.cx,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 16:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPwix-00049I-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 16:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab2ECOJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 10:09:35 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:53686 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab2ECOJe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 10:09:34 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SPwik-0005X2-9p; Thu, 03 May 2012 10:09:31 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1336044026-16897-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -0.2 (/)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196909>

Michael Mueller noted that a feature I recently added failed to check the return
of lookup_commit to ensure that it was not NULL.  I don't think a NULL can
actually happen in the this particular use case, but regardless it seems a good
idea to check.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
---
 sequencer.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f83cdfd..f7eac1d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -261,9 +261,9 @@ static int is_index_unchanged(void)
 		return error(_("Could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(head_sha1);
-	if (!head_commit || parse_commit(head_commit))
-		return error(_("could not parse commit %s\n"),
-			     sha1_to_hex(head_commit->object.sha1));
+
+	if (parse_commit(head_commit))
+		return -1;
 
 	if (!active_cache_tree)
 		active_cache_tree = cache_tree();
-- 
1.7.7.6
