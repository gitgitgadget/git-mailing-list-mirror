From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 11/12] t3418: non-interactive rebase --continue with rerere enabled
Date: Tue,  7 Jul 2015 22:08:33 +0800
Message-ID: <1436278114-28057-12-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:10:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTZK-000610-FP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757823AbbGGOJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33859 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276AbbGGOJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:19 -0400
Received: by pabvl15 with SMTP id vl15so113952756pab.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ku0FPHRsf96ncbJ3RpW4TuVSiIISUG107gHzCRXuBus=;
        b=dDbIKSq8oldtNSre6PXDoCt6xFkK7VQIL5APFk2z7sJfcwwC910x1MxmsxPBCoj+d1
         NAQJJlUI/IcUgH+IYRorCzgpeo98vEUkErxYG/58deJvD0E1V9+lVbmUDkH5wWVj9TpD
         TFt/Y+zBwC9WUNgRhlFKUizR071OBU8xpr71clu+CCkQJtvdfMuTWnk/yuBesFnv1exv
         uH07b7bd2wRVieFa0bMOBu8GkWk8v8PxZ20ILXRRikCDN1ZpKv/B+6VVbN4t0PrTZtNh
         JjGHHOr/yy7qVFd7mVs9miTYsXUwPR2GBF/fvhaO3N9pwEv6Scck9EzzyJIbVuI0udFj
         zJrQ==
X-Received: by 10.68.65.74 with SMTP id v10mr9471148pbs.9.1436278158620;
        Tue, 07 Jul 2015 07:09:18 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:17 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273518>

Since 8389b52 (git-rerere: reuse recorded resolve., 2006-01-28), git-am
will call git-rerere to re-use recorded merge conflict resolutions if
any occur in a threeway merge.

Add a test to ensure that git-rerere is called by git-am (which handles
the non-interactive rebase).

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t3418-rebase-continue.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2680375..4428b90 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -40,6 +40,25 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
 	git rebase --continue
 '
 
+test_expect_success 'non-interactive rebase --continue with rerere enabled' '
+	test_config rerere.enabled true &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master &&
+	rm -fr .git/rebase-* &&
+
+	test_must_fail git rebase --onto master master topic &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	cp F2 F2.expected &&
+	git rebase --continue &&
+
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	git checkout master &&
+	test_must_fail git rebase --onto master master topic &&
+	test_cmp F2.expected F2
+'
+
 test_expect_success 'rebase --continue can not be used with other options' '
 	test_must_fail git rebase -v --continue &&
 	test_must_fail git rebase --continue -v
-- 
2.5.0.rc1.76.gf60a929
