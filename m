From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH 2/3] t5304: Add test for .bitmap garbage files
Date: Fri, 18 Dec 2015 18:06:39 -0600
Message-ID: <1450483600-64091-3-git-send-email-dougk.ff7@gmail.com>
References: <20151215232534.GA30998@sigill.intra.peff.net>
 <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, gitster@pobox.com,
	Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 01:07:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA53X-0000NW-S8
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 01:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbbLSAHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 19:07:16 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35609 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbbLSAHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 19:07:04 -0500
Received: by mail-yk0-f174.google.com with SMTP id v6so76647817ykc.2
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 16:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fUF77s+7NAUr7NQHNhzM6XLvmAsx66e9VXghceJq3LQ=;
        b=zoTtfmbiDA+5YyTX73Cb7jjDuAEwsu+nsIusdqDIoi9z+vnNA/Bv/AODy8ibee/A+0
         9DiIEvxiAqoNMwLd++9Bme7Hf34jhjZt/9TH2x0jWOvgErT6jbE1dO9DNihDR+chRI3C
         KCAQ1YbwCsqSDMETQ/KKNFX9kE/4qzNcIlsvKTurOwfJ59Ach6cL5cRddqj1aFKFabbd
         6jLH90ggmpMG5oGdBg/FlPUtA8v+cF7dLIsrmzMlLlY1+fykuVBHvQXaEU8grPh3BB2s
         Yvg3YBWlAXuU6skycR8tV7PJ8zzJdJd9Qx9EKDgsltDgXCMrx3ZYM5i6mlx7PLHNhVR5
         m2zw==
X-Received: by 10.13.249.199 with SMTP id j190mr5327389ywf.286.1450483624098;
        Fri, 18 Dec 2015 16:07:04 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id w184sm18490831ywc.41.2015.12.18.16.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Dec 2015 16:07:03 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282724>

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
