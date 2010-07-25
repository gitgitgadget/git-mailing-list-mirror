From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: [PATCH v2] revert: only suggest to commit if not passing -n
Date: Sun, 25 Jul 2010 05:54:30 -0700
Message-ID: <1280062470-21891-1-git-send-email-carenas@sajinet.com.pe>
References: <20100723164218.GA2284@localhost.localdomain>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 14:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0jB-0000KL-MS
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab0GYMye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 08:54:34 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:58311 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014Ab0GYMyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:54:33 -0400
Received: by sajino.sajinet.com.pe (Postfix, from userid 65534)
	id A783AA580D4; Sun, 25 Jul 2010 12:54:31 +0000 (UTC)
Received: from dell.sajinet.com.pe (dsl081-071-036.sfo1.dsl.speakeasy.net [64.81.71.36])
	by sajino.sajinet.com.pe (Postfix) with ESMTP id 5770FA580B9
	for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:54:31 +0000 (UTC)
X-Mailer: git-send-email 1.7.2
In-Reply-To: <20100723164218.GA2284@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151739>

while doing revert or cherry-pick, if the automatic merge fails
and the user specifically suggested he didn't want to commit,
then don't suggest to do that as part of the conflict resolution.

Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
---
 builtin/revert.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 8b9d829..b7cb69b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -250,14 +250,18 @@ static char *help_msg(void)
 		return msg;
 
 	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
-		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
-		"and commit the result");
+		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'");
+	if (!no_commit) {
+		strbuf_addstr(&helpbuf, "\nand commit the result");
 
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
1.7.2
