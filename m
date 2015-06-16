From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Tue, 16 Jun 2015 19:50:47 +0530
Message-ID: <1434464457-10749-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 16:21:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rjo-0003a8-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262AbbFPOVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:21:08 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34132 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbbFPOVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:21:06 -0400
Received: by pdbki1 with SMTP id ki1so15502126pdb.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O5hKvlLRDbauxxD8LUx0bWWjNCT1g6R08jx8Jr7jzo4=;
        b=WaU9eP0SeVdnmGpY41nEDKP3jy3TKvJtoC/VROIyyDKNgrJTISt70uCRUWpQnpK8U9
         A7bL+YasUhmgAhltxDZkPsZyLiYDwgLDbrgcir2eG7gSyIHmgCI0IKFy2OisqWL+yW9v
         DUKo3czPDXsBqL5t2wwET60gHqBKC75l/wUIVu6D8822wWWP/puuXzuz6PsdiSQh+hY/
         f29Bz8q0Uxw+V8MU7snPavlcSzjgsKBWPPJYp8otvgetTu+ivUZATEr8iIfgGyX5hQhR
         BlpU6tRAnP+q8LMA0X1A84IEOoziGzEok46hcwChsaiX7uPPrWPS7L5NzWq5gvvVQFNG
         ELSA==
X-Received: by 10.70.103.70 with SMTP id fu6mr1234677pdb.22.1434464465890;
        Tue, 16 Jun 2015 07:21:05 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm1594145pda.54.2015.06.16.07.21.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jun 2015 07:21:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.436.g722e2ce.dirty
In-Reply-To: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271755>

Add tests for 'for-each-ref' which utilizes the ref-filter APIs.
Currently it's redundant with the tests in 't6300' but more tests
will be eventually added as we implement more options into
'for-each-ref'.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6301-for-each-ref-filter.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 t/t6301-for-each-ref-filter.sh

diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
new file mode 100755
index 0000000..bfcb866
--- /dev/null
+++ b/t/t6301-for-each-ref-filter.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='test for-each-refs usage of ref-filter APIs'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+
+test_expect_success 'setup some history and refs' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git checkout -b side &&
+	test_commit four &&
+	git checkout master &&
+	git update-ref refs/odd/spot master
+'
+
+test_expect_success 'filtering by leading name' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/heads/side
+	EOF
+	git for-each-ref --format="%(refname)" refs/heads >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'filtering with fnmatch' '
+	cat >expect <<-\EOF &&
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" refs/tags/t* >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.4.3.436.g722e2ce.dirty
