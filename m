From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 07/11] connect.c: Support PuTTY plink and TortoisePlink as SSH on Windows
Date: Sun, 31 May 2009 18:15:21 +0200
Message-ID: <1243786525-4493-8-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
 <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de>
 <1243786525-4493-7-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:19:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnkz-0002tv-M7
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758794AbZEaQT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759256AbZEaQT2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:19:28 -0400
Received: from mailer.zib.de ([130.73.108.11]:58967 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759162AbZEaQT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:19:27 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFWaB006800;
	Sun, 31 May 2009 18:15:37 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVE021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-7-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120419>

From: Edward Z. Yang <edwardzyang@thewritingpot.com>

OpenSSH uses -p to specify custom ports, while PuTTY plink and
TortoisePlink use -P. Git now detects if plink is in GIT_SSH and
modify its flags as necessary.

We call plink with -batch, so that it will error out with an error
message instead of waiting for user input.  As reported in msysGit
issue 96, plink wants to interact with the user asking if a host
key should be accepted, but this just blocks the terminal, since
plink tries to get the answer from stdin.  However, stdin is
already connected to Git that wants to send input to the remote
command.

But we do not pass -batch to TortoisePlink, because TortoisePlink
uses a GUI to communicate with the user, and it does not understand
-batch.

Signed-off-by: Edward Z. Yang <edwardzyang@thewritingpot.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 connect.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index f6b8ba6..692d476 100644
--- a/connect.c
+++ b/connect.c
@@ -602,14 +602,18 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		die("command line too long");
 
 	conn->in = conn->out = -1;
-	conn->argv = arg = xcalloc(6, sizeof(*arg));
+	conn->argv = arg = xcalloc(7, sizeof(*arg));
 	if (protocol == PROTO_SSH) {
 		const char *ssh = getenv("GIT_SSH");
+		int putty = ssh && strcasestr(ssh, "plink");
 		if (!ssh) ssh = "ssh";
 
 		*arg++ = ssh;
+		if (putty && !strcasestr(ssh, "tortoiseplink"))
+			*arg++ = "-batch";
 		if (port) {
-			*arg++ = "-p";
+			/* P is for PuTTY, p is for OpenSSH */
+			*arg++ = putty ? "-P" : "-p";
 			*arg++ = port;
 		}
 		*arg++ = host;
-- 
1.6.3.1.54.g99dd
