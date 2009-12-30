From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [Updated PATCH 2/2] Improve transport helper exec failure reporting
Date: Wed, 30 Dec 2009 12:52:18 +0200
Message-ID: <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 11:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwAT-00025X-J4
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 11:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZL3Kw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 05:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbZL3KwZ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 05:52:25 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:35108 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZL3KwY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 05:52:24 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 70D398C474
	for <git@vger.kernel.org>; Wed, 30 Dec 2009 12:52:23 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A057576D1B8; Wed, 30 Dec 2009 12:52:23 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 5CE0D1C6393
	for <git@vger.kernel.org>; Wed, 30 Dec 2009 12:52:22 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
In-Reply-To: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135880>

Previously transport-helper exec failure error reporting was pretty
much useless as it didn't report errors from execve, only from pipe
and fork. Now that run-command passes errno from exec, use the
improved support to actually print useful errors if execution fails.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 5078c71..0965c9b 100644
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
+	if (start_command(helper)) {
+		if (errno == ENOENT)
+			die("Unable to find remote helper for \"%s\"",
+				data->name);
+		else
+			die("Unable to run helper %s: %s", helper->argv[0],
+				strerror(errno));
+	}
 	data->helper = helper;
 
 	write_str_in_full(helper->in, "capabilities\n");
-- 
1.6.6.3.gaa2e1
