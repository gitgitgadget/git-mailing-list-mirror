From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] update http tests according to remote-curl capabilities
Date: Sun, 25 Oct 2009 13:06:18 +0100
Message-ID: <1256472380-924-2-git-send-email-drizzd@aon.at>
References: <1256472380-924-1-git-send-email-drizzd@aon.at>
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Oct 25 13:07:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N21sK-0002BZ-UO
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 13:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbZJYMG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 08:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbZJYMG6
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 08:06:58 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45178 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbZJYMG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 08:06:58 -0400
Received: by mail-bw0-f227.google.com with SMTP id 27so1602555bwz.21
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 05:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=x+JK82SN39xNlUOE6dAQsfkwqIj0L2AUPe2eOHzrmZE=;
        b=oG2mlXvChX4qF1rpuBayfKgTz2PS6QJCxMBc7zjh7IvXnm/y7x/W8t91GiPCpy69Rw
         zEL09Zp7sLUHh40yKCii7KpZl/pz6xj6s5ikZDpUH7afLcqJg3Tu4f6tJAhrasZYmX/T
         AFf+dupkuGHm7m2dMlCWoKDFGAvQc4iXBmJkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=J0HmUrTvlEnHVTD5WA3+bMPsUKFu/x2as3Wx1NIp7auTpqb25BZtm8SvpB3BsrrE5D
         9f1/HnqSC5fq2ziYozw3bHewcVwusNwZt4FzLC5yqsz+E7oK6QYrrAOHEjtEcKT9Y68E
         FakTAoRhHZKHQ64pPzGK6zkzzRkkGWNPZSUlo=
Received: by 10.204.150.76 with SMTP id x12mr4733683bkv.30.1256472422800;
        Sun, 25 Oct 2009 05:07:02 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 3sm6809094fxm.85.2009.10.25.05.07.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 05:07:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N21sP-0001Ph-Nv; Sun, 25 Oct 2009 13:07:13 +0100
X-Mailer: git-send-email 1.6.5.35.ge41a3
In-Reply-To: <1256472380-924-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131201>

 o Pushing packed refs is now fixed.

 o The transport helper fails if refs are already up-to-date. Add a
   test for that.

 o The transport helper will notice if refs are already up-to-date. We
   therefore need to update server info in the unpacked-refs test.

 o The transport helper will purge deleted branches automatically.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5540-http-push.sh |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index f4a2cf6..09edd23 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -36,6 +36,7 @@ test_expect_success 'setup remote repository' '
 	cd test_repo.git &&
 	git --bare update-server-info &&
 	mv hooks/post-update.sample hooks/post-update &&
+	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
 	cd - &&
 	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"
 '
@@ -45,7 +46,7 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '
 
-test_expect_failure 'push to remote repository with packed refs' '
+test_expect_success 'push to remote repository with packed refs' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
@@ -57,11 +58,15 @@ test_expect_failure 'push to remote repository with packed refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_success ' push to remote repository with unpacked refs' '
+test_expect_failure 'push already up-to-date' '
+	git push
+'
+
+test_expect_success 'push to remote repository with unpacked refs' '
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 rm packed-refs &&
-	 git update-ref refs/heads/master \
-		0c973ae9bd51902a28466f3850b543fa66a6aaf4) &&
+	 git update-ref refs/heads/master $ORIG_HEAD &&
+	 git --bare update-server-info) &&
 	git push &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
 	 test $HEAD = $(git rev-parse --verify HEAD))
@@ -113,7 +118,6 @@ test_expect_success 'create and delete remote branch' '
 	git push origin dev &&
 	git fetch &&
 	git push origin :dev &&
-	git branch -d -r origin/dev &&
 	git fetch &&
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
-- 
1.6.5.35.ge41a3
