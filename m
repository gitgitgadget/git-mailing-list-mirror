From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 8/9] t9001: refactor sendmail aliases test infrastructure
Date: Sun, 31 May 2015 18:29:30 -0400
Message-ID: <1433111371-19573-9-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBks-0005p2-5H
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633AbbEaWaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:46 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38715 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbbEaWaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:25 -0400
Received: by igbjd9 with SMTP id jd9so48926937igb.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5z919QTNfYrChe1His0LhDpWxweWdoHcCS+hY1jhPo=;
        b=HfzQ/cSkOFLvH0+0z7mjz9YqfdWlLURgrNOU/pzZ1x7zcaxfJqhW9rLAJ18o9jQ3Sd
         odMHRizxnGMUmtiiZAho8d6cQJMP4j9+oT91HELXT8MwQFX1FWKRGkY+fjm0pDKV71ih
         rAhuu0Vh28sqN34ptuqjOmXiBnMb4gkmA0/jNsj2fu3vsznZqa16qFN9N0UKXswEGtZO
         coY9yeZnbuvnt9FwkCKgDaMkQ9y1FBUEAuoHZjJ0rWYIGcRhs7hzCwAqSidXLH1J11h/
         yO0eQAcVU0Q455zJFcA2IYY5njU0gi1Nc5WqIi2vxZsljIHePuMCp/PcpFqxUY0g6sns
         mC/g==
X-Received: by 10.42.255.200 with SMTP id nj8mr25482889icb.18.1433111424908;
        Sun, 31 May 2015 15:30:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.24
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270359>

Several new tests of sendmail aliases parsing will be added in a
subsequent patch, so factor out functionality common to all of them
into a new helper function.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9001-send-email.sh | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a3663da..1012fa3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1549,10 +1549,35 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
 
-test_expect_success $PREREQ 'sendemail.aliasfiletype=sendmail' '
-	clean_fake_sendmail && rm -fr outdir &&
-	git format-patch -1 -o outdir &&
-	cat >>.tmp-email-aliases <<-\EOF &&
+test_sendmail_aliases () {
+	msg="$1" && shift &&
+	expect="$@" &&
+	cat >.tmp-email-aliases &&
+
+	test_expect_success $PREREQ "$msg" '
+		clean_fake_sendmail && rm -fr outdir &&
+		git format-patch -1 -o outdir &&
+		git config --replace-all sendemail.aliasesfile \
+			"$(pwd)/.tmp-email-aliases" &&
+		git config sendemail.aliasfiletype sendmail &&
+		git send-email \
+			--from="Example <nobody@example.com>" \
+			--to=alice --to=bcgrp \
+			--smtp-server="$(pwd)/fake.sendmail" \
+			outdir/0001-*.patch \
+			2>errors >out &&
+		for i in $expect
+		do
+			grep "^!$i!$" commandline1 || return 1
+		done
+	'
+}
+
+test_sendmail_aliases 'sendemail.aliasfiletype=sendmail' \
+	'awol@example\.com' \
+	'bob@example\.com' \
+	'chloe@example\.com' \
+	'o@example\.com' <<-\EOF
 	alice: Alice W Land <awol@example.com>
 	bob: Robert Bobbyton <bob@example.com>
 	# this is a comment
@@ -1561,20 +1586,6 @@ test_expect_success $PREREQ 'sendemail.aliasfiletype=sendmail' '
 	abgroup: alice, bob
 	bcgrp: bob, chloe, Other <o@example.com>
 	EOF
-	git config --replace-all sendemail.aliasesfile \
-		"$(pwd)/.tmp-email-aliases" &&
-	git config sendemail.aliasfiletype sendmail &&
-	git send-email \
-		--from="Example <nobody@example.com>" \
-		--to=alice --to=bcgrp \
-		--smtp-server="$(pwd)/fake.sendmail" \
-		outdir/0001-*.patch \
-		2>errors >out &&
-	grep "^!awol@example\.com!$" commandline1 &&
-	grep "^!bob@example\.com!$" commandline1 &&
-	grep "^!chloe@example\.com!$" commandline1 &&
-	grep "^!o@example\.com!$" commandline1
-'
 
 do_xmailer_test () {
 	expected=$1 params=$2 &&
-- 
2.4.2.538.g5f4350e
