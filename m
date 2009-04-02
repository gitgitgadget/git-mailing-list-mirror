From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Fix 'git checkout <submodule>' to update the index
Date: Thu, 2 Apr 2009 15:30:25 +0200 (CEST)
Message-ID: <c267451c12c4ead4c222eebe6df460b46edd59c1.1238678601u.git.johannes.schindelin@gmx.de>
References: <cover.1238678601u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 15:32:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpN1Z-0000OH-PB
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 15:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZDBNad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 09:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbZDBNac
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 09:30:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:34757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbZDBNab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 09:30:31 -0400
Received: (qmail invoked by alias); 02 Apr 2009 13:30:28 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp037) with SMTP; 02 Apr 2009 15:30:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RKtsCY6UR1vlBNCwpeS3yTb0nHdedh1tm8onuio
	2Qua6FOG9WXTyn
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1238678601u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115463>

While 'git checkout <submodule>' should not update the submodule's
working directory, it should update the index.  This is in line with
how submodules are handled in the rest of Git.

While at it, test 'git reset [<commit>] <submodule>', too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have no idea who thought that it would be a good idea to leave 
	the submodules alone, but I think it is highly counterintuitive 
	that

		git checkout <submodule>

	does not touch the index.

	This patch fixes it.

	I'm really swamped with work these days, but happily, this fix was 
	part of it: one of my users had a merge conflict in a submodule 
	and wanted to use the same procedure as for files.

	In the meantime, "git reset <submodule>" did the job, but this 
	rather limits the user's options:

		git checkout --theirs <submodule>

	is a much desired function here.  (Note: I did not test that this 
	works, actually, but then, I do not see why it should not, after
	this patch...)

 builtin-checkout.c            |    3 --
 t/t2013-checkout-submodule.sh |   42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)
 create mode 100755 t/t2013-checkout-submodule.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 33d1fec..2e4fe1a 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -53,9 +53,6 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	int len;
 	struct cache_entry *ce;
 
-	if (S_ISGITLINK(mode))
-		return 0;
-
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
new file mode 100755
index 0000000..fda3f0a
--- /dev/null
+++ b/t/t2013-checkout-submodule.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='checkout can handle submodules'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir submodule &&
+	(cd submodule &&
+	 git init &&
+	 test_commit first) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m superproject &&
+	(cd submodule &&
+	 test_commit second) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m updated.superproject
+'
+
+test_expect_success '"reset <submodule>" updates the index' '
+	git update-index --refresh &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	test_must_fail git reset HEAD^ submodule &&
+	test_must_fail git diff-files --quiet &&
+	git reset submodule &&
+	git diff-files --quiet
+'
+
+test_expect_success '"checkout <submodule>" updates the index only' '
+	git update-index --refresh &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout HEAD^ submodule &&
+	test_must_fail git diff-files --quiet &&
+	git checkout HEAD submodule &&
+	git diff-files --quiet
+'
+
+test_done
-- 
1.6.2.1.493.g67cf3
