From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH 8/8] Support mandatory capabilities
Date: Tue,  1 Dec 2009 15:57:18 +0200
Message-ID: <1259675838-14692-9-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 15:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFTPP-0000SF-S6
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 15:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbZLAOI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 09:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbZLAOIZ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 09:08:25 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:37500 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbZLAOIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 09:08:23 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 6C50413BED5
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:58:02 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A041FF6968A; Tue, 01 Dec 2009 15:58:02 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id D7BF6E51A8
	for <git@vger.kernel.org>; Tue,  1 Dec 2009 15:57:59 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc0.64.g5593e
In-Reply-To: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134209>

Add support for marking capability as mandatory for hosting git version
to understand. This is useful for helpers which require various types
of assistance from main git binary.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |    5 ++++-
 transport-helper.c                   |   31 +++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index adf815c..eab9c03 100644
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
index 697f026..a128560 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -145,30 +145,45 @@ static struct child_process *get_helper(struct transport *transport)
 	write_constant(helper->in, "capabilities\n");
 
 	while (1) {
+		const char* capname;
+		int mandatory = 0;
 		recvline(data, &buf, seen_line);
 		seen_line = 1;
 
 		if (!*buf.buf)
 			break;
-		if(debug) fprintf(stderr, "Debug: Got cap %s\n", buf.buf);
-		if (!strcmp(buf.buf, "fetch"))
+
+		if(*buf.buf == '*') {
+			capname = buf.buf + 1;
+			mandatory = 1;
+		} else
+			capname = buf.buf;
+
+		if(debug) fprintf(stderr, "Debug: Got cap %s\n", capname);
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
 		}
-		if (!strcmp(buf.buf, "connect-r"))
+		else if (!strcmp(capname, "connect-r"))
 			data->connect_r = 1;
-		if (!strcmp(buf.buf, "invoke-r"))
+		else if (!strcmp(capname, "invoke-r"))
 			data->invoke_r = 1;
+		else if (mandatory) {
+			fflush(stderr);
+			die("Unknown madatory capability %s. This remote "
+			    "helper probably needs newer version of Git.\n",
+			    capname);
+		}
 	}
 	if (refspecs) {
 		int i;
-- 
1.6.6.rc0.64.g5593e
