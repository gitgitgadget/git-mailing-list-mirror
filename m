From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 3/7] test patch hunk editing with "commit -p -m"
Date: Sat, 15 Mar 2014 22:42:26 +0100
Message-ID: <1394919750-28432-3-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
 <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwM5-0001uc-D2
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbaCOVmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:42:53 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:40553 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:42:52 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so3348402wes.17
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MdW6Uc66qp3Oq+AYg4rx7CdzV1sdDMvdrjrLea8+c3g=;
        b=BmQaeoQTy8H9iqX4WxI7tR6yHQ3MFU+mx78mB8sfOdF6D88kn9PzYupOyxwXSvW6Eb
         RefVnbyo+oSjoix0c2F4wx3xPyrtW3YQh27yhlybA8h2MgqAChX/Blcecnp/u5A1QfNc
         V7jkvBKWmA6LC4rjq+Xs0BZQYiMQ2h1NnqHQmW3oVfb2lmbPULSRIj2Fw21Z+8DhDaSY
         83VsJcHwndLrHnI3Ki57UjCnA86pomKyGc23XSff0M3bnWgQKHQJAQgUik4BSYCTzoyg
         Ligy8Ig2i4lnTQWiGcdkM5SiM9wjqBhklWeB2ebwXT8634bPKQ1QSfXlKzuXcseow266
         uoKg==
X-Received: by 10.180.20.176 with SMTP id o16mr3516456wie.7.1394919771821;
        Sat, 15 Mar 2014 14:42:51 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id ju6sm24373808wjc.1.2014.03.15.14.42.49
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:42:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244171>

Add (failing) tests: with commit changing the environment to let hooks
know that no editor will be used (by setting GIT_EDITOR to ":"), the
"edit hunk" functionality does not work (no editor is launched and the
whole hunk is committed).

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7513-commit-patch.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/t7513-commit-patch.sh

diff --git a/t/t7513-commit-patch.sh b/t/t7513-commit-patch.sh
new file mode 100755
index 0000000..9311b0c
--- /dev/null
+++ b/t/t7513-commit-patch.sh
@@ -0,0 +1,32 @@
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
+	git commit -m commit1
+'
+
+test_expect_failure 'edit hunk "commit -p -m message"' '
+	test_when_finished "rm -f editor_was_started" &&
+	echo more >>file &&
+	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit2 file &&
+	test -r editor_was_started
+'
+
+test_expect_failure 'edit hunk "commit --dry-run -p -m message"' '
+	test_when_finished "rm -f editor_was_started" &&
+	echo more >>file &&
+	echo e | env GIT_EDITOR="touch editor_was_started" git commit -p -m commit3 file &&
+	test -r editor_was_started
+'
+
+test_done
-- 
1.9.0
