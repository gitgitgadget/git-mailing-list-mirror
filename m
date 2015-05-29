From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 3/8] t5520: test for failure if index has unresolved entries
Date: Fri, 29 May 2015 19:44:40 +0800
Message-ID: <1432899885-25143-4-git-send-email-pyokagan@gmail.com>
References: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 13:45:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIj1-0003w7-K4
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbbE2LpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:45:07 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33958 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbbE2LpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 07:45:03 -0400
Received: by pabru16 with SMTP id ru16so56096802pab.1
        for <git@vger.kernel.org>; Fri, 29 May 2015 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4CrUHw/0+Ge4/H8uoInRZFsrhY0UZjohHth+tRw4gC8=;
        b=iq7Adk0AiG3LhSYCRdYpwg0Lve7K2gY5kGCpeX4q7/osaqHqLolKrRW/CspROCX5mX
         0CHejN5sEsuChg+g/NrEbiokYpZ0oqAOmM9y1UKXNMtN6MuEGliBmi7je0RE/shIx+Dm
         5A3TKc8f2pO7aPX3XBncss6iXsNj5wQxfRWywISFwxyrPppPZAIlwgWK+dMGnSgOvhMS
         +0c+R+zh0P2FlT0EkLoAWBtWMnkT/qTTzZtL0yfyhQqymA+9jTchBQTc4eXKKlut4scA
         Zy/JkOfro46ckQlH0kD8YXnBxosnvix4a/7/jk3cfn8fnhmTYxxZf1SKPMuHX2LJt0Pv
         g9og==
X-Received: by 10.68.129.72 with SMTP id nu8mr14237314pbb.145.1432899902800;
        Fri, 29 May 2015 04:45:02 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qg5sm5392460pdb.13.2015.05.29.04.45.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 May 2015 04:45:01 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432899885-25143-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270232>

Commit d38a30d (Be more user-friendly when refusing to do something
because of conflict., 2010-01-12) introduced code paths to git-pull
which will error out with user-friendly advices if the user is in the
middle of a merge or has unmerged files.

Implement tests to ensure that git-pull will not run, and will print
these advices, if the user is in the middle of a merge or has unmerged
files in the index.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    
    v5:
    
    * use "test_commit"

 t/t5520-pull.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 4a2c0a1..265c693 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -164,6 +164,25 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test "$(cat file)" = file
 '
 
+test_expect_success 'fail if the index has unresolved entries' '
+	git checkout -b third second^ &&
+	test_when_finished "git checkout -f copy && git branch -D third" &&
+	test "$(cat file)" = file &&
+	test_commit modified2 file &&
+	test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second &&
+	test -n "$(git ls-files -u)" &&
+	cp file expected &&
+	test_must_fail git pull . second 2>err &&
+	test_i18ngrep "Pull is not possible because you have unmerged files" err &&
+	test_cmp expected file &&
+	git add file &&
+	test -z "$(git ls-files -u)" &&
+	test_must_fail git pull . second 2>err &&
+	test_i18ngrep "You have not concluded your merge" err &&
+	test_cmp expected file
+'
+
 test_expect_success '--rebase' '
 	git branch to-rebase &&
 	echo modified again > file &&
-- 
2.1.4
