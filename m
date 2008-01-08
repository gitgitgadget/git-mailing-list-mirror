From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized arrays.
Date: Tue, 08 Jan 2008 17:24:18 +0100
Message-ID: <4783A3B2.3060801@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 17:24:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCHFy-0003X6-0X
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 17:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYAHQYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 11:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbYAHQYW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 11:24:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48126 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYAHQYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 11:24:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JCHFT-00076Z-Bt; Tue, 08 Jan 2008 17:24:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 600CD6EF; Tue,  8 Jan 2008 17:24:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69888>

From: Johannes Sixt <johannes.sixt@telecom.at>

How come we got along with this not very portable construct for so long?
Probably because the array sizes were computed from the results of
strlen() of string constants. Anyway, a follow-up patch will make the
lengths really non-constant.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 sideband.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sideband.c b/sideband.c
index 756bbc2..513d7b3 100644
--- a/sideband.c
+++ b/sideband.c
@@ -19,7 +19,10 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 {
 	unsigned pf = strlen(PREFIX);
 	unsigned sf = strlen(SUFFIX);
-	char buf[pf + LARGE_PACKET_MAX + sf + 1];
+	char *buf, *save;
+
+	save = xmalloc(sf);
+	buf = xmalloc(pf + LARGE_PACKET_MAX + sf + 1);
 	memcpy(buf, PREFIX, pf);
 	while (1) {
 		int band, len;
@@ -29,6 +32,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 		if (len < 1) {
 			len = sprintf(buf, "%s: protocol error: no band designator\n", me);
 			safe_write(err, buf, len);
+			free(buf);
+			free(save);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
 		band = buf[pf] & 0xff;
@@ -38,6 +43,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 			buf[pf] = ' ';
 			buf[pf+1+len] = '\n';
 			safe_write(err, buf, pf+1+len+1);
+			free(buf);
+			free(save);
 			return SIDEBAND_REMOTE_ERROR;
 		case 2:
 			buf[pf] = ' ';
@@ -59,7 +66,6 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 				 * line data actually contains something.
 				 */
 				if (brk > pf+1 + 1) {
-					char save[sf];
 					memcpy(save, buf + brk, sf);
 					buf[brk + sf - 1] = buf[brk - 1];
 					memcpy(buf + brk - 1, SUFFIX, sf);
@@ -83,9 +89,13 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
 				      "%s: protocol error: bad band #%d\n",
 				      me, band);
 			safe_write(err, buf, len);
+			free(buf);
+			free(save);
 			return SIDEBAND_PROTOCOL_ERROR;
 		}
 	}
+	free(buf);
+	free(save);
 	return 0;
 }

-- 
1.5.4.rc2.815.g2f849-dirty
