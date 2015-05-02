From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 6/7] t5520: test --rebase failure on unborn branch with index
Date: Sat,  2 May 2015 23:37:14 +0800
Message-ID: <1430581035-29464-7-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZUC-00037G-BC
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbbEBPho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:44 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34894 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbbEBPhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:42 -0400
Received: by pabtp1 with SMTP id tp1so119405639pab.2
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VhI+vqIhFG2waFqrg6nFTmNZx8nNuvIc/xSDudcP53I=;
        b=xqGZqoXmc2HWBHpJ1BrSDa7nQrDIIf4U15c5h8Y2TNnM66fv0rpvWmIFvsVwYZYcvL
         vp4+vNv2GpjUIChjkI1iYNAy0vFLSPVOYPDdsAfp3SpJ2o0SWgixLFNWNvKCDvJI1TNn
         lY3JXqytn3kVBjVkNTVLuAZJwoavZfS7X1DG2rYxtoJRlmbpOtbMVQ9OL9tFor8btCg2
         t+bpZsNUNBwMBELDrx8PLYnj3xbcT8PY+FdG+FKLxrrHXOeY+3Fu5fs6uRhgoj7XkTjZ
         bl4xpKqwbrK3btvz+KUbcfMVDwZbQ2GfuOHo7DPzWTH4cPB57zXF0ddkvkLONYxSvYJt
         WPew==
X-Received: by 10.66.120.196 with SMTP id le4mr27683638pab.53.1430581061705;
        Sat, 02 May 2015 08:37:41 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:40 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268236>

Commit 19a7fcbf (allow pull --rebase on branch yet to be born) special
cases git-pull on an unborn branch in a different code path such that
git-pull --rebase is still valid even though there is no HEAD yet.

This code path still ensures that there is no index in order not to lose
any staged changes. Implement a test to ensure that this check is
triggered.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

I wonder if the .git/index check is still required, as git-read-tree -m
will take into account entries in the index as well.

 t/t5520-pull.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 17c63ff..34f3780 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -417,6 +417,17 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
+	git init empty_repo2 &&
+	test_when_finished "rm -rf empty_repo2" &&
+	(
+		cd empty_repo2 &&
+		echo staged-file >staged-file &&
+		git add staged-file &&
+		test_must_fail git pull --rebase .. master
+	)
+'
+
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
 	(cd src &&
-- 
2.1.4
