From: Max Horn <max@quendi.de>
Subject: [PATCH] remote-hg: fix handling of file perms when pushing
Date: Tue, 15 Jan 2013 14:02:39 +0100
Message-ID: <1358254959-50435-1-git-send-email-max@quendi.de>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 14:03:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv6Ag-0006AN-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 14:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab3AONC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 08:02:57 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:52112 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756245Ab3AONC4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 08:02:56 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1Tv6AH-0002kg-Kv; Tue, 15 Jan 2013 14:02:53 +0100
X-Mailer: git-send-email 1.8.1.448.g79c577a.dirty
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1358254976;d98a47fc;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213632>

Previously, when changing and committing an executable file, the file
would loose its executable bit on the hg side. Likewise, symlinks ended
up as "normal" files". This was not immediately apparent on the git side
unless one did a fresh clone.
---
 contrib/remote-helpers/git-remote-hg     |  2 +-
 contrib/remote-helpers/test-hg-hg-git.sh | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 7c74d8b..328c2dc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -53,7 +53,7 @@ def gittz(tz):
     return '%+03d%02d' % (-tz / 3600, -tz % 3600 / 60)
 
 def hgmode(mode):
-    m = { '0100755': 'x', '0120000': 'l' }
+    m = { '100755': 'x', '120000': 'l' }
     return m.get(mode, '')
 
 def get_config(config):
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 3e76d9f..7e3967f 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -109,6 +109,74 @@ setup () {
 
 setup
 
+test_expect_success 'executable bit' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	chmod 0644 alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	chmod 0755 alpha &&
+	git add alpha &&
+	git commit -m "set executable bit" &&
+	chmod 0644 alpha &&
+	git add alpha &&
+	git commit -m "clear executable bit"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -r 1 -v &&
+		hg manifest -v
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+	cp -r log-* output-* /tmp/foo/ &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
+test_expect_success 'symlink' '
+	mkdir -p tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	(
+	git init -q gitrepo &&
+	cd gitrepo &&
+	echo alpha > alpha &&
+	git add alpha &&
+	git commit -m "add alpha" &&
+	ln -s alpha beta &&
+	git add beta &&
+	git commit -m "add beta"
+	) &&
+
+	for x in hg git; do
+		(
+		hg_clone_$x gitrepo hgrepo-$x &&
+		cd hgrepo-$x &&
+		hg_log . &&
+		hg manifest -v
+		) > output-$x &&
+
+		git_clone_$x hgrepo-$x gitrepo2-$x &&
+		git_log gitrepo2-$x > log-$x
+	done &&
+
+	test_cmp output-hg output-git &&
+	test_cmp log-hg log-git
+'
+
 test_expect_success 'merge conflict 1' '
 	mkdir -p tmp && cd tmp &&
 	test_when_finished "cd .. && rm -rf tmp" &&
-- 
1.8.1.448.g79c577a.dirty
