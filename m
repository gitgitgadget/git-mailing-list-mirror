From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/6] tests: add remote-hg tests
Date: Sun, 21 Oct 2012 19:49:03 +0200
Message-ID: <1350841744-21564-6-git-send-email-felipe.contreras@gmail.com>
References: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 19:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPzf2-0002xp-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 19:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441Ab2JURtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 13:49:53 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34362 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420Ab2JURtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 13:49:52 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so1546732wib.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DE4eoy960DwHQ7F+TRTHdld4zEkUsUxOOt+aNebM8+U=;
        b=q2FvRQie5bSCbs0fNLY2qRnXlW/Gf41+BERa7ibr4JYZ1NkPga/8xIBk2tr34Z17OI
         50m678lElYpi1wJx++pQF32hDGDnvoDb8cHMr9NEg9y2R2DEo0v54AAla+VOzb5JsJcO
         PxMjHm6vafCmO0Qhl/d6DK0v19e/vrGxo3PG2P/eLB6SN/Knbo2gYCa++GIImPQ2PV53
         EaUYqdWq1RhHq0IBQaZa3oko6wq4k0r3Km3e3FFoTAb28ZkEhmQdKrIoLSk8GliHXgF/
         prERk0b0iDQUjzWWeLImkKagcpdKXcqhuF2HdQTpQm9//kICa4zfVFrq05nvGI60l07T
         1unA==
Received: by 10.216.198.66 with SMTP id u44mr4069491wen.133.1350841791179;
        Sun, 21 Oct 2012 10:49:51 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id dt9sm46888673wib.1.2012.10.21.10.49.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 10:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc2.7.g0961fdf.dirty
In-Reply-To: <1350841744-21564-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208133>

>From the original remote-hg.

You need git-remote-hg already in your path to run them.

I'm not proposing to include this patch like this, but should make it easier to
test.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-hg.sh | 143 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100755 t/t5801-remote-hg.sh

diff --git a/t/t5801-remote-hg.sh b/t/t5801-remote-hg.sh
new file mode 100755
index 0000000..2e68372
--- /dev/null
+++ b/t/t5801-remote-hg.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Sverre Rabbelier
+#
+
+test_description='Test remote-helper import and export commands'
+
+. ./test-lib.sh
+
+if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
+import sys
+if sys.hexversion < 0x02040000:
+    sys.exit(1)
+'
+then
+	:
+else
+	skip_all='skipping git remote-hg tests: requires Python 2.4 or newer'
+	test_done
+fi
+
+if ! type hg >/dev/null 2>&1
+then
+	skip_all='skipping git remote-hg tests: requires hg'
+	test_done
+fi
+
+# Call cmp with the arguments -x ".hg" -x ".git" <left> <right>
+
+vcs_cmp () {
+	$DIFF -u -x ".hg" -x ".git" $1 $2
+}
+
+ROOT=$PWD
+
+test_expect_success 'setup repository' '
+	printf "[ui]\nusername = A U Thor <author@example.com>" > \
+		${HOME}/.hgrc &&
+	mkdir server &&
+	hg init server/.hg &&
+	hg clone "$ROOT/server" public &&
+	(cd public &&
+	 echo content >file &&
+	 hg add file &&
+	 hg commit -m one &&
+	 hg push)
+'
+
+test_expect_success 'cloning from local repo' '
+	git clone "hg::file://${ROOT}/server" localclone &&
+	vcs_cmp public localclone
+'
+
+test_expect_success 'cloning from remote repo' '
+	git clone "hg::remote://${ROOT}/server" clone &&
+	vcs_cmp public clone
+'
+
+test_expect_success 'create new commit on remote' '
+	(cd public &&
+	 echo content >>file &&
+	 hg commit -A -m two &&
+	 hg push)
+'
+
+test_expect_success 'pulling from local repo' '
+	(cd localclone && git pull) &&
+	vcs_cmp public localclone
+'
+
+test_expect_success 'pulling from remote remote' '
+	(cd clone && git pull) &&
+	vcs_cmp public clone
+'
+
+test_expect_success 'pushing to local empty repo' '
+	hg init localempty &&
+	(cd localclone &&
+	git push --all "hg::file://${ROOT}/localempty") &&
+	(cd localempty &&
+	hg up tip) &&
+	vcs_cmp localclone localempty
+'
+
+test_expect_success 'pushing to remote empty repo' '
+	hg init empty &&
+	(cd localclone &&
+	git push --all "hg::remote://${ROOT}/empty") &&
+	(cd empty &&
+	hg up tip) &&
+	vcs_cmp localclone empty
+'
+
+test_expect_success 'pushing to local repo' '
+	(cd localclone &&
+	echo content >>file &&
+	git commit -a -m three &&
+	git push) &&
+	(cd server &&
+	hg up tip) &&
+	vcs_cmp localclone server
+'
+
+test_expect_success 'synch with changes from localclone' '
+	(cd clone &&
+	 git pull)
+'
+
+test_expect_success 'pushing remote local repo' '
+	(cd clone &&
+	echo content >>file &&
+	git commit -a -m four &&
+	git push) &&
+	(cd server &&
+	hg up tip) &&
+	vcs_cmp clone server
+'
+
+test_expect_success 'creating new branch' '
+	(cd public &&
+	hg branch different-branch &&
+	echo different >> file &&
+	hg commit -m five &&
+	hg push -f)
+'
+
+test_expect_success 'pull in new branch to local repository' '
+	(cd localclone &&
+	git fetch origin default &&
+	test_must_fail git rev-parse -q --verify refs/remotes/origin/different-branch &&
+	git fetch &&
+	git rev-parse --no-revs --verify refs/remotes/origin/different-branch)
+'
+
+test_expect_success 'pull in new branch to remote repository' '
+	(cd clone &&
+	git fetch origin default &&
+	test_must_fail git rev-parse -q --verify refs/remotes/origin/different-branch &&
+	git fetch &&
+	git rev-parse --no-revs --verify refs/remotes/origin/different-branch)
+'
+
+test_done
-- 
1.8.0.rc2.7.g0961fdf.dirty
