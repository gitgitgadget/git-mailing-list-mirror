From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 9/9] t9001: add sendmail aliases line continuation tests
Date: Sun, 31 May 2015 18:29:31 -0400
Message-ID: <1433111371-19573-10-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkr-0005p2-I2
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbbEaWao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:44 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35331 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758577AbbEaWa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:26 -0400
Received: by igbyr2 with SMTP id yr2so49047728igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fdDpA0aaaVg9rFqThOSrYG2QkmI0KRP+LZ3R6JhpKc=;
        b=YVgSupiMTx5+aF79ZJDeo9jeuA7qS4sn65Y2XmdkD34EME6NUoELynLE4boTanVKcA
         6FXd/Rk2BoykZP2cFL+FjGAcwJfUTnmyV1PVYJc+riJ+E3Jju6M/ze5Z2MaOfhtZDTpC
         wqokBX4BeszitZVU+6fipPFFe4zas++MF6kw5/7Hsk7476vBLcgktPi6qW4O/z+oM1kn
         vj/T0T65CmeoEPkkQNY2HZ37NtmUtvpV/moI0EJ3HZan/VvKQDy3T1oFs5WEWF92qcjb
         lTq1fnLjh3jqTYXTq2txmKsqj2dm8HwouJ0RYHpeWeKN8OPYEMUKfN4FKwbKGuvZ8TUV
         +5xA==
X-Received: by 10.43.56.146 with SMTP id wc18mr25982298icb.24.1433111425550;
        Sun, 31 May 2015 15:30:25 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.24
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270364>

A line beginning with whitespace is folded into the preceding line.
A line ending with '\' consumes the following line.

While here, also test an empty sendmail aliases file.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9001-send-email.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1012fa3..db2f45e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1587,6 +1587,40 @@ test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
 	bcgrp: bob, chloe, Other <o@example.com>
 	EOF
 
+test_sendmail_aliases 'sendmail aliases line folding' \
+	alice1 \
+	bob1 bob2 \
+	chuck1 chuck2 \
+	darla1 darla2 darla3 \
+	elton1 elton2 elton3 \
+	fred1 fred2 \
+	greg1 <<-\EOF
+	alice: alice1
+	bob: bob1,\
+	bob2
+	chuck: chuck1,
+	    chuck2
+	darla: darla1,\
+	darla2,
+	    darla3
+	elton: elton1,
+	    elton2,\
+	elton3
+	fred: fred1,\
+	    fred2
+	greg: greg1
+	bcgrp: bob, chuck, darla, elton, fred, greg
+	EOF
+
+test_sendmail_aliases 'sendmail aliases tolerate bogus line folding' \
+	alice1 bob1 <<-\EOF
+	    alice: alice1
+	bcgrp: bob1\
+	EOF
+
+test_sendmail_aliases 'sendmail aliases empty' alice bcgrp <<-\EOF
+	EOF
+
 do_xmailer_test () {
 	expected=$1 params=$2 &&
 	git format-patch -1 &&
-- 
2.4.2.538.g5f4350e
