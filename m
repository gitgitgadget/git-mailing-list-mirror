From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC 1/2] Add backdoor options to receive-pack for use in Git-aware CGI
Date: Sun,  3 Aug 2008 00:25:16 -0700
Message-ID: <1217748317-70096-1-git-send-email-spearce@spearce.org>
References: <20080803025602.GB27465@spearce.org>
To: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 09:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPXz2-00077l-CB
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 09:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYHCHZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 03:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYHCHZV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 03:25:21 -0400
Received: from george.spearce.org ([209.20.77.23]:41406 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYHCHZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 03:25:20 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0607038368; Sun,  3 Aug 2008 07:25:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 63C2838368;
	Sun,  3 Aug 2008 07:25:18 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.221.g9ae23
In-Reply-To: <20080803025602.GB27465@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91210>

The new --report-status flag forces the status report feature of
the push protocol to be enabled.  This can be useful in a CGI
program that implements the server side of a "smart" Git-aware
HTTP transport.  The CGI code can perform the selection of the
feature and ask receive-pack to enable it automatically.

The new --no-advertise-heads causes receive-pack to bypass its usual
display of known refs to the client, and instead immediately start
reading the commands and pack from stdin.  This is useful in a CGI
situation where we want to hand off all input to receive-pack.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index d44c19e..512eae6 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -464,6 +464,7 @@ static int delete_only(struct command *cmd)
 
 int main(int argc, char **argv)
 {
+	int advertise_heads = 1;
 	int i;
 	char *dir = NULL;
 
@@ -472,7 +473,15 @@ int main(int argc, char **argv)
 		char *arg = *argv++;
 
 		if (*arg == '-') {
-			/* Do flag handling here */
+			if (!strcmp(arg, "--report-status")) {
+				report_status = 1;
+				continue;
+			}
+			if (!strcmp(arg, "--no-advertise-heads")) {
+				advertise_heads = 0;
+				continue;
+			}
+
 			usage(receive_pack_usage);
 		}
 		if (dir)
@@ -497,10 +506,10 @@ int main(int argc, char **argv)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
-	write_head_info();
-
-	/* EOF */
-	packet_flush(1);
+	if (advertise_heads) {
+		write_head_info();
+		packet_flush(1);
+	}
 
 	read_head_info();
 	if (commands) {
-- 
1.6.0.rc1.221.g9ae23
