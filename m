From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-apply: Remove directories that have become empty after deleting a file.
Date: Tue, 09 Jan 2007 21:25:46 +0100
Message-ID: <87fyak0wxh.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 21:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4NXf-0002PC-OJ
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbXAIUZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbXAIUZx
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:25:53 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:53675 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbXAIUZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:25:52 -0500
Received: from adsl-84-226-97-216.adslplus.ch ([84.226.97.216] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1H4NXb-00058c-7L
	for git@vger.kernel.org; Tue, 09 Jan 2007 14:25:52 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 4018B4F6AD; Tue,  9 Jan 2007 21:25:46 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36394>


Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-apply.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 1c35837..fac8349 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2239,7 +2239,21 @@ static void remove_file(struct patch *patch)
 		cache_tree_invalidate_path(active_cache_tree, patch->old_name);
 	}
 	if (!cached)
-		unlink(patch->old_name);
+	{
+		if (!unlink(patch->old_name))
+		{
+			char *name = xstrdup(patch->old_name);
+			char *end = strrchr(name, '/');
+			while (end)
+			{
+				*end = 0;
+				if (rmdir(name))
+					break;
+				end = strrchr(name, '/');
+			}
+			free(name);
+		}
+	}
 }
 
 static void add_index_file(const char *path, unsigned mode, void *buf, unsigned long size)
-- 
1.4.4.4.g37ed

-- 
Alexandre Julliard
julliard@winehq.org
