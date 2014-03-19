From: Max Horn <max@quendi.de>
Subject: [PATCH v2] remote-hg: do not fail on invalid bookmarks
Date: Wed, 19 Mar 2014 22:42:46 +0100
Message-ID: <1395265366-85650-1-git-send-email-max@quendi.de>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 22:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQOGD-0008W6-9h
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 22:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbaCSVms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 17:42:48 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:38049 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754151AbaCSVmr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Mar 2014 17:42:47 -0400
Received: from ip-178-202-253-62.unitymediagroup.de ([178.202.253.62] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQOG6-0005i3-08; Wed, 19 Mar 2014 22:42:46 +0100
X-Mailer: git-send-email 1.9.0.7.ga299b13
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395265367;94409214;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244499>

Mercurial can have bookmarks pointing to "nullid" (the empty root
revision), while Git can not have references to it.
When cloning or fetching from a Mercurial repository that has such a
bookmark, the import will fail because git-remote-hg will not be able to
create the corresponding reference.

Warn the user about the invalid reference, and continue the import,
instead of stopping right away.

Also add some test cases for this issue.

Reported-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Max Horn <max@quendi.de>
---
 contrib/remote-helpers/git-remote-hg |  6 +++++
 contrib/remote-helpers/test-hg.sh    | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index eb89ef6..49b2c2e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -625,6 +625,12 @@ def list_head(repo, cur):
 def do_list(parser):
     repo = parser.repo
     for bmark, node in bookmarks.listbookmarks(repo).iteritems():
+        if node == '0000000000000000000000000000000000000000':
+            if fake_bmark == 'default' and bmark == 'master':
+                pass
+            else:
+                warn("Ignoring invalid bookmark '%s'", bmark)
+                continue
         bmarks[bmark] = repo[node]
 
     cur = repo.dirstate.branch()
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index a933b1e..8d01b32 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -772,4 +772,52 @@ test_expect_success 'remote double failed push' '
 	)
 '
 
+test_expect_success 'clone remote with master null bookmark' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo a >a &&
+	hg add a &&
+	hg commit -m a &&
+	hg bookmark -r null master
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD a
+'
+
+test_expect_success 'clone remote with default null bookmark' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo a >a &&
+	hg add a &&
+	hg commit -m a &&
+	hg bookmark -r null -f default
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD a
+'
+
+test_expect_success 'clone remote with generic null bookmark' '
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo a >a &&
+	hg add a &&
+	hg commit -m a &&
+	hg bookmark -r null bmark
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	check gitrepo HEAD a
+'
+
 test_done
-- 
1.9.0.7.ga299b13
