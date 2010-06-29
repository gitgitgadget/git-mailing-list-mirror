From: newren@gmail.com
Subject: [PATCH 2/5] Add another rename + D/F conflict testcase
Date: Mon, 28 Jun 2010 19:12:13 -0600
Message-ID: <1277773936-12412-3-git-send-email-newren@gmail.com>
References: <1277773936-12412-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, vmiklos@frugalware.org,
	gitster@pobox.com, spearce@spearce.org,
	Alexander Gladysh <agladysh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 03:18:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTPSz-0000ad-5Y
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 03:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab0F2BSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 21:18:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56574 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab0F2BST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 21:18:19 -0400
Received: by pvg2 with SMTP id 2so2212208pvg.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 18:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4sIMpv5cbCoq5BeFwjbT0rrUclYIu8ogfh6zLsLScD8=;
        b=GWc1uwUnEo5xh5ZrDApSz0wZFS7iaiJlsUGHmSkGlgaPm+SBJiw9XyqwCX7JBHfySC
         nrxCSXZnMHKo4Kp+DhVjebqm/XTfFaZ80cDMPMRj/sV+h8zSnmedBIDUqTrTq+gCDFaf
         srZrArQUQW7x5rD+n8Rx+LhNE/Vvx69avIYlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qnZzsfCO1rz+kcaqGPEMoglv1NqcR2AoY6JVPUNv8YfuzEMWxGWupLKCWwTEYYe2LQ
         voUYPxfnNPbuuE+KXY4aGS/tyeNDQLJh7SGVXYHKElVer6pJvr1bLzQa/DLDTVyvN0t5
         4UXgaBnNvqPTemK/3rnfUEqJ9EH7Ij7pkQmtg=
Received: by 10.142.249.2 with SMTP id w2mr6834661wfh.25.1277773852752;
        Mon, 28 Jun 2010 18:10:52 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-59-120.hsd1.nm.comcast.net [76.113.59.120])
        by mx.google.com with ESMTPS id x34sm8105171wfi.4.2010.06.28.18.10.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 18:10:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.207.ga9fc
In-Reply-To: <1277773936-12412-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149878>

From: Alexander Gladysh <agladysh@gmail.com>

This is a simple testcase where both sides of the rename are paths involved
in (separate) D/F merge conflicts.
---
I hope it's not bad style to take someone else's testcase from the mailing
list and submit it on their behalf as a testsuite addition (nor do I know
what to do about the signed-off-by line in this case).  This is simply the
testcase Alexander Gladysh posted to the list on March 8.  I really like
his example due to how it serves as a simple case where there are two D/F
conflicts with a rename across paths involved in both of those D/F
conflicts.

I'm trying to submit this with Alexander listed as the author, but I'm not
sure how to preserve that when using git-send-email.

 t/t6020-merge-df.sh |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index e71c687..99acb89 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -45,4 +45,36 @@ test_expect_failure 'F/D conflict' '
 	git merge master
 '
 
+test_expect_success 'Setup rename across paths each below D/F conflicts' '
+	git symbolic-ref HEAD refs/heads/newmaster &&
+	rm .git/index &&
+	git clean -fdx &&
+
+	mkdir a &&
+	touch a/f &&
+	git add a &&
+	git commit -m "a" &&
+
+	mkdir b &&
+	ln -s ../a b/a &&
+	git add b &&
+	git commit -m "b" &&
+
+	git checkout -b branch &&
+	rm b/a &&
+	mv a b/ &&
+	ln -s b/a a &&
+	git add . &&
+	git commit -m "swap" &&
+
+	touch f1 &&
+	git add f1 &&
+	git commit -m "f1"
+'
+
+test_expect_failure 'Test rename across paths below D/F conflicts' '
+	git checkout newmaster &&
+	git cherry-pick branch
+'
+
 test_done
-- 
1.7.2.rc0.212.g0c601
