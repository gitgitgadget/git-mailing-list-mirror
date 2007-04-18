From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix overwriting of files when applying contextually independent diffs
Date: Wed, 18 Apr 2007 23:58:56 +0200
Message-ID: <20070418215856.GA2477@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 23:59:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeIBB-0007az-9W
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbXDRV7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbXDRV7B
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:59:01 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:62170 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbXDRV7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 17:59:00 -0400
Received: from tigra.home (Fca1e.f.strato-dslnet.de [195.4.202.30])
	by post.webmailer.de (mrclete mo18) (RZmta 5.5)
	with ESMTP id F000bej3IKDOWb ; Wed, 18 Apr 2007 23:58:57 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 93FEB277BD;
	Wed, 18 Apr 2007 23:58:57 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1F549BDDE; Wed, 18 Apr 2007 23:58:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl6Sg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44955>

Noticed by applying two diffs of different contexts to the same file.

The check for existence of a file was wrong: the test assumed it was
a directory and reset the errno (twice: directly and by calling
lstat). So if an entry existed and was _not_ a directory no attempt
was made to rename into it, because the errno (expected by renaming
code) was already reset to 0. This resulted in error:

    fatal: unable to write file file mode 100644

For Linux, removing "errno = 0" is enough, as lstat wont modify errno
if it was successful. The behavior should not be depended upon,
though, so modify the "if" as well.

The test simulates this situation.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Found it. Somewhat unusual situation, I admit, but splitting
patches just to apply them would be too annoying. GNU patch
accepts such patches too, not even a warning.

 builtin-apply.c        |    3 +--
 t/t4121-apply-diffs.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)
 create mode 100755 t/t4121-apply-diffs.sh

diff --git a/builtin-apply.c b/builtin-apply.c
index fd92ef7..94311e7 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2416,8 +2416,7 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 		 * used to be.
 		 */
 		struct stat st;
-		errno = 0;
-		if (!lstat(path, &st) && S_ISDIR(st.st_mode) && !rmdir(path))
+		if (!lstat(path, &st) && (!S_ISDIR(st.st_mode) || !rmdir(path)))
 			errno = EEXIST;
 	}
 
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
new file mode 100755
index 0000000..2b2f1ed
--- /dev/null
+++ b/t/t4121-apply-diffs.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='git-apply for contextually independent diffs'
+. ./test-lib.sh
+
+echo '1
+2
+3
+4
+5
+6
+7
+8' >file
+
+test_expect_success 'setup' \
+	'git add file &&
+	git commit -q -m 1 &&
+	git checkout -b test &&
+	mv file file.tmp &&
+	echo 0 >file &&
+	cat file.tmp >>file &&
+	rm file.tmp &&
+	git commit -a -q -m 2 &&
+	echo 9 >>file &&
+	git commit -a -q -m 3 &&
+	git checkout master'
+
+test_expect_success \
+	'check if contextually independent diffs for the same file apply' \
+	'( git diff test~2 test~1; git diff test~1 test~0 )| git apply'
+
+test_done
+
-- 
1.5.1.1.876.ge36f76
