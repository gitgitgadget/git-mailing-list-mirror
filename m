From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: [PATCH] revert: only suggest to commit if not passing -n
Date: Thu, 22 Jul 2010 06:51:32 -0700
Message-ID: <1279806692-6762-1-git-send-email-carenas@sajinet.com.pe>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 16:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObwJw-0002dQ-Cc
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 16:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441Ab0GVN7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 09:59:31 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:38536 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195Ab0GVN7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 09:59:17 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jul 2010 09:59:17 EDT
Received: by sajino.sajinet.com.pe (Postfix, from userid 65534)
	id 4906AA580C3; Thu, 22 Jul 2010 13:51:33 +0000 (UTC)
Received: from dell.sajinet.com.pe (dsl081-071-036.sfo1.dsl.speakeasy.net [64.81.71.36])
	by sajino.sajinet.com.pe (Postfix) with ESMTP id F2F3EA58079
	for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:51:32 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151458>

while doing revert or cherry-pick, if the automatic merge fails
and the user specifically suggested he didn't want to commit,
then don't suggest to do that as part of the conflict resolution.

Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
---
 builtin/revert.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b9d829..72d0753 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -250,14 +250,18 @@ static char *help_msg(void)
 		return msg;
 
 	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
-		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
-		"and commit the result");
+		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'");
+	if (!no_commit) {
+		strbuf_addf(&helpbuf, "\nand commit the result");
 
-	if (action == CHERRY_PICK) {
-		strbuf_addf(&helpbuf, " with: \n"
-			"\n"
-			"        git commit -c %s\n",
-			    sha1_to_hex(commit->object.sha1));
+		if (action == CHERRY_PICK) {
+			strbuf_addf(&helpbuf, " with: \n"
+				"\n"
+				"        git commit -c %s\n",
+				    sha1_to_hex(commit->object.sha1));
+		}
+		else
+			strbuf_addch(&helpbuf, '.');
 	}
 	else
 		strbuf_addch(&helpbuf, '.');
-- 
1.7.1.1
