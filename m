From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH 7/7] Add t/t7401 - test submodule interaction with remotes machinery
Date: Sun,  3 Feb 2008 12:20:49 -0500
Message-ID: <1202059249-3532-8-git-send-email-mlevedahl@gmail.com>
References: <1202059249-3532-1-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-2-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-3-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-4-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-5-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-6-git-send-email-mlevedahl@gmail.com>
 <1202059249-3532-7-git-send-email-mlevedahl@gmail.com>
Cc: git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Sun Feb 03 18:22:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLiXa-00062p-8D
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759164AbYBCRVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759140AbYBCRVV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:21:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:19931 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758903AbYBCRVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:21:17 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1716391fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hbsqVqkERd+h+O5cVgsMW3/vr+ImFlgnKOvaMIHWWcU=;
        b=BCBatu9BWTHDbL7DHvyERYwaQ4iOiQuc6ZW/HQ9DsV8uvjY5Nin9WwcxJJBJN9/+EyTJQRB5JfEU5dfIU4SJsG2ui1v96OkMLNqOzWc1iZHU/wNyesU/s4Yn6UCjPH7L6rOwKzJxNWcf9qPUaoaGw0+d8/Vk+6h8VX9R08FNI7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kkCdVwEzd4saQxXixSQYT2fpA1KE2OZ9qR/tCvGtKvPG+F5XdEa22GYMopaG/VfRpmMsVK5SZphRFJRoWjBhrJnLI1e5CDa58VDSrQXGbT2axZ4bCaU04vI3DfRTpbg7I4EMg33d/oVuOwOHoCtaGDDNaXX6PM3WfI6YAcZ5nPc=
Received: by 10.82.174.20 with SMTP id w20mr11184333bue.21.1202059276225;
        Sun, 03 Feb 2008 09:21:16 -0800 (PST)
Received: from localhost.localdomain ( [71.191.242.88])
        by mx.google.com with ESMTPS id x6sm4293526gvf.0.2008.02.03.09.21.13
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:21:14 -0800 (PST)
X-Mailer: git-send-email 1.5.4.18.g43c18
In-Reply-To: <1202059249-3532-7-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72371>

This adds a sequence of tests to assure that the following two sequences
work:

	git clone -o frotz <someurl> foo
	cd foo
	git submodule init
	git submodule update

This should result in the master and subproject having "frotz" as the
name of the default remote (and origin undefined).

Then, in the same working directory
	git remote add fork <some url>
	git fetch fork
	git checkout --track -b fork fork/<somebranch>
	git submodule init
	git submodule update

will retrive new submodules from remote "fork", and define fork in the
existing modules. Origin remains undefined.

Note: this latter case is a clear motivation for overriding "origin": after
the second test, the various submodules would have different ideas of
remote "origin": these would point to different servers. This would
entirely prevent the top-level branch.<name>.remote machinery from
controlling the project as there is no uniform naming of remotes.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/t7401-submodule-remote.sh |  104 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100755 t/t7401-submodule-remote.sh

diff --git a/t/t7401-submodule-remote.sh b/t/t7401-submodule-remote.sh
new file mode 100755
index 0000000..1a793db
--- /dev/null
+++ b/t/t7401-submodule-remote.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+test_description='Porcelain support for submodules with multiple remotes
+
+This test verifies operation of submodules using multiple remotes and
+differing remote per top-level branch.  This includes ability to name the
+default something other than origin, to follow the top-level
+remote.<branch>, and to propagate definition of new remotes down to
+submodules as needed.
+'
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
1.5.4.18.g43c18
