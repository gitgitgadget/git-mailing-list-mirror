From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [REROLL PATCH 2/8] Support mandatory capabilities
Date: Tue,  8 Dec 2009 15:16:11 +0200
Message-ID: <1260278177-9029-3-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 14:17:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHzw0-0006BE-HJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZLHNQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 08:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZLHNQS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:16:18 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:52161 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbZLHNQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:16:15 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 63BE5EF8A2
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:21 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06C1951074; Tue, 08 Dec 2009 15:16:21 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 300811C6386
	for <git@vger.kernel.org>; Tue,  8 Dec 2009 15:16:20 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.300.gfbc27
In-Reply-To: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134861>

Add support for marking capability as mandatory for hosting git version
to understand. This is useful for helpers which require various types
of assistance from main git binary.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |    5 ++++-
 transport-helper.c                   |   26 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 5cfdc0c..20a05fe 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -25,7 +25,10 @@ Commands are given by the caller on the helper's standard input, one per line.
 
 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
-	with a blank line.
+	with a blank line. Each capability may be preceeded with '*'.
+	This marks them mandatory for git version using the remote
+	helper to understand (unknown mandatory capability is fatal
+	error).
 
 'list'::
 	Lists the refs, one per line, in the format "<value> <name>
diff --git a/transport-helper.c b/transport-helper.c
index a721dc2..f977d28 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -93,25 +93,39 @@ static struct child_process *get_helper(struct transport *transport)
 
 	data->out = xfdopen(helper->out, "r");
 	while (1) {
+		const char *capname;
+		int mandatory = 0;
 		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
+
+		if (*buf.buf == '*') {
+			capname = buf.buf + 1;
+			mandatory = 1;
+		} else
+			capname = buf.buf;
+
 		if (debug)
-			fprintf(stderr, "Debug: Got cap %s\n", buf.buf);
-		if (!strcmp(buf.buf, "fetch"))
+			fprintf(stderr, "Debug: Got cap %s\n", capname);
+		if (!strcmp(capname, "fetch"))
 			data->fetch = 1;
-		if (!strcmp(buf.buf, "option"))
+		else if (!strcmp(capname, "option"))
 			data->option = 1;
-		if (!strcmp(buf.buf, "push"))
+		else if (!strcmp(capname, "push"))
 			data->push = 1;
-		if (!strcmp(buf.buf, "import"))
+		else if (!strcmp(capname, "import"))
 			data->import = 1;
-		if (!data->refspecs && !prefixcmp(buf.buf, "refspec ")) {
+		else if (!data->refspecs && !prefixcmp(capname, "refspec ")) {
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+		} else if (mandatory) {
+			fflush(stderr);
+			die("Unknown madatory capability %s. This remote "
+			    "helper probably needs newer version of Git.\n",
+			    capname);
 		}
 	}
 	if (refspecs) {
-- 
1.6.6.rc1.300.gfbc27
