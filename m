From: Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
Subject: [PATCH v2] send-email: allow use of basic email list in --cc --to and --bcc
Date: Wed, 19 Jun 2013 13:34:00 +0200
Message-ID: <1371641640-3897-1-git-send-email-Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Cc: gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 19 13:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpGeV-0000dx-8o
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 13:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934460Ab3FSLeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 07:34:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40652 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934075Ab3FSLeI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 07:34:08 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5JBY1oi016562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Jun 2013 13:34:01 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5JBY2ou011521;
	Wed, 19 Jun 2013 13:34:02 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5JBY2Wh010069;
	Wed, 19 Jun 2013 13:34:02 +0200
Received: (from garciagj@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id r5JBY2cl010060;
	Wed, 19 Jun 2013 13:34:02 +0200
X-Mailer: git-send-email 1.7.8
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Jun 2013 13:34:01 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228390>

From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>

Make it so that we can use a list of email in flags
instead of having to use one flag per email address.

The use-case is to copy-paste a list of addresses from an email.
This change makes it so that we no longer need to cut the list.

The format of email list handled is pretty basic for now:
	$ git send-email --to='Foo <foo@example.com>, bar@example.com'
We thought it would be nice to have a "first-step" version which works
before handling more complex ones such as names with commas:
	$ git send-email --to='Foo, Bar <foobar@example.com>'

This artificial limitation is imposed by 79ee555b (Check and document
the options to prevent mistakes, 2006-06-21).

Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
---

Changes since v1:
 - more detailed commit message, explaining the most common use-case,
   and referring to the commit which introduced the comma limitation
 - use of map in the function, to match sanitize_address_list
 - did not change the two regexp into one, because it's faster with two

 Documentation/git-send-email.txt |   21 +++++++++++++++------
 git-send-email.perl              |   36 ++++++++++++++++++++++--------------
 t/t9001-send-email.sh            |   37 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 40a9a9a..e3444cf 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -50,16 +50,22 @@ Composing
 	'sendemail.multiedit'.
 
 --bcc=<address>::
+--bcc="[<address>,...]"::
 	Specify a "Bcc:" value for each email. Default is the value of
 	'sendemail.bcc'.
-+
-The --bcc option must be repeated for each user you want on the bcc list.
+	The format supported for email list is the following:
+	"Foo <foo@example.com>, bar@example.com".
+	Please notice that the email list does not handle commas in
+	email names such as "Foo, Bar <foobar@example.com>".
 
 --cc=<address>::
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
@@ -111,12 +117,15 @@ is not set, this will be prompted for.
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
index 671762b..03f3876 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -426,20 +426,6 @@ my ($repoauthor, $repocommitter);
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
@@ -1079,6 +1065,25 @@ sub smtp_auth_maybe {
 	return $auth;
 }
 
+sub split_emails {
+    my ($emails) = @_;
+    my @split_list;
+    if ($emails =~ /,/) {
+	@split_list = split(/,/, $emails);
+    } else {
+	@split_list = $emails;
+    }
+    # Removal of unwanted spaces
+    for (my $j = 0; $j <= $#split_list; $j++) {
+	$split_list[$j] =~ s/^\s+//;
+	$split_list[$j] =~ s/\s+$//;
+    }
+    return @split_list;
+}
+
+sub split_emails_list {
+	return (map { split_emails($_) } @_);
+}
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1089,6 +1094,9 @@ sub send_message {
 		      not grep { $cc eq $_ || $_ =~ /<\Q${cc}\E>$/ } @recipients
 		    }
 	       @cc);
+	@cc = split_emails_list(@cc);
+	@bcclist = split_emails_list(@bcclist);
+	@recipients = split_emails_list(@recipients);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
 	@recipients = (map { extract_valid_address_or_die($_) } @recipients);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 9f46f22..87641bc 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1349,4 +1349,39 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	grep "^!someone@example\.org!$" commandline1
 '
 
-test_done
+test_expect_success $PREREQ 'setup expected-list' '
+	git send-email \
+		--dry-run \
+		--suppress-cc=sob \
+		--from="Example <from@example.com>" \
+		--to="to1@example.com" --to="to2@example.com" \
+		--to="to3@example.com" --cc="cc0@example.com" \
+		--cc="Cc 1 <cc1@example.com>" --cc="Cc 2 <cc2@example.com>" \
+		--bcc="bcc1@example.com" --bcc="bcc2@example.com" \
+		-1 >output
+	sed	-e "s/^\(\/tmp\/\).*/\1patch/" \
+		-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		<output >expected-list
+'
+
+test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
+	git send-email \
+		--dry-run \
+		--suppress-cc=sob \
+		--from="Example <from@example.com>" \
+		--to="to1@example.com, to2@example.com,to3@example.com" \
+		--cc="cc0@example.com" \
+		--cc="Cc 1 <cc1@example.com>, Cc 2 <cc2@example.com>" \
+		--bcc="bcc1@example.com, bcc2@example.com" \
+		-1 >output
+	sed	-e "s/^\(\/tmp\/\).*/\1patch/" \
+		-e "s/^\(Date:\).*/\1 DATE-STRING/" \
+		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
+		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
+		<output >actual-list &&
+	test_cmp expected-list actual-list
+'
+
+test_done
\ No newline at end of file
-- 
1.7.8
