From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 27/31] rebase -m: remember allow_rerere_autoupdate option
Date: Sun,  6 Feb 2011 13:43:56 -0500
Message-ID: <1297017841-20678-28-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eI-0005ZO-Go
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab1BFSql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:41 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab1BFSqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:34 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=qKec2jQdv8fszwP1vSHo+ErtLqBlLiv4RvLRKnsN7q8=;
        b=eN/8DwJOrtkR4cw3MYasbP3x1HlitFe2TPfpPkQrd0Fksj0oudFnyiC9YOgsqK51hQ
         s3u2Z3ramran3CTrfeJX8X+j504CxPhXp1Q1TGagodEvy1thLvOHZJkAZBa80vFRNygG
         mlvm15IQew85LOKApDTut1+/1bMGODvHOXtr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=STI8NHNbGNHvZSlAmzxlmqW0FGmT5AYeGnF2Ie1W78altS6OW0l+Kj5Q6ja4mSe4LZ
         PA/hwL3hfY86KpC2oHt33Dv/yDn53RD4uZ2EPoWmqK4bz9pTDOuTG/FoLg+tYgzaS/tO
         V32F145Vs/bAjJZd2E6vsBCdNDabnzNe8Smn0=
Received: by 10.229.225.199 with SMTP id it7mr12398975qcb.7.1297017994512;
        Sun, 06 Feb 2011 10:46:34 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:33 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166188>

If '--[no-]allow_rerere_autoupdate' is passed when 'git rebase -m' is
called and a merge conflict occurs, the flag will be forgotten for the
rest of the rebase process. Make rebase remember it by saving the
value.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
allow_rerere_autoupdate is only used by git-rebase--merge. Still ok to
write and read it here?

Should allow_rerere_autoupdate also be added to git_am_opt?


 git-rebase.sh              |    4 ++++
 t/t3418-rebase-continue.sh |   21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index f4ad7c1..be9ec2a 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -84,6 +84,8 @@ read_basic_state () {
 	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
 	test -f "$state_dir"/strategy_opts &&
 		strategy_opts="$(cat "$state_dir"/strategy_opts)"
+	test -f "$state_dir"/allow_rerere_autoupdate &&
+		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
 }
 
 write_basic_state () {
@@ -95,6 +97,8 @@ write_basic_state () {
 	test -n "$strategy" && echo "$strategy" > "$state_dir"/strategy
 	test -n "$strategy_opts" && echo "$strategy_opts" > \
 		"$state_dir"/strategy_opts
+	test -n "$allow_rerere_autoupdate" && echo "$allow_rerere_autoupdate" > \
+		"$state_dir"/allow_rerere_autoupdate
 }
 
 output () {
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 5469546..1e855cd 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,4 +74,25 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
+test_expect_success 'rebase --continue remembers --rerere-autoupdate' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F3-on-topic-branch &&
+	git checkout master
+	test_commit "commit-new-file-F3" F3 3 &&
+	git config rerere.enabled true &&
+	test_must_fail git rebase -m master topic &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	test_must_fail git rebase --continue &&
+	echo "Resolved" >F3 &&
+	git add F3 &&
+	git rebase --continue &&
+	git reset --hard topic@{1} &&
+	test_must_fail git rebase -m --rerere-autoupdate master &&
+	test "$(cat F2)" = "Resolved" &&
+	test_must_fail git rebase --continue &&
+	test "$(cat F3)" = "Resolved" &&
+	git rebase --continue
+'
+
 test_done
-- 
1.7.4.rc2.33.g8a14f
