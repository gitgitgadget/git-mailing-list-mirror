From: Steffen Prohaska <prohaska@zib.de>
Subject: .gittattributes handling has deficiencies
Date: Sun, 21 Oct 2007 10:48:55 +0200
Message-ID: <1192956535617-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Oct 21 10:50:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjWVV-00039P-JM
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 10:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXJUIts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 04:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbXJUItr
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 04:49:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:58438 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbXJUItq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 04:49:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9L8mu90022608
	for <git@vger.kernel.org>; Sun, 21 Oct 2007 10:49:44 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9L8mtv8017531;
	Sun, 21 Oct 2007 10:48:56 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61888>

If a .gitattributes is in the work tree and we checkout a
different head, the .gitattributes of the head we are switching
to must have precedence. Files are expected to be converted as
configured in the .gitattributes that is available in the head
we're switching to.

This adds a test case revealing deficiencies of the current
handling of .gitattributes.

At a first glance, I saw two possible resolutions:
1) .gitattributes from the index has precedence. It's unclear
   how merging can be handled appropriately.
2) .gitattributes are handled as a special file. Checkout is a
   two pass process. In the first pass only the special file
   .gitattributes is checked out. In th second pass the remaining
   files are added. Maybe this gives a perspective how to handle
   merges.

But actually the issue is much harder to solve.

Here is what needs to be done: Whenever the attributes of a file
change the file must be freshly checked out according to the
attributes of the head we switch to. The file itself does not
necessarily change between the two commits. A fresh checkout is
already needed if only .gitattributes change.

But this is really hard to solve. We would need to compare
attributes before and after for _all_ files that have attributes
in one of the two commits and check if they changed. If so, we
need to do a fresh checkout according to the new attributes.

Maybe the gitattributes of a file should be part of the per-file
flags in the index. Thus we could verify if the flags changed and
if so, adjust the work tree accordig to the new flags.  I'm
lacking a deeper insight into the git internals.  Therefore, I
can't really say if the index is the right place.  But it looks
to me as if changing an attribute should be treated similar to a
changing sha1, as far as the work tree is concerned.

So, I need some help.
    Steffen

---
 t/t0020-crlf.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 62bc4bb..5d7e033 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -371,6 +371,29 @@ test_expect_success 'in-tree .gitattributes (4)' '
 	}
 '
 
+test_expect_success 'in-tree .gitattributes (5)' '
+
+	git reset --hard master &&
+	echo >.gitattributes &&
+	git add .gitattributes &&
+	git commit -m "empty .gitattributes" &&
+	rm -rf tmp one dir .gitattributes patch.file three &&
+	git reset --hard master &&
+	git checkout master^ &&
+
+	if remove_cr one >/dev/null
+	then
+		echo "Eh? one should not have CRLF"
+		false
+	else
+		: happy
+	fi &&
+	remove_cr three >/dev/null || {
+		echo "Eh? three should still have CRLF"
+		false
+	}
+'
+
 test_expect_success 'invalid .gitattributes (must not crash)' '
 
 	echo "three +crlf" >>.gitattributes &&
-- 
1.5.3.mingw.1.138.g7bf9d
