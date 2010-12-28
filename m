From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 07/31] rebase: stricter check of standalone sub command
Date: Tue, 28 Dec 2010 10:30:24 +0100
Message-ID: <1293528648-21873-8-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYu-0005Wr-2b
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0L1Pdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:50 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56716 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0L1Pcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:35 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so9391760qwa.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fq+91tOSMQECoBBvYFOiEI2cU2NvA/bAbZvkx4lewDk=;
        b=SMYBDIJNCrz6a8NYjlkOGJMqkf8cFIoEpCPt5ltzivnqF4+A/lSiPn6+KI/+neW6AB
         9ayckAo29C2bUuwqq+QHbJG/wNODlLfPEMAawwWY1RfS2Yo2yEkDJUZpK9epRaThfvko
         YpgWfFKDifctr4AfhWClEN/HLK9GKtXTT3Zr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fw9a3fQjrtG8RWUdz5xVqfa7sdARxz+YGPhNPd/o7ouBefJ9+sgsffPMApGlTgcN38
         wKZ5E2orTYRxWjgKa7xvl3GKoLDCayzXCp+euz4tyLo25VPkoRKvB5mM/5DrOjB530ki
         xAIEiuvFW0WYunMn2NBcs3c2tmPwFBEWa7EgM=
Received: by 10.224.177.212 with SMTP id bj20mr13026061qab.169.1293550354325;
        Tue, 28 Dec 2010 07:32:34 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:33 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164268>

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
index 29f1214..1cb0564 100755
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
1.7.3.2.864.gbbb96
