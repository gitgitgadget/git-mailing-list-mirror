From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v4 09/10] send-email: allow multiple emails using --cc, --to and --bcc
Date: Wed, 17 Jun 2015 16:31:07 +0200
Message-ID: <1434551467-24668-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 16:32:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ENu-0000nM-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbbFQOb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:31:57 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:57584 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755105AbbFQObp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 10:31:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 187922809;
	Wed, 17 Jun 2015 16:31:44 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 91DkJ6j79Wc6; Wed, 17 Jun 2015 16:31:44 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0748427F2;
	Wed, 17 Jun 2015 16:31:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id F417720DC;
	Wed, 17 Jun 2015 16:31:43 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xzC07JyOSsQ1; Wed, 17 Jun 2015 16:31:43 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-475-169.w90-52.abo.wanadoo.fr [90.52.146.169])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id D64C2209F;
	Wed, 17 Jun 2015 16:31:42 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271848>

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

Helped-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Documentation/git-send-email.txt | 12 +++++------
 git-send-email.perl              | 17 ++--------------
 t/t9001-send-email.sh            | 44 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b48a764..afd9569 100644
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
index 8594ab9..265299e 100755
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
@@ -1101,7 +1087,8 @@ sub sanitize_address_list {
 }
 
 sub process_address_list {
-	my @addr_list = expand_aliases(@_);
+	my @addr_list = map { parse_address_line($_) } @_;
+	@addr_list = expand_aliases(@addr_list);
 	@addr_list = sanitize_address_list(@addr_list);
 	@addr_list = validate_address_list(@addr_list);
 	return @addr_list;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 714fcae..3c5b853 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1675,4 +1675,48 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
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
1.9.1
