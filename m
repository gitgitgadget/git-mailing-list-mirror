From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] rebase: finish_rebase() in noop rebase
Date: Thu, 13 Jun 2013 21:36:13 +0530
Message-ID: <1371139573-28047-4-git-send-email-artagnon@gmail.com>
References: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 18:08:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnA4b-0005m0-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 18:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782Ab3FMQIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 12:08:18 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45031 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab3FMQIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 12:08:16 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so10452696pbb.22
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l15bf5/Mc7ZrQYviOavU2LmOgXQj/GXdENl/zX2WFwY=;
        b=f+fU3Zy/VBRjq4pFqiTGPxjcukfn+TiChojod7Hk0PFfh96VyL0cHjx0hreUggCpCW
         3w+GyRdHL4PBwghh1L9fW/yY4OQHFELe70hgFt/70ByK3zlFQ70C/lCOu09ecYRaezcf
         pbv6unhIEeVWH0c/p7rKWTM+g69+Q20A7mdshqRpVyHHfcBXCECEAa3jCu1hTBvCh3pY
         SJGmx2pMvWaRcvW/6/oCAp24KZ5Yi5j21pLJH0KQo8MqlNwj1CfCPBXQZ1+2cX6fZfep
         CLPkGlnN0XT0P09LeXBIx2uNBuLX4g+ssVbc0M/gN+MIn+XyxVqOlgD8WM/1emxkvHcJ
         0L3Q==
X-Received: by 10.66.255.72 with SMTP id ao8mr3531540pad.3.1371139695574;
        Thu, 13 Jun 2013 09:08:15 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id rn7sm23911564pbc.12.2013.06.13.09.08.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 09:08:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.gf08dd97.dirty
In-Reply-To: <1371139573-28047-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227745>

In the following case

  $ git rebase master
  Current branch autostash-fix is up to date.

the autostash is not applied automatically, because this codepath
forgets to call finish_rebase().  Fix this.  Also add a test to guard
against regressions.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase.sh               |  1 +
 t/t3420-rebase-autostash.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 154d4be..2d5c2bd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -547,6 +547,7 @@ then
 		# Lazily switch to the target branch if needed...
 		test -z "$switch_to" || git checkout "$switch_to" --
 		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		finish_rebase
 		exit 0
 	else
 		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 1bde007..90eb264 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -152,6 +152,17 @@ test_expect_success "rebase: fast-forward rebase" '
 	git checkout feature-branch
 '
 
+test_expect_success "rebase: noop rebase" '
+	test_config rebase.autostash true &&
+	git reset --hard &&
+	git checkout -b same-feature-branch feature-branch &&
+	test_when_finished git branch -D same-feature-branch &&
+	echo dirty >>file1 &&
+	git rebase feature-branch &&
+	grep dirty file1 &&
+	git checkout feature-branch
+'
+
 testrebase "" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
-- 
1.8.3.1.381.gf08dd97.dirty
