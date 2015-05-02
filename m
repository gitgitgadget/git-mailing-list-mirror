From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 4/7] t5520: test work tree fast-forward when fetch updates head
Date: Sat,  2 May 2015 23:37:12 +0800
Message-ID: <1430581035-29464-5-git-send-email-pyokagan@gmail.com>
References: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 17:37:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoZUB-00037G-1Y
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 17:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbbEBPhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 11:37:39 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36854 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbbEBPhg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 11:37:36 -0400
Received: by pdea3 with SMTP id a3so121301675pde.3
        for <git@vger.kernel.org>; Sat, 02 May 2015 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8hNDGc44xHWTqNYwjoZeJranxn7iEpWbeI+grA0Vp5Y=;
        b=QtPqef6O1sLP1td15VgDF7i5KTduLJfb6A/KrD1mHBmsGgirDi8uMjg+0AEbWmvAob
         yXlo087CX2fWCEccqnuU0liaZkpQnscshln2kANIYPd4RG9+CyvRYEcf5lCE+BEzM+GJ
         0OxjTxKfnJMEKW6Y6n6Q9ghyS+pYc4jRuLFMhDGJmiVIDITUNaeU0WbFdWxBsuarxtel
         ahsbB3ZKM4dH+i6D0mrDhYPKWd0YqmH3A5AKf+iPJNePn1unVxpuUpUkvWLQR0KLEX6H
         EO/LHI+90tRmaj3HZDzCfgfHiOCfiRIC1uNSAKOUqFtj69ti7BS3x8j5n8q/7iafFngj
         NhTA==
X-Received: by 10.68.191.229 with SMTP id hb5mr27322284pbc.126.1430581055905;
        Sat, 02 May 2015 08:37:35 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.172.217])
        by mx.google.com with ESMTPSA id tk9sm7925072pbc.35.2015.05.02.08.37.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 May 2015 08:37:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430581035-29464-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268234>

Since commit b10ac50f (Fix pulling into the same branch), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Implement tests to ensure that the fast-forward occurs in such a case,
as well as to ensure that the user-friendly advice is printed upon
failure.
---
 t/t5520-pull.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9f57e0d..25d519d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -189,6 +189,27 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_i18ngrep "You have not concluded your merge" out
 '
 
+test_expect_success 'fast-forwards working tree if branch head is updated' '
+	git checkout -b third master^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	echo file >expected &&
+	test_cmp expected file &&
+	git pull . second:third 2>out &&
+	test_i18ngrep "fetch updated the current branch head" out &&
+	echo modified >expected &&
+	test_cmp expected file
+'
+
+test_expect_success 'fast-forward fails with conflicting work tree' '
+	git checkout -b third master^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	echo file >expected &&
+	test_cmp expected file &&
+	echo conflict >file &&
+	test_must_fail git pull . second:third 2>out &&
+	test_i18ngrep "Cannot fast-forward your working tree" out
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
