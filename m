From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/18] reset: Make reset remove the sequencer state
Date: Mon,  1 Aug 2011 23:37:01 +0530
Message-ID: <1312222025-28453-15-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:12:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnwys-0004Pw-7g
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242Ab1HASMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:12:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:62360 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1HASMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:12:41 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so11912645pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vwSLEAx43UprQccl1GqW7cw8ijs0m0vTw5tM5NQBL3Q=;
        b=CI2RyJ5oSP7PFvRoGKWvbkeT6ozajsDQqkRAmfS/+ZeTR2vGPSiG/Z9ujZzLlNaXwU
         pqLTFPwVmGhdGLQ/4nn86r6NOscExSjBtel9Aq1fN81uo+mBL6C/4gNziURETx3K4wAn
         ySGh/lOZo21AFj9940NVw0VbT2/xpLBpJWLWM=
Received: by 10.68.5.98 with SMTP id r2mr7899041pbr.98.1312222360476;
        Mon, 01 Aug 2011 11:12:40 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.12.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:12:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178386>

Years of muscle memory have trained users to use "git reset --hard" to
remove the branch state after any sort operation.  Make it also remove
the sequencer state to facilitate this established workflow:

  $ git cherry-pick foo..bar
  ... conflict encountered ...
  $ git reset --hard # Oops, I didn't mean that
  $ git cherry-pick quux..bar
  ... cherry-pick succeeded ...

Guard against accidental removal of the sequencer state by providing
one level of "undo".  In the first "reset" invocation,
".git/sequencer" is moved to ".git/sequencer-old"; it is completely
removed only in the second invocation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c                 |    2 ++
 t/7106-reset-sequence.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 t/7106-reset-sequence.sh

diff --git a/branch.c b/branch.c
index c0c865a..d06aec4 100644
--- a/branch.c
+++ b/branch.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "commit.h"
+#include "sequencer.h"
 
 struct tracking {
 	struct refspec spec;
@@ -228,4 +229,5 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
+	remove_sequencer_state(0);
 }
diff --git a/t/7106-reset-sequence.sh b/t/7106-reset-sequence.sh
new file mode 100755
index 0000000..4956caa
--- /dev/null
+++ b/t/7106-reset-sequence.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='Test interaction of reset --hard with sequencer
+
+  + anotherpick: rewrites foo to d
+  + picked: rewrites foo to c
+  + unrelatedpick: rewrites unrelated to reallyunrelated
+  + base: rewrites foo to b
+  + initial: writes foo as a, unrelated as unrelated
+'
+
+. ./test-lib.sh
+
+pristine_detach () {
+	git cherry-pick --reset &&
+	git checkout -f "$1^0" &&
+	git read-tree -u --reset HEAD &&
+	git clean -d -f -f -q -x
+}
+
+test_expect_success setup '
+	echo unrelated >unrelated &&
+	git add unrelated &&
+	test_commit initial foo a &&
+	test_commit base foo b &&
+	test_commit unrelatedpick unrelated reallyunrelated &&
+	test_commit picked foo c &&
+	test_commit anotherpick foo d &&
+	git config advice.detachedhead false
+
+'
+
+test_expect_success 'reset --hard cleans up sequencer state, providing one-level undo' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test_path_is_dir .git/sequencer &&
+	git reset --hard &&
+	test_path_is_missing .git/sequencer &&
+	test_path_is_dir .git/sequencer-old &&
+	git reset --hard &&
+	test_path_is_missing .git/sequencer-old
+'
+
+test_done
-- 
1.7.4.rc1.7.g2cf08.dirty
