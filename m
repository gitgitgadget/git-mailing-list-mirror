From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] Test cccmd in t9001-send-email.sh and fix two bugs
Date: Wed, 10 Jun 2009 13:34:03 -0400
Message-ID: <1244655243-12914-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 19:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MERgw-0001GE-Cp
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 19:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757666AbZFJReF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 13:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757522AbZFJReF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 13:34:05 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:43243 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348AbZFJReC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 13:34:02 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MERgZ-0003Mi-ST; Wed, 10 Jun 2009 13:34:03 -0400
X-Mailer: git-send-email 1.6.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121287>

For another patch series I'm working on I needed some tests
for the cc-cmd feature of git-send-email.

This patch adds 3 tests for the feature, and fix two bugs.
The first bug is that the --suppress-cc option for `cccmd' was
misspelled as `ccmd' in the code.  The second bug, which is
actually found only with my other series, is that the argument
to the cccmd is never quoted, so the cccmd would fail with
patch file names containing a space.

I also test the possibility to specify --suppress-cc
multiple times.
---
 git-send-email.perl   |    4 +-
 t/t9001-send-email.sh |   80 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 7 deletions(-)

	The patch is on top of maint, but it applies everywhere.

diff --git a/git-send-email.perl b/git-send-email.perl
index cccbf45..65a86d9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -333,7 +333,7 @@ if (@suppress_cc) {
 }
 
 if ($suppress_cc{'all'}) {
-	foreach my $entry (qw (ccmd cc author self sob body bodycc)) {
+	foreach my $entry (qw (cccmd cc author self sob body bodyccc)) {
 		$suppress_cc{$entry} = 1;
 	}
 	delete $suppress_cc{'all'};
@@ -1091,7 +1091,7 @@ foreach my $t (@files) {
 	close F;
 
 	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd $t |")
+		open(F, "$cc_cmd \Q$t\E |")
 			or die "(cc-cmd) Could not execute '$cc_cmd'";
 		while(<F>) {
 			my $c = $_;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..00375f3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -148,6 +148,22 @@ test_expect_success 'Prompting works' '
 		grep "^To: to@example.com$" msgtxt1
 '
 
+test_expect_success 'cccmd works' '
+	clean_fake_sendmail &&
+	cp $patches cccmd.patch &&
+	echo cccmd--cccmd@example.com >>cccmd.patch &&
+	echo sed -n s/^cccmd--//p \"\$1\" > cccmd-sed &&
+	chmod +x cccmd-sed &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--cc-cmd=./cccmd-sed \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		cccmd.patch \
+		&&
+	grep ^Cc:.*cccmd@example.com msgtxt1
+'
+
 z8=zzzzzzzz
 z64=$z8$z8$z8$z8$z8$z8$z8$z8
 z512=$z64$z64$z64$z64$z64$z64$z64$z64
@@ -274,7 +290,7 @@ EOF
 test_suppression () {
 	git send-email \
 		--dry-run \
-		--suppress-cc=$1 \
+		--suppress-cc=$1 ${2+"--suppress-cc=$2"} \
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
@@ -282,8 +298,8 @@ test_suppression () {
 	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
 		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
-		>actual-suppress-$1 &&
-	test_cmp expected-suppress-$1 actual-suppress-$1
+		>actual-suppress-$1${2+"-$2"} &&
+	test_cmp expected-suppress-$1${2+"-$2"} actual-suppress-$1${2+"-$2"}
 }
 
 test_expect_success 'sendemail.cc set' '
@@ -316,6 +332,34 @@ test_expect_success 'sendemail.cc unset' '
 	test_suppression sob
 '
 
+cat >expected-suppress-cccmd <<\EOF
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
+test_expect_success 'sendemail.cccmd' '
+	echo echo cc-cmd@example.com > cccmd &&
+	chmod +x cccmd &&
+	git config sendemail.cccmd ./cccmd &&
+	test_suppression cccmd
+'
+
 cat >expected-suppress-all <<\EOF
 0001-Second.patch
 Dry-OK. Log says:
@@ -341,13 +385,14 @@ cat >expected-suppress-body <<\EOF
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
 (mbox) Adding cc: One <one@example.com> from line 'Cc: One <one@example.com>, two@example.com'
 (mbox) Adding cc: two@example.com from line 'Cc: One <one@example.com>, two@example.com'
+(cc-cmd) Adding cc: cc-cmd@example.com from: './cccmd'
 Dry-OK. Log says:
 Server: relay.example.com
 MAIL FROM:<from@example.com>
-RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>
+RCPT TO:<to@example.com>,<author@example.com>,<one@example.com>,<two@example.com>,<cc-cmd@example.com>
 From: Example <from@example.com>
 To: to@example.com
-Cc: A <author@example.com>, One <one@example.com>, two@example.com
+Cc: A <author@example.com>, One <one@example.com>, two@example.com, cc-cmd@example.com
 Subject: [PATCH 1/1] Second.
 Date: DATE-STRING
 Message-Id: MESSAGE-ID-STRING
@@ -360,6 +405,30 @@ test_expect_success '--suppress-cc=body' '
 	test_suppression body
 '
 
+cat >expected-suppress-body-cccmd <<\EOF
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
+test_expect_success '--suppress-cc=body --suppress-cc=cccmd' '
+	test_suppression body cccmd
+'
+
 cat >expected-suppress-sob <<\EOF
 0001-Second.patch
 (mbox) Adding cc: A <author@example.com> from line 'From: A <author@example.com>'
@@ -381,6 +450,7 @@ Result: OK
 EOF
 
 test_expect_success '--suppress-cc=sob' '
+	git config --unset sendemail.cccmd
 	test_suppression sob
 '
 
-- 
1.6.0.3
