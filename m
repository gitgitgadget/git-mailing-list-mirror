From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 1/3] git-p4: add failing test for submit from detached head
Date: Sat, 21 Nov 2015 09:54:39 +0000
Message-ID: <1448099681-20183-2-git-send-email-luke@diamand.org>
References: <1448099681-20183-1-git-send-email-luke@diamand.org>
Cc: larsxschneider@gmail.com, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, sunshine@sunshineco.com,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 10:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a04st-0007uB-2q
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 10:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759815AbbKUJy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2015 04:54:59 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36044 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbbKUJy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2015 04:54:57 -0500
Received: by pacdm15 with SMTP id dm15so141301203pac.3
        for <git@vger.kernel.org>; Sat, 21 Nov 2015 01:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=veoDl+NiDAdbO3zqlvCKeGxtOlqwZ9Z2eIm46ZlqKNA=;
        b=T0WHmcBsmD6uIsUzurQfxKAtnGl79poVXZ5Lp3NtN9D9TKaQAc4xeF3NxRbBGT+C5r
         vvVclWE4E12eDJfr84RjmVw6lxjg84gGyttjeBNhXQl2Akv+7CF/zOLjuAHfizDECjpx
         c4v7IfkMlWWtYFHR2PRyNzyjgbYCxcqn0IrXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=veoDl+NiDAdbO3zqlvCKeGxtOlqwZ9Z2eIm46ZlqKNA=;
        b=kGVtv0hYmRGzjqH37fhvUZRfdseRUI7IAoKidgaVo1rnPsPqZztUTMnLELT6hGAQU+
         geUuGJa8DLsmS3YLmI26ej1crgHjdyjBHKXFV89aaw1ColacwoNeL7vo9jchVebPPrXn
         umdgLCR+0hsCw5c+HVHFWqNbRng6DCdL2QMkX4T/u4zcCHhi99NIyfcYoHEKzfJ+QYA/
         tU6qqGW5u2dB0NDcTcCC5tDgPOtxDdZ2g4iuzozwl/LNPS1I2IBKo/lHNNLZ9rvxVsfi
         JRHY4RcL3MR/KG3sqYmnFjwfI1pSYUemG/RxCH5B8xmOsTc0/psJVTSQzzsd+s1BWFC0
         iBTQ==
X-Gm-Message-State: ALoCoQn9qTp3TNGgsbRDtPRG3pRvSahSickMWa7JXpIjyV4XNv4f67BEVz+JNcDZ2vFsBSXXZpf/
X-Received: by 10.68.103.227 with SMTP id fz3mr24448728pbb.159.1448099696773;
        Sat, 21 Nov 2015 01:54:56 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id xi8sm2949984pab.9.2015.11.21.01.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Nov 2015 01:54:56 -0800 (PST)
X-Mailer: git-send-email 2.6.3.492.g06488d6
In-Reply-To: <1448099681-20183-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281549>

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
