From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] rebase: make it usable for binary files as well.
Date: Tue, 15 Nov 2005 15:34:18 -0800
Message-ID: <7v64qtfptx.fsf@assigned-by-dhcp.cox.net>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 00:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAJj-0004kA-Te
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVKOXeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVKOXeV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:34:21 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43669 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965074AbVKOXeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:34:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115233346.SDFY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:33:46 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 15 Nov 2005 15:32:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11966>

Use git-format-patch --full-index to generate a patch, and feed
that to git-am that uses git-apply --allow-binary-replacement.
This way, rebase can be used to move development that contains
binary files as long as there is no need for file-level merges.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-am.sh     |    7 ++++---
 git-rebase.sh |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

applies-to: 349326f3647597dabf38d82e1c2806cef45060f7
7f5bff7c3e5b1245e479fc13665641424dee9a41
diff --git a/git-am.sh b/git-am.sh
index 38841d9..8307d77 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -46,7 +46,7 @@ fall_back_3way () {
 	    cd "$dotest/patch-merge-tmp-dir" &&
 	    GIT_INDEX_FILE="../patch-merge-tmp-index" \
 	    GIT_OBJECT_DIRECTORY="$O_OBJECT" \
-	    git-apply --index <../patch
+	    git-apply --allow-binary-replacement --index <../patch
         )
     then
 	echo Using index info to reconstruct a base tree...
@@ -77,7 +77,7 @@ fall_back_3way () {
 		GIT_OBJECT_DIRECTORY="$O_OBJECT" &&
 		export GIT_INDEX_FILE GIT_OBJECT_DIRECTORY &&
 		git-read-tree "$base" &&
-		git-apply --index &&
+		git-apply --index --allow-binary-replacement &&
 		mv ../patch-merge-tmp-index ../patch-merge-index &&
 		echo "$base" >../patch-merge-base
 	    ) <"$dotest/patch"  2>/dev/null && break
@@ -310,7 +310,8 @@ do
 	echo "Applying '$SUBJECT'"
 	echo
 
-	git-apply --index "$dotest/patch"; apply_status=$?
+	git-apply --allow-binary-replacement --index "$dotest/patch"
+	apply_status=$?
 	if test $apply_status = 1 && test "$threeway" = t
 	then
 		if (fall_back_3way)
diff --git a/git-rebase.sh b/git-rebase.sh
index 56196e7..b8abf33 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -25,4 +25,4 @@ esac
 
 # Rewind the head to "$other"
 git-reset --hard "$other"
-git-format-patch -k --stdout "$other" ORIG_HEAD | git am -3 -k
+git-format-patch -k --stdout --full-index "$other" ORIG_HEAD | git am -3 -k
---
0.99.9.GIT
