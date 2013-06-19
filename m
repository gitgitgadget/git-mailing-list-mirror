From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 3/7] t/t2012-checkout-last: test "checkout -" after a rebase
Date: Wed, 19 Jun 2013 13:34:45 +0530
Message-ID: <1371629089-27008-4-git-send-email-artagnon@gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 10:08:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpDRY-00029c-4j
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 10:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab3FSII1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 04:08:27 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:65301 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab3FSIIF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 04:08:05 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa11so4872763pad.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2013 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vedO9vitjkvfEBiJZGCx3pkb6+TmOH0qh12qWy29d9o=;
        b=c3slEZvRl4E6lvC2PrQssUUpXAvyDnsgHrq08/fpK4vGHLK2K/1uvvgUcUhz3QeyMp
         eHOFZTuZsCwtf2r2duBhmaE3qZXtUBcC2T8I4xJRZUrnFFmOecIH1wLZupLIrCl5Ksqn
         nDfMIEgAkLgycgZ3lG0JdOSn13U/ZvL2unD1ydyvVJNeZK/t4rZYWF2iZceX3ZunQvpf
         F0yVwzX65VP0ZvM43KL5wV9HDBBvifyV0w+2ORSpSGcU+8u1iaR3i2hPfvG7p0nr9rlk
         hH/1/wlvKZD7zgXjyqTc8qOEhiuJyqAzYwz+yZqe1Kryyx/kwECeO0TxFJsALa48ab98
         5LBQ==
X-Received: by 10.68.78.37 with SMTP id y5mr1719570pbw.28.1371629284452;
        Wed, 19 Jun 2013 01:08:04 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm23663400pac.20.2013.06.19.01.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 01:08:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.449.g41b32a4.dirty
In-Reply-To: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228375>

  $ git checkout -

does not work as expected after a rebase.  This is because the
reflog records "checkout" made by "rebase" as its implementation
detail the same way as end-user initiated "checkout", and makes it
count as the branch that was previously checked out.

Add four failing tests documenting this bug: two for a normal rebase,
and another two for an interactive rebase.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2012-checkout-last.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index b44de9d..6ad6edf 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,4 +116,38 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
+test_expect_failure '"checkout -" works after a rebase A' '
+	git checkout master &&
+	git checkout other &&
+	git rebase master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after a rebase A B' '
+	git branch moodle master~1 &&
+	git checkout master &&
+	git checkout other &&
+	git rebase master moodle &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after a rebase -i A' '
+	git checkout master &&
+	git checkout other &&
+	git rebase -i master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after a rebase -i A B' '
+	git branch foodle master~1 &&
+	git checkout master &&
+	git checkout other &&
+	git rebase master foodle &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
 test_done
-- 
1.8.3.1.449.g41b32a4.dirty
