From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 1/2] git-commit: Disallow unchanged tree in non-merge mode
Date: Thu, 6 Sep 2007 03:49:41 +0400
Message-ID: <20070905234941.GA643@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:50:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4dS-0002lK-50
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbXIEXuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757867AbXIEXuA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:50:00 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:47122 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757789AbXIEXt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:49:56 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 315482510737;
	Thu,  6 Sep 2007 03:49:55 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 93693170DB; Thu,  6 Sep 2007 03:49:41 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57774>

Do not commit an unchanged tree in non-merge mode.

While regular mode is already handled by git-runstatus, this cheap check
allows to avoid costly git-runstatus later.  Also, amend mode needs
special attention, because git-runstatus return value is ignored.
The idea is that amend should not commit an unchanged tree,
one should just remove the top commit using git-reset instead.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 git-commit.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 1d04f1f..800f96c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -629,6 +629,16 @@ then
 		tree=$(GIT_INDEX_FILE="$TMP_INDEX" git write-tree) &&
 		rm -f "$TMP_INDEX"
 	fi &&
+	if test -n "$current" -a ! -f "$GIT_DIR/MERGE_HEAD"
+	then
+		current_tree="$(git cat-file commit "$current${amend:+^}" 2>/dev/null |
+				sed -e '/^tree \+/!d' -e 's///' -e q)"
+		if test "$tree" = "$current_tree"
+		then
+			echo >&2 "nothing to commit${amend:+ (use \"git reset HEAD^\" to remove the top commit)}"
+			false
+		fi
+	fi &&
 	commit=$(git commit-tree $tree $PARENTS <"$GIT_DIR/COMMIT_MSG") &&
 	rlogm=$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
 	git update-ref -m "$GIT_REFLOG_ACTION: $rlogm" HEAD $commit "$current" &&
-- 
ldv
