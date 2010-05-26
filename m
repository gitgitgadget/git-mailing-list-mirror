From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 101/104] test get_git_work_tree() return value for NULL
Date: Wed, 26 May 2010 18:01:11 +1200
Message-ID: <1274853674-18521-101-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9lk-0004ff-CI
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934076Ab0EZGGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:06:53 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49312 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933970Ab0EZGGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 081D1338B3;
	Wed, 26 May 2010 18:02:14 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSU6atgUd5Of; Wed, 26 May 2010 18:02:07 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 08672338EB;
	Wed, 26 May 2010 18:01:41 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147753>

From: Clemens Buchacher <drizzd@aon.at>

If we are in a git directory, get_git_work_tree() can return NULL.
While trying to determine whether or not the given paths are outside
the work tree, the following command would read from it anyways and
trigger a segmentation fault.

 git diff / /

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index aae8e7a..4cd9dac 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -150,16 +150,14 @@ static int queue_diff(struct diff_options *o,
 
 static int path_outside_repo(const char *path)
 {
-	/*
-	 * We have already done setup_git_directory_gently() so we
-	 * know we are inside a git work tree already.
-	 */
 	const char *work_tree;
 	size_t len;
 
 	if (!is_absolute_path(path))
 		return 0;
 	work_tree = get_git_work_tree();
+	if (!work_tree)
+		return 1;
 	len = strlen(work_tree);
 	if (strncmp(path, work_tree, len) ||
 	    (path[len] != '\0' && path[len] != '/'))
-- 
1.7.1.rc2.333.gb2668
