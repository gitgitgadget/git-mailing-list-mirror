From: Junio C Hamano <gitster@pobox.com>
Subject: Teach read-tree 2-way merge to ignore intermediate symlinks
Date: Thu, 12 Jul 2007 01:04:16 -0700
Message-ID: <7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
References: <20070704203541.GA13286@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 10:04:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8tf1-00064V-WA
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 10:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbXGLIEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 04:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbXGLIEW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 04:04:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55995 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbXGLIES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 04:04:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712080418.MSRZ1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Jul 2007 04:04:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NY4G1X0071kojtg0000000; Thu, 12 Jul 2007 04:04:16 -0400
In-Reply-To: <20070704203541.GA13286@artemis.corp> (Pierre Habouzit's message
	of "Wed, 4 Jul 2007 22:35:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52257>

Earlier in 16a4c61, we taught "read-tree -m -u" not to be
confused when switching from a branch that has a path frotz/filfre
to another branch that has a symlink frotz that points at xyzzy/
directory.  The fix was incomplete in that it was still confused
when coming back (i.e. switching from a branch with frotz -> xyzzy/
to another branch with frotz/filfre).

This fix is rather expensive in that for a path that is created
we would need to see if any of the leading component of that
path exists as a symbolic link in the filesystem (in which case,
we know that path itself does not exist, and the fact we already
decided to check it out tells us that in the index we already
know that symbolic link is going away as there is no D/F
conflict).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Re: [BUG (or misfeature?)] git checkout and symlinks

  Pierre Habouzit <madcoder@debian.org> writes:

  >   if in a branch [branch1] you track the file: dir1/file1.c
  > and in the branch [branch2] you track elsewhere/file1.c and dir1 be
  > symlink on elsewhere, then it's not possible to checkout the branch
  > [branch1] if your previous checkout was [branch2]. You have to manually
  > remove the symlink `dir1` else git complains that checkouting branch1
  > would overwrite dir1/file1.c.
  >
  >   I'm not sure how to fix this, and it's quite painful actually :)

  We probably could add a path buffer to cache the last look-up
  made by has_symlink_leading_path(), like the other caller
  does, but this is to give the fix a wider exposure and testing
  early.

 t/t2007-checkout-symlink.sh |   50 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c              |    3 ++
 2 files changed, 53 insertions(+), 0 deletions(-)
 create mode 100755 t/t2007-checkout-symlink.sh

diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
new file mode 100755
index 0000000..0526fce
--- /dev/null
+++ b/t/t2007-checkout-symlink.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Junio C Hamano
+
+test_description='git checkout to switch between branches with symlink<->dir'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	mkdir frotz &&
+	echo hello >frotz/filfre &&
+	git add frotz/filfre &&
+	test_tick &&
+	git commit -m "master has file frotz/filfre" &&
+
+	git branch side &&
+
+	echo goodbye >nitfol &&
+	git add nitfol
+	test_tick &&
+	git commit -m "master adds file nitfol" &&
+
+	git checkout side &&
+
+	git rm --cached frotz/filfre &&
+	mv frotz xyzzy &&
+	ln -s xyzzy frotz &&
+	git add xyzzy/filfre frotz &&
+	test_tick &&
+	git commit -m "side moves frotz/ to xyzzy/ and adds frotz->xyzzy/"
+
+'
+
+test_expect_success 'switch from symlink to dir' '
+
+	git checkout master
+
+'
+
+rm -fr frotz xyzzy nitfol &&
+git checkout -f master || exit
+
+test_expect_success 'switch from dir to symlink' '
+
+	git checkout side
+
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index cac2411..89dd279 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -495,6 +495,9 @@ static void verify_absent(const char *path, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return;
 
+	if (has_symlink_leading_path(path, NULL))
+		return;
+
 	if (!lstat(path, &st)) {
 		int cnt;
 
