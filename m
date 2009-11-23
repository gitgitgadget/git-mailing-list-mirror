From: "Steven J. Murdoch" <git+Steven.Murdoch@cl.cam.ac.uk>
Subject: git-apply fails on creating a new file, with both -p and
	--directory specified
Date: Mon, 23 Nov 2009 19:45:24 +0000
Message-ID: <20091123194523.GZ15966@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 20:45:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCeqq-00018A-RO
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 20:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbZKWTpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 14:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbZKWTpU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 14:45:20 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:47531 "EHLO mta2.cl.cam.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755294AbZKWTpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 14:45:19 -0500
Received: from alport.cl.cam.ac.uk ([128.232.9.64])
	by mta2.cl.cam.ac.uk with esmtp (Exim 3.092 #1)
	id 1NCeqi-0001ZB-00; Mon, 23 Nov 2009 19:45:24 +0000
Received: from sjm217 by alport.cl.cam.ac.uk with local (Exim 4.69)
	(envelope-from <sjm217@cl.cam.ac.uk>)
	id 1NCeqi-00014x-3j; Mon, 23 Nov 2009 19:45:24 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133530>

While trying to apply a patch from one repository (created by
git-format-patch), to another (using git-am), git fails with:

"fatal: git apply: bad git-diff - inconsistent new filename on line X"

This appears to be because I was both using -p to strip some path
components, and --directory to add different ones in. Only creating
new files was affected.

This was the case in git 1.6.5.2, and also the development version
1.6.6.rc0.15.g4fa80. I have tested this on MacOS X Snow Leopard.

This appears related to the bug discussed in:
  http://marc.info/?l=git&m=122237537312597&w=2
in which the following fix was posted:
  http://git.kernel.org/?p=git/git.git;a=commitdiff;h=969c877506cf8cc760c7b251fef6c5b6850bfc19

I have included a patch below to the test cases, which currently fails
but, if I understand correctly, should succeed.

Steven Murdoch.

-- >8 --
Test git-apply creating a new file, combining --directory and -p flags

Signed-off-by: Steven Murdoch <Steven.Murdoch@cl.cam.ac.uk>
---
 t/t4128-apply-root.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index 8f6aea4..6cc741a 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -58,6 +58,23 @@ test_expect_success 'apply --directory (new file)' '
 '
 
 cat > patch << EOF
+diff --git a/c/newfile2 b/c/newfile2
+new file mode 100644
+index 0000000..d95f3ad
+--- /dev/null
++++ b/c/newfile2
+@@ -0,0 +1 @@
++content
+EOF
+
+test_expect_success 'apply --directory -p (new file)' '
+	git reset --hard initial &&
+	git apply -p2 --directory=some/sub/dir/ --index patch &&
+	test content = $(git show :some/sub/dir/newfile2) &&
+	test content = $(cat some/sub/dir/newfile2)
+'
+
+cat > patch << EOF
 diff --git a/delfile b/delfile
 deleted file mode 100644
 index d95f3ad..0000000
-- 
1.6.5.2

-- 
http://www.cl.cam.ac.uk/users/sjm217/
