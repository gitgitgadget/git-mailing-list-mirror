From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/2] git-p4: add failing test for submit from detached head
Date: Sat,  5 Sep 2015 15:02:17 +0100
Message-ID: <1441461738-25066-2-git-send-email-luke@diamand.org>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 16:02:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYE3E-0004KV-Nf
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 16:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbbIEOCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 10:02:34 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37082 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbIEOCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 10:02:32 -0400
Received: by wicfx3 with SMTP id fx3so42546564wic.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xhlNTyKpwOXM0ElDxkONveVX4LMce0rB9ipJxOlMSj8=;
        b=g5VEjS6C3lvLDmqjpepK3hX5JcpbdVnSAYSY/74BPOf/0v3/4gx5TdDjJFti8jcygf
         jLeKcbP4hItxAiAo6BeO1DxN/q+j6D4Zh1kDVvFzH7ir1MjSQ/Z9qxeJ9aOx1Hg/YxJ4
         0rkd6hWi/Ydj+5tmRWn3TDepoh9Nc66uevhaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xhlNTyKpwOXM0ElDxkONveVX4LMce0rB9ipJxOlMSj8=;
        b=EJjxsaw7LjCZQ149A/wF0FptvcKymIn8WAYHi5ORIYmCOmTlXNn5zZp2wXcyz8x0Na
         tqhzKsfs/2i5AhuJzCq5aVaVpquonMmjJzJeu0vWxRJTwH1Fjw+vQJhAoE4KX7O7WzZN
         Z6JUxKZ5CmZnQYorCg7DNhiu08hjVoW0RiQZ1vBxiFAT2tYuwX3Q4kmbm5pUm1v93G1G
         OjRiHMZIgSVfJC0elImX4dz7MJN/GCc452Di0/rEwePQzO+aYPK2DHm1K6Q0c39Xz/XZ
         pgM8HRzju6rE5azZJbYtLWyT6xADzLevSeOn7bmjS6WbYftsw3j4i1Y4svWpwRTsQDmh
         63bg==
X-Gm-Message-State: ALoCoQmJ9uNVn+o/lVNQ5E+TY4sEJAuPom0TDZIWLmcYYanIav7MqRZ055z8WBSn3enUadArWTR6
X-Received: by 10.180.10.170 with SMTP id j10mr17699582wib.77.1441461750731;
        Sat, 05 Sep 2015 07:02:30 -0700 (PDT)
Received: from lgd-kipper.local.diamand.org (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id fs8sm10225413wib.0.2015.09.05.07.02.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2015 07:02:30 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.133.ga438a11.dirty
In-Reply-To: <1441461738-25066-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277381>

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
2.6.0.rc0.133.ga438a11.dirty
