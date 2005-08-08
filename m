From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Stash away the original head in ORIG_HEAD when resetting.
Date: Sun, 07 Aug 2005 23:06:56 -0700
Message-ID: <7vy87dgdxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Mon Aug 08 08:08:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E20n3-00051M-6W
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 08:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVHHGHB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 02:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVHHGHB
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 02:07:01 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7064 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750731AbVHHGHA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 02:07:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808060658.YESO7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 02:06:58 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When rewinding the head, stash away the value of the original
HEAD in ORIG_HEAD, just like git-resolve-script does.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Since rewinding the head is a dangerous operation, saving it
somewhere just in case would make life a bit safer.  This also
lets you do:

    $ git commit
    ... "oops, I forgot to include that fix."
    $ git reset HEAD^1
    ... edit away and update-cache
    $ git commit -m ORIG_HEAD

to reuse the old commit message.

 git-reset-script |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

87aced8864d926cf870ddfb2ca7ac5784fccb911
diff --git a/git-reset-script b/git-reset-script
--- a/git-reset-script
+++ b/git-reset-script
@@ -2,6 +2,12 @@
 . git-sh-setup-script || die "Not a git archive"
 rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
 rev=$(git-rev-parse --revs-only --verify $rev^0) || exit
-git-read-tree --reset "$rev" && echo "$rev" > "$GIT_DIR/HEAD"
+git-read-tree --reset "$rev" && {
+	if orig=$(git-rev-parse --verify HEAD 2>/dev/null)
+	then
+		echo "$orig" >"$GIT_DIR/ORIG_HEAD"
+	fi
+	echo "$rev" > "$GIT_DIR/HEAD"
+}
 git-update-cache --refresh
 rm -f "$GIT_DIR/MERGE_HEAD"
