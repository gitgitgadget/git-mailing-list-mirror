From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 10/12] git rm: do not abort due to an initialised submodule
Date: Fri, 26 Mar 2010 15:25:38 +0000
Message-ID: <1269617140-7827-11-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:26:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBQh-0005ou-Kq
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab0CZP03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:29 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55550 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754307Ab0CZPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:58 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ2-0001oB-Ur; Fri, 26 Mar 2010 15:25:55 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023V-JD; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143247>

This patch causes the "git rm" command to consider "directory not
empty" errors as nonfatal, which will be caused by a submodule being
in an initialised state.  As this is a normal state for a submodule,
it should not cause us to abort.  Neither should we recursively delete
the submodule directory as it may contain unsaved data.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 builtin/rm.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 6ac5114..02ee259 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -250,7 +250,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * abort the "git rm" (but once we've successfully removed
 	 * any file at all, we'll go ahead and commit to it all:
 	 * by then we've already committed ourselves and can't fail
-	 * in the middle)
+	 * in the middle).  However failure to remove a submodule
+	 * directory due to the submodule being initialised is never
+	 * a fatal condition.
 	 */
 	if (!index_only) {
 		int removed = 0;
@@ -261,7 +263,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				removed = 1;
 				continue;
 			}
-			if (!removed)
+			if (!removed && errno != EEXIST && errno != ENOTEMPTY)
 				die_errno("git rm: '%s'", path);
 			else
 				warning("git rm: '%s': %s", path, strerror(errno));
-- 
1.6.5
