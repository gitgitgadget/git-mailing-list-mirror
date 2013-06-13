From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/6] t/checkout-last: checkout - doesn't work after rebase
Date: Thu, 13 Jun 2013 19:02:24 +0530
Message-ID: <1371130349-30651-2-git-send-email-artagnon@gmail.com>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:31:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7cb-0004LG-J8
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758338Ab3FMNbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:31:01 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46779 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758375Ab3FMNaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:39 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so5350814pdj.24
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LFWG2ggmtYYUEVhBTE+XNv8YTvE+EVGrLlZpXJ5D+LE=;
        b=cza8jvJBng5riG8TN5epTZpwPwtASR4m1XbwgDbcCdmicmpLhjlAGROeGdxYpzFFNT
         6IbX04P+Nj+iyuF9QRRkqrVvyJ122qtBL9yzTvPv8W9ncDSOilk74Xp/57o8SwFX7yKc
         qN2wqTTRruwmG+Zu41YOfR1VFeDFVWUEcpDDtuoX+IuGsQSJeLzhOxg7hriB8S+dQhO4
         S0nsSvkdjRL+RIDATSsw/ay2XkNJjYkWsp03zCrwrc88sZxImA75GRgqeksqseVZLqtN
         90N5bBbMaKfs+g6x4tuK6J8Hd4m7nyz/PktLoUs9/WtbK74fdI1kYWffA9L9ThO5isxL
         6Cxg==
X-Received: by 10.68.106.196 with SMTP id gw4mr830005pbb.126.1371130238199;
        Thu, 13 Jun 2013 06:30:38 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
In-Reply-To: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227734>

The following command

  $ git checkout -

does not work as expected after a rebase.  Every kind of rebase must
behave in the exactly same way: for the purposes of checkout -, the
rebase event should be inconsequential.

Add two failing tests documenting this bug: one for a normal rebase, and
another for an interactive rebase.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t2012-checkout-last.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index b44de9d..ae6d319 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -116,4 +116,20 @@ test_expect_success 'master...' '
 	test "z$(git rev-parse --verify HEAD)" = "z$(git rev-parse --verify master^)"
 '
 
+test_expect_failure '"checkout -" works after a rebase' '
+	git checkout master &&
+	git checkout other &&
+	git rebase master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
+test_expect_failure '"checkout -" works after an interactive rebase' '
+	git checkout master &&
+	git checkout other &&
+	git rebase -i master &&
+	git checkout - &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/master"
+'
+
 test_done
-- 
1.8.3.1.384.g7cec0b4
