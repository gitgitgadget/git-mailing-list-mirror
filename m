From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Solaris 5.8 returns ENOTDIR for inappropriate renames.
Date: Mon, 15 Jan 2007 17:30:59 -0800
Message-ID: <17433.1168911059@lotus.CS.Berkeley.EDU>
X-From: git-owner@vger.kernel.org Tue Jan 16 02:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6dSM-0003aq-DZ
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 02:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbXAPBtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 20:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXAPBtm
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 20:49:42 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:45209 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbXAPBtl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 20:49:41 -0500
X-Greylist: delayed 1120 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 20:49:40 EST
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0G1V0SH017442
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:31:00 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0G1V0dd017438
	for <git@vger.kernel.org>; Mon, 15 Jan 2007 17:31:00 -0800 (PST)
To: git@vger.kernel.org
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36907>

The reflog code clears empty directories when rename returns
either EISDIR or ENOTDIR.  Seems to be the only place.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
   Haven't been keeping up with the list, so I apologize if I've
   missed discussions related to these changes.

 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 689ac50..851b573 100644
--- a/refs.c
+++ b/refs.c
@@ -837,7 +837,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 
  retry:
 	if (log && rename(git_path("tmp-renamed-log"), git_path("logs/%s", newref))) {
-		if (errno==EISDIR) {
+		if (errno==EISDIR || errno==ENOTDIR) {
 			if (remove_empty_directories(git_path("logs/%s", newref))) {
 				error("Directory not empty: logs/%s", newref);
 				goto rollback;
-- 
1.5.0.rc1.gf4b6c
