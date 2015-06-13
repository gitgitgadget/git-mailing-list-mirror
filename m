From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Sun, 14 Jun 2015 01:48:16 +0530
Message-ID: <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:18:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rt2-0003GV-Rm
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbbFMUSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:18:37 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33631 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbFMUSg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:18:36 -0400
Received: by pdjn11 with SMTP id n11so45020175pdj.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lRH8RQCxoIQ+V77IHCGD3V8yVa+daW2u/tjuEgw8SAM=;
        b=P1zI2Y7mcbhy+NTIMFPEZsHz1JH1YOcenMk3K7uxQgY7Q9TWx/f39+CTCCc2p5Si3I
         ZdECPPGDLJY/WWgKIfhjPvQKkSaJ7pzHCN+m3mrZM/A1+NxtAn7WWs8HhsO3Ce9aQBQf
         ZMTz9v3AHz/V6+lMaQT9XtVh2e1doqSKHz9XJCNblfLgyfOwEJkzGI363CvSitCKQQ4I
         oDFa3m07sp35QCNLheQdKSGwo0rV7biCUAUVXoKDDC/Ex8a2VrIbizLqdjcTgkcI5dBQ
         wpnSeUKYbG0uk1Fm1NmWMUKUvUFiKzXZKDU2+X7payq3D+0mBAHDc13zUU0RK1Rn23m7
         iq7Q==
X-Received: by 10.70.125.129 with SMTP id mq1mr34696930pdb.19.1434226715569;
        Sat, 13 Jun 2015 13:18:35 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nw8sm7471590pdb.30.2015.06.13.13.18.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 13:18:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271578>

Add tests for for-each-ref which utilizes the ref-filter APIs.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t6301-for-each-ref-filter.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 t/t6301-for-each-ref-filter.sh

diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
new file mode 100644
index 0000000..5bd49b3
--- /dev/null
+++ b/t/t6301-for-each-ref-filter.sh
@@ -0,0 +1,35 @@
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
2.4.3.435.g2403634.dirty
