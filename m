From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach git-status-script about git-ls-files --others
Date: Fri, 26 Aug 2005 18:18:59 -0700
Message-ID: <7vfysw89do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 03:19:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pMK-0003hT-9q
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbVH0BTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbVH0BTE
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:19:04 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29167 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965196AbVH0BTB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 21:19:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827011900.BKYY25443.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 21:19:00 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7832>

When there is non-empty $GIT_DIR/info/exclude file, use it along
with .gitignore per-directory exclude pattern files (which was
a convention agreed on the list while ago and is compatible with
Cogito) to generate a list of ignored files as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-status-script |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

5444043b5f5a2464938acd6da9408ec55ca40249
diff --git a/git-status-script b/git-status-script
--- a/git-status-script
+++ b/git-status-script
@@ -1,4 +1,7 @@
 #!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+#
 . git-sh-setup-script || die "Not a git archive"
 
 report () {
@@ -33,10 +36,35 @@ case "$branch" in
 refs/heads/master) ;;
 *)	echo "# On branch $branch" ;;
 esac
+
 git-update-cache --refresh >/dev/null 2>&1
-git-diff-cache -M --cached HEAD | sed 's/^://' | report "Updated but not checked in" "will commit"
+
+git-diff-cache -M --cached HEAD |
+sed 's/^://' |
+report "Updated but not checked in" "will commit"
+
 committable="$?"
-git-diff-files | sed 's/^://' | report "Changed but not updated" "use git-update-cache to mark for commit"
+
+git-diff-files |
+sed 's/^://' |
+report "Changed but not updated" "use git-update-cache to mark for commit"
+
+if grep -v '^#' "$GIT_DIR/info/exclude" >/dev/null 2>&1
+then
+	git-ls-files --others \
+	    --exclude-from="$GIT_DIR/info/exclude" \
+	    --exclude-per-directory=.gitignore |
+	sed -e '
+	1i\
+#\
+# Ignored files:\
+#   (use "git add" to add to commit)\
+#
+	s/^/#	/
+	$a\
+#'
+fi
+
 if [ "$committable" == "0" ]
 then
 	echo "nothing to commit"
