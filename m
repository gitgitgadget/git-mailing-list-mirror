From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 1/3] git-p4: add failing test for submit from detached head
Date: Sat,  7 Nov 2015 01:07:51 +0000
Message-ID: <1446858473-19911-2-git-send-email-luke@diamand.org>
References: <1446858473-19911-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, sunshine@sunshineco.com,
	larsxschneider@gmail.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 02:08:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zurzb-0006z2-A2
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 02:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbbKGBIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 20:08:10 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35444 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbbKGBIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 20:08:05 -0500
Received: by pasz6 with SMTP id z6so142564029pas.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 17:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=veoDl+NiDAdbO3zqlvCKeGxtOlqwZ9Z2eIm46ZlqKNA=;
        b=J1660pMwkpgw1eNyKcOOG4HVxuKqG/4frU3a2Vp5Rfg3QH9wDvaiUAok2H/lTkKaVD
         N9phY4+gp9oiWnIGBKCZbyzoO7yp5yRLM5urokdG1qjHXg5cLcmt/BASIimzeFtTfhWR
         IMmjDWO0F22UO90pVS2fQhC2FmYEtzZjYCH4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=veoDl+NiDAdbO3zqlvCKeGxtOlqwZ9Z2eIm46ZlqKNA=;
        b=YwgOpGnmpO4/eM61SgTfMVtD0uI5MsKHPp3sZOEKAGJYQ/tWinFXADO2y73/aYcdlb
         SKP74CZTGNXAwGokGarSlIO+LBJP8BC2EoWl/LcA6zBjIL4HLSNdXOyUFbDMR68yydjb
         7NOj1DGDV66kPWVk4sfV9vHHuCQ2RljvbNLWsEQbU00Ng7y3AhE8nvnyhkuCaSqcx92c
         29LCLXylIXhc/3Tz6ZckDw2NFqW31FxGFBR+17RxCrirygwP40bXV4bfwdbZvj0XSagT
         x+7Nxbb/guQ+Ig6pxbQIwS+SGt78maTf3UPwARPhDd+sh6mVgl9hn/GQzMe2koKQnc8M
         WMuw==
X-Gm-Message-State: ALoCoQmoVRBSZ27EIUS0RnMxZvK1gWGg8yrKSx95/I93Xmiv6ARrs2wu5fCf+YwdWSioP6m5eM5P
X-Received: by 10.66.141.231 with SMTP id rr7mr12231305pab.123.1446858485074;
        Fri, 06 Nov 2015 17:08:05 -0800 (PST)
Received: from lgd-kipper.local ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id t13sm2239577pbs.88.2015.11.06.17.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2015 17:08:04 -0800 (PST)
X-Mailer: git-send-email 2.6.0.rc3.238.gc07a1e8
In-Reply-To: <1446858473-19911-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281009>

git-p4 can't submit from a detached head. This test case
demonstrates the problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9800-git-p4-basic.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 90d41ed..114b19f 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -241,6 +241,22 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 	)
 '
 
+test_expect_failure 'submit from detached head' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git checkout p4/master &&
+		>detached_head_test &&
+		git add detached_head_test &&
+		git commit -m "add detached_head" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit &&
+		git p4 rebase &&
+		git log p4/master | grep detached_head
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.6.0.rc3.238.gc07a1e8
