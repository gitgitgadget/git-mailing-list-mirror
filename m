From: Rob Hoelz <rob@hoelz.ro>
Subject: [PATCH] remote.<name>.pushurl does not consider aliases when
 pushing
Date: Sun, 17 Mar 2013 22:40:02 +0100
Message-ID: <20130317224002.366f54f7@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: josh@joshtriplett.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 17 22:48:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHLQq-0003t3-Jf
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 22:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab3CQVr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 17:47:29 -0400
Received: from hoelz.ro ([66.228.44.67]:53381 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476Ab3CQVr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 17:47:28 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Mar 2013 17:47:28 EDT
Received: from localhost.localdomain (g95115.upc-g.chello.nl [80.57.95.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id 21BD1280F2;
	Sun, 17 Mar 2013 17:40:06 -0400 (EDT)
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218374>

Hi everyone!  I found a bug in Git today and wrote up a fix; I did my best to conform to the rules layed out in Documentation/SubmittingPatches, but please let me know if I need to change anything to get my work merged. =)  I have CC'ed Josh Triplet, as
he was the last one to touch the line I modified.  I hope my commit messages explain the problem I encountered well enough; if not,
I can always go back and amend them.

Patches follow.

-Rob

>From 5007b11e86c0835807632cb41e6cfa75ce9a1aa1 Mon Sep 17 00:00:00 2001
From: Rob Hoelz <rob@hoelz.ro>
Date: Sun, 17 Mar 2013 21:49:20 +0100
Subject: [PATCH 1/2] Add test for pushInsteadOf + pushurl

git push currently doesn't consider pushInsteadOf when
using pushurl; this test tests that.

Signed-off-by: Rob Hoelz <rob@hoelz.ro>
---
 t/t5500-push-pushurl.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 t/t5500-push-pushurl.sh

diff --git a/t/t5500-push-pushurl.sh b/t/t5500-push-pushurl.sh
new file mode 100644
index 0000000..74d4ff6
--- /dev/null
+++ b/t/t5500-push-pushurl.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2013 Rob Hoelz
+#
+
+test_description='Test that remote.<name>.pushurl uses pushInsteadOf'
+. ./test-lib.sh
+
+wd=$(pwd)
+test_expect_success 'setup test repositories' '
+	mkdir ro &&
+	mkdir rw &&
+
+	git init --bare ro/repo &&
+	git init --bare rw/repo &&
+	git init test-repo
+'
+
+test_expect_success 'setup remote config' "
+	cd test-repo &&
+	git config 'url.file://$wd/ro/.insteadOf' herero: &&
+	git config 'url.file://$wd/rw/.pushInsteadOf' hererw: &&
+	git remote add origin herero:repo &&
+	git config remote.origin.pushurl hererw:repo
+"
+
+test_expect_success 'test commit and push' '
+	test_commit one &&
+	git push origin master:master
+'
+
+test_expect_success 'check for commits in rw repo' '
+	cd ../rw/repo &&
+	git log --pretty=oneline | grep -q .
+'
+
+test_done
-- 
1.8.2

>From 0cbd1aab6bdc0c2f8893ed8b9a8e3eb0126917d1 Mon Sep 17 00:00:00 2001
From: Rob Hoelz <rob@hoelz.ro>
Date: Sun, 17 Mar 2013 16:34:35 +0100
Subject: [PATCH 2/2] push: Alias pushurl from push rewrites

If you use pushurl with an alias that has a pushInsteadOf configuration
value, Git does not take advantage of it.  For example:

[url "git://github.com/"]
    insteadOf = github:
[url "git://github.com/myuser/"]
    insteadOf = mygithub:
[url "git@github.com:myuser/"]
    pushInsteadOf = mygithub:
[remote "origin"]
    url     = github:organization/project
    pushurl = mygithub:project

This commit fixes that.

Signed-off-by: Rob Hoelz <rob@hoelz.ro>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index ca1f8f2..de7a915 100644
--- a/remote.c
+++ b/remote.c
@@ -465,7 +465,7 @@ static void alias_all_urls(void)
 		if (!remotes[i])
 			continue;
 		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
-			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites);
+			remotes[i]->pushurl[j] = alias_url(remotes[i]->pushurl[j], &rewrites_push);
 		}
 		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
 		for (j = 0; j < remotes[i]->url_nr; j++) {
-- 
1.8.2
