From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] diff.c: Reuse the pprint_rename function for diff --summary output.
Date: Sat, 10 Feb 2007 15:36:47 +0100
Message-ID: <87mz3mdqps.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 10 15:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtLT-0003sr-EE
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbXBJOgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXBJOgw
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:36:52 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:40294 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300AbXBJOgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:36:52 -0500
Received: from adsl-62-167-54-243.adslplus.ch ([62.167.54.243] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HFtLO-0000Fg-IB
	for git@vger.kernel.org; Sat, 10 Feb 2007 08:36:51 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 1C8F84FB65; Sat, 10 Feb 2007 15:36:48 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39220>

This avoids some code duplication, and yields more readable results
for directory renames.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 diff.c |   31 ++++---------------------------
 1 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/diff.c b/diff.c
index ad476f7..4c642d7 100644
--- a/diff.c
+++ b/diff.c
@@ -2430,34 +2430,11 @@ static void show_mode_change(struct diff_filepair *p, int show_name)
 
 static void show_rename_copy(const char *renamecopy, struct diff_filepair *p)
 {
-	const char *old, *new;
+	char *names = pprint_rename(p->one->path, p->two->path);
 
-	/* Find common prefix */
-	old = p->one->path;
-	new = p->two->path;
-	while (1) {
-		const char *slash_old, *slash_new;
-		slash_old = strchr(old, '/');
-		slash_new = strchr(new, '/');
-		if (!slash_old ||
-		    !slash_new ||
-		    slash_old - old != slash_new - new ||
-		    memcmp(old, new, slash_new - new))
-			break;
-		old = slash_old + 1;
-		new = slash_new + 1;
-	}
-	/* p->one->path thru old is the common prefix, and old and new
-	 * through the end of names are renames
-	 */
-	if (old != p->one->path)
-		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
-		       (int)(old - p->one->path), p->one->path,
-		       old, new, (int)(0.5 + p->score * 100.0/MAX_SCORE));
-	else
-		printf(" %s %s => %s (%d%%)\n", renamecopy,
-		       p->one->path, p->two->path,
-		       (int)(0.5 + p->score * 100.0/MAX_SCORE));
+	printf(" %s %s (%d%%)\n", renamecopy, names,
+	       (int)(0.5 + p->score * 100.0/MAX_SCORE));
+	free(names);
 	show_mode_change(p, 0);
 }
 
-- 
1.5.0.rc4.31.g6289

-- 
Alexandre Julliard
julliard@winehq.org
