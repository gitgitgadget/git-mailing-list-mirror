From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/5] t7607: use test_commit and test_must_fail
Date: Sat,  9 Oct 2010 15:52:56 +0200
Message-ID: <1286632380-7002-2-git-send-email-drizzd@aon.at>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 15:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4ZrX-0003Jt-8d
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 15:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab0JINxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 09:53:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46802 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab0JINxG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 09:53:06 -0400
Received: by bwz15 with SMTP id 15so854497bwz.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dgU+xZ6R/YVDFO4cSg4e192mZsuXyBL5i32evaYHAX4=;
        b=BOg9TSbCRH34UFM67KKsNLIfGRuev4B/KpH8tlouuGOWdTsZHWfA4PK2Pw1DDka2Fq
         gpAazDjY4LSj9HbwYlmKDkAvZGB6i33KfxYtWl9gWZ/PVRzVA9Edbl1/Z1M2Th8TfH6u
         3+DsyeTPMfjs7pqZgq+ugW+H41b1BVUHmNbCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=u0o0fCctZqy2lGO2QkWgMnpNKi92RXoM6zuwfajinIOKwRAXX4wsKz1jFdHw/FiI4O
         fjWCDiq2pTWYp3SQ0kn9QhICUAd9ygU8DLpLV+O8+YJ5LRP6QOWDdgxBLlVaJvUh85rk
         8kij6KtMGSRCWcN9nWFx9w9XNTg5YHZzfdX9g=
Received: by 10.204.68.136 with SMTP id v8mr3194740bki.88.1286632383567;
        Sat, 09 Oct 2010 06:53:03 -0700 (PDT)
Received: from darc.lan (p549A51C3.dip.t-dialin.net [84.154.81.195])
        by mx.google.com with ESMTPS id u4sm1111176bkz.5.2010.10.09.06.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 06:53:01 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4ZrN-0001sa-2W; Sat, 09 Oct 2010 15:53:13 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158589>

Also make sure that aborted merges do not leave
MERGE_HEAD except in the "will not overwrite
removed file" test, where we cannot do so. See
also the discussion in the following thread.

http://mid.gmane.org/7vskopwxej.fsf@gitster.siamese.dyndns.org
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t7607-merge-overwrite.sh |   78 +++++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index d82349a..6ed40b1 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -7,81 +7,73 @@ Do not overwrite changes.'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	echo c0 > c0.c &&
-	git add c0.c &&
-	git commit -m c0 &&
-	git tag c0 &&
-	echo c1 > c1.c &&
-	git add c1.c &&
-	git commit -m c1 &&
-	git tag c1 &&
+	test_commit c0 &&
+	test_commit c1 &&
+	test_commit "c1a" "c1.t" "c1 a" &&
 	git reset --hard c0 &&
-	echo c2 > c2.c &&
-	git add c2.c &&
-	git commit -m c2 &&
-	git tag c2 &&
-	git reset --hard c1 &&
-	echo "c1 a" > c1.c &&
-	git add c1.c &&
-	git commit -m "c1 a" &&
-	git tag c1a &&
+	test_commit c2 &&
 	echo "VERY IMPORTANT CHANGES" > important
 '
 
 test_expect_success 'will not overwrite untracked file' '
 	git reset --hard c1 &&
-	cat important > c2.c &&
+	cp important c2.t &&
 	test_must_fail git merge c2 &&
-	test_cmp important c2.c
+	! test -f .git/MERGE_HEAD &&
+	test_cmp important c2.t
 '
 
 test_expect_success 'will not overwrite new file' '
 	git reset --hard c1 &&
-	cat important > c2.c &&
-	git add c2.c &&
+	cp important c2.t &&
+	git add c2.t &&
 	test_must_fail git merge c2 &&
-	test_cmp important c2.c
+	! test -f .git/MERGE_HEAD &&
+	test_cmp important c2.t
 '
 
 test_expect_success 'will not overwrite staged changes' '
 	git reset --hard c1 &&
-	cat important > c2.c &&
-	git add c2.c &&
-	rm c2.c &&
+	cp important c2.t &&
+	git add c2.t &&
+	rm c2.t &&
 	test_must_fail git merge c2 &&
-	git checkout c2.c &&
-	test_cmp important c2.c
+	! test -f .git/MERGE_HEAD &&
+	git checkout c2.t &&
+	test_cmp important c2.t
 '
 
 test_expect_success 'will not overwrite removed file' '
 	git reset --hard c1 &&
-	git rm c1.c &&
-	git commit -m "rm c1.c" &&
-	cat important > c1.c &&
+	git rm c1.t &&
+	git commit -m "rm c1.t" &&
+	cp important c1.t &&
 	test_must_fail git merge c1a &&
-	test_cmp important c1.c
+	test_cmp important c1.t
 '
 
 test_expect_success 'will not overwrite re-added file' '
 	git reset --hard c1 &&
-	git rm c1.c &&
-	git commit -m "rm c1.c" &&
-	cat important > c1.c &&
-	git add c1.c &&
+	git rm c1.t &&
+	git commit -m "rm c1.t" &&
+	cp important c1.t &&
+	git add c1.t &&
 	test_must_fail git merge c1a &&
-	test_cmp important c1.c
+	! test -f .git/MERGE_HEAD &&
+	test_cmp important c1.t
 '
 
 test_expect_success 'will not overwrite removed file with staged changes' '
 	git reset --hard c1 &&
-	git rm c1.c &&
-	git commit -m "rm c1.c" &&
-	cat important > c1.c &&
-	git add c1.c &&
-	rm c1.c &&
+	git rm c1.t &&
+	git commit -m "rm c1.t" &&
+	cp important c1.t &&
+	git add c1.t &&
+	rm c1.t &&
 	test_must_fail git merge c1a &&
-	git checkout c1.c &&
-	test_cmp important c1.c
+	! test -f .git/MERGE_HEAD &&
+	git checkout c1.t &&
+	test_cmp important c1.t
 '
 
 test_done
-- 
1.7.1.571.gba4d01
