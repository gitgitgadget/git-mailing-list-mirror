From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Detect misspelled pathspec to git-add
Date: Wed, 15 Feb 2006 01:14:54 -0800
Message-ID: <7v1wy5m19t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 10:15:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9IkY-000851-26
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 10:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945897AbWBOJO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 04:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945899AbWBOJO5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 04:14:57 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39844 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1945897AbWBOJO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 04:14:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215091349.OII3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 04:13:49 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16226>

This is in the same spirit as an earlier patch for git-commit.
It does an extra ls-files to avoid complaining when a fully
tracked directory name is given on the command line (otherwise
--others restriction would say the pathspec does not match).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I noticed this when I accidentally said "git add /a/b/c"
   when I meant "git add a/b/c", and I did not notice it until
   I said "git commit" which said "Nothing to commit."

   It does one extra ls-files only if any pathspec is given; I
   am hoping this slight performance hit is tolerated.  I think
   people who does "git add ." all the time to mean "add
   everything I added anywhere since I did git add last time"
   deserve it ;-).

   Comments?

 git-add.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

ca28a7e03232b9a3b66df8519d9ee827882c83c1
diff --git a/git-add.sh b/git-add.sh
index f719b4b..13fad82 100755
--- a/git-add.sh
+++ b/git-add.sh
@@ -24,6 +24,17 @@ while : ; do
   shift
 done
 
+# Check misspelled pathspec
+case "$#" in
+0)	;;
+*)
+	git-ls-files --error-unmatch --others --cached -- "$@" >/dev/null || {
+		echo >&2 "Maybe you misspelled it?"
+		exit 1
+	}
+	;;
+esac
+
 if test -f "$GIT_DIR/info/exclude"
 then
 	git-ls-files -z \
-- 
1.2.0.gcfba7
