From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 2/2] bisect: add tests for bisection on bare repositories
Date: Tue,  9 Aug 2011 11:21:40 +1000
Message-ID: <1312852900-29457-3-git-send-email-jon.seymour@gmail.com>
References: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 03:22:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqb1H-0005Vb-OL
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 03:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab1HIBWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 21:22:04 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35417 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab1HIBWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 21:22:01 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9208568pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 18:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YMZBN/PjqIwtHM4KWR7r17VGrt0+70w0IKXwtFFkFcc=;
        b=RRVp5qnX21Za94pwS96gDWZ9Qbu2fY1lRdY92+xopRM+BpcDQiAxAYgTD1sEVDkUv8
         zJXG0KU565hM5QLG638VDy7/wgzHcxeGfKmXzWd4W0MJl3mgcqG5PohNpNLtLSNu4KbQ
         1AHcgSmskbVhp6skF3mF0oOPkaw8Qmqd/8SIo=
Received: by 10.143.59.19 with SMTP id m19mr6372498wfk.50.1312852921597;
        Mon, 08 Aug 2011 18:22:01 -0700 (PDT)
Received: from localhost.localdomain (bh02i525f01.au.ibm.com [202.81.18.30])
        by mx.google.com with ESMTPS id v2sm5006171pbi.67.2011.08.08.18.21.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 18:22:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.523.g2ad34
In-Reply-To: <1312852900-29457-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179014>

We add a test to check that bisection works on bare repositories
both when --no-checkout is specified explicitly and when it
is defaulted.

Improved-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4fb7d11..62125ec 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -592,6 +592,37 @@ test_expect_success 'erroring out when using bad path parameters' '
 	grep "bad path parameters" error.txt
 '
 
+test_expect_success 'test bisection on bare repo - --no-checkout specified' '
+	git clone --bare . bare.nocheckout &&
+	(
+		cd bare.nocheckout &&
+		git bisect start --no-checkout &&
+		git bisect good $HASH1 &&
+		git bisect bad $HASH4 &&
+		git bisect run eval \
+			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
+			>../nocheckout.log &&
+		git bisect reset
+	) &&
+	grep "$HASH3 is the first bad commit" nocheckout.log
+'
+
+
+test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
+	git clone --bare . bare.defaulted &&
+	(
+		cd bare.defaulted &&
+		git bisect start &&
+		git bisect good $HASH1 &&
+		git bisect bad $HASH4 &&
+		git bisect run eval \
+			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
+			>../defaulted.log &&
+		git bisect reset
+	) &&
+	grep "$HASH3 is the first bad commit" defaulted.log
+'
+
 #
 # This creates a broken branch which cannot be checked out because
 # the tree created has been deleted.
-- 
1.7.6.522.g810f.dirty
