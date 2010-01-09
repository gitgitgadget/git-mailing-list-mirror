From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 2/2] Improve transport helper exec failure reporting
Date: Sat,  9 Jan 2010 15:45:57 +0200
Message-ID: <1263044757-12560-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 09 14:46:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTbdv-0002WI-CB
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 14:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab0AINqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 08:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553Ab0AINqH
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 08:46:07 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:47955 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab0AINqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 08:46:04 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id C1047EBC03
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 15:46:02 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00690B53DC; Sat, 09 Jan 2010 15:46:02 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 9474427D89
	for <git@vger.kernel.org>; Sat,  9 Jan 2010 15:46:01 +0200 (EET)
X-Mailer: git-send-email 1.6.6.3.gaa2e1
In-Reply-To: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136531>

Previously transport-helper exec failure error reporting was pretty
much useless as it didn't report errors from execve, only from pipe
and fork. Now that run-command passes errno from exec, use the
improved support to actually print useful errors if execution fails.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 transport-helper.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 5147296..72be965 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -102,6 +102,7 @@ static struct child_process *get_helper(struct transport *transport)
 	int refspec_nr = 0;
 	int refspec_alloc = 0;
 	int duped;
+	int code;
 
 	if (data->helper)
 		return data->helper;
@@ -111,13 +112,31 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->out = -1;
 	helper->err = 0;
 	helper->argv = xcalloc(4, sizeof(*helper->argv));
-	strbuf_addf(&buf, "remote-%s", data->name);
+	strbuf_addf(&buf, "git-remote-%s", data->name);
 	helper->argv[0] = strbuf_detach(&buf, NULL);
 	helper->argv[1] = transport->remote->name;
 	helper->argv[2] = remove_ext_force(transport->url);
-	helper->git_cmd = 1;
-	if (start_command(helper))
-		die("Unable to run helper: git %s", helper->argv[0]);
+	helper->argv[2] = transport->url;
+	helper->git_cmd = 0;
+	helper->silent_exec_failure = 1;
+	helper->extended_error_code = 1;
+	/*
+	 * Print errors even if start_command should have printed them in
+	 * order to get proper fatal-level error message and include
+	 * errnos to make inevitable incomplete problem reports more useful
+	 * (those have nasty tendency of including only the last line that
+	 * looks like error).
+	 */
+	code = start_command(helper);
+	if (code == -2)
+		die("Unable to find remote helper for '%s'",
+			data->name);
+	else if(code == -1)
+		die_errno("Error running helper for '%s'", data->name);
+	else if(code != 0)
+		/* Shouldn't happen. */
+		die_errno("code %i running helper for '%s'", code, data->name);
+
 	data->helper = helper;
 	data->no_disconnect_req = 0;
 
-- 
1.6.6.3.gaa2e1
