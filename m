From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not lose author name information to locale gotchas.
Date: Thu, 10 Nov 2005 23:42:14 -0800
Message-ID: <7vk6ffska1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 11 08:43:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaTYB-0004hm-7Z
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 08:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKKHmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 02:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVKKHmQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 02:42:16 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41607 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932188AbVKKHmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 02:42:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111074152.UZRF1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 02:41:52 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11569>

I noticed format-patch loses authorship information of Lukas' patch
when I run git tools with LC_LANG set to ja_JP.  It turns out that
the sed script to set environment variables were not working on his
name (encoded in UTF-8), which is unfortunate but technically correct.

Force sed invocation under C locale because we always want literal byte
semantics.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I might have screwed up people's names already without
   noticing; if that happened to you, please forgive me.  I
   think this patch fixes all the problematic places...

 git-commit.sh       |    2 +-
 git-format-patch.sh |    2 +-
 git-revert.sh       |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

applies-to: 8eacf17303188e55375f76bea8051555ba1baf02
0375d39e7d3052bdb9b21f984a7b7d2b02e627a5
diff --git a/git-commit.sh b/git-commit.sh
index daf90f1..41955e8 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -184,7 +184,7 @@ then
 		}
 		'
 		set_author_env=`git-cat-file commit "$use_commit" |
-		sed -ne "$pick_author_script"`
+		LANG=C LC_ALL=C sed -ne "$pick_author_script"`
 		eval "$set_author_env"
 		export GIT_AUTHOR_NAME
 		export GIT_AUTHOR_EMAIL
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 548d2d5..7ee5d32 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -201,7 +201,7 @@ process_one () {
 	    ;;
 	esac
 
-	eval "$(sed -ne "$whosepatchScript" $commsg)"
+	eval "$(LANG=C LC_ALL=C sed -ne "$whosepatchScript" $commsg)"
 	test "$author,$au" = ",$me" || {
 		mailScript="$mailScript"'
 	a\
diff --git a/git-revert.sh b/git-revert.sh
index dfd914c..4154fe0 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -112,7 +112,7 @@ cherry-pick)
 		q
 	}'
 	set_author_env=`git-cat-file commit "$commit" |
-	sed -ne "$pick_author_script"`
+	LANG=C LC_ALL=C sed -ne "$pick_author_script"`
 	eval "$set_author_env"
 	export GIT_AUTHOR_NAME
 	export GIT_AUTHOR_EMAIL
---
0.99.9.GIT
