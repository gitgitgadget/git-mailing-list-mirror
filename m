From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH] Fix rebase with file move when diff.renames = copies
Date: Wed, 21 Jul 2010 12:58:23 -0700
Message-ID: <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"David D. Kilzer" <ddkilzer@kilzer.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 22:10:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObfcH-0006cu-So
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 22:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab0GUUKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 16:10:00 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:55981 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0GUUKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 16:10:00 -0400
X-Greylist: delayed 676 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Jul 2010 16:10:00 EDT
Received: from relay16.apple.com (relay16.apple.com [17.128.113.55])
	by mail-out3.apple.com (Postfix) with ESMTP id 40C0A9ECC31D;
	Wed, 21 Jul 2010 12:58:43 -0700 (PDT)
X-AuditID: 11807137-b7b43ae000004f8e-db-4c4751730354
Received: from ddkilzer.apple.com (ddkilzer.apple.com [17.202.32.26])
	by relay16.apple.com (Apple SCV relay) with SMTP id D0.5D.20366.371574C4; Wed, 21 Jul 2010 12:58:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151416>

With diff.renames = copies, a rebase with a file move will fail with
the following error:

    fatal: mode change for <file>, which is not in current HEAD
    Repository lacks necessary blobs to fall back on 3-way merge.
    Cannot fall back to three-way merge.
    Patch failed at 0001.

The bug is that git rebase does not disable diff.renames when it runs
format-patch internally to feed into "am -3".  The fix is simply to
include a --no-renames argument to format-patch to override any local
diff.renames setting.

Fix by Junio C Hamano.  Test case by David D. Kilzer.

Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>
---
 git-rebase.sh     |    2 +-
 t/t3400-rebase.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6ec155c..0718caf 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -514,7 +514,7 @@ fi
 if test -z "$do_merge"
 then
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		$root_flag "$revisions" |
+		--no-renames $root_flag "$revisions" |
 	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
 	move_to_original_branch
 	ret=$?
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 4e6a44b..6d2ec91 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -155,4 +155,21 @@ test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	git diff --exit-code file-with-cr:CR HEAD:CR
 '
 
+test_expect_success 'rebase a single file move with diff.renames = copies' '
+     git config diff.renames copies &&
+     git checkout master &&
+     echo 1 > Y &&
+     git add Y &&
+     test_tick &&
+     git commit -m "prepare file move" &&
+     git checkout -b filemove HEAD^ &&
+     echo 1 > Y &&
+     git add Y &&
+     mkdir D &&
+     git mv A D/A &&
+     test_tick &&
+     git commit -m filemove &&
+     GIT_TRACE=1 git rebase master
+'
+
 test_done
-- 
1.7.1
