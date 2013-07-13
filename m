From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/2] t4203: test check-mailmap command invocation
Date: Fri, 12 Jul 2013 20:53:11 -0400
Message-ID: <1373676791-42758-3-git-send-email-sunshine@sunshineco.com>
References: <1373676791-42758-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 02:54:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxo66-00046F-Be
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 02:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab3GMAx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 20:53:58 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48573 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980Ab3GMAx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 20:53:56 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so21047141iec.7
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GMbW8/K8h45WAP03tqvJKmCNEe24+ejwoNttKPArwd4=;
        b=mHDRxK6B2/mj6ffUiaSmSEqc3BdQt3PwtoPwbMsVW9m20k+WeFkftpyhO/Klp7w30z
         mzJB4tdsPZxXDvz3vmH9ZuFffwCbcOy2yrlW9KCcke+ZF+kWFHOX/ItVw2Mi8r51T1mJ
         BSpF/A9ic+K84XAebACthslPZZ0K74Bztil2Ub1g6LwOmn+7fZJzpWnhMsKiKa+VeKeQ
         /6gQZkfWR609rf4rN3CxLVwzDCuJYPkN6CMjJXfzMUxOt/BKBZd7bfC2CS50v58A8oUc
         V3210R3b7WsL5mVMbhVNymVKJ47toSV88v9DEhhJnBN0UPZmX8MU1IKwNvrXSoCzB07Z
         DDvA==
X-Received: by 10.50.47.12 with SMTP id z12mr1692442igm.50.1373676836468;
        Fri, 12 Jul 2013 17:53:56 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id nm17sm2562384igb.5.2013.07.12.17.53.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 17:53:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373676791-42758-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230271>

Test the command-line interface of check-mailmap.

(Actual .mailmap functionality is already covered by existing tests.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4203-mailmap.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..b7476f2 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -13,6 +13,11 @@ fuzz_blame () {
 }
 
 test_expect_success setup '
+	cat >contacts <<-\EOF &&
+	A U Thor <author@example.com>
+	nick1 <bugs@company.xx>
+	EOF
+
 	echo one >one &&
 	git add one &&
 	test_tick &&
@@ -23,6 +28,44 @@ test_expect_success setup '
 	git commit --author "nick1 <bugs@company.xx>" -m second
 '
 
+test_expect_success 'check-mailmap no arguments' '
+	test_must_fail git check-mailmap
+'
+
+test_expect_success 'check-mailmap arguments' '
+	cat >expect <<-\EOF &&
+	A U Thor <author@example.com>
+	nick1 <bugs@company.xx>
+	EOF
+	git check-mailmap \
+		"A U Thor <author@example.com>" \
+		"nick1 <bugs@company.xx>" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --stdin' '
+	cat >expect <<-\EOF &&
+	A U Thor <author@example.com>
+	nick1 <bugs@company.xx>
+	EOF
+	git check-mailmap --stdin <contacts >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap --stdin arguments' '
+	cat >expect <<-\EOF &&
+	Internal Guy <bugs@company.xy>
+	EOF
+	cat <contacts >>expect &&
+	git check-mailmap --stdin "Internal Guy <bugs@company.xy>" \
+		<contacts >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-mailmap bogus contact' '
+	test_must_fail git check-mailmap bogus
+'
+
 cat >expect <<\EOF
 A U Thor (1):
       initial
-- 
1.8.3.2.804.g0da7a53
