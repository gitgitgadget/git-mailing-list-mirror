From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v8a] bisect: fix 'git bisect run' so that it works with alternate --update-ref
Date: Sun, 31 Jul 2011 23:46:43 +1000
Message-ID: <1312120003-26321-1-git-send-email-jon.seymour@gmail.com>
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 15:47:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWM7-0006BK-Tc
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab1GaNq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 09:46:56 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62138 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1GaNqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 09:46:55 -0400
Received: by pzk37 with SMTP id 37so9684110pzk.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=UQ+HyEed42tvEJ8OD2qRcFlHazOmvRyPPRVFTMidf+k=;
        b=BMccgejvpZpkhpSDiZBiKh8XBMH4ZExDJTk5XXsd+83RDHuc9gEmoLY0DDzbRQQvnv
         Uyg3nfEEAUGEd7M6Rsp5zlI9EzpMrjBbd3pZg/yu9Cig6RNau1gvG/briLakpg/TwyTy
         EQcVq5ta9zgXT7mMLac1sHYHif9g6SF2xDkng=
Received: by 10.68.39.167 with SMTP id q7mr6167372pbk.415.1312120014924;
        Sun, 31 Jul 2011 06:46:54 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id l7sm4398394pbh.10.2011.07.31.06.46.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 06:46:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.389.gccb79d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178256>

An additional patch for the v8 series that ensures that 'git bisect run'
respects .git/BISECT_UPDATE_REF.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh               |    5 +++--
 t/t6030-bisect-porcelain.sh |   15 +++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ec70cd2..126d698 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -230,8 +230,9 @@ bisect_state() {
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
 	1,bad|1,good|1,skip)
-		rev=$(git rev-parse --verify HEAD) ||
-			die "$(gettext "Bad rev input: HEAD")"
+		ref=${BISECT_UPDATE_REF:-HEAD}
+		rev=$(git rev-parse --verify "$ref") ||
+			die "$(gettext "Bad rev input: $ref")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
 	2,bad|*,good|*,skip)
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index fa4366f..40f7a76 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -736,4 +736,19 @@ test \$rc -eq 0;' &&
 	git bisect reset
 "
 
+test_expect_success 'bisect: demonstrate identification of damage boundary using alternate reference' "
+	git bisect reset &&
+	git checkout broken &&
+	git bisect start broken master --no-checkout --update-ref=CURSOR &&
+	git bisect run eval '
+rc=1;
+if git rev-list --objects CURSOR >tmp.$$; then
+   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
+fi;
+rm tmp.$$;
+test \$rc -eq 0;' &&
+	check_same BROKEN_HASH6 bisect/bad &&
+	git bisect reset
+"
+
 test_done
-- 
1.7.6.389.gccb79d.dirty
