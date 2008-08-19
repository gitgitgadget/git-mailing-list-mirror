From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI] Work around sed issues
Date: Mon, 18 Aug 2008 19:18:49 -0500
Message-ID: <RJmd_We0BRt641swOemkgHiaYcXguvcn3HcZHHGRLDm-254BgNjVCw@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEx2-0006Tn-My
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbYHSASw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbYHSASw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:18:52 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39944 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYHSASv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:18:51 -0400
Received: by mail.nrlssc.navy.mil id m7J0IoZK001258; Mon, 18 Aug 2008 19:18:50 -0500
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Aug 2008 00:18:49.0882 (UTC) FILETIME=[27594FA0:01C90191]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92788>


/usr/xpg4/bin/sed exits non-zero if the sed script is not newline
terminated. /bin/sed does not have this problem, so use it instead
where possible.

But, /bin/sed does not handle tab correctly. For this case in t4200,
rework the test so that the exit status of sed does not affect the
outcome of the test, and use /usr/xpg4/bin/sed (which is in the PATH).

---
 t/annotate-tests.sh            |    2 +-
 t/t4118-apply-empty-context.sh |    2 +-
 t/t4200-rerere.sh              |    5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index cacb273..14ee531 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -114,7 +114,7 @@ test_expect_success \
 test_expect_success \
     'some edit' \
     'mv file file.orig &&
-    sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" < file.orig > file &&
+    /bin/sed -e "s/^3A/99/" -e "/^1A/d" -e "/^incomplete/d" < file.orig > file &&
     echo "incomplete" | tr -d "\\012" >>file &&
     GIT_AUTHOR_NAME="D" git commit -a -m "edit"'
 
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index f92e259..c064f7b 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 	cat file2 >file2.orig
 	git add file1 file2 &&
 	sed -e "/^B/d" <file1.orig >file1 &&
-	sed -e "/^[BQ]/d" <file2.orig >file2 &&
+	/bin/sed -e "/^[BQ]/d" <file2.orig >file2 &&
 	echo Q | tr -d "\\012" >>file2 &&
 	cat file1 >file1.mods &&
 	cat file2 >file2.mods &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b68ab11..834f52f 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -189,8 +189,9 @@ test_expect_success 'file2 added differently in two branches' '
 	echo Bello > file2 &&
 	git add file2 &&
 	git commit -m version2 &&
-	test_must_fail git merge fourth &&
-	sha1=$(sed -e "s/	.*//" .git/MERGE_RR) &&
+	test_must_fail git merge fourth || return 1
+	sha1=$(sed -e "s/	.*//" .git/MERGE_RR)
+	test -n "$sha1" &&
 	rr=.git/rr-cache/$sha1 &&
 	echo Cello > file2 &&
 	git add file2 &&
-- 
1.6.0.11.gecc7e
