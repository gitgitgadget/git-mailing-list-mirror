From: Joe Perches <joe@perches.com>
Subject: [PATCH V4] git-send-email.perl: Add --to-cmd
Date: Fri, 24 Sep 2010 10:03:00 -0700
Message-ID: <1285347780.11616.97.camel@Joe-Laptop>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	 <AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	 <1285227413.7286.47.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	 <20100923090931.GA29789@albatros> <20100923120024.GA26715@albatros>
	 <1285253867.31572.13.camel@Joe-Laptop>
	 <Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	 <1285262237.31572.18.camel@Joe-Laptop>
	 <AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	 <1285263993.31572.25.camel@Joe-Laptop>
	 <AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
	 <1285267520.31572.34.camel@Joe-Laptop>
	 <7v62xwqe7i.fsf@alter.siamese.dyndns.org>
	 <1285291098.25928.220.camel@Joe-Laptop>
	 <m3lj6rgnub.fsf@localhost.localdomain>
	 <1285344394.11616.23.camel@Joe-Laptop>
	 <AANLkTinGZ1H3ODYwRhvzya_UkA8t2QTW7cEyjb2Hx_7M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Julia Lawall <julia@diku.dk>, git@vger.kernel.org,
	Vasiliy Kulikov <segooon@gmail.com>,
	Matt Mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 19:03:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzBg7-0003lB-24
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 19:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757047Ab0IXRDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 13:03:05 -0400
Received: from mail.perches.com ([173.55.12.10]:2340 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754057Ab0IXRDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 13:03:02 -0400
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 16E5D24368;
	Fri, 24 Sep 2010 10:02:51 -0700 (PDT)
In-Reply-To: <AANLkTinGZ1H3ODYwRhvzya_UkA8t2QTW7cEyjb2Hx_7M@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157024>

Add the ability to use a command line --to-cmd=3Dcmd
to create the list of "To:" addresses.

Used a shared routine for --cc-cmd and --to-cmd.

Did not use IPC::Open2, leaving that for =C3=86var if
ever he decides to fix the other bugs he might find.

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-send-email.txt |    8 +++++-
 git-send-email.perl              |   51 +++++++++++++++++++++++++-----=
-------
 t/t9001-send-email.sh            |   18 +++++++++++++
 3 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index c283084..fff97a3 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -97,7 +97,7 @@ See the CONFIGURATION section for 'sendemail.multiedi=
t'.
 	Specify the primary recipient of the emails generated. Generally, thi=
s
 	will be the upstream maintainer of the project involved. Default is t=
he
 	value of the 'sendemail.to' configuration value; if that is unspecifi=
ed,
-	this will be prompted for.
+	and --to-cmd is not specified, this will be prompted for.
 +
 The --to option must be repeated for each user you want on the to list=
=2E
=20
@@ -177,6 +177,12 @@ user is prompted for a password while the input is=
 masked for privacy.
 Automating
 ~~~~~~~~~~
=20
+--to-cmd=3D<command>::
+	Specify a command to execute once per patch file which
+	should generate patch file specific "To:" entries.
+	Output of this command must be single email address per line.
+	Default is the value of 'sendemail.tocmd' configuration value.
+
 --cc-cmd=3D<command>::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "Cc:" entries.
diff --git a/git-send-email.perl b/git-send-email.perl
index 6dab3bf..3acfdc2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -70,6 +70,7 @@ git send-email [options] <file | directory | rev-list=
 options >
=20
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
+    --to-cmd                <str>  * Email To: via `<str> \$patch_path=
`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path=
`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, bod=
y, bodycc, all.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses.=
 Default on.
@@ -187,7 +188,8 @@ sub do_edit {
 }
=20
 # Variables with corresponding config settings
-my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_c=
md);
+my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
+my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption)=
;
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_d=
omain);
 my ($validate, $confirm);
@@ -214,6 +216,7 @@ my %config_settings =3D (
     "smtppass" =3D> \$smtp_authpass,
 	"smtpdomain" =3D> \$smtp_domain,
     "to" =3D> \@to,
+    "tocmd" =3D> \$to_cmd,
     "cc" =3D> \@initial_cc,
     "cccmd" =3D> \$cc_cmd,
     "aliasfiletype" =3D> \$aliasfiletype,
@@ -272,6 +275,7 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$send=
er,
                     "in-reply-to=3Ds" =3D> \$initial_reply_to,
 		    "subject=3Ds" =3D> \$initial_subject,
 		    "to=3Ds" =3D> \@to,
+		    "to-cmd=3Ds" =3D> \$to_cmd,
 		    "no-to" =3D> \$no_to,
 		    "cc=3Ds" =3D> \@initial_cc,
 		    "no-cc" =3D> \$no_cc,
@@ -711,7 +715,7 @@ if (!defined $sender) {
 	$prompting++;
 }
=20
-if (!@to) {
+if (!@to && !defined $to_cmd) {
 	my $to =3D ask("Who should the emails be sent to? ");
 	push @to, parse_address_line($to) if defined $to; # sanitized/validat=
ed later
 	$prompting++;
@@ -1238,21 +1242,10 @@ foreach my $t (@files) {
 	}
 	close F;
=20
-	if (defined $cc_cmd && !$suppress_cc{'cccmd'}) {
-		open(F, "$cc_cmd \Q$t\E |")
-			or die "(cc-cmd) Could not execute '$cc_cmd'";
-		while(<F>) {
-			my $c =3D $_;
-			$c =3D~ s/^\s*//g;
-			$c =3D~ s/\n$//g;
-			next if ($c eq $sender and $suppress_from);
-			push @cc, $c;
-			printf("(cc-cmd) Adding cc: %s from: '%s'\n",
-				$c, $cc_cmd) unless $quiet;
-		}
-		close F
-			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
-	}
+	push @to, recipients_cmd("to-cmd", "to", $to_cmd, $t)
+		if defined $to_cmd;
+	push @cc, recipients_cmd("cc-cmd", "cc", $cc_cmd, $t)
+		if defined $cc_cmd && !$suppress_cc{'cccmd'};
=20
 	if ($broken_encoding{$t} && !$has_content_type) {
 		$has_content_type =3D 1;
@@ -1310,6 +1303,30 @@ foreach my $t (@files) {
 	$message_id =3D undef;
 }
=20
+# Execute a command (ie: $to_cmd) to get a list of email addresses
+# and return a results array
+sub recipients_cmd {
+	my ($prefix, $what, $cmd, $file) =3D @_;
+
+	my $sanitized_sender =3D sanitize_address($sender);
+	my @addresses =3D ();
+	open(F, "$cmd \Q$file\E |")
+	    or die "($prefix) Could not execute '$cmd'";
+	while(<F>) {
+		my $address =3D $_;
+		$address =3D~ s/^\s*//g;
+		$address =3D~ s/\s*$//g;
+		$address =3D sanitize_address($address);
+		next if ($address eq $sanitized_sender and $suppress_from);
+		push @addresses, $address;
+		printf("($prefix) Adding %s: %s from: '%s'\n",
+		       $what, $address, $cmd) unless $quiet;
+		}
+	close F
+	    or die "($prefix) failed to close pipe to '$cmd'";
+	return @addresses;
+}
+
 cleanup_compose_files();
=20
 sub cleanup_compose_files() {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 71b3df9..36cf421 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -201,6 +201,24 @@ test_expect_success $PREREQ 'Prompting works' '
 		grep "^To: to@example.com\$" msgtxt1
 '
=20
+test_expect_success $PREREQ 'tocmd works' '
+	clean_fake_sendmail &&
+	cp $patches tocmd.patch &&
+	echo tocmd--tocmd@example.com >>tocmd.patch &&
+	{
+	  echo "#!$SHELL_PATH"
+	  echo sed -n -e s/^tocmd--//p \"\$1\"
+	} > tocmd-sed &&
+	chmod +x tocmd-sed &&
+	git send-email \
+		--from=3D"Example <nobody@example.com>" \
+		--to-cmd=3D./tocmd-sed \
+		--smtp-server=3D"$(pwd)/fake.sendmail" \
+		tocmd.patch \
+		&&
+	grep "^To: tocmd@example.com" msgtxt1
+'
+
 test_expect_success $PREREQ 'cccmd works' '
 	clean_fake_sendmail &&
 	cp $patches cccmd.patch &&
