From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v7 09/10] send-email: allow multiple emails using --cc, --to and --bcc
Date: Tue, 30 Jun 2015 14:16:50 +0200
Message-ID: <1435666611-18429-10-git-send-email-Matthieu.Moy@imag.fr>
References: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 30 14:17:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9uTb-0005aN-Hs
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 14:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbbF3MRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 08:17:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39693 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbbF3MRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 08:17:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH1Nl015349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 14:17:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UCH3t3022766;
	Tue, 30 Jun 2015 14:17:03 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Z9uTH-00051p-5t; Tue, 30 Jun 2015 14:17:03 +0200
X-Mailer: git-send-email 2.5.0.rc0.10.g7792c2a
In-Reply-To: <1435666611-18429-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 30 Jun 2015 14:17:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UCH1Nl015349
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1436271424.1145@31ZA3LJ46se7jVn/WLgIlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273048>

From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

Accept a list of emails separated by commas in flags --cc, --to and
--bcc.  Multiple addresses can already be given by using these options
multiple times, but it is more convenient to allow cutting-and-pasting
a list of addresses from the header of an existing e-mail message,
which already lists them as comma-separated list, as a value to a
single parameter.

The following format can now be used:

    $ git send-email --to='Jane <jdoe@example.com>, mike@example.com'

Remove the limitation imposed by 79ee555b (Check and document the
options to prevent mistakes, 2006-06-21) which rejected every argument
with comma in --cc, --to and --bcc.

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-send-email.txt | 12 +++++------
 git-send-email.perl              | 17 ++--------------
 t/t9001-send-email.sh            | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7ae467b..f14705e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -49,17 +49,17 @@ Composing
 	of 'sendemail.annotate'. See the CONFIGURATION section for
 	'sendemail.multiEdit'.
 
---bcc=<address>::
+--bcc=<address>,...::
 	Specify a "Bcc:" value for each email. Default is the value of
 	'sendemail.bcc'.
 +
-The --bcc option must be repeated for each user you want on the bcc list.
+This option may be specified multiple times.
 
---cc=<address>::
+--cc=<address>,...::
 	Specify a starting "Cc:" value for each email.
 	Default is the value of 'sendemail.cc'.
 +
-The --cc option must be repeated for each user you want on the cc list.
+This option may be specified multiple times.
 
 --compose::
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
@@ -110,13 +110,13 @@ is not set, this will be prompted for.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
---to=<address>::
+--to=<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the 'sendemail.to' configuration value; if that is unspecified,
 	and --to-cmd is not specified, this will be prompted for.
 +
-The --to option must be repeated for each user you want on the to list.
+This option may be specified multiple times.
 
 --8bit-encoding=<encoding>::
 	When encountering a non-ASCII message or subject that does not
diff --git a/git-send-email.perl b/git-send-email.perl
index df9d3f6..4a681f5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -460,20 +460,6 @@ my ($repoauthor, $repocommitter);
 ($repoauthor) = Git::ident_person(@repo, 'author');
 ($repocommitter) = Git::ident_person(@repo, 'committer');
 
-# Verify the user input
-
-foreach my $entry (@initial_to) {
-	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
-}
-
-foreach my $entry (@initial_cc) {
-	die "Comma in --cc entry: $entry'\n" unless $entry !~ m/,/;
-}
-
-foreach my $entry (@bcclist) {
-	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
-}
-
 sub parse_address_line {
 	if ($have_mail_address) {
 		return map { $_->format } Mail::Address->parse($_[0]);
@@ -1057,7 +1043,8 @@ sub sanitize_address_list {
 }
 
 sub process_address_list {
-	my @addr_list = expand_aliases(@_);
+	my @addr_list = map { parse_address_line($_) } @_;
+	@addr_list = expand_aliases(@addr_list);
 	@addr_list = sanitize_address_list(@addr_list);
 	@addr_list = validate_address_list(@addr_list);
 	return @addr_list;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index fce081c..733431b 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1720,4 +1720,48 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
 	do_xmailer_test 1 "--xmailer"
 '
 
+test_expect_success $PREREQ 'setup expected-list' '
+	git send-email \
+	--dry-run \
+	--from="Example <from@example.com>" \
+	--to="To 1 <to1@example.com>" \
+	--to="to2@example.com" \
+	--to="to3@example.com" \
+	--cc="Cc 1 <cc1@example.com>" \
+	--cc="Cc2 <cc2@example.com>" \
+	--bcc="bcc1@example.com" \
+	--bcc="bcc2@example.com" \
+	0001-add-master.patch | replace_variable_fields \
+	>expected-list
+'
+
+test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
+	git send-email \
+	--dry-run \
+	--from="Example <from@example.com>" \
+	--to="To 1 <to1@example.com>, to2@example.com" \
+	--to="to3@example.com" \
+	--cc="Cc 1 <cc1@example.com>, Cc2 <cc2@example.com>" \
+	--bcc="bcc1@example.com, bcc2@example.com" \
+	0001-add-master.patch | replace_variable_fields \
+	>actual-list &&
+	test_cmp expected-list actual-list
+'
+
+test_expect_success $PREREQ 'aliases work with email list' '
+	echo "alias to2 to2@example.com" >.mutt &&
+	echo "alias cc1 Cc 1 <cc1@example.com>" >>.mutt &&
+	test_config sendemail.aliasesfile ".mutt" &&
+	test_config sendemail.aliasfiletype mutt &&
+	git send-email \
+	--dry-run \
+	--from="Example <from@example.com>" \
+	--to="To 1 <to1@example.com>, to2, to3@example.com" \
+	--cc="cc1, Cc2 <cc2@example.com>" \
+	--bcc="bcc1@example.com, bcc2@example.com" \
+	0001-add-master.patch | replace_variable_fields \
+	>actual-list &&
+	test_cmp expected-list actual-list
+'
+
 test_done
-- 
2.5.0.rc0.10.g7792c2a
