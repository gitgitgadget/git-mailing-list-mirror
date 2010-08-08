From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 8/9] t3903-stash.sh: tests of git stash with stash-like arguments
Date: Sun,  8 Aug 2010 14:46:10 +1000
Message-ID: <1281242771-24764-9-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:48:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohxo0-0007yQ-7c
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab0HHEsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:48:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37021 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0HHEsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:48:08 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so3342990pxi.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=40GBuPIPVhGjshP2hN6mkCA09MHNZ0S0bpTu109+kXY=;
        b=Bn/NBk2W3+0ZBWGc726NpX/Da6WDpDk4iGrE95VqTc34QeXgfwjdqERp7tRwCzjHND
         m7oO60KFN+izQCQ1cZL8VF3scb9VqwNPWYuszVwCT9f4EIHMjxgxNxcp3CQDN5sgmiA5
         rYYTTjqmKYOsF90I7V4Js2aygLtcQPHyMPbPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WEVh5HCkr/W/4KcjqGexAOsJ938QTAvuPiVyFB8jJPyHfTebtUvNfqIKVHWt5fVQ0x
         EgIhByXMUhEey6FaCNAhNi5OteLIEBy9O1iRKvFuEPjsC35nXbg5aP+IIj3GclyAfvq/
         DnTPZ2sUjxQbgQOkwCMUGJHN3LWV1g32JHZIk=
Received: by 10.142.135.7 with SMTP id i7mr12180296wfd.138.1281242888751;
        Sat, 07 Aug 2010 21:48:08 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.48.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:48:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152891>

Adds new tests which check that:
* git stash branch handles a stash-like argument when there is a stash stack
* git stash branch handles a stash-like argument when there is not a stash stack
* git stash show handles a stash-like argument when there is a stash stack
* git stash show handles a stash-like argument when there is not a stash stack
* git stash drop fails early if the specified argument is not a stash reference
* git stash pop fails early if the specified argument is not a stash reference

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3903-stash.sh |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..4910409 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,85 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash branch stash-branch $(git rev-parse stash-tag) &&
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
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash branch stash-branch $(git rev-parse stash-tag) &&
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
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash show stash-tag
+'
+test_expect_success 'stash show - no stashes on stack, stash-like argument' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash show stash-tag
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
 test_done
-- 
1.7.2.1.51.g82c0c0
