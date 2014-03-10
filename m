From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Mon, 10 Mar 2014 19:49:33 +0100
Message-ID: <1394477377-10994-4-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HC-0005To-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbaCJStx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:49:53 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:41412 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaCJStw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:52 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so8831432wes.8
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=mFnYoHbf/KpH9CjDnC1mmqu7nPnMhmvrgwKgwcb5B+o=;
        b=ViXAQKOP7kJGj5qB9oYZzgZZ+QIicDQykVySCB6DVX8+i5fCiN6VrhPzO4H4bPamFr
         mOWqrgYBMTnv7V8MfSYjwLIoBMWMJ5MW32/8hQKwxNYyUeh9Nsam4kjVI0LRq/Xvp63f
         iCN4xs8bTwJKIjEhPDjKOMERqeuAWjYn/MViCpwQLez9Y9q56HnTnMJcDwPdMuegNIHe
         NwZWIsZrxQL+NZ3Io1wCaMdy6yNAF5UvSGmaG8g5t9Zoiyz1pEF3LHeDpIflT+4DX3PM
         JOvIXhvuZkdrdFTx1VEPc63PCT0z6Tt+Tb08cNxxv9UZixJAbDTXJ5ho2uHpn/bRFvlL
         4Utg==
X-Received: by 10.194.87.195 with SMTP id ba3mr3669176wjb.53.1394477391215;
        Mon, 10 Mar 2014 11:49:51 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id 15sm54370479wjo.13.2014.03.10.11.49.49
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243787>

Add (failing) test: with commit changing the environment to let hooks
now that no editor will be used (by setting GIT_EDITOR to ":"), the
"edit hunk" functionality does not work (no editor is launched and the
whole hunk is committed).

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7513-commit_-p_-m_hunk_edit.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100755 t/t7513-commit_-p_-m_hunk_edit.sh

diff --git a/t/t7513-commit_-p_-m_hunk_edit.sh b/t/t7513-commit_-p_-m_hunk_edit.sh
new file mode 100755
index 0000000..994939a
--- /dev/null
+++ b/t/t7513-commit_-p_-m_hunk_edit.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='hunk edit with "commit -p -m"'
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all="skipping '$test_description' tests, perl not available"
+	test_done
+fi
+
+test_expect_success 'setup (initial)' '
+	echo line1 >file &&
+	git add file &&
+	git commit -m commit1 &&
+	echo line3 >>file &&
+	cat >expect <<-\EOF
+	diff --git a/file b/file
+	index a29bdeb..c0d0fb4 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 line1
+	+line2
+	EOF
+'
+
+test_expect_failure 'edit hunk "commit -p -m message"' '
+	echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
+	git diff HEAD^ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.9.0
