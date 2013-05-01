From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Wed,  1 May 2013 21:50:31 +0530
Message-ID: <1367425235-14998-2-git-send-email-artagnon@gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 18:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXZlk-0006UK-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 18:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab3EAQU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 12:20:29 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39519 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3EAQU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 12:20:26 -0400
Received: by mail-pa0-f48.google.com with SMTP id lb1so928622pab.7
        for <git@vger.kernel.org>; Wed, 01 May 2013 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=klgK3NS+q23vvq/bJgQDnw6KmrMZfTGWoR6/Pznym9A=;
        b=hhjCdJiDIvRrzx005MyIsUyxGwNYxLknxu+V/1Uoo1BqhAgNRzx91A3I4WHhERoFor
         4/XDQN0KBuQrH0Cc8AGul3G3QzN5Fj0JJYFFL0EyH4XXoURXLHMRpz3ww1PGYB7/9i/C
         /2DJSyOLMGHGID9xpnEosetj+0EkdS8AXPKrUwyVwp7blSXgnJHmKa+XHs+1/qzSSzD6
         Sm9DPwGfJB5iRqAbYMLfIwK6xMsNKrEEO5VqwiWWoVVZN5X/CiCj4BeLwAd1mTmRF/8w
         NIyDJIgLaXPO5AfAXl0niLbxj69SsMrzalYeyXXMwuuj0O6eIPfs8QmTwweO4luwvnyj
         UcDg==
X-Received: by 10.68.225.133 with SMTP id rk5mr4762305pbc.143.1367425225958;
        Wed, 01 May 2013 09:20:25 -0700 (PDT)
Received: from localhost.localdomain ([122.164.132.210])
        by mx.google.com with ESMTPSA id sg4sm3549741pbc.7.2013.05.01.09.20.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 09:20:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.24.g6456091
In-Reply-To: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223095>

To emphasize what we're testing in @{1}@{u}, document that @{0}@{0} is
also nonsense.  This makes it clear that @{<n>} does not resolve to a
ref whose upstream we can determine with @{u}/ reflog we can dig with
@{0}.

Since HEAD is implicit in @{}, check that HEAD@{} works fine for these
cases.  It doesn't make sense in @{-<n>} because @{-<n>} cannot be
used with anything other than HEAD, and interpret_nth_prior_checkout()
hard-codes "HEAD".

Additionally, document bugs in the @-parser by symbolic-ref'ing @ to
HEAD and re-running some tests.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index d5d6244..efa2a2a 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -39,13 +39,27 @@ test_expect_success 'setup' '
 
 check HEAD new-two
 check "@{1}" new-one
+check "HEAD@{1}" new-one
+check "@{now}" new-two
+check "HEAD@{now}" new-two
 check "@{-1}" old-two
 check "@{-1}@{1}" old-one
 check "@{u}" upstream-two
+check "HEAD@{u}" upstream-two
 check "@{u}@{1}" upstream-one
 check "@{-1}@{u}" master-two
 check "@{-1}@{u}@{1}" master-one
 nonsense "@{u}@{-1}"
+nonsense "@{0}@{0}"
 nonsense "@{1}@{u}"
+nonsense "HEAD@{-1}"
+
+# Make sure that the @-parser isn't buggy; check things with
+# symbolic-ref @ pointing to HEAD.
+git symbolic-ref @ HEAD
+check "@@{1}" new-one
+check "@@{now}" new-two
+check "@@{u}" upstream-two failure
+nonsense "@@{-1}"
 
 test_done
-- 
1.8.3.rc0.24.g6456091
