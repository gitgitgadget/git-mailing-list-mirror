From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 8/9] detached-stash: tests of git stash with stash-like arguments
Date: Sat, 21 Aug 2010 14:09:03 +1000
Message-ID: <1282363744-4924-9-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:10:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfPN-0006qB-OA
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab0HUEKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:10:09 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37067 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HUEKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:10:07 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1481994pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PaoJ54wYEtqtb9PPq34/M4IXluId5f6tkofElcQuHGk=;
        b=SkGZlwgXHbyfo3U6mpt3295DwLKTB5GY9Bjre9zwIEpDJdGz0rXxbC7I7YDQgInFR6
         ZCG6JinKOvBKdAe51goA9G+MsDbUu4cygMdjbrF2ibg4caF3Tbf1+o0pfGCpSTjYksse
         6QJ0yuy94BdXY3FNk6wOr137pNhxlJa5TvLQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hffuD08h/mCs6/i3Mu+fpGfQiYnPdRP0oJStKB7CvTs78cXDfTxZlo5d/hFwIS5KYV
         +zvMNjv1xluVrwGq0pGbUaJFZOfOCK+cDSH3ejgd7/OgkJNfyfqgztWBtil7rHfz+iuM
         ilp2pNDBi9OFKDDt5uHaU2MdhAExGJB4RlB2U=
Received: by 10.142.207.5 with SMTP id e5mr1782062wfg.229.1282363807502;
        Fri, 20 Aug 2010 21:10:07 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.10.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:10:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154105>

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
---
 t/t3903-stash.sh |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..ea9f979 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,116 @@ test_expect_failure 'stash file to directory' '
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
+	test_must_fail "git stash drop $(git rev-parse stash@{0})" &&
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
+	test_must_fail "git stash pop $(git rev-parse stash@{0})" &&
+	git stash pop &&
+	test bar = "$(cat file)" &&
+	git reset --hard HEAD
+'
+
+test_expect_success 'ref with non-existant reflog' '
+	git stash clear &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	! "git rev-parse --quiet --verify does-not-exist" &&
+	test_must_fail "git stash drop does-not-exist" &&
+	test_must_fail "git stash drop does-not-exist@{0}" &&
+	test_must_fail "git stash pop does-not-exist" &&
+	test_must_fail "git stash pop does-not-exist@{0}" &&
+	test_must_fail "git stash apply does-not-exist" &&
+	test_must_fail "git stash apply does-not-exist@{0}" &&
+	test_must_fail "git stash show does-not-exist" &&
+	test_must_fail "git stash show does-not-exist@{0}" &&
+	test_must_fail "git stash branch tmp does-not-exist" &&
+	test_must_fail "git stash branch tmp does-not-exist@{0}" &&
+	git stash drop
+'
+
+test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
+	git stash clear &&
+	test_must_fail "git stash drop stash@{0}" &&
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	git stash &&
+	test_must_fail "git drop stash@{1}" &&
+	test_must_fail "git pop stash@{1}" &&
+	test_must_fail "git apply stash@{1}" &&
+	test_must_fail "git show stash@{1}" &&
+	test_must_fail "git branch tmp stash@{1}" &&
+	git stash drop
+'
+
 test_done
-- 
1.7.2.1.110.g34f32
