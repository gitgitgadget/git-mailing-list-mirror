From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-merge-one-file: fix longstanding stupid thinko
Date: Mon, 17 Mar 2008 17:48:36 -0700
Message-ID: <7vbq5camcb.fsf_-_@gitster.siamese.dyndns.org>
References: <20080316043138.GA7942@kroah.com>
 <7vlk4ganti.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 01:49:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbQ1F-0001tP-An
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 01:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbYCRAsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 20:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbYCRAsy
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 20:48:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbYCRAsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 20:48:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 431652E1B;
	Mon, 17 Mar 2008 20:48:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8DFD42E1A; Mon, 17 Mar 2008 20:48:47 -0400 (EDT)
In-Reply-To: <7vlk4ganti.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 17 Mar 2008 17:16:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77475>

When a merge result creates a new file, and when our side already has a
file in the path, taking the merge result may clobber the untracked file.
However, the logic to detect this situation was totally the wrong way.  We
should complain when the file exists, not when the file does not exist.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is quite an old bug introduced by ed93b44 (merge: loosen
   overcautious "working file will be lost" check., 2006-10-08).  I
   originally wanted to catch the breakage Greg mentioned, but no such
   luck.

 git-merge-one-file.sh       |    5 ++-
 t/t1004-read-tree-m-u-wf.sh |   46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 9ee3f80..e1eb963 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -48,10 +48,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 	;;
 "..$3")
 	echo "Adding $4"
-	test -f "$4" || {
+	if test -f "$4"
+	then
 		echo "ERROR: untracked $4 is overwritten by the merge."
 		exit 1
-	}
+	fi
 	git update-index --add --cacheinfo "$7" "$3" "$4" &&
 		exec git checkout-index -u -f -- "$4"
 	;;
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 9d1371c..283e77c 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -157,4 +157,50 @@ test_expect_success '3-way not overwriting local changes (their side)' '
 
 '
 
+test_expect_success 'D/F setup' '
+
+	git reset --hard &&
+
+	git checkout side-a &&
+	rm -f subdir/file2 &&
+	mkdir subdir/file2 &&
+	echo qfwfq >subdir/file2/another &&
+	git add subdir/file2/another &&
+	test_tick &&
+	git commit -m "side-a changes file2 to directory"
+
+'
+
+test_expect_success 'D/F' '
+
+	git checkout side-b &&
+	git read-tree -m -u branch-point side-b side-a &&
+	git ls-files -u >actual &&
+	(
+		a=$(git rev-parse branch-point:subdir/file2)
+		b=$(git rev-parse side-a:subdir/file2/another)
+		echo "100644 $a 1	subdir/file2"
+		echo "100644 $a 2	subdir/file2"
+		echo "100644 $b 3	subdir/file2/another"
+	) >expect &&
+	test_cmp actual expect
+
+'
+
+test_expect_success 'D/F resolve' '
+
+	git reset --hard &&
+	git checkout side-b &&
+	git merge-resolve branch-point -- side-b side-a
+
+'
+
+test_expect_success 'D/F recursive' '
+
+	git reset --hard &&
+	git checkout side-b &&
+	git merge-recursive branch-point -- side-b side-a
+
+'
+
 test_done
-- 
1.5.5.rc0.122.g8e28f
