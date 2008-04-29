From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add tests for sendemail.cc configuration variable
Date: Tue, 29 Apr 2008 12:56:47 +0200
Message-ID: <1209466607-10454-1-git-send-email-vmiklos@frugalware.org>
References: <7vprsbf3hz.fsf@gitster.siamese.dyndns.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 13:09:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqnht-00033p-11
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 13:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbYD2LIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 07:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbYD2LIW
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 07:08:22 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:40530 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbYD2LIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 07:08:21 -0400
X-Greylist: delayed 683 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Apr 2008 07:08:21 EDT
Received: from vmobile.example.net (dhcp-79.r.wlan.bme.hu [152.66.144.79])
	by yugo.frugalware.org (Postfix) with ESMTP id CDA7E1DDC5B;
	Tue, 29 Apr 2008 12:56:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7722B18610C; Tue, 29 Apr 2008 12:56:47 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <7vprsbf3hz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80678>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Apr 27, 2008 at 01:26:48PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks, the idea makes sense.
>
> Tests?

Here it is.

(Sorry for the duplication, I forgot to CC the list.)

 t/t9001-send-email.sh |   66 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index c0973b4..af655cf 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -166,4 +166,70 @@ test_expect_success 'second message is patch' '
 	grep "Subject:.*Second" msgtxt2
 '
 
+cat >expected-show-all-headers <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<cc@example.com>,<author@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: cc@example.com, A <author@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success 'sendemail.cc set' '
+	git config sendemail.cc cc@example.com &&
+	git send-email \
+		--dry-run \
+		--from="Example <from@example.com>" \
+		--to=to@example.com \
+		--smtp-server relay.example.com \
+		$patches |
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		>actual-show-all-headers &&
+	test_cmp expected-show-all-headers actual-show-all-headers
+'
+
+cat >expected-show-all-headers <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success 'sendemail.cc unset' '
+	git config --unset sendemail.cc &&
+	git send-email \
+		--dry-run \
+		--from="Example <from@example.com>" \
+		--to=to@example.com \
+		--smtp-server relay.example.com \
+		$patches |
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		>actual-show-all-headers &&
+	test_cmp expected-show-all-headers actual-show-all-headers
+'
+
 test_done
-- 
1.5.5.1.100.ge64d7
