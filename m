From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Create a symbolic link as a regular file on filesystems without symlinks.
Date: Tue, 27 Feb 2007 22:41:39 +0100
Message-ID: <11726125052184-git-send-email-johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <11726125033437-git-send-email-johannes.sixt@telecom.at> <1172612504272-git-send-email-johannes.sixt@telecom.at>
Cc: Johannes Sixt <johannes.sixt@telecom.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 22:42:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA58-0000yR-2J
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbXB0Vlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXB0Vlt
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:49 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:46978 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbXB0Vlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:47 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 8A92B976FC;
	Tue, 27 Feb 2007 22:41:45 +0100 (CET)
X-Mailer: git-send-email 1.5.0.19.gddff
In-Reply-To: <1172612504272-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40815>

If core.symlinks = false, the filesystem is actually populated with
a regular file that contains the link text.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 builtin-apply.c |    2 +-
 entry.c         |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index bec95d6..1636807 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2284,7 +2284,7 @@ static int try_create_file(const char *path, unsigned int mode, const char *buf,
 {
 	int fd;
 
-	if (S_ISLNK(mode))
+	if (trust_symlink_fmt && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
diff --git a/entry.c b/entry.c
index c2641dd..3d5c0e4 100644
--- a/entry.c
+++ b/entry.c
@@ -100,6 +100,11 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 		if (to_tempfile) {
 			strcpy(path, ".merge_link_XXXXXX");
 			fd = mkstemp(path);
+		} else if (!trust_symlink_fmt) {
+			/* write a regular file */
+			fd = create_file(path, 0666);
+		}
+		if (to_tempfile || !trust_symlink_fmt) {
 			if (fd < 0) {
 				free(new);
 				return error("git-checkout-index: unable to create "
-- 
1.5.0.19.gddff
