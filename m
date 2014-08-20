From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: [PATCH 3/4] Added tests for the case of merged and unmerged entries for the same file
Date: Wed, 20 Aug 2014 13:26:02 +0200
Message-ID: <7782c581021d529947a1385939231eeb145d150e.1408533065.git.jsorianopastor@gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
 <cover.1408533065.git.jsorianopastor@gmail.com>
Cc: Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 13:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK43O-0004yh-GT
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 13:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbaHTL1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 07:27:08 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:45686 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbaHTL1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 07:27:06 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so6924121wiw.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=90rcDrsM0u7S9UwJL98T/brPIQ7dsA7atXJ/RkLnkU0=;
        b=xQRAsjggsp/iBH066iipcTSvlHKzoPr3iZpr6ZclCnnc8+igVlVDO1QFfkzFEh77fT
         umEriyDE3Vet9kNXCRyTP/TKyIZcCCsynurseMZw3NDeXjJ59E1OMn7+GGwv+YHnI9qu
         eDzSOlxNtM/as7ZofIQE7yJ5AbI2S7/kQ5PRbgRJ+fznOSycwFE7ifsG9wkMr02OkkHL
         qcMXhnxu7DEsAtu6BfhQppcBJvI1qT4kTRBvbWH0Rckm3k7UVO/Ks8wq3m4zJtt+Fxgw
         yjALZb7F1i5nZDSoxF8wCYkCCDxDlIKjePKRH/rKI3HG6aRLaF+cScQNFDbZdYUw3NeW
         qO/Q==
X-Received: by 10.194.202.231 with SMTP id kl7mr2045191wjc.134.1408534025231;
        Wed, 20 Aug 2014 04:27:05 -0700 (PDT)
Received: from ubuntu-jsoriano.tuenti.local (50.red-80-26-152.adsl.static.ccgg.telefonica.net. [80.26.152.50])
        by mx.google.com with ESMTPSA id je17sm8301873wic.22.2014.08.20.04.27.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 04:27:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.4.gaf54b2b
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
In-Reply-To: <cover.1408533065.git.jsorianopastor@gmail.com>
References: <cover.1408533065.git.jsorianopastor@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255565>

Signed-off-by: Jaime Soriano Pastor <jsorianopastor@gmail.com>
---
 t/t9904-unmerged-file-with-merged-entry.sh | 86 ++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 t/t9904-unmerged-file-with-merged-entry.sh

diff --git a/t/t9904-unmerged-file-with-merged-entry.sh b/t/t9904-unmerged-file-with-merged-entry.sh
new file mode 100755
index 0000000..945bc1c
--- /dev/null
+++ b/t/t9904-unmerged-file-with-merged-entry.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description='Operations with unmerged files with merged entries'
+
+. ./test-lib.sh
+
+setup_repository() {
+	test_commit A conflict A
+	test_commit A conflict2 A2 branchbase
+	test_commit B conflict B
+	test_commit B conflict2 B2
+	git checkout branchbase -b branch1
+	test_commit C conflict C
+	test_commit C conflict2 C2
+	test_commit something otherfile otherfile
+}
+
+setup_stage_state() {
+	git checkout -f HEAD
+	{
+		git ls-files -s conflict conflict2
+		git merge master > /dev/null
+		git ls-files -s conflict conflict2
+	} > index
+	cat index | git update-index --index-info
+	rm index
+}
+
+test_expect_success 'setup - two branches with conflicting files' '
+	setup_repository &&
+	setup_stage_state &&
+	git ls-files -s conflict > output &&
+	test_line_count = 4 output &&
+	git ls-files -s conflict2 > output &&
+	test_line_count = 4 output &&
+	rm output
+'
+
+test_expect_success 'git commit -a' '
+	setup_stage_state &&
+	test_must_fail git commit -a
+'
+
+test_expect_success 'git add conflict' '
+	setup_stage_state &&
+	test_must_fail git add conflict
+'
+
+test_expect_success 'git rm conflict' '
+	setup_stage_state &&
+	test_must_fail git rm conflict
+'
+
+test_expect_success 'git add otherfile' '
+	setup_stage_state &&
+	>otherfile &&
+	git add otherfile
+'
+
+test_expect_success 'git rm otherfile' '
+	setup_stage_state &&
+	git rm otherfile
+'
+
+test_expect_success 'git add newfile' '
+	setup_stage_state &&
+	>newfile &&
+	git add newfile
+'
+
+test_expect_success 'git merge branch' '
+	setup_stage_state &&
+	test_must_fail git merge master
+'
+
+test_expect_success 'git reset --hard' '
+	setup_stage_state &&
+	git reset --hard &&
+	git show HEAD:conflict > expected &&
+	cat conflict > current &&
+	git show HEAD:conflict2 > expected &&
+	cat conflict2 > current &&
+	test_cmp expected current
+'
+
+test_done
-- 
2.0.4.4.gaf54b2b
