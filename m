From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Thu,  7 May 2015 16:44:07 +0800
Message-ID: <1430988248-18285-12-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:45:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQZ-0005rQ-HU
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbbEGIo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:44:58 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36647 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbEGIoy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:54 -0400
Received: by pabsx10 with SMTP id sx10so34344819pab.3
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HaYzSY43qyQtBuAH6iBd35imsKoJlAs3+5Xu4HJLGnM=;
        b=YyAxkz/+09F3/AFa3zao2+S5slx+yYAxLGncNPURy4eGS9XnjOAKHAM/kSVe+eFizq
         WZpQnWBs9YGT80q+xFUKGncTFN5xDgLTMMNO8jyIs/oW9qpZAUK/VZqnnnEyF6/DvP4i
         RteaUod8Hm+5inDfI7YCjTTi7sp//8l6MUgabkcd8b1LEAlaVfEJT8qp1RVNylaW9y3d
         5JpOPLP6oV/HhDjD6vpLtZoW5Axi56SqoeWYDiaMqmIJxLiW1gvNB96h6+Zj8+KunGHU
         ih0Q706oUH7PZURcABplYxKcmtRYQctnoi8buUo01+Ayu10MIg7ZnPGqP0L+0+HEwTMO
         CPkA==
X-Received: by 10.68.137.138 with SMTP id qi10mr4888017pbb.75.1430988293393;
        Thu, 07 May 2015 01:44:53 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:52 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268522>

While git-pull supports --log and passes the switch to git-merge, it
does not support --log=<n>, ignoring the value <n>.

This is not only at odds with the documentation of git-pull, it's also a
undesirable limitation as <n> could simply be passed to git-merge as
well.

Implement a failing test that demonstrates this.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Added this test to the patch series

 t/t5524-pull-msg.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..5b7af07 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -17,6 +17,9 @@ test_expect_success setup '
 		git commit -m "add bfile"
 	) &&
 	test_tick && test_tick &&
+	echo "second" >afile &&
+	git add afile &&
+	git commit -m "second commit" &&
 	echo "original $dollar" >afile &&
 	git add afile &&
 	git commit -m "do not clobber $dollar signs"
@@ -32,4 +35,18 @@ test_expect_success pull '
 )
 '
 
+test_expect_failure '--log=1 limits shortlog length' '
+(
+	cd cloned &&
+	git reset --hard HEAD^ &&
+	test `cat afile` = original &&
+	test `cat bfile` = added &&
+	git pull --log &&
+	git log -3 &&
+	git cat-file commit HEAD >result &&
+	grep Dollar result &&
+	! grep "second commit" result
+)
+'
+
 test_done
-- 
2.1.4
