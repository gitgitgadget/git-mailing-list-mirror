From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] pull --rebase: exit early when the working directory is
 dirty
Date: Wed, 21 May 2008 12:32:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805211230290.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 21 13:33:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JymZ1-0004xO-Po
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 13:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760053AbYEULcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 07:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759660AbYEULcI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 07:32:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:54223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759381AbYEULcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 07:32:06 -0400
Received: (qmail invoked by alias); 21 May 2008 11:32:05 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp016) with SMTP; 21 May 2008 13:32:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+1t1ZqWOG1axzVylomEtm3wIJPduky3ug+vrljvs
	tG9oEit3U9mYGo
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82539>


When rebasing fails during "pull --rebase", you cannot just clean up the
working directory and call "pull --rebase" again, since the remote branch
was already fetched.

Therefore, die early when the working directory is dirty.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-pull.sh     |    5 +++++
 t/t5520-pull.sh |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index bf0c298..9a9e764 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -107,6 +107,11 @@ error_on_no_merge_candidates () {
 }
 
 test true = "$rebase" && {
+	git update-index --refresh &&
+	git diff-files --quiet &&
+        git diff-index --cached --quiet HEAD -- ||
+	die "refusing to pull with rebase: your working tree is not up-to-date"
+
 	. git-parse-remote &&
 	origin="$1"
 	test -z "$origin" && origin=$(get_default_remote)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9484129..997b2db 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -92,4 +92,22 @@ test_expect_success '--rebase with rebased upstream' '
 
 '
 
+test_expect_success 'pull --rebase dies early with dirty working directory' '
+
+	git update-ref refs/remotes/me/copy copy^ &&
+	COPY=$(git rev-parse --verify me/copy) &&
+	git rebase --onto $COPY copy &&
+	git config branch.to-rebase.remote me &&
+	git config branch.to-rebase.merge refs/heads/copy &&
+	git config branch.to-rebase.rebase true &&
+	echo dirty >> file &&
+	git add file &&
+	test_must_fail git pull &&
+	test $COPY = $(git rev-parse --verify me/copy) &&
+	git checkout HEAD -- file &&
+	git pull &&
+	test $COPY != $(git rev-parse --verify me/copy)
+
+'
+
 test_done
-- 
1.5.5.1.497.ga63a5
