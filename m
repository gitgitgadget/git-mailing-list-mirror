From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [updated patch v3 2/2] Improve transport helper exec failure reporting
Date: Thu, 31 Dec 2009 20:26:43 +0200
Message-ID: <1262284003-1417-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 19:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQPjh-0006KS-LS
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 19:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZLaS0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 13:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbZLaS0t
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 13:26:49 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:51394 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbZLaS0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 13:26:47 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id C7ADFEF5F6
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 20:26:46 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07BDE918A7; Thu, 31 Dec 2009 20:26:46 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id B6330407E
	for <git@vger.kernel.org>; Thu, 31 Dec 2009 20:26:45 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
In-Reply-To: <1262284003-1417-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135963>

Previously transport-helper exec failure error reporting was pretty
much useless as it didn't report errors from execve, only from pipe
and fork. Now that run-command passes errno from exec, use the
improved support to actually print useful errors if execution fails.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 5078c71..73da339 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -31,13 +31,19 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->out = -1;
 	helper->err = 0;
 	helper->argv = xcalloc(4, sizeof(*helper->argv));
-	strbuf_addf(&buf, "remote-%s", data->name);
+	strbuf_addf(&buf, "git-remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
 	helper->argv[1] = transport->remote->name;
 	helper->argv[2] = transport->url;
-	helper->git_cmd = 1;
-	if (start_command(helper))
-		die("Unable to run helper: git %s", helper->argv[0]);
+	helper->git_cmd = 0;
+	helper->silent_exec_failure = 1;
+	if (start_command(helper)) {
+		if (errno == ENOENT)
+			die("Unable to find remote helper for \"%s\"",
+				data->name);
+		else
+			die_errno("Unable to run helper %s", helper->argv[0]);
+	}
 	data->helper = helper;
 
 	write_str_in_full(helper->in, "capabilities\n");
-- 
1.6.6.3.gaa2e1
