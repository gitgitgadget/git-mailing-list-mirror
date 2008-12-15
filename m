From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fast-import: close pack before unlinking it
Date: Mon, 15 Dec 2008 22:11:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812152210480.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: spearce@spearce.org, Johannes Sixt <j.sixt@viscovery.net>,
	gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 22:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCKcK-0005uv-So
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 22:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbYLOVDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 16:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbYLOVDF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 16:03:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:46607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755356AbYLOVDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 16:03:03 -0500
Received: (qmail invoked by alias); 15 Dec 2008 21:02:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 15 Dec 2008 22:02:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zhc4TlOLznZyv9bO8nnDEkmgw/kbWKvSqNMhCck
	DNxkUmWvgg5BpZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103207>


This is sort of a companion patch to 4723ee9(Close files opened by
lock_file() before unlinking.): on Windows, you cannot delete what
is still open.

This makes test 9300-fast-import pass on Windows for me; quite a few
fast-imports leave temporary packs until the test "blank lines not
necessary after other commands" actually tests for the number of files
in .git/objects/pack/, which has a few temporary packs now.

I guess that 8b4eb6b(Do not perform cross-directory renames when
creating packs) was "responsible" for the breakage.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fast-import.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3276d5d..201d4ff 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -983,8 +983,10 @@ static void end_packfile(void)
 
 		pack_id++;
 	}
-	else
+	else {
+		close(old_p->pack_fd);
 		unlink(old_p->pack_name);
+	}
 	free(old_p);
 
 	/* We can't carry a delta across packfiles. */
-- 
1.6.1.rc3.368.g63acc
