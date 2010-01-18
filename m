From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH 2/2] branch: warn and refuse to set a branch as a tracking branch of itself.
Date: Mon, 18 Jan 2010 22:44:12 +0200
Message-ID: <1263847452-29634-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1263847452-29634-1-git-send-email-ilari.liusvaara@elisanet.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 21:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWySm-0005pO-6q
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab0ARUo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 15:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121Ab0ARUo0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 15:44:26 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:53360 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0ARUoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 15:44:25 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 8504E18D5A6;
	Mon, 18 Jan 2010 22:44:24 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00AD5831C7; Mon, 18 Jan 2010 22:44:24 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 6774C41BE2;
	Mon, 18 Jan 2010 22:44:21 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
In-Reply-To: <1263847452-29634-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137403>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

Previous patch allows commands like "git branch foo foo --track", which
doesn't make much sense. Warn the user and don't change the configuration
in this case. Don't die to let the caller finish its job in such case.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 branch.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 40d3c45..9e1f63e 100644
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
1.6.6.199.gff4b0
