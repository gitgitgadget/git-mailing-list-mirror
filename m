X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 1/5] git-svn: make test for SVK mirror path import
Date: Tue, 05 Dec 2006 16:17:38 +1100
Message-ID: <20061205051738.16552.8987.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Tue, 5 Dec 2006 05:22:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.10
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33301>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrSlC-0001ly-4E for gcvg-git@gmane.org; Tue, 05 Dec
 2006 06:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967997AbWLEFW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 00:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967636AbWLEFW1
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 00:22:27 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:59223 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937347AbWLEFWY (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 00:22:24 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 656ED139B0C;
 Tue,  5 Dec 2006 18:22:18 +1300 (NZDT)
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

From:  <sam@vilain.net>

A manual test that sets up a repository that looks like an SVK depot,
and then imports it to check that it looks like we mirrored the
'original' source.

There is also a minor modification to the git-svn test library shell
file which sets a variable for the subversion repository's filesystem
path.
---

 t/lib-git-svn.sh                   |    3 -
 t/t9107-git-svn-svk-mirrorpaths.sh |   92 ++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 63c6703..dffd1fb 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -45,6 +45,5 @@ else
 	svnadmin create "$svnrepo"
 fi
 
+rawsvnrepo="$svnrepo"
 svnrepo="file://$svnrepo"
-
-
diff --git a/t/t9107-git-svn-svk-mirrorpaths.sh b/t/t9107-git-svn-svk-mirrorpaths.sh
new file mode 100755
index 0000000..130e786
--- /dev/null
+++ b/t/t9107-git-svn-svk-mirrorpaths.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Eric Wong
+#
+
+test_description='git-svn on SVK mirror paths'
+. ./lib-git-svn.sh
+
+if test -n "$GIT_SVN_NO_LIB" && test "$GIT_SVN_NO_LIB" -ne 0
+then
+	echo 'Skipping: only implemented with SVN libraries'
+	test_done
+	exit 0
+fi
+
+# ok, people who don't have SVK installed probably don't care about
+# this test.
+
+# we set up the repository manually, because even if SVK is installed
+# it is difficult to use it in a way that is idempotent.
+
+# we are not yet testing merge tickets..
+
+uuid=b00bface-b1ff-c0ff-f0ff-b0bafe775e1e 
+url=https://really.slow.server.com/foobar 
+
+test_expect_success 'initialize repo' "
+	echo '#!/bin/sh' > $rawsvnrepo/hooks/pre-revprop-change &&
+	echo 'exit 0' >> $rawsvnrepo/hooks/pre-revprop-change &&
+	chmod +x $rawsvnrepo/hooks/pre-revprop-change &&
+
+	mkdir import &&
+	cd import &&
+	mkdir local &&
+	echo hello > local/readme &&
+	svn import -m 'random local work' . $svnrepo &&
+	cd .. &&
+
+	svn co $svnrepo wc &&
+	cd wc &&
+	mkdir -p mirror/foobar &&
+        svn add mirror &&
+	svn ps svm:source $url mirror/foobar &&
+	svn ps svm:uuid $uuid mirror/foobar &&
+	svn ps svm:mirror mirror/foobar . &&
+	svn commit -m 'setup mirror/foobar as mirror of upstream' &&
+	svn ps -r 2 --revprop svm:headrev $uuid:0 $svnrepo &&
+
+        mkdir mirror/foobar/trunk
+	echo hello, world > mirror/foobar/trunk/readme &&
+	svn add mirror/foobar/trunk &&
+	svn commit -m 'first upstream revision' &&
+	svn ps -r 3 --revprop svm:headrev $uuid:1 $svnrepo &&
+
+	svn up &&
+        svn mkdir mirror/foobar/branches &&
+	svn cp mirror/foobar/trunk mirror/foobar/branches/silly &&
+        svn commit -m 'make branch for silliness' &&
+	svn ps -r 4 --revprop svm:headrev $uuid:2 $svnrepo &&
+
+	svn up &&
+	echo random untested feature >> mirror/foobar/trunk/readme &&
+	svn commit -m 'add a c00l feature to trunk' &&
+	svn ps -r 5 --revprop svm:headrev $uuid:3 $svnrepo &&
+
+	svn up &&
+	echo bug fix >> mirror/foobar/branches/silly/readme &&
+	svn commit -m 'fix a bug' &&
+	svn ps -r 6 --revprop svm:headrev $uuid:4 $svnrepo &&
+
+        svn mkdir mirror/foobar/tags &&
+	svn cp mirror/foobar/branches/silly mirror/foobar/tags/blah-1.0 &&
+        svn commit -m 'make a release' &&
+	svn ps -r 7 --revprop svm:headrev $uuid:5 $svnrepo &&
+
+	cd ..
+	"
+
+test_expect_success 'multi-init an SVK mirror path' "git-svn multi-init -t tags -b branches $svnrepo/mirror/foobar"
+
+test_expect_success 'multi-fetch an SVK mirror path' "git-svn multi-fetch"
+
+test_expect_success 'got tag history OK' "test \`git-log --pretty=oneline remotes/tags/blah-1.0 | wc -l \` = 3"
+
+test_expect_success 're-wrote git-svn-id URL' "git-show HEAD | grep git-svn-id: | fgrep $url"
+test_expect_success 're-wrote git-svn-id UUID' "git-show HEAD | grep git-svn-id: | fgrep $uuid"
+test_expect_success 're-wrote git-svn-id revision' "git-show HEAD | grep git-svn-id: | fgrep '@3'"
+test_expect_success 're-wrote author e-mail domain UUID' "test \`git-show --pretty=fuller HEAD | grep '<.*@.*>' | fgrep $uuid | wc -l\` = 2"
+
+test_debug 'gitk --all &'
+
+test_done
