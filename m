From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/3] bash prompt: indicate dirty index even on orphan branches
Date: Sat, 21 Nov 2015 12:30:09 +0100
Message-ID: <1448105409-4494-3-git-send-email-szeder@ira.uka.de>
References: <1448105409-4494-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 21 12:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a06OC-0006Qt-Q3
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 12:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760066AbbKULao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2015 06:30:44 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52721 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759895AbbKULa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2015 06:30:27 -0500
Received: from x4db28c43.dyn.telefonica.de ([77.178.140.67] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a06N3-0003r7-NA; Sat, 21 Nov 2015 12:30:23 +0100
X-Mailer: git-send-email 2.6.3.402.geb6a0f7
In-Reply-To: <1448105409-4494-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1448105423.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281553>

__git_ps1() doesn't indicate dirty index while on an orphan branch.

To check the dirtiness of the index, __git_ps1() runs 'git diff-index
--cached ... HEAD', which doesn't work on an orphan branch,
because HEAD doesn't point to a valid commit.

Run 'git diff ... --cached' instead, as it does the right thing both
on valid and invalid HEAD, i.e. compares the index to the existing
HEAD in the former case and to the empty tree in the latter.  This
fixes the two failing tests added in the first commit of this series.

The dirtiness of the worktree is already checked with 'git diff' and
is displayed correctly even on an orphan branch.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 5 ++---
 t/t9903-bash-prompt.sh           | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 7a95fbdcfd..64219e631a 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -477,9 +477,8 @@ __git_ps1 ()
 		   [ "$(git config --bool bash.showDirtyState)" !=3D "false" ]
 		then
 			git diff --no-ext-diff --quiet || w=3D"*"
-			if [ -n "$short_sha" ]; then
-				git diff-index --cached --quiet HEAD -- || i=3D"+"
-			else
+			git diff --no-ext-diff --cached --quiet || i=3D"+"
+			if [ -z "$short_sha" ] && [ -z "$i" ]; then
 				i=3D"#"
 			fi
 		fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 2c9d1f928a..af82049f82 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -285,7 +285,7 @@ test_expect_success 'prompt - dirty status indicato=
r - orphan branch - clean' '
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure 'prompt - dirty status indicator - orphan branch -=
 dirty index' '
+test_expect_success 'prompt - dirty status indicator - orphan branch -=
 dirty index' '
 	printf " (orphan +)" >expected &&
 	test_when_finished "git checkout master" &&
 	git checkout --orphan orphan &&
@@ -296,7 +296,7 @@ test_expect_failure 'prompt - dirty status indicato=
r - orphan branch - dirty ind
 	test_cmp expected "$actual"
 '
=20
-test_expect_failure 'prompt - dirty status indicator - orphan branch -=
 dirty index and worktree' '
+test_expect_success 'prompt - dirty status indicator - orphan branch -=
 dirty index and worktree' '
 	printf " (orphan *+)" >expected &&
 	test_when_finished "git checkout master" &&
 	git checkout --orphan orphan &&
--=20
2.6.3.402.geb6a0f7
