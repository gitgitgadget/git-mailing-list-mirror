From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] t9200 - Allow cvs version 1.12
Date: Mon, 15 Jul 2013 16:36:25 -0400
Message-ID: <1373920585-22370-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 22:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UypVm-0001bj-6B
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 22:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab3GOUgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 16:36:32 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:63038 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab3GOUgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 16:36:32 -0400
Received: by mail-qc0-f182.google.com with SMTP id e10so6455455qcy.41
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=truawPXql1A2Wd6UOhIaStR6sy1YVGXMVfr4dWucxQM=;
        b=yYTthndkOCViZGtPCZ4xIvonTltUMLudvaJsBSgbOkyDInnn0DCjwCDdqZB/c3cEuB
         Rh2BOMj0c1nydSnhhcwNm7UB9CPYSusNEz7pGdUHP4g79R4dbiLPMaplE5RsyXi7CWt0
         xrcA9PCBlVNF4DmhVrsIX99VwgioJR2TqdnESaL8zY7IhXMfdvxcP2R2rytqjpXUVwZ8
         5nlue2k3KWOnpmo5WqA3Tc7nrQIxQK5pYBZRRVhAIs172utunbsHvkTDaQLy3gKBjiPY
         7oKQSCO1JuMu5xTdNm6fyDO9RDy+ufHPDA3OdLGGJ5gz8oqKDIPHJzZPKmfVvoKeP/t3
         ZQqA==
X-Received: by 10.49.130.8 with SMTP id oa8mr52793532qeb.87.1373920591340;
        Mon, 15 Jul 2013 13:36:31 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id a8sm58780823qae.11.2013.07.15.13.36.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 13:36:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230522>

cvs v1.12 does not correctly handle "cvs co -d $DIR", which is shorthand
for "mkdir $DIR, cd $DIR, cvs co, cd -". So, use the latter form.

Also cvs v1.12 does not necessarily match cvs v1.11 in the format of
CVS/Entries, and this causes a false failure in subtest 14. Eliminate
checking CVS/Entries for this one test, but keep the test that the
created file exists and is checked out.

With these changes, all tests in t9200 pass on Cygwin using its default
cvs version 1.12.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 3fb3368..17cb554 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -28,7 +28,8 @@ rm -rf "$CVSROOT" "$CVSWORK"
 
 cvs init &&
 test -d "$CVSROOT" &&
-cvs -Q co -d "$CVSWORK" . &&
+mkdir -p "$CVSWORK" &&
+(cd "$CVSWORK" && cvs -Q co .) &&
 echo >empty &&
 git add empty &&
 git commit -q -a -m "Initial" 2>/dev/null ||
@@ -313,7 +314,6 @@ test_expect_success 'commit a file with leading spaces in the name' '
 	git commit -m "Add a file with a leading space" &&
 	id=$(git rev-parse HEAD) &&
 	git cvsexportcommit -w "$CVSWORK" -c $id &&
-	check_entries "$CVSWORK" " space/1.1/|DS/1.1/|attic_gremlin/1.3/|release-notes/1.2/" &&
 	test_cmp "$CVSWORK/ space" " space"
 
 '
-- 
1.8.3.2.0.63
