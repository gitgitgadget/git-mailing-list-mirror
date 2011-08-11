From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 1/5] fast-import: add input format tests
Date: Thu, 11 Aug 2011 16:21:06 +0600
Message-ID: <1313058070-4774-2-git-send-email-divanorama@gmail.com>
References: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 12:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSO2-0004S2-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab1HKKVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:21:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56320 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab1HKKU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:20:58 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so867233bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DCirVUrNMCil3R0WqlWlYV4MXEmB0UjfDIrniAcZUPs=;
        b=IXvhI0cDDd9U1vFQmi8teeEX0VwFD06MofokP07AR08/oEQD1XnYmqZZ8u5BpIKdIX
         gqMO2+Tc7CcaWZUqhaeLuZ1FJBB23uJBrH3O/yvXSth2m8LbiY490qu+2Udp8eBdYtse
         N5wL33YSFcMopBFVLJNrUyc5epc0JX0zkTxmA=
Received: by 10.204.33.208 with SMTP id i16mr2916700bkd.313.1313058057891;
        Thu, 11 Aug 2011 03:20:57 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id p15sm476918bkd.62.2011.08.11.03.20.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:20:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179102>

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
index f256475..0844e9d 100755
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
