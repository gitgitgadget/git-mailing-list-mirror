From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/2] send-email: allow multiple emails using --cc, --to and --bcc
Date: Mon,  1 Jun 2015 16:14:02 +0200
Message-ID: <1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 16:14:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQUK-0007jg-2C
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 16:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbbFAOOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 10:14:42 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:60834 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753341AbbFAOOH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 10:14:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 78DB23611;
	Mon,  1 Jun 2015 16:14:03 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HvbTOHlsAoXU; Mon,  1 Jun 2015 16:14:03 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5F744360E;
	Mon,  1 Jun 2015 16:14:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 59C6220A2;
	Mon,  1 Jun 2015 16:14:03 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gC9EHsk1+izz; Mon,  1 Jun 2015 16:14:03 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-029022.grenet.fr [130.190.29.22])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 3B5C020D8;
	Mon,  1 Jun 2015 16:14:03 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270413>

Accept a list of emails separated by commas in flags --cc, --to and
--bcc.  Multiple addresses can already be given by using these options
multiple times, but it is more convenient to allow cutting-and-pasting
a list of addresses from the header of an existing e-mail message,
which already lists them as comma-separated list, as a value to a
single parameter.

The following format can now be used:

    $ git send-email --to='Jane <jdoe@example.com>, mike@example.com'

However format using commas in names doesn't work:

    $ git send-email --to='"Jane, Doe" <jdoe@example.com>'

Remove the limitation imposed by 79ee555b (Check and document the
options to prevent mistakes, 2006-06-21) which rejected every argument
with comma in --cc, --to and --bcc

Helped-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Documentation/git-send-email.txt | 21 +++++++++++++++------
 git-send-email.perl              | 33 ++++++++++++++-------------------
 t/t9001-send-email.sh            | 30 ++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 043f345..f862fa6 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -49,17 +49,23 @@ Composing
 	of 'sendemail.annotate'. See the CONFIGURATION section for
 	'sendemail.multiEdit'.
 
---bcc=<address>::
+--bcc=<address>,...::
 	Specify a "Bcc:" value for each email. Default is the value of
 	'sendemail.bcc'.
 +
-The --bcc option must be repeated for each user you want on the bcc list.
+Addresses containing commas ("Foo, Bar" <foobar@example.com>) are not
+currently supported.
++
+This option may be specified multiple times
 
---cc=<address>::
+--cc=<address>,...::
 	Specify a starting "Cc:" value for each email.
 	Default is the value of 'sendemail.cc'.
 +
-The --cc option must be repeated for each user you want on the cc list.
+Addresses containing commas ("Foo, Bar" <foobar@example.com>) are not
+currently supported.
++
+This option may be specified multiple times
 
 --compose::
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
@@ -110,13 +116,16 @@ is not set, this will be prompted for.
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
+Addresses containing commas ("Foo, Bar" <foobar@example.com>) are not
+currently supported.
++
+This option may be specified multiple times
 
 --8bit-encoding=<encoding>::
 	When encountering a non-ASCII message or subject that does not
diff --git a/git-send-email.perl b/git-send-email.perl
index ffea500..389f19c 100755
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
@@ -838,11 +824,11 @@ sub expand_one_alias {
 }
 
 @initial_to = expand_aliases(@initial_to);
-@initial_to = validate_address_list(sanitize_address_list(@initial_to));
+@initial_to = extract_address_list(@initial_to);
 @initial_cc = expand_aliases(@initial_cc);
-@initial_cc = validate_address_list(sanitize_address_list(@initial_cc));
+@initial_cc = extract_address_list(@initial_cc);
 @bcclist = expand_aliases(@bcclist);
-@bcclist = validate_address_list(sanitize_address_list(@bcclist));
+@bcclist = extract_address_list(@bcclist);
 
 if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to = ask(
@@ -1055,6 +1041,15 @@ sub sanitize_address_list {
 	return (map { sanitize_address($_) } @_);
 }
 
+sub split_address_list_items {
+	return (map { split /\s*,\s*/, $_ } @_);
+}
+
+sub extract_address_list {
+	return validate_address_list(sanitize_address_list(
+		split_address_list_items(@_)));
+}
+
 # Returns the local Fully Qualified Domain Name (FQDN) if available.
 #
 # Tightly configured MTAa require that a caller sends a real DNS
@@ -1564,8 +1559,8 @@ foreach my $t (@files) {
 		($confirm =~ /^(?:auto|compose)$/ && $compose && $message_num == 1));
 	$needs_confirm = "inform" if ($needs_confirm && $confirm_unconfigured && @cc);
 
-	@to = validate_address_list(sanitize_address_list(@to));
-	@cc = validate_address_list(sanitize_address_list(@cc));
+	@to = extract_address_list(@to);
+	@cc = extract_address_list(@cc);
 
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 71968ee..4245c06 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1612,4 +1612,34 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
 	do_xmailer_test 1 "--xmailer"
 '
 
+test_expect_success $PREREQ 'setup expected-list' '
+	git send-email \
+	--dry-run \
+	--from="Example <from@example.com>" \
+	--to="to1@example.com" \
+	--to="to2@example.com" \
+	--to="to3@example.com" \
+	--cc="cc1@example.com" \
+	--cc="Cc 1 <cc1@example.com>" \
+	--cc="Cc 2 <cc2@example.com>" \
+	--bcc="bcc1@example.com" \
+	--bcc="bcc2@example.com" \
+	0001-add-master.patch |	replace_variable_fields \
+	>expected-list
+'
+
+test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
+	git send-email \
+	--dry-run \
+	--from="Example <from@example.com>" \
+	--to="to1@example.com, to2@example.com" \
+	--to="to3@example.com" \
+	--cc="cc1@example.com, Cc 1 <cc1@example.com>" \
+	--cc="Cc 2 <cc2@example.com>" \
+	--bcc="bcc1@example.com, bcc2@example.com" \
+	0001-add-master.patch |	replace_variable_fields \
+	 >actual-list &&
+	test_cmp expected-list actual-list
+'
+
 test_done
-- 
1.9.1
