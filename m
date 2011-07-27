From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/18] reset: Make reset remove the sequencer state
Date: Wed, 27 Jul 2011 08:49:12 +0530
Message-ID: <1311736755-24205-16-git-send-email-artagnon@gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 05:23:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QluiZ-00068x-N1
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 05:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab1G0DX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 23:23:29 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35904 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab1G0DX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 23:23:28 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so1938359pzk.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=y/W+ZMzPsf0vgw5ToB83XArHKsPh3z7B/n6CKyLedb0=;
        b=aPwKqksAvpFEcGhqEUGmoyx1swHoOsTlXvjoNhAbDhUtdZBsk2odUBjJ24jbGHVfzW
         P5ASiareYPIggHBBDUtLNCKeAu+R5ABlaB/lpIUZsQoQuvNVEGk9XEwU6ppwunTYeHRA
         E6W4O5KnUGo6r2KUkkYLlgtd4urhQNvXhsG1Y=
Received: by 10.68.60.229 with SMTP id k5mr1242487pbr.365.1311737007717;
        Tue, 26 Jul 2011 20:23:27 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id p7sm1210706pbn.65.2011.07.26.20.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 20:23:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177916>

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

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
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
