From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/5] fast-import: add input format tests
Date: Thu, 28 Jul 2011 11:44:00 +0600
Message-ID: <1311831844-13123-2-git-send-email-divanorama@gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 07:41:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJLV-0004Gf-Es
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 07:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678Ab1G1FlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 01:41:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56514 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab1G1FlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 01:41:16 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so916357fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 22:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=f8ESm7p+8TkdK8iYs4I7OmZWzXULGmvkfYNMrZMCWUw=;
        b=ZF783rdxeaujA3TX50Zmt7ZsJ208sdu1wT9HdEgjVZn8CZ3fMAkZHqv3K8yzJjxnfC
         RAYGvc+tmJA4QPqJXIq5tBm43mJMLJ7dNHt/hWULlmY9C5XhhvvHjs39bjbmjXj7gXCZ
         4HOrIDlAStorqBbbhDGIQkND/ufBkisW4rouw=
Received: by 10.204.174.65 with SMTP id s1mr180166bkz.375.1311831675332;
        Wed, 27 Jul 2011 22:41:15 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g11sm154133bku.49.2011.07.27.22.41.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 22:41:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178036>

Documentation/git-fast-import.txt says that git-fast-import is strict
about it's input format. But committer/author field parsing is a bit
loose. Invalid values can be unnoticed and written out to the commit,
either with format-conforming input or with non-format-conforming one.

Add one passing and one failing test for empty/absent committer name
with well-formed input. And a failed test with unnoticed ill-formed
input.

Reported-by: SASAKI Suguru <sss.sonik@gmail.com>
Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 t/t9300-fast-import.sh |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2a53640..a659dd4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -324,6 +324,105 @@ test_expect_success \
 	 test `git rev-parse master` = `git rev-parse TEMP_TAG^`'
 rm -f .git/TEMP_TAG
 
+git gc 2>/dev/null >/dev/null
+git prune 2>/dev/null >/dev/null
+
+cat >input <<INPUT_END
+commit refs/heads/empty-committer-1
+committer  <> $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_success 'B: accept empty committer' '
+	git fast-import <input &&
+	out=$(git fsck) &&
+	echo "$out" &&
+	test -z "$out"
+'
+git update-ref -d refs/heads/empty-committer-1 || true
+
+git gc 2>/dev/null >/dev/null
+git prune 2>/dev/null >/dev/null
+
+cat >input <<INPUT_END
+commit refs/heads/empty-committer-2
+committer <a@b.com> $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_failure 'B: accept and fixup committer with no name' '
+	git fast-import <input &&
+	out=$(git fsck) &&
+	echo "$out" &&
+	test -z "$out"
+'
+git update-ref -d refs/heads/empty-committer-2 || true
+
+git gc 2>/dev/null >/dev/null
+git prune 2>/dev/null >/dev/null
+
+cat >input <<INPUT_END
+commit refs/heads/invalid-committer
+committer Name email> $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_failure 'B: fail on invalid committer (1)' '
+	test_must_fail git fast-import <input
+'
+git update-ref -d refs/heads/invalid-committer || true
+
+cat >input <<INPUT_END
+commit refs/heads/invalid-committer
+committer Name <e<mail> $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_failure 'B: fail on invalid committer (2)' '
+	test_must_fail git fast-import <input
+'
+git update-ref -d refs/heads/invalid-committer || true
+
+cat >input <<INPUT_END
+commit refs/heads/invalid-committer
+committer Name <email>> $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_failure 'B: fail on invalid committer (3)' '
+	test_must_fail git fast-import <input
+'
+git update-ref -d refs/heads/invalid-committer || true
+
+cat >input <<INPUT_END
+commit refs/heads/invalid-committer
+committer Name <email $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_failure 'B: fail on invalid committer (4)' '
+	test_must_fail git fast-import <input
+'
+git update-ref -d refs/heads/invalid-committer || true
+
+cat >input <<INPUT_END
+commit refs/heads/invalid-committer
+committer Name<email> $GIT_COMMITTER_DATE
+data <<COMMIT
+empty commit
+COMMIT
+INPUT_END
+test_expect_failure 'B: fail on invalid committer (5)' '
+	test_must_fail git fast-import <input
+'
+git update-ref -d refs/heads/invalid-committer || true
+
 ###
 ### series C
 ###
-- 
1.7.3.4
