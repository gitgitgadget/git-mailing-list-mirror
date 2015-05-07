From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 12/12] t5520: check reflog action in fast-forward merge
Date: Thu,  7 May 2015 16:44:08 +0800
Message-ID: <1430988248-18285-13-git-send-email-pyokagan@gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 10:45:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHQa-0005rQ-4D
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 10:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbEGIpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 04:45:00 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35694 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbbEGIo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 04:44:56 -0400
Received: by pabtp1 with SMTP id tp1so34380252pab.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 01:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ov138yy3xi3AN4Fxl1p3YL1fSPNV9mzlM+ObcYuvOrY=;
        b=g/xIqLujf7Sg++gU3LU/APZyoGY9lysLe/P5CryPWiKfBLdVZRiksXyw4D/iTuruyE
         7BmdTPxfyZWvETfT3+nGe2EH1pklIcGBrNnIyMWeRC87o2zvr//maAck0KOTQuW6336v
         q01gwwHW8ug0RQwuodB7o9Rn5eG5brRzRfwA5XmoMBYpniZiLjm4iAkqwmbugk4ZyOPc
         c2v257KrxOzUtGikQ02aEvAhRv3GZvoafj4O6MKAxfXw62YjmlR0HgK9R5p2nsmXAdJD
         iFVIErcXU6P/sBjplWjm8tI9d+njcfyoxqvNhdRmr6pxpmXARTEWCEtEd8W3PtNzJnzu
         8CPQ==
X-Received: by 10.66.119.161 with SMTP id kv1mr5130851pab.78.1430988296414;
        Thu, 07 May 2015 01:44:56 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wh6sm1369308pbc.96.2015.05.07.01.44.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 May 2015 01:44:55 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268521>

When testing a fast-forward merge with git-pull, check to see if the
reflog action is "pull" with the arguments passed to git-pull.

While we are in the vicinity, remove the empty line as well.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    * Added this test to the patch series.

 t/t5520-pull.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index b93b735..6045491 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -86,7 +86,6 @@ test_expect_success 'pulling into void must not create an octopus' '
 '
 
 test_expect_success 'test . as a remote' '
-
 	git branch copy master &&
 	git config branch.copy.remote . &&
 	git config branch.copy.merge refs/heads/master &&
@@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
 	git checkout copy &&
 	test `cat file` = file &&
 	git pull &&
-	test `cat file` = updated
+	test `cat file` = updated &&
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'the default remote . should not break explicit pull' '
@@ -106,7 +109,11 @@ test_expect_success 'the default remote . should not break explicit pull' '
 	git reset --hard HEAD^ &&
 	test `cat file` = file &&
 	git pull . second &&
-	test `cat file` = modified
+	test `cat file` = modified &&
+	git reflog -1 >reflog.actual &&
+	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull . second: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
 '
 
 test_expect_success 'fail if wildcard spec does not match any refs' '
-- 
2.1.4
