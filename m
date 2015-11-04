From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 2/3] t5304: Add test for cleaning pack garbage
Date: Tue,  3 Nov 2015 21:05:07 -0600
Message-ID: <1446606308-1668-2-git-send-email-dougk.ff7@gmail.com>
References: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
 <1446606308-1668-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 04:05:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtoO9-0001aO-Dk
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 04:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbbKDDFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 22:05:25 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38816 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbKDDFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 22:05:24 -0500
Received: by igbdj2 with SMTP id dj2so26617598igb.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 19:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qc9lPNwBBlHuIlzeTcjSF/nEvTs3MHwN556jcb/Mop8=;
        b=G94BTW71gNInC9Puo7QWQojHwDExGZ+pRfaiwn/sIr9R2Jsg/tZO3436CTUvYA6/RQ
         vYvLbSQLu1JkWNq64Z7lFKAUzCsSkH4JMflEsUoqsr+DNBEA/93Dl1cizN3ZHxyv9Pzt
         JfA02Uyv3TacUQjnFkVrNKHwhMFADK57Y2Ed0082SRoJARhbr4JrXG6D4xCJtyNC0iX3
         gY0qFPc1Ay+vqIDEFySwVj9GZDcynSr+kVB0tp7Z+dI1ZAzLxu5Uz0BWiVdOE6S8wDAi
         7jtr86BO1x2LBVq5kiGBdHWx1a0IRjHOejdutPRg9qKg+spxdAG5Gbq9RAG+BfFd0B1V
         fFsg==
X-Received: by 10.50.155.1 with SMTP id vs1mr22021016igb.20.1446606323511;
        Tue, 03 Nov 2015 19:05:23 -0800 (PST)
Received: from kenshin.dougk-ff7.net (64-151-63-23.static.everestkc.net. [64.151.63.23])
        by smtp.gmail.com with ESMTPSA id c23sm292311iod.0.2015.11.03.19.05.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Nov 2015 19:05:22 -0800 (PST)
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1446606308-1668-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280845>

Pack garbage, noticeably stale .idx files, can be cleaned up during
a garbage collection.  This tests to ensure such garbage is properly
cleaned up.

Note that the prior test for checking pack garbage with count-objects
left some stale garbage after the test exited.  This has also been
corrected.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 t/t5304-prune.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 023d7c6..0297515 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -219,6 +219,7 @@ test_expect_success 'gc: prune old objects after local clone' '
 
 test_expect_success 'garbage report in count-objects -v' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
+	test_when_finished "rm -f .git/objects/pack/foo*" &&
 	: >.git/objects/pack/foo &&
 	: >.git/objects/pack/foo.bar &&
 	: >.git/objects/pack/foo.keep &&
@@ -244,6 +245,26 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_failure 'clean pack garbage with gc' '
+	test_when_finished "rm -f .git/objects/pack/fake*" &&
+	test_when_finished "rm -f .git/objects/pack/foo*" &&
+	: >.git/objects/pack/foo.keep &&
+	: >.git/objects/pack/foo.pack &&
+	: >.git/objects/pack/fake.idx &&
+	: >.git/objects/pack/fake2.keep &&
+	: >.git/objects/pack/fake2.idx &&
+	: >.git/objects/pack/fake3.keep &&
+	git gc &&
+	git count-objects -v 2>stderr &&
+	grep "^warning:" stderr | sort >actual &&
+	cat >expected <<\EOF &&
+warning: no corresponding .idx or .pack: .git/objects/pack/fake3.keep
+warning: no corresponding .idx: .git/objects/pack/foo.keep
+warning: no corresponding .idx: .git/objects/pack/foo.pack
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'prune .git/shallow' '
 	SHA1=`echo hi|git commit-tree HEAD^{tree}` &&
 	echo $SHA1 >.git/shallow &&
-- 
2.5.1
