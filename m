From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 4/8] t5520: test work tree fast-forward when fetch updates head
Date: Fri, 29 May 2015 19:44:41 +0800
Message-ID: <1432899885-25143-5-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIj2-0003w7-7V
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbbE2LpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34958 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbE2LpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:06 -0400
Received: by pacrp13 with SMTP id rp13so9524720pac.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DpPgeGerzbTpnaIWzUlfhg+IinkK2ZmwndBOx65N+fA=;
        b=i/ug4k92SXKiRmXv5uQrepM9B/CwpkYhyHNgvCinztzXCgPoU+sz8kpOCDWrAQ+Th7
         Wvs266O7dy6qDDj+2M1ft47TDWo5iGtHouiLQHdw2ZGe4oESfj2GgfTIWnhluRkGYAMw
         c0WW77gtcgIJFfsIq7uzJw6yrCsg637rH9VqghEFcfDV3xVDx8StgCMHceJOY4WXEyyz
         8smZt8ZP7DXu5OmL6VSgX6mTu/PoI7u2jqFCXfnmrY3/+xIUn1VcgNDnbO77z6wlYiyV
         rvxcqaxC95i9zXCb909eZCGV3M995th93vzIE8/zr+TzeCMO57SyUwmppTodYX3Ce5Wo
         kG3A==
X-Received: by 10.66.224.237 with SMTP id rf13mr14032792pac.131.1432899905740;
        Fri, 29 May 2015 04:45:05 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.45.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:45:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270235>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Implement tests to ensure that the fast-forward occurs in such a case,
as well as to ensure that the user-friendly advice is printed upon
failure.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

 t/t5520-pull.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 265c693..872d765 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -183,6 +183,27 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_cmp expected file
 '
 
+test_expect_success 'fast-forwards working tree if branch head is updated' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	test "$(cat file)" = file &&
+	git pull . second:third 2>err &&
+	test_i18ngrep "fetch updated the current branch head" err &&
+	test "$(cat file)" = modified &&
+	test "$(git rev-parse third)" = "$(git rev-parse second)"
+'
+
+test_expect_success 'fast-forward fails with conflicting work tree' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	test "$(cat file)" = file &&
+	echo conflict >file &&
+	test_must_fail git pull . second:third 2>err &&
+	test_i18ngrep "Cannot fast-forward your working tree" err &&
+	test "$(cat file)" = conflict &&
+	test "$(git rev-parse third)" = "$(git rev-parse second)"
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
