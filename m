From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 6/8] t5520: test --rebase failure on unborn branch with index
Date: Fri, 29 May 2015 19:44:43 +0800
Message-ID: <1432899885-25143-7-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIj9-00043m-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755450AbbE2LpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:21 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35130 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbE2LpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:12 -0400
Received: by pacrp13 with SMTP id rp13so9528224pac.2
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ae6UILFqd4omaOGsG579ASu5t1duaMToqi3xx5ACFSw=;
        b=rYtjxlyvyAgznFSDyqjE+OHinpvoLzzqQ539ZsuDWkOmv3BLxGwDLfrvI/BRpyQZwY
         esn5ovZvslaaYjY2JxMbtO1jVvWmQXy4zIY1o2iem0eONXAyUIihhKsF21v1ekEYXS/F
         n55RN2PiQOMm3yhbD26suQqCYCXz6ir5CLkYhL8pwb3MeXSJUzCncb7Q5wpZDXlJtHZN
         bVC6U25P1wMI+46X4g4nhHMzWrhGu7Ncsx/jK5v3WNT8kEIcSHYu6l2VBos7/iSOi48G
         cBfz/blqljI3OPFsir0m5Q+jDYHq27HD9FqVOusPQNxW/s0d93E5CHLPSOWLmsum2FbI
         hJfQ==
X-Received: by 10.70.126.225 with SMTP id nb1mr14298887pdb.71.1432899911714;
        Fri, 29 May 2015 04:45:11 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.45.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:45:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270233>

Commit 19a7fcb (allow pull --rebase on branch yet to be born,
2009-08-11) special cases git-pull on an unborn branch in a different
code path such that git-pull --rebase is still valid even though there
is no HEAD yet.

This code path still ensures that there is no index in order not to lose
any staged changes. Implement a test to ensure that this check is
triggered.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    
    v5:
    
    * Move test_i18ngrep into subshell

 t/t5520-pull.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 90728e0..a04f55c 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -412,6 +412,21 @@ test_expect_success 'pull --rebase works on branch yet to be born' '
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
+		test_must_fail git pull --rebase .. master 2>err &&
+		test "$(git ls-files)" = staged-file &&
+		test "$(git show :staged-file)" = staged-file &&
+		test_i18ngrep "unborn branch with changes added to the index" err
+	)
+'
+
 test_expect_success 'setup for detecting upstreamed changes' '
 	mkdir src &&
 	(cd src &&
-- 
2.1.4
