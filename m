From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2] send-email: Use To: headers in patch files
Date: Wed, 29 Sep 2010 00:26:44 -0700
Message-ID: <1285745204-22443-1-git-send-email-bebarino@gmail.com>
References: <AANLkTimTmfORavF6pNGjC6L46_f+GOaz86jEzBPYUxF2@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 09:26:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0r46-0002v4-HL
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 09:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0I2H0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 03:26:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41247 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab0I2H0w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 03:26:52 -0400
Received: by gwj17 with SMTP id 17so172434gwj.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=NwV9IiBvg1hWXwJ+zsg5NUAJnQHaIuy/xZFzG1+WPDU=;
        b=nD/YzXv5Y9Eo+pd3NPU31RXbswJ73LCYC4+RuhpbZ8phs1+/pIqhcqMZ7WLP0eKkOb
         /5Tk0D73f2m6C8xgegScNhYu0EZS1CnrEp6ucMgNC25Kij4ikhUIaboV4ds8hf08lGTj
         htgh639FAazV8LqaJpQj1HDWlFJpq6i8E6Ggk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gm78w1bQstDFigonfWxOWYSTZq7cEaQTA94NN6ZBpVL7V8Hiw4BSCcdOV8XEmXCGYq
         Jsqv18zp3mzmVqkPc2HewdbSPij96cogeSPJ5/Wb7AL9HOmeM0ak4o2RvgEDqTEDVwaY
         zidJqLCs56tSBOpi0btusTO5oqBDpss3VgGtQ=
Received: by 10.151.113.8 with SMTP id q8mr1434992ybm.399.1285745211495;
        Wed, 29 Sep 2010 00:26:51 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id x3sm8232232ybl.22.2010.09.29.00.26.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 00:26:50 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 29 Sep 2010 00:26:45 -0700
X-Mailer: git-send-email 1.7.3.16.g5d4d9
In-Reply-To: <AANLkTimTmfORavF6pNGjC6L46_f+GOaz86jEzBPYUxF2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157539>

It's a minor annoyance when you take the painstaking time to setup To:
headers for each patch in a large series, and then go out to send the
series with git-send-email and watch git ignore the To: headers in the
patch files.

Therefore, always add To: headers from a patch file to the To: headers
for that message. Keep the prompt for the blanket To: header so as to
not break scripts (and user expectations). This means even if a patch
has a To: header, git will prompt for the To: address. Otherwise, we'll
need to introduce interface breakage to either request the header for
each patch missing a To: header or default the header to whatever To:
address is found first (be it in a patch or from user input). Both of
these options don't seem very obvious/useful.

Reported-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Stephen Boyd <bebarino@gmail.com>
Tested-by: Viresh Kumar <viresh.kumar@st.com>
---

Changes since v1:
 - Added test_when_finished calls.

 git-send-email.perl   |    7 +++++++
 t/t9001-send-email.sh |   24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e1f29a7..d6028ec 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1176,6 +1176,13 @@ foreach my $t (@files) {
 					$1, $_) unless $quiet;
 				push @cc, $1;
 			}
+			elsif (/^To:\s+(.*)$/) {
+				foreach my $addr (parse_address_line($1)) {
+					printf("(mbox) Adding to: %s from line '%s'\n",
+						$addr, $_) unless $quiet;
+					push @to, sanitize_address($addr);
+				}
+			}
 			elsif (/^Cc:\s+(.*)$/) {
 				foreach my $addr (parse_address_line($1)) {
 					if (unquote_rfc2047($addr) eq $sender) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 71b3df9..294e31f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -947,6 +947,30 @@ test_expect_success $PREREQ '--no-bcc overrides sendemail.bcc' '
 	! grep "RCPT TO:<other@ex.com>" stdout
 '
 
+test_expect_success $PREREQ 'patches To headers are used by default' '
+	patch=`git format-patch -1 --to="bodies@example.com"` &&
+	test_when_finished "rm $patch" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--smtp-server relay.example.com \
+		$patch >stdout &&
+	grep "RCPT TO:<bodies@example.com>" stdout
+'
+
+test_expect_success $PREREQ 'patches To headers are appended to' '
+	patch=`git format-patch -1 --to="bodies@example.com"` &&
+	test_when_finished "rm $patch" &&
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server relay.example.com \
+		$patch >stdout &&
+	grep "RCPT TO:<bodies@example.com>" stdout &&
+	grep "RCPT TO:<nobody@example.com>" stdout
+'
+
 test_expect_success $PREREQ 'setup expect' '
 cat >email-using-8bit <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
-- 
1.7.3.16.g5d4d9
