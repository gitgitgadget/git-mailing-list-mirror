From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 14/17] reset: Make hard reset remove the sequencer state
Date: Mon, 11 Jul 2011 14:54:05 +0000
Message-ID: <1310396048-24925-15-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsh-0005F4-9A
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877Ab1GKOyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:38 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55920 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab1GKOyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:36 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716880vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S1L2VSWrxM5sMbCTgxqiPL4GU1nT+iQSwz/6uiaic0o=;
        b=RBQ1IgGdgKXa9aVBEUqepFLcR4ckiapLE4jHPJAbnn5g+an+yFF1LCDYP9AUbYJnD/
         8yugv/8ONAyQufdVHSehQUJJ6Cv4XHfelGopLzu0S1A3zN4JHVdbU+i5pRb/uZxVXR5I
         tuz0vred0itoI1rfm/I3K3xtxtJjAlQMsLiIs=
Received: by 10.52.30.138 with SMTP id s10mr2574782vdh.368.1310396076072;
        Mon, 11 Jul 2011 07:54:36 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176851>

Years of muscle memory have trained users to use "git reset --hard" to
remove away the branch state after any sort of operation.  In
retrospect, while this may not have been the best design decision, we
are stuck with it for historical reasons.  This sort of workflow is
now possible:

$ git cherry-pick foo..bar
... conflict encountered ...
$ git reset --hard # Oops, I didn't mean that
$ git cherry-pick quux..bar
... cherry-pick succeeded ...

Also, guard against accidental removal of the sequencer state by
moving ".git/sequencer" to ".git/sequencer-old" in the first "git
reset --hard" call, and only remove it completely only after the
second call.

Additionally, this patch ensures that some existing tests don't break
when features like "--reset" and "--continue" are introduced later in
the series.  Without this patch, we would expect the last cherry-pick
call in the example to fail with the complaint that an existing
cherry-pick operation is in progress.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/reset.c          |    2 ++
 t/7106-reset-sequence.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100755 t/7106-reset-sequence.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..899e250 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -20,6 +20,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
+#include "sequencer.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]",
@@ -367,6 +368,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	switch (reset_type) {
 	case HARD:
+		remove_sequencer_state();
 		if (!update_ref_status && !quiet)
 			print_new_head_line(commit);
 		break;
diff --git a/t/7106-reset-sequence.sh b/t/7106-reset-sequence.sh
new file mode 100755
index 0000000..5aa8b71
--- /dev/null
+++ b/t/7106-reset-sequence.sh
@@ -0,0 +1,40 @@
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
+test_expect_success 'reset --hard cleans up sequencer state' '
+	pristine_detach initial &&
+	test_must_fail git cherry-pick base..anotherpick &&
+	test_path_is_dir .git/sequencer &&
+	git reset --hard &&
+	test_path_is_missing .git/sequencer
+'
+
+test_done
-- 
1.7.5.GIT
