From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 7/9] git rm: do not abort due to an initialised submodule
Date: Sat, 10 Apr 2010 19:23:48 +0100
Message-ID: <1270923830-11830-8-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMQ-0007O3-OI
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0DJSYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:21 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37802 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100Ab0DJSX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:59 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLV-0006qU-TC; Sat, 10 Apr 2010 19:23:54 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036Q-L6; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144568>

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
