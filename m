From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 4/5] fsck: add a few committer name tests
Date: Thu, 11 Aug 2011 16:21:09 +0600
Message-ID: <1313058070-4774-5-git-send-email-divanorama@gmail.com>
References: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 12:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSO5-0004S2-46
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab1HKKVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:21:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42211 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab1HKKVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:21:03 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so867264bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dPTkI9WWFFP9mp1gSlI9GMU6pCQ69MXx3KFTXLJ7r2s=;
        b=sc8VggKGHQhZ5iEie05ZxeZSMNtWdWxNLJjallRy4XmdYhbn76rAJIbIdl0Td4fX9B
         6V2rGVcW7r+bg9jK/lGkpPpL4HeuhyKHGLmz4cP4oGi4WbdGwYhw/lT4WZbFzt2F6Z48
         q+l+S1nwQRg3stGxSyctCZ1giI9KL7zlv2TIE=
Received: by 10.204.149.19 with SMTP id r19mr1804930bkv.351.1313058062964;
        Thu, 11 Aug 2011 03:21:02 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id p15sm476918bkd.62.2011.08.11.03.21.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:21:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179105>

fsck reports "missing space before <email>" for committer string equal
to "name email>" or to "". It'd be nicer to say "missing email" for
the second string and "name is bad" (has > in it) for the first one.
Add a failing test for these messages.

For "name> <email>" no error is reported. Looks like a bug, so add
such a failing test."

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 t/t1450-fsck.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index bb01d5a..01ccefd 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -110,6 +110,42 @@ test_expect_success 'email with embedded > is not okay' '
 	grep "error in commit $new" out
 '
 
+test_expect_failure 'missing < email delimiter is reported nicely' '
+	git cat-file commit HEAD >basis &&
+	sed "s/<//" basis >bad-email-2 &&
+	new=$(git hash-object -t commit -w --stdin <bad-email-2) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new.* - bad name" out
+'
+
+test_expect_failure 'missing email is reported nicely' '
+	git cat-file commit HEAD >basis &&
+	sed "s/[a-z]* <[^>]*>//" basis >bad-email-3 &&
+	new=$(git hash-object -t commit -w --stdin <bad-email-3) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new.* - missing email" out
+'
+
+test_expect_failure '> in name is reported' '
+	git cat-file commit HEAD >basis &&
+	sed "s/ </> </" basis >bad-email-4 &&
+	new=$(git hash-object -t commit -w --stdin <bad-email-4) &&
+	test_when_finished "remove_object $new" &&
+	git update-ref refs/heads/bogus "$new" &&
+	test_when_finished "git update-ref -d refs/heads/bogus" &&
+	git fsck 2>out &&
+	cat out &&
+	grep "error in commit $new" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
-- 
1.7.3.4
