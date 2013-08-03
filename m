From: Hiroshige Umino <hiroshige88@gmail.com>
Subject: [PATCH] cherry-pick: allow "-" as abbreviation of '@{-1}'
Date: Sat,  3 Aug 2013 14:15:13 +0900
Message-ID: <1375506913-3390-1-git-send-email-hiroshige88@gmail.com>
Cc: Hiroshige Umino <hiroshige88@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 07:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5UC3-00048Q-3G
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 07:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab3HCFPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 01:15:50 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:60371 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3HCFPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 01:15:49 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so1407761pbb.14
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=V8JSQ+vSXAd5OoNrrjqIpL7TUDYd9K/r+PB92zEWLyU=;
        b=GBS9DSHskxKJKX8okfZYXiewM/hQEmeYglPQOLXVXhN9Ob3CZeEbpK6bNU+5SqA0Bw
         IM3fNBZqO88QquRNrYBTP++7+mubJZ7rz/Riu0WTYp/N6rsrC0ftoaP93RCybkTqqnjx
         wQUb/utcauQYdIk0pOQZAHHGVp/kAQ+FpUKR0ENcc5Jku94thEcwWW5DBNDV671IK4Sd
         C2ttWfCu2P72F+yQyTQqtO6xo9wXyTnUS3PoiGdG+h5CVfaSrEsjiMH2yXwk3LyjsNDK
         2WUIAe9Z0HiAYCR4zKHTxKt1flFQWx+kgbuXU3UsBu/AHmffX4joEGjGSTO3NuSGVmcG
         TTyg==
X-Received: by 10.66.146.66 with SMTP id ta2mr14143020pab.11.1375506948977;
        Fri, 02 Aug 2013 22:15:48 -0700 (PDT)
Received: from localhost.localdomain (113x43x131x34.ap113.ftth.ucom.ne.jp. [113.43.131.34])
        by mx.google.com with ESMTPSA id w8sm11156805paj.4.2013.08.02.22.15.47
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 22:15:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231560>

As "git cherry-pick -" or "git merge -" is convenient to
switch back to or merge the previous branch,
"git cherry-pick -" is abbreviation of "git cherry-pick @{-1}"
to pick up a commit from the previous branch conveniently.

Signed-off-by: Hiroshige Umino <hiroshige88@gmail.com>
---
 builtin/revert.c            |  2 ++
 t/t3512-cherry-pick-last.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100755 t/t3512-cherry-pick-last.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index 1d2648b..cb403f8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -234,6 +234,8 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
+	if (!strcmp(argv[1], "-"))
+		argv[1] = "@{-1}";
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
diff --git a/t/t3512-cherry-pick-last.sh b/t/t3512-cherry-pick-last.sh
new file mode 100755
index 0000000..8b05f81
--- /dev/null
+++ b/t/t3512-cherry-pick-last.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Test cherry-pick -'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+ echo hello >world &&
+ git add world &&
+ git commit -m initial &&
+ git branch other &&
+ echo "hello again" >>world &&
+ git add world &&
+ git commit -m second
+'
+
+test_expect_success '"cherry-pick -" does not work initially' '
+ test_must_fail git cherry-pick -
+'
+
+test_expect_success 'cherry-pick the commit in the previous branch' '
+ prev=$(git rev-parse HEAD) &&
+ git checkout other &&
+ git cherry-pick - &&
+ test "z$(git rev-parse HEAD)" = "z$prev"
+'
+
+test_done
-- 
1.8.3.3
