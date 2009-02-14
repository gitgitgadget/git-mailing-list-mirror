From: Thomas Rast <trast@student.ethz.ch>
Subject: [Interdiff v3] send-email: --suppress-cc improvements
Date: Sat, 14 Feb 2009 18:06:26 +0100
Message-ID: <1234631186-10179-2-git-send-email-trast@student.ethz.ch>
References: <1234631186-10179-1-git-send-email-trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:09:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYO0y-0001RS-TC
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbZBNRGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 12:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbZBNRGk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 12:06:40 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6609 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbZBNRGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 12:06:38 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 18:06:34 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 18:06:34 +0100
X-Mailer: git-send-email 1.6.2.rc0.287.g66074
In-Reply-To: <1234631186-10179-1-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 17:06:34.0584 (UTC) FILETIME=[970FE580:01C98EC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109882>

Interdiff to Jay's v2.
---
 Documentation/git-send-email.txt |   27 +++++---
 git-send-email.perl              |   20 +++---
 t/t9001-send-email.sh            |  142 +++++++++++++++++++++++++++++---------
 3 files changed, 136 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d6af035..45a092c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -164,16 +164,23 @@ Automating
 
 --suppress-cc::
 	Specify an additional category of recipients to suppress the
-	auto-cc of.  'self' will avoid including the sender, 'author' will
-	avoid including the patch author, 'cc' will avoid including anyone
-	mentioned in Cc lines in the patch header, 'ccbody' will avoid
-	including anyone mentioned in Cc lines in the patch body (commit
-	message), 'sob' will avoid including anyone mentioned in Signed-off-by
-	lines, and 'cccmd' will avoid running the --cc-cmd. 'body' is
-	equivalent to 'sob' + 'ccbody'. 'all' will suppress all auto cc
-	values.  Default is the value of 'sendemail.suppresscc' configuration
-	value; if that is unspecified, default to 'self' if --suppress-from is
-	specified, as well as 'body' if --no-signed-off-cc is specified.
+	auto-cc of:
++
+--
+- 'author' will avoid including the patch author
+- 'cc' will avoid including anyone mentioned in Cc lines in the patch header
+- 'ccbody' will avoid including anyone mentioned in Cc lines in the
+  patch body (commit message)
+- 'cccmd' will avoid running the --cc-cmd.
+- 'self' will avoid including the sender
+- 'sob' will avoid including anyone mentioned in Signed-off-by lines
+- 'body' is equivalent to 'sob' + 'ccbody'
+- 'all' will suppress all auto cc values.
+--
++
+Default is the value of 'sendemail.suppresscc' configuration value; if
+that is unspecified, default to 'self' if --suppress-from is
+specified, as well as 'body' if --no-signed-off-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
diff --git a/git-send-email.perl b/git-send-email.perl
index 23a55e2..3a8c71f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -69,8 +69,7 @@
     --identity              <str>  * Use the sendemail.<id> options.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
-    --[no-]signed-off-by-cc        * Send to Cc: and Signed-off-by:
-                                     addresses. Default on.
+    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
@@ -331,16 +330,16 @@
 	delete $suppress_cc{'all'};
 }
 
-if ($suppress_cc{'sob'} && $suppress_cc{'bodycc'}) {
-	$suppress_cc{'body'} = 1;
-}
-
 # If explicit old-style ones are specified, they trump --suppress-cc.
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
-# For backwards compatibility, old-style --signed-off-by-cc suppresses
-# SOB and body Cc lines, whereas --supress-cc=sob suppresses just the SOB
-# line, but not the body Cc.
-$suppress_cc{'body'} = !$signed_off_by_cc if defined $signed_off_by_cc;
+$suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
+
+if ($suppress_cc{'body'}) {
+	foreach my $entry (qw (sob bodycc)) {
+		$suppress_cc{$entry} = 1;
+	}
+	delete $suppress_cc{'body'};
+}
 
 # Debugging, print out the suppressions.
 if (0) {
@@ -1014,7 +1013,6 @@ sub get_patch_subject($) {
 	# Now parse the message body
 	while(<F>) {
 		$message .=  $_;
-		next if $suppress_cc{'body'};
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d7766f9..ca006cf 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -172,7 +172,7 @@ test_expect_success 'second message is patch' '
 	grep "Subject:.*Second" msgtxt2
 '
 
-cat >expected-show-all-headers <<\EOF
+cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
@@ -192,11 +192,10 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
 
-test_expect_success 'sendemail.cc set' '
-	git config sendemail.cc cc@example.com &&
+test_suppression () {
 	git send-email \
 		--dry-run \
-		--suppress-cc=sob \
+		--suppress-cc=$1 \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
@@ -204,11 +203,16 @@ test_expect_success 'sendemail.cc set' '
 	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
 		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
-		>actual-show-all-headers &&
-	test_cmp expected-show-all-headers actual-show-all-headers
+		>actual-suppress-$1 &&
+	test_cmp expected-suppress-$1 actual-suppress-$1
+}
+
+test_expect_success 'sendemail.cc set' '
+	git config sendemail.cc cc@example.com &&
+	test_suppression sob
 '
 
-cat >expected-show-all-headers <<\EOF
+cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
@@ -230,21 +234,10 @@ EOF
 
 test_expect_success 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
-	git send-email \
-		--dry-run \
-		--suppress-cc=sob \
-		--from="Example <from@example.com>" \
-		--to=to@example.com \
-		--smtp-server relay.example.com \
-		$patches |
-	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
-		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
-		>actual-show-all-headers &&
-	test_cmp expected-show-all-headers actual-show-all-headers
+	test_suppression sob
 '
 
-cat >expected-show-all-headers <<\EOF
+cat >expected-suppress-all <<\EOF
 0001-Second.patch
 Dry-OK. Log says:
 Server: relay.example.com
@@ -261,18 +254,103 @@ Result: OK
 EOF
 
 test_expect_success '--suppress-cc=all' '
-	git send-email \
-		--dry-run \
-		--suppress-cc=all \
-		--from="Example <from@example.com>" \
-		--to=to@example.com \
-		--smtp-server relay.example.com \
-		$patches |
-	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
-		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
-		>actual-show-all-headers &&
-	test_cmp expected-show-all-headers actual-show-all-headers
+	test_suppression all
+'
+
+cat >expected-suppress-body <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=body' '
+	test_suppression body
+'
+
+cat >expected-suppress-sob <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=sob' '
+	test_suppression sob
+'
+
+cat >expected-suppress-bodycc <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
+(mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>,<committer@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com, C O Mitter <committer@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=bodycc' '
+	test_suppression bodycc
+'
+
+cat >expected-suppress-cc <<\EOF
+0001-Second.patch
+(mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
+(body) Adding cc: C O Mitter <committer@example.com> from line 'Signed-off-by: C O Mitter <committer@example.com>'
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<committer@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Cc: A <author@example.com>, C O Mitter <committer@example.com>
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=cc' '
+	test_suppression cc
 '
 
 test_expect_success '--compose adds MIME for utf8 body' '
-- 
1.6.2.rc0.287.g66074
