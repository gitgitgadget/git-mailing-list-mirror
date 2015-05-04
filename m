From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] t1007: add hash-object --literally tests
Date: Mon,  4 May 2015 03:25:14 -0400
Message-ID: <1430724315-524-3-git-send-email-sunshine@sunshineco.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 09:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpAlM-0005IC-DX
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 09:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbbEDHZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 03:25:41 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35971 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbbEDHZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 03:25:37 -0400
Received: by igblo3 with SMTP id lo3so76951291igb.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPMF9KqJmS6JxPPFeIcdmYka6Mr1DInm9Hz+gTHD0bw=;
        b=WcGhNSvhnKpR8NtE9IfFkfCU3kidnHJToylmIZcczKfmK9UwJy2R6u1P4Q66eK5nuW
         j6DNcxMbIh/oemtp91xQEBQSKHSq0lRsgwMPaPZ3F6K4LtdgnP0TiCnhdx6zLnW1KQ2P
         9EwzqHTMWZNy3Js4MPZdsU73kGwtNsktXROvwndxXef1HT/FBRfl1AE/TG4qfmG1zaPB
         Ad7Ysyg1ub3navkRl3RW3+cRViJiZYg7Pf+btn8txmqpOTI+Hwt8JdLe8DGqx5Shszh1
         TjGWmubS8zY+/WYuIiXO6B09IaZdGfpXRcmJTWk3AszQfily81H/AncFeibRhcX7JO0J
         IptQ==
X-Received: by 10.43.129.130 with SMTP id hi2mr18335591icc.18.1430724336428;
        Mon, 04 May 2015 00:25:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id r4sm4707630igw.12.2015.05.04.00.25.35
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 00:25:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.319.g7a04823
In-Reply-To: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268309>

git-hash-object learned a --literally option in 5ba9a93 (hash-object:
add --literally option, 2014-09-11). Check that --literally allows
object creation with a bogus type.

Also add a failing test demonstrating a crash (buffer overflow leading
to stack corruption) when the bogus type is lengthy.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Although the crash seems to have manifested[1] only on Mac OS X when
testing Karthik's "cat-file --allow-unknown-type" series, I made the
bogus object type extremely long in the failing test included here in
order to ensure that it manifests (hopefully) everywhere. At this
length, the crash manifest on Linux as well.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/268262/focus=268304

 t/t1007-hash-object.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f83df8e..0e65577 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -201,4 +201,15 @@ test_expect_success 'corrupt tag' '
 	test_must_fail git hash-object -t tag --stdin </dev/null
 '
 
+test_expect_success '--literally' '
+	t=1234567890 &&
+	echo example | git hash-object -t $t --literally --stdin
+'
+
+test_expect_failure '--literally with extra-long type' '
+	t=12345678901234567890123456789012345678901234567890 &&
+	t="$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t" &&
+	echo example | git hash-object -t $t --literally --stdin
+'
+
 test_done
-- 
2.4.0.319.g7a04823
