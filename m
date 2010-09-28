From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] send-email: Use To: headers in patch files
Date: Tue, 28 Sep 2010 01:02:44 -0700
Message-ID: <1285660964-26758-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 10:03:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0V9i-0000iJ-1Y
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 10:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab0I1IDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 04:03:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40596 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0I1IDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 04:03:03 -0400
Received: by gwj17 with SMTP id 17so1814149gwj.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=0rGCJsQbrPYTURHU9SpPtlXJcjjJSXoYcHrB1DNs6AU=;
        b=N28VKEuntALG4+5lm0YnCyns2HRU+OhRv3Kk+1ksEit9gXzQRxJmDecZoM7RrT3OZ0
         OFQyp63K51Bg5h9+hJk5QtKFVOn/5TBUZwFps9e8ydcxzy6NISZNsJ9MJ9iZ5m74smzZ
         NEnl8Ndcmz6NlgMsvsxc2P0rPvHimRloZG25k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PiZkElzYKx1wF5A2LOIYCOS6Y/ygBiXpyfPenSAgU+ur4u73ZYN/j9v32eYiZ616yW
         5KS+9c7Wfde/Ijf0np10/pFEjij5rTkFtlVLRc2v4sjHldVCG32tQSm+GUYk0NDLbdfp
         8JwXJkoVlRa+Y8dFlysEjmW0xT9or2+87I3sU=
Received: by 10.150.197.14 with SMTP id u14mr10184683ybf.289.1285660981900;
        Tue, 28 Sep 2010 01:03:01 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id t16sm10294180ybm.10.2010.09.28.01.02.58
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 01:03:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 28 Sep 2010 01:02:44 -0700
X-Mailer: git-send-email 1.7.3.16.g5d4d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157393>

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

This is a resend of a patch a few weeks ago with some added tests.

 git-send-email.perl   |    7 +++++++
 t/t9001-send-email.sh |   22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

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
index 71b3df9..6bd9ea7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -947,6 +947,28 @@ test_expect_success $PREREQ '--no-bcc overrides sendemail.bcc' '
 	! grep "RCPT TO:<other@ex.com>" stdout
 '
 
+test_expect_success $PREREQ 'patches To headers are used by default' '
+	patch=`git format-patch -1 --to="bodies@example.com"` &&
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
