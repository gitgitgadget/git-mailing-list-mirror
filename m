From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Ensure we are inside a Git worktree
Date: Fri, 21 Nov 2008 13:09:16 +0100
Message-ID: <1227269356-19093-1-git-send-email-madduck@debian.org>
References: <20081121120609.GA10326@piper.oerlikon.madduck.net>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Fri Nov 21 13:10:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3UqS-00070g-G3
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbYKUMJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYKUMJa
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:09:30 -0500
Received: from clegg.madduck.net ([193.242.105.96]:34068 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYKUMJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:09:29 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 5D19B1D40A9;
	Fri, 21 Nov 2008 13:09:18 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 2251C9F355;
	Fri, 21 Nov 2008 13:09:17 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A561E45F5; Fri, 21 Nov 2008 13:09:16 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20081121120609.GA10326@piper.oerlikon.madduck.net>
X-Virus-Scanned: ClamAV 0.94.1/8658/Fri Nov 21 11:54:22 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101516>

Bert Wesarg suggests to check that we are not inside the .git directory before
setting up topgit. Because git rev-parse --git-dir only works in the top .git
dir, not deeper (i.e. inside .git/refs) and will always return "."

This patch thus causes topgit to die early on when it's called from outside of
a Git repository, or from underneath .git and outputs error messages
accordingly.

This temporarily makes it even more impossible to call tg --help, but I expect
to have that fixed soon too.

Signed-off-by: martin f. krafft <madduck@debian.org>

---
 tg.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 8c23d26..f8c8de4 100644
--- a/tg.sh
+++ b/tg.sh
@@ -17,6 +17,20 @@ die()
 	exit 1
 }
 
+# Make sure we are in the worktree, not under .git; die otherwise
+ensure_git_repo_or_die()
+{
+	local is_inside_repo is_inside_git_dir
+	is_inside_repo=1
+	is_inside_git_dir=$(git rev-parse --is-inside-git-dir 2>/dev/null) ||
+		is_inside_repo=0
+
+	case "$is_inside_repo/$is_inside_git_dir" in
+	0*) die "Cannot run outside of a Git repository.";;
+	1/true) die "Cannot run from inside \`.git\` hierarchy, please switch to work-tree.";;
+	esac
+}
+
 # setup_hook NAME
 setup_hook()
 {
@@ -249,6 +263,8 @@ do_help()
 [ -d "@cmddir@" ] ||
 	die "No command directory: '@cmddir@'"
 
+ensure_git_repo_or_die
+
 ## Initial setup
 
 set -e
-- 
tg: (2ea19b6..) fixes/ensure-worktree (depends on: upstream)
