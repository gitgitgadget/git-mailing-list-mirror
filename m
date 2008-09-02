From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] ignore trailing slash when creating leading directories
Date: Tue, 2 Sep 2008 10:19:09 +0200
Message-ID: <20080902081909.GA2059@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 10:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaR7O-0003UD-TZ
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 10:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbYIBIS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 04:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYIBIS7
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 04:18:59 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:44658 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbYIBIS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 04:18:58 -0400
Received: from darc.dyndns.org ([84.154.124.185]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Sep 2008 10:18:54 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KaR6T-0005Vp-5J
	for git@vger.kernel.org; Tue, 02 Sep 2008 10:19:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 02 Sep 2008 08:18:56.0463 (UTC) FILETIME=[8B313DF0:01C90CD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94665>

'git clone <repo> path/' (note the trailing slash) fails, because the
entire path is interpreted as leading directories. So when mkdir tries to
create the actual path, it already exists.

This makes sure a trailing slash is ignored.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin-clone.c |    7 ++++---
 sha1_file.c     |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c0e3086..4f945ad 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -422,10 +422,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_bare) {
 		junk_work_tree = work_tree;
 		if (safe_create_leading_directories_const(work_tree) < 0)
-			die("could not create leading directories of '%s'",
-					work_tree);
+			die("could not create leading directories of '%s': %s",
+					work_tree, strerror(errno));
 		if (mkdir(work_tree, 0755))
-			die("could not create work tree dir '%s'.", work_tree);
+			die("could not create work tree dir '%s': %s.",
+					work_tree, strerror(errno));
 		set_git_work_tree(work_tree);
 	}
 	junk_git_dir = git_dir;
diff --git a/sha1_file.c b/sha1_file.c
index 9ee1ed1..3cb9414 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -97,7 +97,7 @@ int safe_create_leading_directories(char *path)
 
 	while (pos) {
 		pos = strchr(pos, '/');
-		if (!pos)
+		if (!pos || !*(pos + 1))
 			break;
 		*pos = 0;
 		if (!stat(path, &st)) {
-- 
1.6.0
