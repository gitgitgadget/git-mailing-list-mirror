From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: Fixes shortstat number of files
Date: Fri, 23 Nov 2012 08:33:19 +0100
Message-ID: <1353655999-9529-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 08:33:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbnln-0008DW-A0
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 08:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830Ab2KWHdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 02:33:37 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:41632 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964780Ab2KWHdg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 02:33:36 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so2290842wer.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 23:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ljh82yfLj11aZUnx421yusNej7QOndBWrYtwMpyC3JA=;
        b=YU88HfyY1+TrRmZuih1zFcwSMQvTUfUWwiza3t5YUDhBP00ALF0g4/vyZp1X280aso
         2TuRkAmoLkF3ZAZxWjCY2hejsBLmYCBMessH/Wkp15lMDx8xvYEPnCJ0PJQ0wnac5/0v
         KOcPLqYCKVo6UliQL5O838gKVo+bBqIDUL4MYAsPnK2lzV5jrG9ywLA+QSTM/ZOhf2Gv
         PpItYohj9hnCRlzhdyZrb8fI31TjJBNf5rSD+WHcW7MaGKMmOnBLrMJJfh1shnql+Lsd
         xgchwie4g42h+YEumcMcPjEgwhzfK+XRuR2asXvHtmsyjA5+R1zx7mN/Ufq7PeLxwaTA
         P0gw==
Received: by 10.216.143.105 with SMTP id k83mr195824wej.15.1353656015231;
        Thu, 22 Nov 2012 23:33:35 -0800 (PST)
Received: from localhost.localdomain (vau06-3-82-247-80-218.fbx.proxad.net. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm7416655wiv.6.2012.11.22.23.33.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Nov 2012 23:33:34 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210240>

There is a discrepancy between the last line of `git diff --stat`
and `git diff --shortstat` in case of a merge.
The unmerged files are actually counted twice, thus doubling the
value of "file changed".

In fact, while stat decrements number of files when seeing an unmerged
file, shortstat doesn't.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 diff.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index e89a201..5c6bcbd 100644
--- a/diff.c
+++ b/diff.c
@@ -1704,9 +1704,8 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 		int added = data->files[i]->added;
 		int deleted= data->files[i]->deleted;
 
-		if (data->files[i]->is_unmerged)
-			continue;
-		if (!data->files[i]->is_renamed && (added + deleted == 0)) {
+		if (data->files[i]->is_unmerged ||
+		  (!data->files[i]->is_renamed && (added + deleted == 0))) {
 			total_files--;
 		} else if (!data->files[i]->is_binary) { /* don't count bytes */
 			adds += added;
-- 
1.7.9.5
