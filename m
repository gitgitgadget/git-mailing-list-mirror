From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Fri, 01 Jun 2007 09:10:39 +0200
Message-ID: <op.ts8d71b89pspc6@localhost>
References: <11802980992216-git-send-email-hjemli@gmail.com> <7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net> <8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com> <7vzm3kz5w9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 09:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu1FR-00012g-EL
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 09:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbXFAHIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 03:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756804AbXFAHIZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 03:08:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:50064 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbXFAHIY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2007 03:08:24 -0400
Received: by wx-out-0506.google.com with SMTP id t15so411596wxc
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 00:08:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=IAkmy2fBef3YMrfFY4flcOkX7DJGjR7igN9mnBgrtWcB2MglfpOB4TQNwd1IR+FDWgT5/oscfpSqBUTNZl2D7zpTDNdJ8PeegAO1NzU9qsaBrtcUk40CyKQh33yB6BYtNPXVRGg6dV8mAJ3AdnQtv8lPLrNGSGNvPnurboSy5NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=uhS7jSQ9DkIqjS9BKz9UKWVON+SaAFPgpi2WCTHsiJAWUuje6+YG3ULt2BveTLFsctORF21YBwiQTy2jemuSCOoC6Yxlj7FPssHE0v/TTi/Xf6ZZllulQd0VF5+tiw12jlSgHqQeQcJ1ohFrLx0+Qaey3cq8szjlYj4PTdN9o4A=
Received: by 10.82.186.5 with SMTP id j5mr596221buf.1180681703079;
        Fri, 01 Jun 2007 00:08:23 -0700 (PDT)
Received: from localhost ( [195.1.56.189])
        by mx.google.com with ESMTP id c22sm485536ika.2007.06.01.00.08.21;
        Fri, 01 Jun 2007 00:08:21 -0700 (PDT)
In-Reply-To: <7vzm3kz5w9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48845>

This test tries to verify basic sanity of git-submodule, i.e. that it is
able to clone and update a submodule repository, that its status output is
sane, and that it barfs when the submodule path is occupied during init.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On 6/1/07, Junio C Hamano <junkio@cox.net> wrote:
> As you said you will be redoing submodule + .git/config stuff in
> your other message, I would expect a replacement (i.e. not on
> top of this) patch for tests to check the existing submodule
> features.  If you want to finish the submodule + .git/config one
> first and then test script on top to test both existing featues
> and submodule + .git/config features, that is fine as well.
> Your choice.

My continuous quest for self-discipline left me no choice but to attempt
the creation of a proper testscript for the existing features ;-)

  t/t7400-submodule-basic.sh |  143 ++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 143 insertions(+), 0 deletions(-)
  create mode 100755 t/t7400-submodule-basic.sh

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
new file mode 100755
index 0000000..a8beee2
--- /dev/null
+++ b/t/t7400-submodule-basic.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Lars Hjemli
+#
+
+test_description='Basic porcelain support for submodules
+
+This test tries to verify basic sanity of the init, update and status
+subcommands of git-submodule.
+'
+
+. ./test-lib.sh
+
+#
+# Test setup:
+#  -create a repository in directory lib
+#  -add a couple of files
+#  -add directory lib to 'superproject', this creates a DIRLINK entry
+#  -add a couple of regular files to enable testing of submodule filtering
+#  -mv lib subrepo
+#  -add an entry to .gitmodules for path 'lib'
+#
+test_expect_success 'Prepare submodule testing' '
+	mkdir lib &&
+	cd lib &&
+	git-init &&
+	echo a >a &&
+	git-add a &&
+	git-commit -m "submodule commit 1" &&
+	git-tag -a -m "rev-1" rev-1 &&
+	rev1=$(git-rev-parse HEAD) &&
+	if test -z "$rev1"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	fi &&
+	cd .. &&
+	echo a >a &&
+	echo z >z &&
+	git-add a lib z &&
+	git-commit -m "super commit 1" &&
+	mv lib .subrepo &&
+	GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+'
+
+test_expect_success 'status should only print one line' '
+	lines=$(git-submodule status | wc -l)
+	test "$lines" = "1"
+'
+
+test_expect_success 'status should initially be "missing"' '
+	git-submodule status | grep "^-$rev1"
+'
+
+test_expect_success 'init should fail when path is used by a file' '
+	echo "hello" >lib &&
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif test -f lib && test "$(cat lib)" != "hello"
+	then
+		echo "[OOPS] init failed but lib file was molested"
+		false
+	else
+		rm lib
+	fi
+'
+
+test_expect_success 'init should fail when path is used by a nonempty directory' '
+	mkdir lib &&
+	echo "hello" >lib/a &&
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif test "$(cat lib/a)" != "hello"
+	then
+		echo "[OOPS] init failed but lib/a was molested"
+		false
+	else
+		rm lib/a
+	fi
+'
+
+test_expect_success 'init should work when path is an empty dir' '
+	rm -rf lib &&
+	mkdir lib &&
+	git-submodule init &&
+	head=$(cd lib && git-rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] Failed to obtain submodule head"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] Submodule head is $head but should have been $rev1"
+		false
+	fi
+'
+
+test_expect_success 'status should be "up-to-date" after init' '
+	git-submodule status | grep "^ $rev1"
+'
+
+test_expect_success 'status should be "modified" after submodule commit' '
+	cd lib &&
+	echo b >b &&
+	git-add b &&
+	git-commit -m "submodule commit 2" &&
+	rev2=$(git-rev-parse HEAD) &&
+	cd .. &&
+	if test -z "$rev2"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	fi &&
+	git-submodule status | grep "^\+$rev2"
+'
+
+test_expect_success 'the --cached sha1 should be rev1' '
+	git-submodule --cached status | grep "^\+$rev1"
+'
+
+test_expect_success 'update should checkout rev1' '
+	git-submodule update &&
+	head=$(cd lib && git-rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] init did not checkout correct head"
+		false
+	fi
+'
+
+test_expect_success 'status should be "up-to-date" after update' '
+	git-submodule status | grep "^ $rev1"
+'
+
+test_done
-- 
1.5.2.839.ga3b1-dirty
