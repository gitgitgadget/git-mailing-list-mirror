From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [RFC-PATCH 2/2] t9001: adding --quote-mail option test
Date: Mon, 23 May 2016 21:30:29 +0200
Message-ID: <1464031829-6107-3-git-send-email-tom.russello@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:32:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vaQ-00033H-8T
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbcEWTcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:32:12 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:58717 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbcEWTcL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:32:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D1AC4210B;
	Mon, 23 May 2016 21:32:08 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VtFoL24ZJD90; Mon, 23 May 2016 21:32:08 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B1684210A;
	Mon, 23 May 2016 21:32:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id AE2712077;
	Mon, 23 May 2016 21:32:08 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTK7eG-CtRsJ; Mon, 23 May 2016 21:32:08 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 705412066;
	Mon, 23 May 2016 21:32:08 +0200 (CEST)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295380>

From: Tom Russello <tom.russello@ensimag.grenoble-inp.fr>

Tests if the "To", "Cc" and "Subject" fields are adequately filled and if the
message is correctly quoted.

Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>

---


diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b3355d2..bda4018 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1885,4 +1885,47 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	test_cmp expected-list actual-list
 '
 
+test_expect_success $PREREQ 'setup expect' '
+	cat >email <<-\EOF
+	Message-Id: <author_123456@example.com>
+	From: author@example.com
+	To: to1@example.com
+	Cc: cc1@example.com
+	Date: Sat, 12 Jun 2010 15:53:58 +0200
+	Subject: subject goes here
+
+	Have you seen my previous email?
+	> Previous content
+	EOF
+'
+
+test_expect_success $PREREQ 'From, To, Cc, Subject with --quote-mail are correct' '
+	clean_fake_sendmail &&
+	git send-email \
+		--quote-mail=email \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "From: Example <nobody@example.com>" msgtxt1 &&
+	to_adr=$(awk "/^To: /,/^Cc: /" msgtxt1) &&
+	echo "$to_adr" | grep author@example.com &&
+	echo "$to_adr" | grep to1@example.com &&
+	grep "Cc: cc1@example.com" msgtxt1
+'
+test_expect_success $PREREQ 'the message given is quoted with --quote-mail' '
+	grep "> Have you seen my previous email?" msgtxt1 &&
+	grep ">> Previous content" msgtxt1
+'
+test_expect_success $PREREQ 'Check if Re is written, only once with --quote-mail' '
+	grep "Subject: Re: subject goes here" msgtxt1 &&
+	git send-email \
+		--quote-mail=msgtxt1 \
+		--from="Example <nobody@example.com>" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		-1 \
+		2>errors &&
+	grep "Subject: Re: subject goes here" msgtxt3
+'
+
 test_done
-- 
2.8.2
