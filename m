From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 04/11] test-chmtime: work around Windows limitation
Date: Sun, 31 May 2009 18:15:18 +0200
Message-ID: <1243786525-4493-5-git-send-email-prohaska@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
 <1243786525-4493-2-git-send-email-prohaska@zib.de>
 <1243786525-4493-3-git-send-email-prohaska@zib.de>
 <1243786525-4493-4-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAniK-0001nG-C5
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757AbZEaQQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbZEaQQM
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:12 -0400
Received: from mailer.zib.de ([130.73.108.11]:58618 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494AbZEaQQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:05 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFVp9006797;
	Sun, 31 May 2009 18:15:36 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPVB021220;
	Sun, 31 May 2009 18:15:31 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1243786525-4493-4-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120412>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Windows has problems changing the mtime when the file is write protected,
even by the owner of said file.

Add a Windows-only workaround to change the mode if necessary before
trying to change the mtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 test-chmtime.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/test-chmtime.c b/test-chmtime.c
index d5358cb..fe476cb 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -87,6 +87,15 @@ int main(int argc, const char *argv[])
 			return -1;
 		}
 
+#ifdef WIN32
+		if (!(sb.st_mode & S_IWUSR) &&
+				chmod(argv[i], sb.st_mode | S_IWUSR)) {
+			fprintf(stderr, "Could not make user-writable %s: %s",
+				argv[i], strerror(errno));
+			return -1;
+		}
+#endif
+
 		utb.actime = sb.st_atime;
 		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
 
-- 
1.6.3.1.54.g99dd
