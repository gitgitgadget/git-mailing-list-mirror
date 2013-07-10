From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC/PATCH 2/4] t4203: test check-mailmap command invocation
Date: Wed, 10 Jul 2013 15:03:59 -0400
Message-ID: <1373483041-27901-3-git-send-email-sunshine@sunshineco.com>
References: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 21:05:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwzhO-00077A-9f
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 21:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab3GJTFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 15:05:03 -0400
Received: from mail-gh0-f175.google.com ([209.85.160.175]:42001 "EHLO
	mail-gh0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab3GJTFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 15:05:01 -0400
X-Greylist: delayed 133778 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2013 15:05:00 EDT
Received: by mail-gh0-f175.google.com with SMTP id z19so2538513ghb.34
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=YcEbDP2qF6ORmEKjrOeseTJHKVt6uHND3w2H+/Lxg7c=;
        b=RMPCjlT3XkfKy4E/RCiBnybQjjeB6UsiZ1RbXPYGm+/EeLBxPNFQ6cATZRHhnY9fm+
         c8d2/4fumimp4OU5itIAhvo7UYtcQhDCerIa9nl78LjxM7onSQq04OByAOSk0/xMMFDB
         gQCfPrSuuZTwodddOPokalSA6eTkejQQvTjC7AD9P4yZlJY2Elz8/+gCtS/l0gbQWNW3
         K88noWPRchEEUTgwAX8y0GcTxuhlvfqTmwNXwlfP0w3ZJhzNc+0K0MOHTQ9clJXnBsD1
         Hkj44wDFB4sa/OpFD5mB+DFYrkm0YpnCxXG8jbt9b+ikNSgT7jk7UcSr54mbz4pCiY2g
         8shg==
X-Received: by 10.236.155.105 with SMTP id i69mr18980651yhk.159.1373483100288;
        Wed, 10 Jul 2013 12:05:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id 66sm54426527yhe.20.2013.07.10.12.04.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 12:04:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373483041-27901-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230067>

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
