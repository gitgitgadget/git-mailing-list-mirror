From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t4202 (log): add test for --follow over a merge
Date: Mon, 22 Apr 2013 20:48:32 +0530
Message-ID: <1366643912-3942-1-git-send-email-artagnon@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:17:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIUT-00056j-V7
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab3DVPRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:17:07 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:55091 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3DVPRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:17:06 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so3640064pdj.41
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Cmzo0Kj+kDBMR1IqIqNRA6Ia/PvRADNZAHs1TItM9So=;
        b=IDmb0BfidSXqyT9u0AutJ6azTqdStsB+tRqLevXN+HuSLXSMY17fGXlbyZH8wCSjn0
         6gXX+Lo7PYSpL776KoyReDpdX5ph11m+pysc6R+KMVF6uMfgAfvzBBB2h+Kr9BbN2h+t
         mZMBdzAeTowCS2ecb+0OTPQGX2jD/AEQ2IShQFA98yMZMnSwZGc3h510WXbHm4QOBwWQ
         2X68ILDaibCY1QSa6XhXMgmsVwl253rPH7APjqJi0qfRIc2xagMCi1YKeKnxZ+FVdXpW
         wYSKyWC9SfBDh9i5yO0mh35uHJstmCa/xk+rlN7teT4LoAQT04dRSWwBQVvt93jz/ftv
         kOxA==
X-Received: by 10.68.41.227 with SMTP id i3mr32513518pbl.139.1366643825062;
        Mon, 22 Apr 2013 08:17:05 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id kd7sm25499515pbb.34.2013.04.22.08.17.02
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 08:17:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.546.gea3475a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222022>

The --follow feature can be used to follow the history of a file over
a merge commit, and is useful even when the file hasn't been
copied/renamed.  Add a test to show off this feature.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I haven't updated the documentation, because I can't claim to
 understand --follow fully without reading the code (doing that now).
 In the meantime, I'm contributing a patch I wrote out originally as
 an example for Thomas Rast to prove a point.

 Where should this go?  What is t4206-log-follow-harder-copies (it
 just has one test which isn't even that special)?  Should we move all
 the --follow tests out of this file and put it in a separate file?

 t/t4202-log.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 523c1be..5b041fd 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -168,6 +168,35 @@ test_expect_success 'git log --follow' '
 
 '
 
+test_expect_success '--follow over merge' '
+	git checkout -b featurebranch
+	echo foodle >>ichi &&
+	git add ichi &&
+	test_tick &&
+	git commit -m "add a line to the end of ichi" &&
+	echo moodle >unrelated &&
+	git add unrelated &&
+	test_tick &&
+	git commit -m quux &&
+	git checkout master &&
+	mv ichi ichi.bak &&
+	echo gooble >ichi &&
+	cat ichi.bak >>ichi &&
+	git add ichi &&
+	test_tick &&
+	git commit -m "add a line to the beginning of ichi" &&
+	git merge featurebranch &&
+	git log --follow --oneline ichi >actual &&
+	cat >expect <<-\EOF &&
+	df26551 add a line to the beginning of ichi
+	882d8d9 add a line to the end of ichi
+	2fbe8c0 third
+	f7dab8e second
+	3a2fdcb initial
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_failure 'log pathspec in tree read into prefix' '
 	git checkout --orphan subtree &&
 	git rm -rf . &&
-- 
1.8.2.1.546.gea3475a
