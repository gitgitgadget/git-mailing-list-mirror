From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-commit: don't add multiple Signed-off-by: from the same identity
Date: Fri, 6 Jul 2007 14:42:27 +0000
Message-ID: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 16:42:32 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6p0y-0003U0-0S
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbXGFOmP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbXGFOmP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:42:15 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41312 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754932AbXGFOmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:42:14 -0400
Received: (qmail 11737 invoked by uid 1000); 6 Jul 2007 14:42:27 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51754>

If requested to signoff a commit, don't add another Signed-off-by: line
to the commit message if the exact same line is already there.

This was noticed and requested by Josh Triplett through
 http://bugs.debian.org/430851

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-commit.sh |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index f866f95..7a7d19a 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -458,16 +458,18 @@ fi | git stripspace >"$GIT_DIR"/COMMIT_EDITMSG
 
 case "$signoff" in
 t)
-	need_blank_before_signoff=
+	sign=$(git-var GIT_COMMITTER_IDENT | sed -e '
+		s/>.*/>/
+		s/^/Signed-off-by: /
+		')
+	blank_before_signoff=
 	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
-	grep 'Signed-off-by:' >/dev/null || need_blank_before_signoff=yes
-	{
-		test -z "$need_blank_before_signoff" || echo
-		git-var GIT_COMMITTER_IDENT | sed -e '
-			s/>.*/>/
-			s/^/Signed-off-by: /
-		'
-	} >>"$GIT_DIR"/COMMIT_EDITMSG
+	grep 'Signed-off-by:' >/dev/null || blank_before_signoff='
+'
+	tail -n 1 "$GIT_DIR"/COMMIT_EDITMSG |
+	grep "$sign"$ >/dev/null ||
+	printf '%s%s\n' "$blank_before_signoff" "$sign" \
+		>>"$GIT_DIR"/COMMIT_EDITMSG
 	;;
 esac
 
-- 
1.5.2.1
