From: BJ Hargrave <bj@bjhargrave.com>
Subject: [PATCH] Support empty blob in fsck --lost-found
Date: Sun, 11 Sep 2011 11:40:28 -0400
Message-ID: <A3964281-B24B-46C0-AE73-0CCB4C12556F@bjhargrave.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 17:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2m97-0004Nk-Mz
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 17:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab1IKPkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 11:40:33 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:60872 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1IKPkc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 11:40:32 -0400
Received: by gwb17 with SMTP id 17so3218617gwb.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 08:40:31 -0700 (PDT)
Received: by 10.236.9.105 with SMTP id 69mr21726627yhs.41.1315755631777;
        Sun, 11 Sep 2011 08:40:31 -0700 (PDT)
Received: from macbookpro2.hargrave.local (106.27.205.68.cfl.res.rr.com [68.205.27.106])
        by mx.google.com with ESMTPS id z24sm11785536yhj.5.2011.09.11.08.40.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Sep 2011 08:40:30 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181175>

fsck --lost-found died when attempting to write out the empty blob.
Avoid calling fwrite when the blob size is zero since the call to
fwrite returns 0 objects written which fails the check and caused
fsck to die.

Signed-off-by: BJ Hargrave <bj@bjhargrave.com>
---
 builtin/fsck.c        |    7 ++++---
 t/t1420-lost-found.sh |   13 ++++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5ae0366..ad6d713 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -232,9 +232,10 @@ static void check_unreachable_object(struct object *obj)
 				char *buf = read_sha1_file(obj->sha1,
 						&type, &size);
 				if (buf) {
-					if (fwrite(buf, size, 1, f) != 1)
-						die_errno("Could not write '%s'",
-							  filename);
+					if (size > 0)
+						if (fwrite(buf, size, 1, f) != 1)
+							die_errno("Could not write '%s'",
+								  filename);
 					free(buf);
 				}
 			} else
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index dc9e402..02323c9 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -8,7 +8,7 @@ test_description='Test fsck --lost-found'
 
 test_expect_success setup '
 	git config core.logAllRefUpdates 0 &&
-	: > file1 &&
+	echo x > file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit -m initial &&
@@ -18,18 +18,21 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m second &&
 	echo 3 > file3 &&
-	git add file3
+	: > file4 &&
+	git add file3 file4
 '
 
 test_expect_success 'lost and found something' '
 	git rev-parse HEAD > lost-commit &&
-	git rev-parse :file3 > lost-other &&
+	git rev-parse :file3 > lost-other3 &&
+	git rev-parse :file4 > lost-other4 &&
 	test_tick &&
 	git reset --hard HEAD^ &&
 	git fsck --lost-found &&
-	test 2 = $(ls .git/lost-found/*/* | wc -l) &&
+	test 3 = $(ls .git/lost-found/*/* | wc -l) &&
 	test -f .git/lost-found/commit/$(cat lost-commit) &&
-	test -f .git/lost-found/other/$(cat lost-other)
+	test -f .git/lost-found/other/$(cat lost-other3) &&
+	test -f .git/lost-found/other/$(cat lost-other4)
 '
 
 test_done
-- 
1.7.6.2
