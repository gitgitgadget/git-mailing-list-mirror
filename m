From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] Preserve the protection mode for the Git config files
Date: Tue, 21 Jul 2009 16:24:36 +0100
Message-ID: <20090721152435.16642.47207.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 17:25:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHD3-0000yf-Q2
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbZGUPYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755293AbZGUPYi
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:24:38 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51598 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755246AbZGUPYh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 11:24:37 -0400
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n6LFKUZm017527
	for <git@vger.kernel.org>; Tue, 21 Jul 2009 16:20:30 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Tue, 21 Jul 2009 16:24:36 +0100
User-Agent: StGit/0.15-rc1-9-gd8846
X-OriginalArrivalTime: 21 Jul 2009 15:24:36.0380 (UTC) FILETIME=[5B2ECDC0:01CA0A17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123665>

Every time an option is set, the config file protection mode is changed
to 0666 & ~umask even if it was different before. This patch is useful
if people store passwords (SMTP server in the StGit case) and do not
want others to read the .gitconfig file.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 lockfile.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index eb931ed..87ee233 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -124,8 +124,12 @@ static char *resolve_symlink(char *p, size_t s)
 
 static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
+	struct stat st;
+
 	if (strlen(path) >= sizeof(lk->filename))
 		return -1;
+	if (stat(path, &st) < 0)
+		st.st_mode = 0666;
 	strcpy(lk->filename, path);
 	/*
 	 * subtract 5 from size to make sure there's room for adding
@@ -134,7 +138,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
 	strcat(lk->filename, ".lock");
-	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
+	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, st.st_mode);
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
 			sigchain_push_common(remove_lock_file_on_signal);
