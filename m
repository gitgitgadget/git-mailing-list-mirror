From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Thu, 28 May 2015 12:42:13 +0200
Message-ID: <1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 12:43:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxvH6-0008NR-RG
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 12:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbbE1Kmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 06:42:53 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40564 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871AbbE1Kmv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 06:42:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E4E7F27A4;
	Thu, 28 May 2015 12:42:49 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tw9QFEcFJa+f; Thu, 28 May 2015 12:42:49 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D3DF127A3;
	Thu, 28 May 2015 12:42:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id CFB7620D6;
	Thu, 28 May 2015 12:42:49 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TvkoqF7indWB; Thu, 28 May 2015 12:42:49 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-031226.grenet.fr [130.190.31.226])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id AF2BF20D4;
	Thu, 28 May 2015 12:42:49 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270135>

From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>

Add the possibility to use a list of emails separated by commas
in flags --cc --to and --bcc instead of having to use one flag
per email address.

The use-case is to copy-paste a list of addresses from an email.
This change makes it so that we no longer need to cut the list.

The format of email list handled is basic for now:
	$ git send-email --to='Foo <foo@example.com>, bar@example.com'
We thought it would be nice to have a "first-step" version which works
before handling more complex ones such as names with commas:
	$ git send-email --to='Foo, Bar <foobar@example.com>'

This artificial limitation is imposed by 79ee555b (Check and document
the options to prevent mistakes, 2006-06-21).

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Contributions-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
---
 Documentation/git-send-email.txt | 23 ++++++++++++++--------
 git-send-email.perl              | 21 ++++++--------------
 t/t9001-send-email.sh            | 41 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 043f345..0aeddcb 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -49,17 +49,21 @@ Composing
 	of 'sendemail.annotate'. See the CONFIGURATION section for
 	'sendemail.multiEdit'.
 
---bcc=<address>::
+--bcc="[<address>,...]"::
 	Specify a "Bcc:" value for each email. Default is the value of
 	'sendemail.bcc'.
-+
-The --bcc option must be repeated for each user you want on the bcc list.
+	The format supported for email list is the following:
+	"Foo <foo@example.com>, bar@example.com".
+	Please notice that the email list does not handle commas in
+	email names such as "Foo, Bar <foobar@example.com>".
 
---cc=<address>::
+--cc="[<address>,...]"::
 	Specify a starting "Cc:" value for each email.
 	Default is the value of 'sendemail.cc'.
-+
-The --cc option must be repeated for each user you want on the cc list.
+	The format supported for email list is the following:
+	"Foo <foo@example.com>, bar@example.com".
+	Please notice that the email list does not handle commas in
+	email names such as "Foo, Bar <foobar@example.com>".
 
 --compose::
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
@@ -111,12 +115,15 @@ is not set, this will be prompted for.
 	is not set, this will be prompted for.
 
 --to=<address>::
+--to="[<address>,...]"::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the 'sendemail.to' configuration value; if that is unspecified,
 	and --to-cmd is not specified, this will be prompted for.
-+
-The --to option must be repeated for each user you want on the to list.
+	The format supported for email list is the following:
+	"Foo <foo@example.com>, bar@example.com".
+	Please notice that the email list does not handle commas in
+	email names such as "Foo, Bar <foobar@example.com>".
 
 --8bit-encoding=<encoding>::
 	When encountering a non-ASCII message or subject that does not
diff --git a/git-send-email.perl b/git-send-email.perl
index ffea500..409ff45 100755
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
@@ -1052,7 +1038,8 @@ sub sanitize_address {
 }
 
 sub sanitize_address_list {
-	return (map { sanitize_address($_) } @_);
+	my @addr_list = split_address_list(@_);
+	return (map { sanitize_address($_) } @addr_list);
 }
 
 # Returns the local Fully Qualified Domain Name (FQDN) if available.
@@ -1193,6 +1180,10 @@ sub file_name_is_absolute {
 	return File::Spec::Functions::file_name_is_absolute($path);
 }
 
+sub split_address_list {
+	return (map { split /\s*,\s*/, $_ } @_);
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a3663da..4245c06 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -519,6 +519,12 @@ Result: OK
 EOF
 "
 
+replace_variable_fields () {
+	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/"
+}
+
 test_suppression () {
 	git send-email \
 		--dry-run \
@@ -526,10 +532,7 @@ test_suppression () {
 		--from="Example <from@example.com>" \
 		--to=to@example.com \
 		--smtp-server relay.example.com \
-		$patches |
-	sed	-e "s/^\(Date:\).*/\1 DATE-STRING/" \
-		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
-		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		$patches | replace_variable_fields \
 		>actual-suppress-$1${2+"-$2"} &&
 	test_cmp expected-suppress-$1${2+"-$2"} actual-suppress-$1${2+"-$2"}
 }
@@ -1609,4 +1612,34 @@ test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
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
