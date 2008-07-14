From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 3/5] Fix relative built-in paths to be relative to the command invocation
Date: Mon, 14 Jul 2008 23:41:27 +0200
Message-ID: <1216071689-14823-4-git-send-email-johannes.sixt@telecom.at>
References: <1216025226.487b128a031fd@webmail.eunet.at>
 <1216071689-14823-1-git-send-email-johannes.sixt@telecom.at>
 <1216071689-14823-2-git-send-email-johannes.sixt@telecom.at>
 <1216071689-14823-3-git-send-email-johannes.sixt@telecom.at>
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 23:42:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIVoa-0002Di-Am
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 23:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbYGNVli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 17:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756975AbYGNVlh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 17:41:37 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:40591 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbYGNVlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 17:41:32 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 3C7AA13ADCC;
	Mon, 14 Jul 2008 23:41:31 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.323.g1e58
In-Reply-To: <1216071689-14823-3-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88465>

$(gitexecdir) (as defined in the Makefile) has gained another path
component, but the relative paths in the MINGW section of the Makefile,
which are interpreted relative to it, do not account for it.

Instead of adding another ../ in front of the path, we change the code that
constructs the absolute paths to do it relative to the command's directory,
which is essentially $(bindir). We do it this way because we will also
allow a relative $(gitexecdir) later.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile   |    2 +-
 exec_cmd.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4de9271..b9ea0ea 100644
--- a/Makefile
+++ b/Makefile
@@ -1301,7 +1301,7 @@ remove-dashes:
 ### Installation rules
 
 ifeq ($(firstword $(subst /, ,$(template_dir))),..)
-template_instdir = $(gitexecdir)/$(template_dir)
+template_instdir = $(bindir)/$(template_dir)
 else
 template_instdir = $(template_dir)
 endif
diff --git a/exec_cmd.c b/exec_cmd.c
index dedb01d..45f92eb 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -43,9 +43,9 @@ static const char *builtin_exec_path(void)
 
 const char *system_path(const char *path)
 {
-	if (!is_absolute_path(path)) {
+	if (!is_absolute_path(path) && argv0_path) {
 		struct strbuf d = STRBUF_INIT;
-		strbuf_addf(&d, "%s/%s", git_exec_path(), path);
+		strbuf_addf(&d, "%s/%s", argv0_path, path);
 		path = strbuf_detach(&d, NULL);
 	}
 	return path;
-- 
1.5.6.3.323.g1e58
