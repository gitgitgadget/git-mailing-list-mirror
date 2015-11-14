From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 2/3] t5304: Add test for .bitmap garbage files
Date: Fri, 13 Nov 2015 16:10:52 -0800
Message-ID: <1447459853-28838-3-git-send-email-dougk.ff7@gmail.com>
References: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
Cc: Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 01:12:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxOS6-0008Ky-9e
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 01:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbKNAMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 19:12:16 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34645 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbbKNAMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 19:12:13 -0500
Received: by padhx2 with SMTP id hx2so114594807pad.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fUF77s+7NAUr7NQHNhzM6XLvmAsx66e9VXghceJq3LQ=;
        b=DDJ7a7Lvj0IeGdAEZe38Lzr5DRd3RZMw2jwjP+0kw/e5Qy2WnwueqfPF4rq0NJa2F9
         WAeuFvNzw+FuYfiP2GmXWk0eSPUCSWbOWpFMVkRQQD83nrTn3VltsHLp5QkmTFmtnuJc
         PESU3Hn4Ir4VEZP7ojaDyqpcZGB9XsrfbTQXmR6E1OldK6Bq4nqzV7q6BDrHzzasHfa5
         BoMCslftb2RWYIZEfwfSj7oWcW1umb+UObjjWGvfJpoSLRfAxlmBEq1NhVWhX5BbeaUP
         LYk0yiqDI+/r/k+k6AFILCaSpVMpktH42N+l60RmOmGPciUrbCaYT76sZajJCXD1C95+
         ve8w==
X-Received: by 10.68.104.229 with SMTP id gh5mr36422320pbb.130.1447459932649;
        Fri, 13 Nov 2015 16:12:12 -0800 (PST)
Received: from k-na.local.com ([104.135.13.127])
        by smtp.gmail.com with ESMTPSA id qd2sm22507609pbb.68.2015.11.13.16.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 16:12:12 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1447459853-28838-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281281>

When checking for pack garbage, .bitmap files are now detected as
garbage when not associated with another .pack/.idx file.

Signed-off-by: Doug Kelly <dougk.ff7@gmail.com>
---
 t/t5304-prune.sh | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 1ea8279..4fa6e7a 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -230,6 +230,12 @@ test_expect_success 'garbage report in count-objects -v' '
 	: >.git/objects/pack/fake.idx &&
 	: >.git/objects/pack/fake2.keep &&
 	: >.git/objects/pack/fake3.idx &&
+	: >.git/objects/pack/fake4.bitmap &&
+	: >.git/objects/pack/fake5.bitmap &&
+	: >.git/objects/pack/fake5.idx &&
+	: >.git/objects/pack/fake6.keep &&
+	: >.git/objects/pack/fake6.bitmap &&
+	: >.git/objects/pack/fake6.idx &&
 	git count-objects -v 2>stderr &&
 	grep "index file .git/objects/pack/fake.idx is too small" stderr &&
 	grep "^warning:" stderr | sort >actual &&
@@ -238,14 +244,20 @@ warning: garbage found: .git/objects/pack/fake.bar
 warning: garbage found: .git/objects/pack/foo
 warning: garbage found: .git/objects/pack/foo.bar
 warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
+warning: no corresponding .idx or .pack: .git/objects/pack/fake4.bitmap
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
 warning: no corresponding .pack: .git/objects/pack/fake3.idx
+warning: no corresponding .pack: .git/objects/pack/fake5.bitmap
+warning: no corresponding .pack: .git/objects/pack/fake5.idx
+warning: no corresponding .pack: .git/objects/pack/fake6.bitmap
+warning: no corresponding .pack: .git/objects/pack/fake6.idx
+warning: no corresponding .pack: .git/objects/pack/fake6.keep
 EOF
 	test_cmp expected actual
 '
 
-test_expect_success 'clean pack garbage with gc' '
+test_expect_failure 'clean pack garbage with gc' '
 	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	test_when_finished "rm -f .git/objects/pack/foo*" &&
 	: >.git/objects/pack/foo.keep &&
@@ -254,15 +266,21 @@ test_expect_success 'clean pack garbage with gc' '
 	: >.git/objects/pack/fake2.keep &&
 	: >.git/objects/pack/fake2.idx &&
 	: >.git/objects/pack/fake3.keep &&
+	: >.git/objects/pack/fake4.bitmap &&
+	: >.git/objects/pack/fake5.bitmap &&
+	: >.git/objects/pack/fake5.idx &&
+	: >.git/objects/pack/fake6.keep &&
+	: >.git/objects/pack/fake6.bitmap &&
+	: >.git/objects/pack/fake6.idx &&
 	git gc &&
 	git count-objects -v 2>stderr &&
 	grep "^warning:" stderr | sort >actual &&
 	cat >expected <<\EOF &&
+warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
 warning: no corresponding .idx or .pack: .git/objects/pack/fake3.keep
+warning: no corresponding .idx or .pack: .git/objects/pack/fake6.keep
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
-warning: no corresponding .pack: .git/objects/pack/fake2.idx
-warning: no corresponding .pack: .git/objects/pack/fake2.keep
 EOF
 	test_cmp expected actual
 '
-- 
2.6.1
