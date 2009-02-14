From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] send-email: --suppress-cc improvements
Date: Sat, 14 Feb 2009 18:06:25 +0100
Message-ID: <1234631186-10179-1-git-send-email-trast@student.ethz.ch>
References: <7vzlgpzfru.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 18:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYO0x-0001RS-NQ
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 18:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZBNRGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 12:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbZBNRGh
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 12:06:37 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:6609 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbZBNRGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 12:06:36 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 18:06:34 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 18:06:34 +0100
X-Mailer: git-send-email 1.6.2.rc0.287.g66074
In-Reply-To: <7vzlgpzfru.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 14 Feb 2009 17:06:34.0412 (UTC) FILETIME=[96F5A6C0:01C98EC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109884>

From: Jay Soffian <jaysoffian@gmail.com>

Since 6564828 (git-send-email: Generalize auto-cc recipient
mechanism., 2007-12-25) we can suppress automatic Cc generation
separately for each of the possible address sources.  However,
--suppress-cc=sob suppressed both SOB lines and body (but not header)
Cc lines, contrary to the name.

Change --suppress-cc=sob to mean only SOB lines, and add separate
choices 'bodycc' (body Cc lines) and 'body' (both 'sob' and 'bodycc').
The option --no-signed-off-by-cc now acts like --suppress-cc=sob,
which is not backwards compatible but matches the name of the option.

Also update the documentation and add a few tests.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-send-email.txt |   25 ++++--
 git-send-email.perl              |   23 ++++--
 t/t9001-send-email.sh            |  150 +++++++++++++++++++++++++++++++++-----
 3 files changed, 163 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index ff4aeff..45a092c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -164,14 +164,23 @@ Automating
 
 --suppress-cc::
 	Specify an additional category of recipients to suppress the
-	auto-cc of.  'self' will avoid including the sender, 'author' will
-	avoid including the patch author, 'cc' will avoid including anyone
-	mentioned in Cc lines in the patch, 'sob' will avoid including
-	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
-	running the --cc-cmd.  'all' will suppress all auto cc values.
-	Default is the value of 'sendemail.suppresscc' configuration value;
-	if that is unspecified, default to 'self' if --suppress-from is
-	specified, as well as 'sob' if --no-signed-off-cc is specified.
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
index 2a3e3e8..3a8c71f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -68,9 +68,8 @@
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-    --suppress-cc           <str>  * author, self, sob, cccmd, all.
-    --[no-]signed-off-by-cc        * Send to Cc: and Signed-off-by:
-                                     addresses. Default on.
+    --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
     --[no-]thread                  * Use In-Reply-To: field. Default on.
@@ -319,13 +318,13 @@
 if (@suppress_cc) {
 	foreach my $entry (@suppress_cc) {
 		die "Unknown --suppress-cc field: '$entry'\n"
-			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
+			unless $entry =~ /^(all|cccmd|cc|author|self|sob|body|bodycc)$/;
 		$suppress_cc{$entry} = 1;
 	}
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (ccmd cc author self sob)) {
+	foreach my $entry (qw (ccmd cc author self sob body bodycc)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -335,6 +334,13 @@
 $suppress_cc{'self'} = $suppress_from if defined $suppress_from;
 $suppress_cc{'sob'} = !$signed_off_by_cc if defined $signed_off_by_cc;
 
+if ($suppress_cc{'body'}) {
+	foreach my $entry (qw (sob bodycc)) {
+		$suppress_cc{$entry} = 1;
+	}
+	delete $suppress_cc{'body'};
+}
+
 # Debugging, print out the suppressions.
 if (0) {
 	print "suppressions:\n";
@@ -1008,13 +1014,14 @@ sub get_patch_subject($) {
 	while(<F>) {
 		$message .=  $_;
 		if (/^(Signed-off-by|Cc): (.*)$/i) {
-			next if ($suppress_cc{'sob'});
 			chomp;
-			my $c = $2;
+			my ($what, $c) = ($1, $2);
 			chomp $c;
+			next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
+			next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
 			next if ($c eq $sender and $suppress_cc{'self'});
 			push @cc, $c;
-			printf("(sob) Adding cc: %s from line '%s'\n",
+			printf("(body) Adding cc: %s from line '%s'\n",
 				$c, $_) unless $quiet;
 		}
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index da54835..ca006cf 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -32,11 +32,11 @@ clean_fake_sendmail() {
 }
 
 test_expect_success 'Extract patches' '
-    patches=`git format-patch --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
+    patches=`git format-patch -s --cc="One <one@example.com>" --cc=two@example.com -n HEAD^1`
 '
 
 test_expect_success 'Send patches' '
-     git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --suppress-cc=sob --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '
 
 cat >expected <<\EOF
@@ -74,6 +74,7 @@ EOF
 test_expect_success 'Show all headers' '
 	git send-email \
 		--dry-run \
+		--suppress-cc=sob \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--cc=cc@example.com \
@@ -171,7 +172,7 @@ test_expect_success 'second message is patch' '
 	grep "Subject:.*Second" msgtxt2
 '
 
-cat >expected-show-all-headers <<\EOF
+cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
@@ -191,10 +192,10 @@ X-Mailer: X-MAILER-STRING
 Result: OK
 EOF
 
-test_expect_success 'sendemail.cc set' '
-	git config sendemail.cc cc@example.com &&
+test_suppression () {
 	git send-email \
 		--dry-run \
+		--suppress-cc=$1 \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
@@ -202,11 +203,16 @@ test_expect_success 'sendemail.cc set' '
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
@@ -228,17 +234,123 @@ EOF
 
 test_expect_success 'sendemail.cc unset' '
 	git config --unset sendemail.cc &&
-	git send-email \
-		--dry-run \
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
+'
+
+cat >expected-suppress-all <<\EOF
+0001-Second.patch
+Dry-OK. Log says:
+Server: relay.example.com
+MAIL FROM:<from@example.com>
+RCPT TO:<to@example.com>
+From: Example <from@example.com>
+To: to@example.com
+Subject: [PATCH 1/1] Second.
+Date: DATE-STRING
+Message-Id: MESSAGE-ID-STRING
+X-Mailer: X-MAILER-STRING
+
+Result: OK
+EOF
+
+test_expect_success '--suppress-cc=all' '
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
