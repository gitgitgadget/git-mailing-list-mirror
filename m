From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 7/8] detached-stash: tests of git stash with stash-like arguments
Date: Wed, 18 Aug 2010 23:48:52 +1000
Message-ID: <1282139333-5150-4-git-send-email-jon.seymour@gmail.com>
References: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:49:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj1Z-0005IP-HL
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab0HRNtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:49:31 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62780 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab0HRNt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:49:29 -0400
Received: by pxi10 with SMTP id 10so218421pxi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QAjojfkLQgkR+58GMj5ciEaiVR/3f8x2nsY80EKaNog=;
        b=javh0ThYr3bOz0iNP+Uz7umnHhWdV/BdE9eB3jaaKw7FQejnZ9oVAE66hBvJgCw933
         oFrA75pVnOdXH9OP4tN0q8OBgtWK8q/pLf7dCPjx692Eiu8SmwlMImhfxsbpGv/uVHIi
         Sqh0R2M5lsws7ZQP//rsmQWEtFjGQgEKk1DqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OolhJ/eikoSYs+Jk3jw0k+7W1+CKSCSZ4JzCuuUoy07LIkkaqEqn80bzMsYpWa6pm+
         KSvDFoofcybn36y6k9bQtQLepaTON8re6z4rBm3pBlW2jt+c2ctwVlP/Bewe+po4Ct67
         oOPBX/1gqfP+IW9dookweyNrcl2vRz82oFUbs=
Received: by 10.114.66.20 with SMTP id o20mr9589521waa.163.1282139369127;
        Wed, 18 Aug 2010 06:49:29 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-26.dyn.iinet.net.au [203.158.55.26])
        by mx.google.com with ESMTPS id s5sm538803wak.12.2010.08.18.06.49.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:49:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.88.g3dbe5
In-Reply-To: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153853>

Adds new tests which check that:
* git stash branch handles a stash-like argument when there is a stash stack
* git stash branch handles a stash-like argument when there is not a stash stack
* git stash show handles a stash-like argument when there is a stash stack
* git stash show handles a stash-like argument when there is not a stash stack
* git stash drop fails early if the specified argument is not a stash reference
* git stash pop fails early if the specified argument is not a stash reference
* git stash * fails early if the reference supplied is bogus
* git stash fails early with stash@{n} where n >= length of stash log

| Amended per advice from Johannes Sixt to avoid burying stash create failures.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3903-stash.sh |  140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 140 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..efc7e7f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,144 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	git stash branch stash-branch ${STASH_ID} &&
+	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test $(git ls-files --modified | wc -l) -eq 1
+'
+
+test_expect_success 'stash branch - stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	echo bar >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	git stash branch stash-branch ${STASH_ID} &&
+	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test $(git ls-files --modified | wc -l) -eq 1
+'
+
+test_expect_success 'stash show - stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git stash &&
+	test_when_finished "git stash drop" &&
+	echo bar >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	git stash show ${STASH_ID}
+'
+test_expect_success 'stash show - no stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	STASH_ID=$(git stash create) &&
+	git reset --hard &&
+	git stash show ${STASH_ID}
+'
+
+test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD && git stash clear" &&
+	git reset --hard &&
+	echo foo > file &&
+	git stash &&
+	echo bar > file &&
+	git stash &&
+	! git stash drop $(git rev-parse stash@{0}) &&
+	git stash pop &&
+	test bar = "$(cat file)" &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD && git stash clear" &&
+	git reset --hard &&
+	echo foo > file &&
+	git stash &&
+	echo bar > file &&
+	git stash &&
+	! git stash pop $(git rev-parse stash@{0}) &&
+	git stash pop &&
+	test bar = "$(cat file)" &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'stash drop - bad stash ref' '
+	git stash clear &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash drop does-not-exist &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash drop does-not-exist@{0} &&
+	git stash drop
+'
+
+test_expect_success 'stash pop - bad stash ref' '
+	git stash clear &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash pop does-not-exist &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash pop does-not-exist@{0} &&
+	git stash drop
+'
+
+test_expect_success 'stash apply - bad stash ref' '
+	git stash clear &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash apply does-not-exist &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash apply does-not-exist@{0} &&
+	git stash drop
+'
+
+test_expect_success 'stash show - bad stash ref' '
+	git stash clear &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash show does-not-exist &&
+	! git rev-parse --quiet --verify does-not-exist &&
+	! git stash show does-not-exist@{0} &&
+	git stash drop
+'
+
+test_expect_success 'stash drop - invalid stash reference' '
+	git stash clear &&
+	! git stash stash@{0} &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	! git drop stash@{1} &&
+	git stash drop
+'
+
 test_done
-- 
1.7.2.1.95.g4fabf
