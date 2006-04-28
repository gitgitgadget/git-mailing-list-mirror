From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] Add a test case for rerere
Date: Fri, 28 Apr 2006 09:56:05 +0200
Message-ID: <20060428075604.GA30714@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 28 09:57:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZNqd-00071P-VJ
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 09:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWD1H5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 03:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWD1H5E
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 03:57:04 -0400
Received: from www2.levante.de ([212.101.151.130]:42887 "EHLO www.levante.de")
	by vger.kernel.org with ESMTP id S1030311AbWD1H5D (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 03:57:03 -0400
Received: from pd95b6420.dip0.t-ipconnect.de ([217.91.100.32] helo=mail.fsforth.de)
	by www.levante.de with asmtp (Exim 3.36 #1 (Debian))
	id 1FZNqX-0007sr-00
	for <git@vger.kernel.org>; Fri, 28 Apr 2006 09:57:01 +0200
Received: from io.fsforth.de ([192.168.40.169])
	by mail.fsforth.de with esmtp (Exim 4.52)
	id 1FZNqN-000265-6P
	for git@vger.kernel.org; Fri, 28 Apr 2006 09:56:51 +0200
Received: by io.fsforth.de (Postfix, from userid 1080)
	id 6E681E287; Fri, 28 Apr 2006 09:56:05 +0200 (CEST)
To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
X-FS-MailScanner: Found to be clean
X-MailScanner-From: uzeisberger@fsforth.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19267>

Currently this test fails because rerere is not able to record
resolves for a file that don't exist in the merge base but in
both branches to merge.

Signed-off-by: Uwe Zeisberger <Uwe_Zeisberger@digi.com>

---

 t/t8003-rerere.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 t/t8003-rerere.sh

It's the last command that fails because rerere didn't record the
conflict between branch1:file-common and master:file-common.

Please feel free to change the filename as I don't know/see the naming
scheme of the tests.

Best regards
Uwe

ff012a80cafa3fe905de72d0db8b616ff76d0038
diff --git a/t/t8003-rerere.sh b/t/t8003-rerere.sh
new file mode 100644
index 0000000..1bb66ff
--- /dev/null
+++ b/t/t8003-rerere.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='git-rerere'
+. ./test-lib.sh
+
+
+test_expect_success 'prepare repository' \
+'mkdir .git/rr-cache &&
+echo "content" > file-base &&
+git add file-base &&
+git commit -m "Initial commit" &&
+git branch branch &&
+echo "added after branch" >> file-base &&
+echo "added after branch" >> file-common &&
+git add file-common &&
+git commit -m "master1" -i file-base file-common &&
+git checkout branch &&
+echo "added in branch" >> file-base &&
+echo "only in branch" > file-branch &&
+echo "added in branch" >> file-common &&
+git add file-branch file-common &&
+git commit -m "branch1" -i file-base file-branch file-common &&
+git branch branch1'
+
+test_expect_failure 'pull master' \
+'git pull . master'
+
+cat >> file-base-expect << EOF
+content
+<<<<<<< HEAD/file-base
+added in branch
+=======
+added after branch
+>>>>>>> `git rev-parse master`/file-base
+EOF
+
+test_expect_success 'merge result' \
+'cmp file-base file-base-expect &&
+git cat-file blob HEAD:file-common | cmp file-common~HEAD - &&
+git cat-file blob master:file-common | cmp file-common~`git rev-parse master` - &&
+git cat-file blob HEAD:file-branch | cmp file-branch -'
+
+test_expect_success 'record and resolve confilcts' \
+'git rerere &&
+echo "content
+added in branch
+added after branch" > file-base &&
+echo "added in branch
+added after branch" > file-common &&
+git rerere &&
+git-ls-files -o | xargs rm &&
+git commit -m "resolved conflicts" -i file-base file-common file-branch &&
+git-checkout master
+'
+ 
+test_expect_failure 'pull branch1' \
+'git pull . branch1'
+
+test_expect_success 'reuse recorded resolve' \
+'git rerere &&
+git cat-file blob branch:file-branch | cmp file-branch - &&
+git cat-file blob branch:file-base | cmp file-base - &&
+git cat-file blob branch:file-common | cmp file-common -'
+
+test_done
+
-- 
1.3.1.gac92


-- 
Uwe Zeisberger
FS Forth-Systeme GmbH, A Digi International Company
Kueferstrasse 8, D-79206 Breisach, Germany
Phone: +49 (7667) 908 0 Fax: +49 (7667) 908 200
Web: www.fsforth.de, www.digi.com
