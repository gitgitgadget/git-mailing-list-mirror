From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH] Fix approxidate("never") to always return 0
Date: Tue, 17 Jun 2008 18:34:57 +0200
Message-ID: <1213720497-9093-1-git-send-email-dkr+ml.git@free.fr>
References: <4855A3CC.2090701@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 18:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8e9x-0004D0-Jc
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 18:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbYFQQfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 12:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755811AbYFQQe7
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 12:34:59 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:39742 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbYFQQe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 12:34:58 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1778512B74A;
	Tue, 17 Jun 2008 18:34:57 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C723512B6FE;
	Tue, 17 Jun 2008 18:34:56 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc3.156.g1a01
In-Reply-To: <4855A3CC.2090701@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85311>

From: Olivier Marin <dkr@freesurf.fr>

Commit af66366a9feb0194ed04b1f538998021ece268a8 introduced the keyword
"never" to be used with approxidate() but defined it with a fixed date
without taking care of timezone. As a result approxidate() will return
a timestamp in the future with a negative timezone.

With this patch, approxidate("never") always return 0 whatever your
timezone is.

Also, print seconds since the Epoch in test-date.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---

Without this patch:

	$ git --version
	git version 1.5.6.rc3.156.g1a01 (next)

	$ mkdir /tmp/repo1 && cd /tmp/repo1 && git init
	$ echo A > A && git add A && git commit -m A

	$ git config gc.reflogexpire never

	$ TZ=UTC git reflog expire --dry-run --verbose HEAD
	keep commit (initial): A

	$ TZ=UTC-2 git reflog expire --dry-run --verbose HEAD
	would prune commit (initial): A

This test does not trigger the problem with Junio's "Per-ref reflog expiry
configuration" patch because it explicitly tests for "never" without relying
on approxidate() but the bug still remains with --expire option and in date.c

This make me thinking about TZ=UTC forced into t/test-lib.sh. Should not
test cases to be independant of the timezone?

 date.c      |    6 ++----
 test-date.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/date.c b/date.c
index a74ed86..1a4eb87 100644
--- a/date.c
+++ b/date.c
@@ -682,10 +682,8 @@ static void date_am(struct tm *tm, int *num)
 
 static void date_never(struct tm *tm, int *num)
 {
-	tm->tm_mon = tm->tm_wday = tm->tm_yday
-		= tm->tm_hour = tm->tm_min = tm->tm_sec = 0;
-	tm->tm_year = 70;
-	tm->tm_mday = 1;
+	time_t n = 0;
+	localtime_r(&n, tm);
 }
 
 static const struct special {
diff --git a/test-date.c b/test-date.c
index 62e8f23..b84e000 100644
--- a/test-date.c
+++ b/test-date.c
@@ -14,7 +14,7 @@ int main(int argc, char **argv)
 		printf("%s -> %s -> %s", argv[i], result, ctime(&t));
 
 		t = approxidate(argv[i]);
-		printf("%s -> %s\n", argv[i], ctime(&t));
+		printf("%s -> %lu -> %s\n", argv[i], t, ctime(&t));
 	}
 	return 0;
 }
-- 
1.5.6.rc3.204.gf01a.dirty
