From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 4/8] t5520: test work tree fast-forward when fetch updates head
Date: Mon, 18 May 2015 21:32:54 +0800
Message-ID: <1431955978-17890-5-git-send-email-pyokagan@gmail.com>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:33:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLB1-0001A5-GC
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbbERNdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:33:43 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35687 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbbERNd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:33:29 -0400
Received: by pdea3 with SMTP id a3so148939023pde.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7n0R6DOCBJlytZxeC+Sr5KFgT9CB8VVs/O1908JPaGU=;
        b=Arb0oMZWSIe9+5XQrELnMyB34kSj63Hr03rQbkz+efZAEdKZHRs98ffY1tkuJjPIYI
         NBkTKBiUWCNMGw+8kd89jl1Ur7KY4fKCf0Ia4cLOMGhGE5I7jyPhsaDmixW5giAvntFp
         TMQkJ+XBlHfDVQq6RucENWPac0RxCUyulqrQBEDncCP2wJdnaKosxQ9gvafHfn6Y8Sg3
         t/1i8byoXJAJKWgr7fci4kMOvHVUrbZay+pykYUWmE5YdmJX3mxLwoOXk/Qz3RzgcJRY
         tJKtqmfTVQguJs+v1SIqCbsOLXtEWiFWJexLHp5kWmGBGhU//z3qVpZraQitjiEmGF9x
         puDw==
X-Received: by 10.66.122.138 with SMTP id ls10mr43701984pab.63.1431956008659;
        Mon, 18 May 2015 06:33:28 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id da2sm10119540pbb.57.2015.05.18.06.33.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:33:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269238>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Implement tests to ensure that the fast-forward occurs in such a case,
as well as to ensure that the user-friendly advice is printed upon
failure.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
* Removed use of "verbose".

 t/t5520-pull.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3bc0594..3a53a5e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -184,6 +184,27 @@ test_expect_success 'fail if the index has unresolved entries' '
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
