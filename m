From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] t3404: preserve test_tick state across short SHA-1 collision test
Date: Wed, 21 Aug 2013 15:12:56 -0400
Message-ID: <1377112378-45511-2-git-send-email-sunshine@sunshineco.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 21:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDqS-0004k4-9h
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512Ab3HUTNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:13:17 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:56055 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3HUTNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:13:15 -0400
Received: by mail-ob0-f172.google.com with SMTP id er7so1643273obc.31
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=asXN/d44ocU0M2NVU4UWgTc5p4S7UZa8f+BwhoYlZDA=;
        b=Cotpkketkjpub216EDcIDtlOGaxihD1Ke2oQxnpxvtB2WHHIP0LrxS2/06i+V6akZX
         TwYimduc4m11k2qV/MBolJE68I6f+jWotfsW6j7L6pAHY6FrLktqFBGjIt94h/rpVp5K
         Ui0SNZIQ7EhNU1m0lc2BIiuESFV5lEsB2zTqFn99r8Dj/G5nF+Kt4qPNWOn1a73+i7bN
         cBftIyB3DVKoyX6MXNa+ffGNTLTV4lNqqkbBKXVEeGNSJC3TjTA2r7H036wFI8BqIEtu
         KXo5DPVBk/xB5WTCb/ihfFZUuNCxE7J9nGZg8hAvrtHiww2jwKGSlVBPZOUsWQrsGaUg
         fuYg==
X-Received: by 10.182.236.169 with SMTP id uv9mr9667122obc.59.1377112393930;
        Wed, 21 Aug 2013 12:13:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm12357303obi.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 12:13:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.499.gfb33910
In-Reply-To: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232721>

The short SHA-1 collision test requires carefully crafted commits in
order to ensure a collision at rebase time. This involves managing state
which impacts the resulting SHA-1, including commit time. To accomplish
this, test_tick is set to a known state for the short SHA-1 collision
test.

Unfortunately, doing so throws away the existing state of test_tick,
which may be problematic for subsequently added tests. Fix this by
preserving the existing state of test_tick across the short SHA-1
collision test.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3404-rebase-interactive.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b65b774..6be97ba 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -994,17 +994,23 @@ test_expect_success 'short SHA-1 setup' '
 	test_when_finished "git checkout master" &&
 	git checkout --orphan collide &&
 	git rm -rf . &&
+	(
 	unset test_tick &&
 	test_commit collide1 collide &&
 	test_commit --notick collide2 collide &&
 	test_commit --notick "collide3 115158b5" collide collide3 collide3
+	)
 '
 
 test_expect_success 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
+	(
+	unset test_tick &&
+	test_tick &&
 	FAKE_COMMIT_MESSAGE="collide2 815200e" \
 	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
+	)
 '
 
 test_done
-- 
1.8.4.rc4.499.gfb33910
