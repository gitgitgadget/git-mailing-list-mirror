From: Max Horn <max@quendi.de>
Subject: [PATCH v3] remote-hg: do not fail on invalid bookmarks
Date: Fri, 21 Mar 2014 12:36:36 +0100
Message-ID: <A4F451CA-D1DE-43A9-A4DA-23594C08C4DD@quendi.de>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 12:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQxki-0007vH-2s
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 12:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965372AbaCULgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 07:36:40 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:33038 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965328AbaCULgj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 07:36:39 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQxkX-0000sl-NT; Fri, 21 Mar 2014 12:36:33 +0100
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395401799;db756438;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244685>

Mercurial can have bookmarks pointing to "nullid" (the empty root
revision), while Git can not have references to it. When cloning or
fetching from a Mercurial repository that has such a bookmark, the
import failed because git-remote-hg was not be able to create the
corresponding reference.

Warn the user about the invalid reference, and do not advertise these
bookmarks as head refs, but otherwise continue the import. In
particular, we still keep track of the fact that the remote repository
has a bookmark of the given name, in case the user wants to modify that
bookmark.

Also add some test cases for this issue.

Reported-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Max Horn <max@quendi.de>
---
This is a different fix than in my previous attempts. I thought
a bit more about the issue, and determined that the previous fix,
while working, was not really correct: It is wrong to
treat nullid bookmarks as if they are non-existent; if e.g.
the user wants to modify the bookmark from git, we need to
into account that the remote already has a bookmark with that name.
Indeed, I extended the new test cases to cover this aspect.
With the previous fix, the new tests would fail upon pushing,
with the new one, they work.

 contrib/remote-helpers/git-remote-hg |  5 ++-
 contrib/remote-helpers/test-hg.sh    | 67 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index eb89ef6..36b5261 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -643,7 +643,10 @@ def do_list(parser):
             print "? refs/heads/branches/%s" % gitref(branch)
 
     for bmark in bmarks:
-        print "? refs/heads/%s" % gitref(bmark)
+        if  bmarks[bmark].hex() == '0000000000000000000000000000000000000000':
+            warn("Ignoring invalid bookmark '%s'", bmark)
+        else:
+            print "? refs/heads/%s" % gitref(bmark)
 
     for tag, node in repo.tagslist():
         if tag == 'tip':
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index a933b1e..f5d0d97 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -772,4 +772,71 @@ test_expect_success 'remote double failed push' '
 	)
 '
 
+test_expect_success 'clone remote with master null bookmark, then push to the bookmark' '
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
+	check gitrepo HEAD a &&
+	cd gitrepo &&
+	git checkout --quiet -b master &&
+	echo b >b &&
+	git add b &&
+	git commit -m b &&
+	git push origin master
+'
+
+test_expect_success 'clone remote with default null bookmark, then push to the bookmark' '
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
+	check gitrepo HEAD a &&
+	cd gitrepo &&
+	git checkout --quiet -b default &&
+	echo b >b &&
+	git add b &&
+	git commit -m b &&
+	git push origin default
+'
+
+test_expect_success 'clone remote with generic null bookmark, then push to the bookmark' '
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
+	check gitrepo HEAD a &&
+	cd gitrepo &&
+	git checkout --quiet -b bmark &&
+	git remote -v &&
+	echo b >b &&
+	git add b &&
+	git commit -m b &&
+	git push origin bmark
+'
+
 test_done
-- 
1.9.0.7.ga299b13
