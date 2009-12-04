From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 8/8] Support mandatory capabilities
Date: Fri,  4 Dec 2009 17:56:08 +0200
Message-ID: <1259942168-24869-11-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaX9-0002gj-Hs
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895AbZLDP5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755796AbZLDP5L
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:57:11 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:58826 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344AbZLDP5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:57:09 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 59FF38C11F
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:57:15 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04DA055236; Fri, 04 Dec 2009 17:57:15 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 286604045
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:57:13 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134526>

Add support for marking capability as mandatory for hosting git version
to understand. This is useful for helpers which require various types
of assistance from main git binary.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 Documentation/git-remote-helpers.txt |    5 ++++-
 transport-helper.c                   |   29 ++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 91cd9eb..6af6824 100644
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
index 03920bb..9ddcdc3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -140,27 +140,42 @@ static struct child_process *get_helper(struct transport *transport)
 	write_constant(helper->in, "capabilities\n");
 
 	while (1) {
+		const char* capname;
+		int mandatory = 0;
 		recvline(data, &buf);
 
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
-		if (!strcmp(buf.buf, "connect"))
+		else if (!strcmp(capname, "connect"))
 			data->connect = 1;
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
1.6.6.rc1.288.g40e67
