From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 3/3] Add t/t7401 - test submodule interaction with remotes machinery
Date: Sat,  9 Feb 2008 11:57:25 -0500
Message-ID: <1202576245-284-3-git-send-email-mlevedahl@gmail.com>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
 <1202576245-284-2-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 17:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNt1n-0008P7-18
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 17:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbYBIQ5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 11:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbYBIQ5i
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 11:57:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:54407 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbYBIQ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 11:57:36 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4336359wxd.4
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 08:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lT1u5z6u3bXly3NkSLy76WqryF/pQLRMwacgXAYhojE=;
        b=f3e+2bsjWxVAxTu/YfgmgZ6UwWat6zLNWIXpM2QmoIb4P9zBC6uTDG/71zq19fQt0+Z29Bji4bBUPzgWmql4wWBdSBUmLdRL/JAuo6lDF814De4pSzlxIqtP7RxbsQchsWSOBssZB3psPRLKWS2ZKK7bc35svypI74msybinb0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CQmTkYUAKdXZ3i89U9E478j4NsdliDq2zkpaCfXvJaUCzLfgqI8eoy3wKn+GDngp7LnD3x3/c8+y5aLdLeufZ4ZqUXlgP5ayHzTJV2NCTem4g+psZWWTF7Ma3W4/HwIEIJqfaJpf83Hf5U4Rohs3LoHrTrGhiku0LxCPQsaV2O8=
Received: by 10.70.118.4 with SMTP id q4mr9041723wxc.9.1202576255787;
        Sat, 09 Feb 2008 08:57:35 -0800 (PST)
Received: from localhost.localdomain ( [71.163.29.241])
        by mx.google.com with ESMTPS id h38sm5351828wxd.15.2008.02.09.08.57.33
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 08:57:34 -0800 (PST)
X-Mailer: git-send-email 1.5.4.47.gcca7b3
In-Reply-To: <1202576245-284-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73241>

This adds a sequence of tests to assure that the following two sequences
work:

	git clone -o frotz <someurl> foo
	cd foo
	git submodule init
	git submodule update

This should result in the top-level project and subproject having "frotz"
as the only defined remote, and should succeed with the
branch.<name>.remote mechanism supplying frotz as the remote.

Then, in the same working directory
	git remote add fork <some url>
	git fetch fork
	git checkout --track -b fork fork/<somebranch>
	git submodule init
	git submodule update

will retrive new submodules from remote "fork", and define fork in the
existing modules.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/t7401-submodule-remote.sh |  118 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100755 t/t7401-submodule-remote.sh

diff --git a/t/t7401-submodule-remote.sh b/t/t7401-submodule-remote.sh
new file mode 100755
index 0000000..e5bef27
--- /dev/null
+++ b/t/t7401-submodule-remote.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='Porcelain support for submodules with multiple remotes
+
+This test verifies operation of submodules using multiple remotes and
+differing remote per top-level branch.  This includes ability to follow
+the top-level remote.<branch>, and to propagate definition of new remotes
+down to submodules as needed.'
+
+. ./test-lib.sh
+
+# the standard tests all work with one repo, but we need several..
+rm -rf .git
+
+test_expect_success 'Prepare master repository with 1 submodule' '
+	(
+	mkdir master &&
+	cd master &&
+	git init &&
+	echo "on master" > master.txt &&
+	git add master.txt &&
+	git commit -m "Add master.txt" &&
+	mkdir submod1 &&
+	cd submod1 &&
+	git init &&
+	echo "submod1" > submod1.txt &&
+	git add submod1.txt &&
+	git commit -m "Added submod1.txt" &&
+	cd .. &&
+	git submodule add ./submod1 submod1 &&
+	git commit -m "Added submodule submod1"
+	)
+'
+
+test_expect_success 'Clone master as fork' '
+	(
+	git clone master fork &&
+	cd fork &&
+	test "$(git remote)" = "origin" &&
+	git submodule init &&
+	git submodule update &&
+	test -e submod1/.git
+	)
+'
+
+test_expect_success 'Add second submodule in fork' '
+	(
+	cd fork &&
+	mkdir submod2 &&
+	cd submod2 &&
+	git init &&
+	echo "submod2" > submod2.txt &&
+	git add submod2.txt &&
+	git commit -m "Added submod2.txt" &&
+	cd .. &&
+	git submodule add ./submod2 submod2 &&
+	git commit -m "Added submodule submod2 on fork"
+	)
+'
+
+test_expect_success 'Clone master using frotz instead of origin' '
+	(
+	git clone -o frotz master worker &&
+	cd worker &&
+	test "$(git remote)" = "frotz"
+	)
+'
+
+test_expect_success 'Get submodules using frotz instead of origin' '
+	(
+	cd worker &&
+	git submodule init &&
+	git submodule update &&
+	test -e submod1/.git &&
+	cd submod1 &&
+	test "$(git remote)" = "frotz"
+	)
+'
+
+test_expect_success 'submodule update fails on detached head' '
+	(
+	cd worker &&
+	git checkout $(git rev-parse HEAD) &&
+	! git submodule update
+	)
+'
+
+test_expect_success 'submodule update -r remote succeeds on detached head' '
+	(
+	cd worker &&
+	git checkout $(git rev-parse HEAD) &&
+	git submodule update -r frotz
+	)
+'
+
+test_expect_success 'Update using fork to get additional submodule' '
+	(
+	cd worker &&
+	git remote add fork $(pwd)/../fork &&
+	git fetch fork &&
+	git checkout --track -b fork_master fork/master &&
+	git submodule init &&
+	git submodule update &&
+	test -e submod2/.git &&
+	cd submod2 &&
+	test "$(git remote)" = "fork" &&
+	cd ../submod1 &&
+	remotes1=$(git remote) &&
+	case $remotes1 in
+		fork*frotz|frotz*fork)
+			true ;;
+		*)
+			false ;;
+	esac
+	)
+'
+
+test_done
-- 
1.5.4.47.gcca7b3
