From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/9] t1508 (at-combinations): test branches separately
Date: Thu,  2 May 2013 19:09:27 +0530
Message-ID: <1367501974-6879-3-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXti9-00020R-7n
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759196Ab3EBNiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:09 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:63460 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758642Ab3EBNiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:07 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so353618pbc.29
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=du9xZuamv9iljPINhiMiYJ6UKfK5/7ayUuWE4dZEqOg=;
        b=02JU3/iY16qg05NpZduAeSPDvj+PVLUqHs33Dov31BTXvMvSc9x4ExJhk9zL1kh1HU
         ZzjqjYiSdDupQgIoww6BE2hMimX8YJ+tfaXAiTNNNyxPufasGAwt4P/fhfGeem9hUA1B
         OWmhlZp4UfiQUHpq8EDLGPfjSzGFx9Q2Q105idmPZkUYU/t6xMjIDnIWiDQjN2tc8jdt
         goFIwdc3QSRRIE982Xh+vK3/G/dA5qgrmUOWkU2KNVJhsLHfHrRUQ+RDWW+S7lSlB76F
         RPmx2bQTXJryHx7tF3Y0yb8F9gdR5tr3ERX1h2JmyxeEo5wDnD8bpvqeumI6A9qtV20Y
         zecQ==
X-Received: by 10.66.157.36 with SMTP id wj4mr9897988pab.88.1367501886780;
        Thu, 02 May 2013 06:38:06 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223198>

From: Felipe Contreras <felipe.contreras@gmail.com>

In the tests involving @{-1} and @{u} as the final component, what we
really want to check is if it's pointing to the right ref.  We
currently check the tip commit of the ref, but we can clarify this by
separating out checking for commits versus checking for refs at
check().

[rr: commit message, fix arguments in check()]

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1508-at-combinations.sh | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 46e3f16..cacb2d0 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -4,9 +4,14 @@ test_description='test various @{X} syntax combinations together'
 . ./test-lib.sh
 
 check() {
-test_expect_${3:-success} "$1 = $2" "
-	echo '$2' >expect &&
-	git log -1 --format=%s '$1' >actual &&
+test_expect_${4:-success} "$1 = ${3:-$2}" "
+	if [ '$2' == 'commit' ]; then
+		echo '$3' >expect &&
+		git log -1 --format=%s '$1' >actual
+	else
+		echo '${3:-$2}' >expect &&
+		git rev-parse --symbolic-full-name '$1' >actual
+	fi &&
 	test_cmp expect actual
 "
 }
@@ -35,14 +40,14 @@ test_expect_success 'setup' '
 	git branch -u upstream-branch new-branch
 '
 
-check HEAD new-two
-check "@{1}" new-one
-check "@{-1}" old-two
-check "@{-1}@{1}" old-one
-check "@{u}" upstream-two
-check "@{u}@{1}" upstream-one
-check "@{-1}@{u}" master-two
-check "@{-1}@{u}@{1}" master-one
+check HEAD refs/heads/new-branch
+check "@{1}" commit new-one
+check "@{-1}" refs/heads/old-branch
+check "@{-1}@{1}" commit old-one
+check "@{u}" refs/heads/upstream-branch
+check "@{u}@{1}" commit upstream-one
+check "@{-1}@{u}" refs/heads/master
+check "@{-1}@{u}@{1}" commit master-one
 nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.8.3.rc0.40.g09a0447
