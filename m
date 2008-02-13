From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/maint review] Protect get_author_ident_from_commit() from
 filenames in work tree
Date: Wed, 13 Feb 2008 13:45:33 -0800
Message-ID: <7vy79oo7ia.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 22:48:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPPSk-0008O2-1a
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 22:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765748AbYBMVrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 16:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933980AbYBMVri
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 16:47:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933947AbYBMVrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 16:47:35 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 981B93360;
	Wed, 13 Feb 2008 16:45:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 33E3D3354; Wed, 13 Feb 2008 16:45:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73819>

We used to use "cat-file commit $commit" to extract the original
author information from existing commit, but an earlier commit
5ac2715 (Consistent message encoding while reusing log from an
existing commit) changed it to use "git show -s $commit".  If
you have a file in your work tree that can be interpreted as a
valid object name (e.g. "HEAD"), this conversion will not work.

Disambiguate by marking the end of revision parameter on the
comand line with an explicit "--" to fix this.

This breakage is most visible with rebase when a file called
"HEAD" exists in the worktree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-sh-setup.sh               |    2 +-
 t/t3404-rebase-interactive.sh |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aae1409..f388275 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -119,7 +119,7 @@ get_author_ident_from_commit () {
 	}
 	'
 	encoding=$(git config i18n.commitencoding || echo UTF-8)
-	git show -s --pretty=raw --encoding="$encoding" "$1" |
+	git show -s --pretty=raw --encoding="$encoding" "$1" -- |
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"
 }
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index e33ea4e..e5ed745 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -340,4 +340,26 @@ test_expect_success 'rebase a commit violating pre-commit' '
 
 '
 
+test_expect_success 'rebase with a file named HEAD in worktree' '
+
+	rm -fr .git/hooks &&
+	git reset --hard &&
+	git checkout -b branch3 A &&
+
+	(
+		GIT_AUTHOR_NAME="Squashed Away" &&
+		export GIT_AUTHOR_NAME &&
+		>HEAD &&
+		git add HEAD &&
+		git commit -m "Add head" &&
+		>BODY &&
+		git add BODY &&
+		git commit -m "Add body"
+	) &&
+
+	FAKE_LINES="1 squash 2" git rebase -i to-be-rebased &&
+	test "$(git show -s --pretty=format:%an)" = "Squashed Away"
+
+'
+
 test_done
-- 
1.5.4.1.1278.gc75be
