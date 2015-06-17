From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] rebase -i: do not leave a =?UTF-8?Q?CHERRY=5FPICK=5FH?=
 =?UTF-8?Q?EAD=20file=20behind?=
Date: Wed, 17 Jun 2015 10:16:18 +0200
Organization: gmx
Message-ID: <2751d249ba6315f0139ba8fd6aa6ff23c32c9e69.1434528725.git.johannes.schindelin@gmx.de>
References: <20150616140612.Horde.a1irZQmh2o42SqDfxAytHg1@webmail.informatik.kit.edu>
 <cover.1434528725.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 17 10:16:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58WQ-0004fM-7t
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757941AbbFQIQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 04:16:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:62282 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756904AbbFQIQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:16:28 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTBLi-1ZXDUq3xAc-00S34e; Wed, 17 Jun 2015 10:16:18
 +0200
In-Reply-To: <cover.1434528725.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:J0Ce1VHCVJEAJG1ygTVgXqiztaqiAyokf2hDKyb3xMqzNK7gtMy
 7PTUS75NoPaiAa549feYXCBpdNqNiarWYzQNS2feGb/IYcXoXT3lfGgIatVWjwZ8OzskHJQ
 l7tAXMqIeiSb2aTjzsB404sPC7O6mnH44VurPDlUjEaZ3wWHMDalUiknO24u7bcch5OnLGt
 ufu62SuOdVriKLkZIs/bQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271816>

When skipping commits whose changes were already applied via `git rebase
--continue`, we need to clean up said file explicitly.

The same is not true for `git rebase --skip` because that will execute
`git reset --hard` as part of the "skip" handling in git-rebase.sh, even
before git-rebase--interactive.sh is called.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    | 6 +++++-
 t/t3404-rebase-interactive.sh | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..16e0a82 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -849,7 +849,11 @@ continue)
 	# do we have anything to commit?
 	if git diff-index --cached --quiet HEAD --
 	then
-		: Nothing to commit -- skip this
+		: Nothing to commit -- skip this commit
+
+		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+		die "Could not remove CHERRY_PICK_HEAD"
 	else
 		if ! test -f "$author_script"
 		then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5d52775..241d4d1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,7 +1102,7 @@ test_expect_success 'rebase -i commits that overwrite untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) = I
 '
 
-test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
+test_expect_success 'rebase --continue removes CHERRY_PICK_HEAD' '
 	git checkout -b commit-to-skip &&
 	for double in X 3 1
 	do
-- 
2.3.1.windows.1.9.g8c01ab4
