From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t3400 (rebase): add failing test for a peculiar rev spec
Date: Thu, 18 Apr 2013 14:22:35 +0530
Message-ID: <1366275155-26244-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 18 10:51:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USkYp-0007mM-N3
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 10:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966658Ab3DRIvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 04:51:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:63628 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965897Ab3DRIvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 04:51:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa11so1443781pad.41
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Fd9tChjrnB5h8/aO2w66okzzseTZ2lDQb8CRelBv8GU=;
        b=0UoJ3BTRe8ut5B7tvhR+Y85WaZTcXcEiOUzbgWFMRqK0C4rsEoQbjl5NJVHUkv+u+0
         YYPBMA0ZilxNc16od0wmBH1wNmFz3/qGaen4v7z8WNPW+5Peib4L9ZjhECbAfU8bjkg5
         UUmZeWzwfABrkKgk4R8W6ilQFpXIKHt/0t+yCdI7hP4v4wMgay5rzI+GFXkthmIGbp9m
         Pf7QPvCu0PTmclZpgWtmQEMm8/RNRoFPy7a5xQB0ODqa22oQQAXzr3NaBnbMrKUv+0mB
         KU56T5RUZlAmgkopW517BNJ5NGS6UfBSpy3C5cpa13Vn8YBmDIgU8f5/ZWQChSsqtPwp
         mGkg==
X-Received: by 10.68.16.164 with SMTP id h4mr12647199pbd.122.1366275070605;
        Thu, 18 Apr 2013 01:51:10 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ms9sm9157262pbc.20.2013.04.18.01.51.08
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 01:51:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.423.g4fb5c0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221628>

'git rebase' does not recognize revisions specified as :/text.  This
is because the attempts to rev-parse ${REV}^0, which fails in this
case.  Add a test to document this failure.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Okay, so I'm not sure what the right fix for this is.

 - The :/text syntax seems to be broken in the first place, as it
   can't be combined with ^ or @.  I'd like to be able to say
   {:/bardery}^1, or even {:/foomery}^{/communist mule}.  Why
   shouldn't I be allowed to do this?

 - The failure occurs in git-rebase.sh:403.  Is it using the ^0 only
   to make sure that the revision specified is a commit?  Surely,
   there'a a better way to do this?

 Can someone point me in the right direction?

 t/t3400-rebase.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index f6cc102..42ca1e0 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -88,6 +88,14 @@ test_expect_success 'rebase fast-forward to master' '
 	test_i18ngrep "Fast-forwarded HEAD to my-topic-branch" out
 '
 
+test_expect_failure 'rebase against revision specified as :/text' '
+	git checkout my-topic-branch^ &&
+	sha1=$(git rev-parse ":/Add B") &&
+	git rebase $sha1 &&
+	git checkout my-topic-branch^ &&
+	git rebase ":/Add B"
+'
+
 test_expect_success 'the rebase operation should not have destroyed author information' '
 	! (git log | grep "Author:" | grep "<>")
 '
-- 
1.8.2.1.423.g4fb5c0a.dirty
