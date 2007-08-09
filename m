From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH 2/2] send-email: get all the quoting of realnames right
Date: Thu,  9 Aug 2007 15:27:58 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <11866660821639-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <11866660781833-git-send-email-ukleinek@informatik.uni-freiburg.de>
 <1186666080946-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 15:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ83w-0007J0-76
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 15:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939205AbXHIN2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 09:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939208AbXHIN2M
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 09:28:12 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63978 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S939197AbXHIN2G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 09:28:06 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJ83Z-0006YP-5M; Thu, 09 Aug 2007 15:28:05 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l79DS4qh015366;
	Thu, 9 Aug 2007 15:28:04 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l79DS3vq015365;
	Thu, 9 Aug 2007 15:28:03 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc4.855.gaac4
In-Reply-To: <1186666080946-git-send-email-ukleinek@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55450>

- when sending several mails I got a slightly different behaviour for t=
he first
  mail compared to the second to last one.  The reason is that $from wa=
s
  assigned in line 608 and was not reset when beginning to handle the n=
ext
  mail.

- Email::Valid can only handle properly quoted real names, so quote arg=
uments
  to extract_valid_address.

This patch cleans up variable naming to better differentiate between se=
nder of
the mail and it's author.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
---
 git-send-email.perl |   50 ++++++++++++++++++++++++-------------------=
-------
 1 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a02ab96..69559b2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -137,7 +137,7 @@ my $compose_filename =3D ".msg.$$";
=20
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
-	$initial_reply_to,$initial_subject,@files,$from,$compose,$time);
+	$initial_reply_to,$initial_subject,@files,$author,$sender,$compose,$t=
ime);
=20
 my $smtp_server;
 my $envelope_sender;
@@ -179,7 +179,7 @@ if (!@bcclist or !$bcclist[0]) {
 # Begin by accumulating all the variables (defined above), that we wil=
l end up
 # needing, first, from the command line:
=20
-my $rc =3D GetOptions("from=3Ds" =3D> \$from,
+my $rc =3D GetOptions("sender|from=3Ds" =3D> \$sender,
                     "in-reply-to=3Ds" =3D> \$initial_reply_to,
 		    "subject=3Ds" =3D> \$initial_subject,
 		    "to=3Ds" =3D> \@to,
@@ -216,8 +216,8 @@ foreach my $entry (@bcclist) {
=20
 # Now, let's fill any that aren't set in with defaults:
=20
-my ($author) =3D $repo->ident_person('author');
-my ($committer) =3D $repo->ident_person('committer');
+my ($repoauthor) =3D $repo->ident_person('author');
+my ($repocommitter) =3D $repo->ident_person('committer');
=20
 my %aliases;
 my @alias_files =3D $repo->config('sendemail.aliasesfile');
@@ -254,17 +254,17 @@ if (@alias_files and $aliasfiletype and defined $=
parse_alias{$aliasfiletype}) {
 	}
 }
=20
-($from) =3D expand_aliases($from) if defined $from;
+($sender) =3D expand_aliases($sender) if defined $sender;
=20
 my $prompting =3D 0;
-if (!defined $from) {
-	$from =3D $author || $committer;
+if (!defined $sender) {
+	$sender =3D $repoauthor || $repocommitter;
 	do {
-		$_ =3D $term->readline("Who should the emails appear to be from? [$f=
rom] ");
+		$_ =3D $term->readline("Who should the emails appear to be from? [$s=
ender] ");
 	} while (!defined $_);
=20
-	$from =3D $_ if ($_);
-	print "Emails will be sent from: ", $from, "\n";
+	$sender =3D $_ if ($_);
+	print "Emails will be sent from: ", $sender, "\n";
 	$prompting++;
 }
=20
@@ -330,7 +330,7 @@ if ($compose) {
 	# effort to have it be unique
 	open(C,">",$compose_filename)
 		or die "Failed to open for writing $compose_filename: $!";
-	print C "From $from # This line is ignored.\n";
+	print C "From $sender # This line is ignored.\n";
 	printf C "Subject: %s\n\n", $initial_subject;
 	printf C <<EOT;
 GIT: Please enter your email below.
@@ -433,11 +433,11 @@ sub make_message_id
 	my $date =3D time;
 	my $pseudo_rand =3D int (rand(4200));
 	my $du_part;
-	for ($from, $committer, $author) {
-		$du_part =3D extract_valid_address($_);
-		last if ($du_part ne '');
+	for ($sender, $repocommitter, $repoauthor) {
+		$du_part =3D extract_valid_address(sanitize_address($_));
+		last if (defined $du_part and $du_part ne '');
 	}
-	if ($du_part eq '') {
+	if (not defined $du_part or $du_part eq '') {
 		use Sys::Hostname qw();
 		$du_part =3D 'user@' . Sys::Hostname::hostname();
 	}
@@ -508,10 +508,10 @@ sub send_message
 	if ($cc ne '') {
 		$ccline =3D "\nCc: $cc";
 	}
-	$from =3D sanitize_address($from);
+	my $sanitized_sender =3D sanitize_address($sender);
 	make_message_id();
=20
-	my $header =3D "From: $from
+	my $header =3D "From: $sanitized_sender
 To: $to${ccline}
 Subject: $subject
 Date: $date
@@ -528,7 +528,7 @@ X-Mailer: git-send-email $gitversion
 	}
=20
 	my @sendmail_parameters =3D ('-i', @recipients);
-	my $raw_from =3D $from;
+	my $raw_from =3D $sanitized_sender;
 	$raw_from =3D $envelope_sender if (defined $envelope_sender);
 	$raw_from =3D extract_valid_address($raw_from);
 	unshift (@sendmail_parameters,
@@ -565,7 +565,7 @@ X-Mailer: git-send-email $gitversion
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n"=
;
 		}
-		print "From: $from\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
+		print "From: $sanitized_sender\nSubject: $subject\nCc: $cc\nTo: $to\=
n\n";
 		if ($smtp) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =3D~ /\n([^\n]+\n)$/s), "\n";
@@ -582,7 +582,7 @@ $subject =3D $initial_subject;
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
=20
-	my $author_not_sender =3D undef;
+	my $author =3D undef;
 	@cc =3D @initial_cc;
 	@xh =3D ();
 	my $input_format =3D undef;
@@ -604,12 +604,11 @@ foreach my $t (@files) {
 					$subject =3D $1;
=20
 				} elsif (/^(Cc|From):\s+(.*)$/) {
-					if (unquote_rfc2047($2) eq $from) {
-						$from =3D $2;
+					if (unquote_rfc2047($2) eq $sender) {
 						next if ($suppress_from);
 					}
 					elsif ($1 eq 'From') {
-						$author_not_sender =3D $2;
+						$author =3D unquote_rfc2047($2);
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
 						$2, $_) unless $quiet;
@@ -653,9 +652,8 @@ foreach my $t (@files) {
 		}
 	}
 	close F;
-	if (defined $author_not_sender) {
-		$author_not_sender =3D unquote_rfc2047($author_not_sender);
-		$message =3D "From: $author_not_sender\n\n$message";
+	if (defined $author) {
+		$message =3D "From: $author\n\n$message";
 	}
=20
=20
--=20
1.5.3.rc3.943.g14c81
