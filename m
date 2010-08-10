From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 8/9] t3903-stash.sh: tests of git stash with stash-like arguments
Date: Tue, 10 Aug 2010 10:04:47 +1000
Message-ID: <1281398688-21008-9-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicMn-0001dO-5I
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab0HJAGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:50 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45353 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757371Ab0HJAGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:49 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so974893pvg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HL+VGb2zPRYST4XIJqpY8rl5GyQD2sZfEbmrf8IMoTo=;
        b=L23obEHtiZMeR713DlxOaeTEjcM2tWkPOuV4ienPQGtdKbZOmomQhHW/pmKy49PAeF
         +WAWpVEsvVM/pPvCO7D6VQnIFW9vhyulf/moSVqQiqxAr0Xa6YVRMWOyJCk9UpRmCGbO
         SJy3ug5bJggXcMGUXvmM3WX/WZetKZ+Lp8qik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=vjc0dauJJ2m726DBW2jWeCfWGtMy23zYLOIsWw4IFam6OFtr4RUxjuP7XT4hG/U57F
         lJWyOwtivz385wwdVTOIghLGh0O+iDYdQMH1FES1PRx7+zauQ0ndeGJDm6ay3bypV/gi
         bREK0ACAh101PmjUo8Uk4vPwdgpKVhdvYdv9A=
Received: by 10.142.157.21 with SMTP id f21mr10147564wfe.257.1281398809402;
        Mon, 09 Aug 2010 17:06:49 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153062>

Adds new tests which check that:
* git stash branch handles a stash-like argument when there is a stash stack
* git stash branch handles a stash-like argument when there is not a stash stack
* git stash show handles a stash-like argument when there is a stash stack
* git stash show handles a stash-like argument when there is not a stash stack
* git stash drop fails early if the specified argument is not a stash reference
* git stash pop fails early if the specified argument is not a stash reference

| Amended per advice from Johannes Sixt to avoid burying stash create failures.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3903-stash.sh |   77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..c051b51 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,81 @@ test_expect_failure 'stash file to directory' '
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
 test_done
-- 
1.6.5.rc3.8.g8ba5e
