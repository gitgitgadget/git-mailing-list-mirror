From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 5/9] t5520: test work tree fast-forward when fetch updates head
Date: Wed, 13 May 2015 17:08:52 +0800
Message-ID: <1431508136-15313-6-git-send-email-pyokagan@gmail.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:09:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSfl-0003Ls-3C
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbbEMJJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:09:43 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35289 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbbEMJJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:09:38 -0400
Received: by pabtp1 with SMTP id tp1so44528283pab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vBsY7MXv7OZpvSBeS693pChnCnKMJrQDPi6rnyRe8ew=;
        b=ZUCwd0Znu7K5leP2thMONKq8rHLLwi61g/CjLEweJhk+Zw6F3FJHPoXVx3M0Ut0w4b
         qs5ILrUVqMentqZ4JwmtGz1C7qA9rH15tw+M4Xje8G7mfG2wQW/MwtOEdyXlQ3xfhUuB
         gE3ZJX5e5+5IpNdBuJmjZ+Dpyiyox8iYwQbpwLEaFFu0jajKpJp3SOsYoFml9RlZZoq1
         HXe/1ec8jcmpT4oowyS52TIOLZIYOGmmRu0wnSurHIKhlohQ9H5dV/8A8h/xyaLM+9tI
         hfz2Q5K7wfW4B1VQ1115Gld1dfoj0fiY1q9WhV8odXmPrAoMQ4PFpH92qwWjUDXYtjaZ
         qJtw==
X-Received: by 10.70.88.108 with SMTP id bf12mr35896964pdb.159.1431508177487;
        Wed, 13 May 2015 02:09:37 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id df7sm18645685pdb.32.2015.05.13.02.09.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:09:35 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268954>

Since b10ac50 (Fix pulling into the same branch., 2005-08-25), git-pull,
upon detecting that git-fetch updated the current head, will
fast-forward the working tree to the updated head commit.

Implement tests to ensure that the fast-forward occurs in such a case,
as well as to ensure that the user-friendly advice is printed upon
failure.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

* Added git rev-parse checks to make it explicit that the branch head has
  been updated.

* "git checkout -b third second^" to make it explicit we are fast-forwarding.

 t/t5520-pull.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 8e95402..954e581 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -184,6 +184,27 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_cmp expected file
 '
 
+test_expect_success 'fast-forwards working tree if branch head is updated' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	verbose test "$(cat file)" = file &&
+	git pull . second:third 2>err &&
+	test_i18ngrep "fetch updated the current branch head" err &&
+	verbose test "$(cat file)" = modified &&
+	verbose test "$(git rev-parse third)" = "$(git rev-parse second)"
+'
+
+test_expect_success 'fast-forward fails with conflicting work tree' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	verbose test "$(cat file)" = file &&
+	echo conflict >file &&
+	test_must_fail git pull . second:third 2>err &&
+	test_i18ngrep "Cannot fast-forward your working tree" err &&
+	verbose test "$(cat file)" = conflict &&
+	verbose test "$(git rev-parse third)" = "$(git rev-parse second)"
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
