From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 1/3] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Mon, 15 Sep 2014 12:07:37 -0700
Message-ID: <1410808059-1459-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:07:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbci-0000aV-5c
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbaIOTHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:07:34 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:59690 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265AbaIOTH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:07:28 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so6803455pdj.20
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=lqzQ8AETOc9O/Uwm1WFStObqspBqqmli3XKm+wpfaPc=;
        b=tiWeSkBX7dMAr6huKaT4tJwBVqPKOn6aq60ReDZPIFoEtPOGYloBl9zUcwUPSIuRlh
         pGL6T5L1PAMcKtP6R4tpvnsiGAvf6tcXwM/BOMbWHaNd4Nit38Wep+nziFjZPdOe22Ql
         kqhfxI1TBGrvp+5OtzQp+vCB0b52PJalKoNegIQgECGUwlZIGqrvN7ihVteiiSuZPO1x
         LupCRY6pnP8nOF+gpZFOOVutoFwxNSSHfBmTgrTj74zmEK9qzSSdxvMQ+c7OzT8gfwKO
         e1JJ8BXT0NSwW0hR8yxi5qDfzbZTfFxxNUB7fLNoTBfG7pp1FTNEUDC/AfiwntrhXVxL
         eZ5Q==
X-Received: by 10.70.88.237 with SMTP id bj13mr49887104pdb.57.1410808048237;
        Mon, 15 Sep 2014 12:07:28 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id cm8sm12023824pdb.95.2014.09.15.12.07.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 12:07:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257070>

Ensure that rev-parse --verify --quiet is silent when asked
about deleted reflog entries.

Helped-by: Fabian Ruch <bafain@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Differences since last time:

This goes back to the original approach of using "git update-ref"
plumbing instead of "git branch" when testing deleted reflogs.

 t/t1503-rev-parse-verify.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 813cc1b..fd9d0c3 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,6 +83,15 @@ test_expect_success 'fails silently when using -q' '
 	test -z "$(cat error)"
 '
 
+test_expect_success 'fails silently when using -q with deleted reflogs' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test &&
+	git update-ref -m "reflog message for refs/test" refs/test "$ref" &&
+	git reflog delete --updateref --rewrite refs/test@{0} &&
+	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
+	test -z "$(cat error)"
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.30.g05c535b.dirty
