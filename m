From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] prune-packed: advanced progress even for non-existing fan-out directories
Date: Mon, 27 Apr 2009 09:44:58 +0200
Message-ID: <1240818298-22179-1-git-send-email-j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyLWs-0003r7-Oa
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 09:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbZD0HpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 03:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZD0HpX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 03:45:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58734 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZD0HpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 03:45:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LyLWd-0005Jj-PU; Mon, 27 Apr 2009 09:45:16 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 99F08795; Mon, 27 Apr 2009 09:45:11 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 628EBFA43; Mon, 27 Apr 2009 09:45:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.rc1.88.g1bf9
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117601>

A progress indicator is used to count through the 256 object fan-out
directories while unused object files are removed. (However, it becomes
visible only if this process takes long enough.)

Previously, display_progress() was only called if object files were
actually removed. But if directories towards the end (fd/, fe/, ff/) did
not exist, this could leave a strange line

   Removing duplicate objects:  99% (255/256), done.

in the terminal instead of the expected "100% (256/256)".

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-prune-packed.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 2d5b2cd..4942892 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -55,6 +55,7 @@ void prune_packed_objects(int opts)
 	for (i = 0; i < 256; i++) {
 		DIR *d;
 
+		display_progress(progress, i + 1);
 		sprintf(pathname + len, "%02x/", i);
 		d = opendir(pathname);
 		if (!d)
-- 
1.6.3.rc1.88.g1bf9
