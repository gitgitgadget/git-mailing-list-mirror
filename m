From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t3903-stash: improve testing of git-stash show
Date: Fri, 24 Sep 2010 15:40:38 -0500
Message-ID: <BVPnfVXRBMtK-9WPRRt3RH05x0aSmoFQsrb6lVp2uyULwHxOV-DnAXrmucCvrGrPQX_-AdS0fnA@cipher.nrlssc.navy.mil>
References: <00400143-1A23-4245-9D7C-4AC9093785F5@gernhardtsoftware.com>
Cc: robbat2@gentoo.org, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 24 22:41:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzF4s-0003wq-8B
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428Ab0IXUk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:40:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54835 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab0IXUk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:40:56 -0400
Received: by mail.nrlssc.navy.mil id o8OKekXF019026; Fri, 24 Sep 2010 15:40:46 -0500
In-Reply-To: <00400143-1A23-4245-9D7C-4AC9093785F5@gernhardtsoftware.com>
X-OriginalArrivalTime: 24 Sep 2010 20:40:46.0648 (UTC) FILETIME=[C3F87B80:01CB5C28]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157055>

From: Brandon Casey <drafnel@gmail.com>

Recently, the 'stash show' functionality was broken for the case when a
stash-like argument was supplied.  Since, commit 9bf09e, 'stash show' when
supplied a stash-like argument prints nothing and still exists with a zero
status.  Unfortunately, the flaw slipped through the test suite cracks
since the output of 'stash show' was not verified to be correct.

Improve and expand on the existing tests so that this flaws is detected.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


On 09/24/2010 03:27 PM, Brian Gernhardt wrote:
> I bisected the issue to a9bf09e (detached-stash: simplify git stash show),
> which is when "git stash show" started using parse_flags_and_rev (via
> assert_stash_like()).
> 
> More worrying to me is that the tests for "git stash show" don't bother
> to test the output.  I'll be working on that now.

I was preparing these tests when your email came in.

hth,
Brandon


 t/t3903-stash.sh |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a283dca..e8a7338 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -406,7 +406,7 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
-test_expect_success 'stash show - stashes on stack, stash-like argument' '
+test_expect_failure 'stash show - stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
@@ -416,16 +416,70 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	echo bar >> file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	git stash show ${STASH_ID}
+	cat >expected <<-EOF &&
+	 file |    1 +
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	EOF
+	git stash show ${STASH_ID} >actual &&
+	test_cmp expected actual
 '
-test_expect_success 'stash show - no stashes on stack, stash-like argument' '
+
+test_expect_failure 'stash show -p - stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	echo bar >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	cat >expected <<-EOF &&
+	diff --git a/file b/file
+	index 7601807..935fbd3 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 baz
+	+bar
+	EOF
+	git stash show -p ${STASH_ID} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'stash show - no stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	cat >expected <<-EOF &&
+	 file |    1 +
+	 1 files changed, 1 insertions(+), 0 deletions(-)
+	EOF
+	git stash show ${STASH_ID} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'stash show -p - no stashes on stack, stash-like argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
 	echo foo >> file &&
 	STASH_ID=$(git stash create) &&
 	git reset --hard &&
-	git stash show ${STASH_ID}
+	cat >expected <<-EOF &&
+	diff --git a/file b/file
+	index 7601807..71b52c4 100644
+	--- a/file
+	+++ b/file
+	@@ -1 +1,2 @@
+	 baz
+	+foo
+	EOF
+	git stash show -p ${STASH_ID} >actual &&
+	test_cmp expected actual
 '
 
 test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
-- 
1.7.3
