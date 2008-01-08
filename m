From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2] recv_sideband: Do not use ANSI escape sequence on dumb
 terminals.
Date: Tue, 08 Jan 2008 17:24:53 +0100
Message-ID: <4783A3D5.70309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 17:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCHGW-0003jW-Co
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 17:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761062AbYAHQY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 11:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761092AbYAHQY4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 11:24:56 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48157 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760477AbYAHQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 11:24:55 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCHG2-00077R-Po; Tue, 08 Jan 2008 17:24:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DC5C66EF; Tue,  8 Jan 2008 17:24:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69889>

From: Johannes Sixt <johannes.sixt@telecom.at>

The "clear to end of line" sequence is used to nicely output the progress
indicator without leaving garbage on the terminal. However, this works
only on ANSI capable terminals. We use the same check as in color.c to
find out whether the terminal supports this feature and use a workaround
(a few spaces in a row) if it does not.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 sideband.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sideband.c b/sideband.c
index 513d7b3..0873e69 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,15 +13,22 @@
  */

 #define PREFIX "remote:"
-#define SUFFIX "\033[K"  /* change to "        " if ANSI sequences don't work */

 int recv_sideband(const char *me, int in_stream, int out, int err)
 {
 	unsigned pf = strlen(PREFIX);
-	unsigned sf = strlen(SUFFIX);
+	unsigned sf;
 	char *buf, *save;
+	char *suffix, *term;

+	term = getenv("TERM");
+	if (term && strcmp(term, "dumb"))
+		suffix = "\033[K";
+	else
+		suffix = "        ";
+	sf = strlen(suffix);
 	save = xmalloc(sf);
+
 	buf = xmalloc(pf + LARGE_PACKET_MAX + sf + 1);
 	memcpy(buf, PREFIX, pf);
 	while (1) {
@@ -68,7 +75,7 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 				if (brk > pf+1 + 1) {
 					memcpy(save, buf + brk, sf);
 					buf[brk + sf - 1] = buf[brk - 1];
-					memcpy(buf + brk - 1, SUFFIX, sf);
+					memcpy(buf + brk - 1, suffix, sf);
 					safe_write(err, buf, brk + sf);
 					memcpy(buf + brk, save, sf);
 				} else
-- 
1.5.4.rc2.815.g2f849-dirty
