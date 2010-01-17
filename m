From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] branch: warn and refuse to set a branch as a tracking branch of itself.
Date: Sun, 17 Jan 2010 15:06:52 +0100
Message-ID: <1263737212-8101-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 15:07:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWVmq-00031f-O0
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 15:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab0AQOHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 09:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753756Ab0AQOHW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 09:07:22 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42491 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753436Ab0AQOHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 09:07:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0HE6cvG014556
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 15:06:38 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NWVmZ-0005j7-8N; Sun, 17 Jan 2010 15:07:11 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NWVmZ-00028I-78; Sun, 17 Jan 2010 15:07:11 +0100
X-Mailer: git-send-email 1.6.6.198.gbaea2
In-Reply-To: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 17 Jan 2010 15:06:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HE6cvG014556
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1264342000.23464@w77QrzMtLAznm3y4PrH5rA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137299>

Previous patch allows commands like "git branch foo foo --track", which
doesn't make much sense. Warn the user and don't change the configuration
in this case. Don't die to let the caller finish its job in such case.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 branch.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index d187891..d769c8a 100644
--- a/branch.c
+++ b/branch.c
@@ -49,9 +49,19 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
+	const char *shortname = remote + 11;
+	int remote_is_branch = !prefixcmp(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
+	if (remote_is_branch
+	    && !strcmp(local, shortname)
+	    && !origin) {
+		warning("Not setting branch %s as its own upstream.",
+			local);
+		return;
+	}
+
 	strbuf_addf(&key, "branch.%s.remote", local);
 	git_config_set(key.buf, origin ? origin : ".");
 
@@ -71,8 +81,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 		strbuf_addstr(&key, origin ? "remote" : "local");
 
 		/* Are we tracking a proper "branch"? */
-		if (!prefixcmp(remote, "refs/heads/")) {
-			strbuf_addf(&key, " branch %s", remote + 11);
+		if (remote_is_branch) {
+			strbuf_addf(&key, " branch %s", shortname);
 			if (origin)
 				strbuf_addf(&key, " from %s", origin);
 		}
-- 
1.6.6.198.gbaea2
