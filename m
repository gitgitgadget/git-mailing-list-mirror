From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 07/31] rebase: stricter check of standalone sub command
Date: Sun,  6 Feb 2011 13:43:36 -0500
Message-ID: <1297017841-20678-8-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9e7-0005ZO-Fc
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599Ab1BFSp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:45:59 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48348 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab1BFSp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:57 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so1045841qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=56ZDbiJ2C3vdtWHkO8IG3xjDT5P+AZUpe4zA1zGGYoM=;
        b=eJHbp83KptzRzeiAEzhxcEjUVwbK/1aj+0b1KvWhJagng7CKuCXP7J/emlZFWJCbq8
         WUzCIVqGXV6oexCR0fxc4tW6nZWaVnDDaRA4u5toYT7GV/G6r1oc2GCg0HYhQP8zRYvy
         7mDw8bLFuavXkI3LiiAuHPxef13il7DuKCg1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PMoVwz8nN8XuEGoPCYBIs4c08rrP8nlVTfprFn1kUBM07YktGa38sIs3/tzcgrs3vx
         ngQsa2KmouNKnb6qEL8PkRWqyAwPNa6OMH6wpaL2kO+EVX06a3uWsLgd6iR8IolmEeyA
         vC6JLnjoZEvBOKtgX7s7SHcys93taNJLflQuU=
Received: by 10.224.80.147 with SMTP id t19mr7509015qak.38.1297017957243;
        Sun, 06 Feb 2011 10:45:57 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:56 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166171>

The sub commands '--continue', '--skip' or '--abort' may only be used
standalone according to the documentation. Other options following the
sub command are currently not accepted, but options preceeding them
are. For example, 'git rebase --continue -v' is not accepted, while
'git rebase -v --continue' is. Tighten up the check and allow no other
options when one of these sub commands are used.

Only check that it is standalone for non-interactive rebase for
now. Once the command line processing for interactive rebase has been
replaced by the command line processing in git-rebase.sh, this check
will also apply to interactive rebase.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Is this too simplistic? Do we forsee that we want to support passing
options when resuming a rebase? Is it better to check for each other
option that it is not passed (i.e. no '-v', no '-s' etc.)?

Might some users be depending on the current behavior, even though it
is undocumented?


 git-rebase.sh              |    4 ++--
 t/t3403-rebase-skip.sh     |    5 +++++
 t/t3407-rebase-abort.sh    |   10 ++++++++++
 t/t3418-rebase-continue.sh |    5 +++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e3fd001..d689aad 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -229,6 +229,7 @@ then
 fi
 test -n "$type" && in_progress=t
 
+total_argc=$#
 while test $# != 0
 do
 	case "$1" in
@@ -239,9 +240,8 @@ do
 		OK_TO_SKIP_PRE_REBASE=
 		;;
 	--continue|--skip|--abort)
+		test $total_argc -eq 1 || usage
 		action=${1##--}
-		shift
-		break
 		;;
 	--onto)
 		test 2 -le "$#" || usage
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 64446e3..826500b 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -35,6 +35,11 @@ test_expect_success 'rebase with git am -3 (default)' '
 	test_must_fail git rebase master
 '
 
+test_expect_success 'rebase --skip can not be used with other options' '
+	test_must_fail git rebase -v --skip &&
+	test_must_fail git rebase --skip -v
+'
+
 test_expect_success 'rebase --skip with am -3' '
 	git rebase --skip
 	'
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index e573dc8..a6a6c40 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -84,6 +84,16 @@ testrebase() {
 		test_cmp reflog_before reflog_after &&
 		rm reflog_before reflog_after
 	'
+
+	test_expect_success 'rebase --abort can not be used with other options' '
+		cd "$work_dir" &&
+		# Clean up the state from the previous one
+		git reset --hard pre-rebase &&
+		test_must_fail git rebase$type master &&
+		test_must_fail git rebase -v --abort &&
+		test_must_fail git rebase --abort -v &&
+		git rebase --abort
+	'
 }
 
 testrebase "" .git/rebase-apply
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 3b0d273..1d90191 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -40,4 +40,9 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git rebase --continue
 '
 
+test_expect_success 'rebase --continue can not be used with other options' '
+	test_must_fail git rebase -v --continue &&
+	test_must_fail git rebase --continue -v
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
