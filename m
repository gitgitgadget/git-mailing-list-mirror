From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [RFC PATCH v2 5/8] Support remote archive from external protocol helpers
Date: Fri,  4 Dec 2009 17:56:05 +0200
Message-ID: <1259942168-24869-8-git-send-email-ilari.liusvaara@elisanet.fi>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 17:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGaWp-0002SW-DA
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 16:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878AbZLDP4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 10:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756865AbZLDP4u
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 10:56:50 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:36023 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870AbZLDP4u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 10:56:50 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 6A48EEBEA3
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:56 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04D2266B0B; Fri, 04 Dec 2009 17:56:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 5D646158A63
	for <git@vger.kernel.org>; Fri,  4 Dec 2009 17:56:53 +0200 (EET)
X-Mailer: git-send-email 1.6.6.rc1.288.g40e67
In-Reply-To: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134524>

Helpers which support invoke/connect also should support remote archive
snapshot (or at least there's only one way to attempt it). So support
remote snapshotting for protocol helpers.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 builtin-archive.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 12351e9..d34b3fd 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -5,6 +5,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
+#include "transport.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "sideband.h"
@@ -25,12 +26,16 @@ static void create_output_file(const char *output_file)
 static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec)
 {
-	char *url, buf[LARGE_PACKET_MAX];
+	char buf[LARGE_PACKET_MAX];
 	int fd[2], i, len, rv;
-	struct child_process *conn;
+	struct transport *transport;
+	struct remote *_remote;
 
-	url = xstrdup(remote);
-	conn = git_connect(fd, url, exec, 0);
+	_remote = remote_get(remote);
+	if (!_remote->url[0])
+		die("git archive: Remote with no URL");
+	transport = transport_get(_remote, _remote->url[0]);
+	transport_connect(transport, "git-upload-archive", exec, fd);
 
 	for (i = 1; i < argc; i++)
 		packet_write(fd[1], "argument %s\n", argv[i]);
@@ -53,9 +58,7 @@ static int run_remote_archiver(int argc, const char **argv,
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
 	rv = recv_sideband("archive", fd[0], 1);
-	close(fd[0]);
-	close(fd[1]);
-	rv |= finish_connect(conn);
+	rv |= transport_disconnect(transport);
 
 	return !!rv;
 }
-- 
1.6.6.rc1.288.g40e67
