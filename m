From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 05/12] t5520: test --rebase failure on unborn branch with index
Date: Thu,  7 May 2015 16:44:01 +0800
Message-ID: <1430988248-18285-6-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:44:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQA-0005Wv-QF
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbbEGIoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32914 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbbEGIoc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:32 -0400
Received: by pacwv17 with SMTP id wv17so34434583pac.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U65f1BTmcEmuVmmyoojxSy1iQY/dc1DGQHKIOfJJkkA=;
        b=wcPGk2DRXcpAttmbvNe3PQoGrauhOlj3F9YGK7SKfW0bDDRGQ9CupIjqdxK6O+dWUI
         AX08h/06AhTdAjhi5q5AABUh+qvIJnEnZMgiNb9DuuQxsYozcbqYrrqbOu+WFSD5Wz2h
         9xnSkMLUQlxE40ykgn535tuECIXC/kOgOiu0pW1KF9UE46jlRAnxS7eIKPUBqpTaPYzl
         rl1OzzbadD5IISDoKAoONi5dYM7FkElGXb12DbNL9ICEDve1e4cb3TsBaTqf+TXElwmU
         ILPqMMNAxAInqbKTWtFAJ5uQB8+pJCqQpqBie58cQ5zZZLeG0gJxv0pG2VV7igJYtAx/
         McTQ==
X-Received: by 10.69.27.66 with SMTP id je2mr4069105pbd.49.1430988271844;
        Thu, 07 May 2015 01:44:31 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:30 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268517>

Commit 19a7fcbf (allow pull --rebase on branch yet to be born) special
cases git-pull on an unborn branch in a different code path such that
git-pull --rebase is still valid even though there is no HEAD yet.

This code path still ensures that there is no index in order not to lose
any staged changes. Implement a test to ensure that this check is
triggered.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Test for error message.
    
    * Ensure that when git-pull does not modify the index.
    
    * Moved test_when_finished

 t/t5520-pull.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 05a92a2..9107991 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -415,6 +415,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
+	test_when_finished "rm -rf empty_repo2" &&
+	git init empty_repo2 &&
+	(
+		cd empty_repo2 &&
+		echo staged-file >staged-file &&
+		git add staged-file &&
+		test "$(git ls-files)" = staged-file &&
+		test_must_fail git pull --rebase .. master 2>../out &&
+		test "$(git ls-files)" = staged-file &&
+		test "$(git show :staged-file)" = staged-file
+	) &&
+	test_i18ngrep "unborn branch with changes added to the index" out
+'
+
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
 	(cd src &&
-- 
2.1.4
