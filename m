From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 1/5] prune-packed: don't call display_progress() for every file
Date: Tue, 30 Oct 2007 14:57:31 -0400
Message-ID: <1193770655-20492-2-git-send-email-nico@cam.org>
References: <1193770655-20492-1-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwI9-0001bd-M3
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 19:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbXJ3S6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 14:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752554AbXJ3S6H
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 14:58:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37695 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbXJ3S6F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 14:58:05 -0400
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ0021VNC05WB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:57:36 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.4.1463.gf79ad2
In-reply-to: <1193770655-20492-1-git-send-email-nico@cam.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62730>

The progress count is per fanout directory, so it is useless to call
it for every file as the count doesn't change that often.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 builtin-prune-packed.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 015c8bb..907e368 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -15,6 +15,9 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 	struct dirent *de;
 	char hex[40];
 
+	if (opts == VERBOSE)
+		display_progress(&progress, i + 1);
+
 	sprintf(hex, "%02x", i);
 	while ((de = readdir(dir)) != NULL) {
 		unsigned char sha1[20];
@@ -26,8 +29,6 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
 		if (!has_sha1_pack(sha1, NULL))
 			continue;
 		memcpy(pathname + len, de->d_name, 38);
-		if (opts == VERBOSE)
-			display_progress(&progress, i + 1);
 		if (opts & DRY_RUN)
 			printf("rm -f %s\n", pathname);
 		else if (unlink(pathname) < 0)
-- 
1.5.3.4.1463.gf79ad2
