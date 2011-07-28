From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/18] reset: Make reset remove the sequencer state
Date: Thu, 28 Jul 2011 22:22:27 +0530
Message-ID: <1311871951-3497-15-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:56:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTtJ-00049i-7B
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880Ab1G1Q4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:56:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60323 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798Ab1G1Q4h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:56:37 -0400
Received: by mail-gx0-f174.google.com with SMTP id 21so1954221gxk.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Q1hG+p1V2Mm4dho8beBxJqhL0xCfxaSyZYzdZKnt55U=;
        b=updYJxb1PO9VtPyU0xN6dbxTVTfToZbVH1luvC9QnVU8rNvpYJ5M7D6QrHs+UmOYwy
         p5E8dhA7LWF9DSMKDC+cnWn1p1WsU/yoCx4i2lQ50M89AFGEfMLO5ezcSsKcmwoW66b/
         n8kDAkpdtOZr1aiF/HyHbgLjsR2dcJZgaL7jM=
Received: by 10.42.139.65 with SMTP id f1mr190940icu.8.1311872197331;
        Thu, 28 Jul 2011 09:56:37 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.56.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:56:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178090>

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
 t/7106-reset-sequence.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)
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
index 0000000..c61c62d
--- /dev/null
+++ b/t/7106-reset-sequence.sh
@@ -0,0 +1,43 @@
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
