From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] t4203: test check-mailmap command invocation
Date: Thu, 11 Jul 2013 10:55:26 -0400
Message-ID: <1373554528-15775-3-git-send-email-sunshine@sunshineco.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 16:56:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxII9-00006J-Bz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 16:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514Ab3GKO4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 10:56:16 -0400
Received: from mail-ye0-f174.google.com ([209.85.213.174]:35418 "EHLO
	mail-ye0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497Ab3GKO4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 10:56:14 -0400
Received: by mail-ye0-f174.google.com with SMTP id m9so2794312yen.19
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YcEbDP2qF6ORmEKjrOeseTJHKVt6uHND3w2H+/Lxg7c=;
        b=OPsAnvi1JlWsagtNdKav0xX0E85blBVFwj1wyXDHbSFMe8L3G2YkTm83KcI7hPey1H
         AYMkJjw4iwBsE2hVWOCQIkGJRrof9iNoNtk2J2yF8z7cvKCW2YpHUUPRNAbR+cuP45ce
         UR95ilTuw7kZKGZhWjrn1GvHbnPWiArQiolJRvF71k5/BYIlAN/29l/BtRLEhtqqEQEv
         aqOyr/hK5qGRsD0vE0PNPa2hyj/FQNiSaA8j0pMqafyJo57Qgwd12TR6i85JdbGdIfTN
         tXOutUDLh8h8/D6cN1IyhFj/v5C0+YT51gf5uhksBrGdwN4LaAfsZKklrs9uxn0bZ4OY
         tImA==
X-Received: by 10.236.140.132 with SMTP id e4mr20512570yhj.144.1373554574326;
        Thu, 11 Jul 2013 07:56:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id s29sm60841065yhf.6.2013.07.11.07.56.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 07:56:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230101>

Test the command-line interface of check-mailmap. (Actual .mailmap
functionality is already covered by existing tests.)

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4203-mailmap.sh | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..8645492 100755
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
@@ -23,6 +28,51 @@ test_expect_success setup '
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
+test_expect_success 'check-mailmap -z' '
+	printf "A U Thor <author@example.com>\0" >expect &&
+	printf "nick1 <bugs@company.xx>\0" >>expect &&
+	git check-mailmap -z --stdin <contacts >actual &&
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
1.8.3.2
