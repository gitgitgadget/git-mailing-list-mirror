From: Thomas Rast <trast@student.ethz.ch>
Subject: =?UTF-8?q?=5BPATCH=5D=20send-email=3A=20ask=20about=20and=20declare=208bit=20mails?=
Date: Sat, 12 Jun 2010 17:06:20 +0200
Message-ID: <cebe57bb68b5e8ea445e560bbe6305c915ce8a1c.1276354971.git.trast@student.ethz.ch>
References: <201006121211.12870.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 12 17:09:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONSL0-0006dl-MA
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 17:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab0FLPGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 11:06:45 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:9014 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab0FLPGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 11:06:44 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 17:06:42 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 12 Jun
 2010 17:06:21 +0200
X-Mailer: git-send-email 1.7.1.557.gd161
In-Reply-To: <201006121211.12870.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149009>

git-send-email passes on an 8bit mail as-is even if it does not
declare a content-type.  Because the user can edit email between
format-patch and send-email, such invalid mails are unfortunately not
very hard to come by.

Make git-send-email stop and ask about the encoding to use if it
encounters any such mail.  Also provide a configuration setting to
permanently configure an encoding.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This takes care of what I ran into earlier today.  However, there's
another problem: format-patch doesn't even mark the patch 8bit if its
patch contents (not log message) are non-ASCII.  I'm really not sure
what to do there.

On the practical hand, there's the problem that the entire
log_tree_commit() call chain is geared towards printing on a file, at
which time it's too late.  So we would either have to go in and fix
all of that to support formatting to a strbuf, or rewrite the patch if
it turns out to be non-ASCII.

On the philosophical hand, we don't really care about file encodings
so far, but this requires declaring one.

Either way, I think if vger doesn't accept format-patch;send-email,
something is really wrong :-)


 Documentation/git-send-email.txt |    9 ++++
 git-send-email.perl              |   59 +++++++++++++++++++++++++++++
 t/t9001-send-email.sh            |   77 ++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 145 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 12622fc..c283084 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -101,6 +101,15 @@ See the CONFIGURATION section for 'sendemail.multi=
edit'.
 +
 The --to option must be repeated for each user you want on the to list=
=2E
=20
+--8bit-encoding=3D<encoding>::
+	When encountering a non-ASCII message or subject that does not
+	declare its encoding, add headers/quoting to indicate it is
+	encoded in <encoding>.  Default is the value of the
+	'sendemail.assume8bitEncoding'; if that is unspecified, this
+	will be prompted for if any non-ASCII files are encountered.
++
+Note that no attempts whatsoever are made to validate the encoding.
+
=20
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 111c981..6b2ac79 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,6 +54,7 @@ git send-email [options] <file | directory | rev-list=
 options >
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --annotate                     * Review each patch that will be se=
nt in an editor.
     --compose                      * Open an editor for introduction.
+    --8bit-encoding         <str>  * Encoding to assume 8bit mails if =
undeclared
=20
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -191,6 +192,7 @@ my ($smtp_server, $smtp_server_port, $smtp_authuser=
, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_d=
omain);
 my ($validate, $confirm);
 my (@suppress_cc);
+my ($auto_8bit_encoding);
=20
 my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
=20
@@ -222,6 +224,7 @@ my %config_settings =3D (
     "multiedit" =3D> \$multiedit,
     "confirm"   =3D> \$confirm,
     "from" =3D> \$sender,
+    "assume8bitencoding" =3D> \$auto_8bit_encoding,
 );
=20
 # Help users prepare for 1.7.0
@@ -297,6 +300,7 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$send=
er,
 		    "thread!" =3D> \$thread,
 		    "validate!" =3D> \$validate,
 		    "format-patch!" =3D> \$format_patch,
+		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
 	 );
=20
 unless ($rc) {
@@ -669,6 +673,34 @@ sub ask {
 	return undef;
 }
=20
+my %broken_encoding;
+
+sub file_declares_8bit_cte($) {
+	my $fn =3D shift;
+	open (my $fh, '<', $fn);
+	while (my $line =3D <$fh>) {
+		return 1 if ($line =3D~ /^Content-Transfer-Encoding: .*8bit.*$/);
+	}
+	close $fh;
+	return 0;
+}
+
+foreach my $f (@files) {
+	next unless (body_or_subject_has_nonascii($f)
+		     && !file_declares_8bit_cte($f));
+	$broken_encoding{$f} =3D 1;
+}
+
+if (!defined $auto_8bit_encoding && scalar %broken_encoding) {
+	print "The following files are 8bit, but do not declare " .
+		"a Content-Transfer-Encoding.\n";
+	foreach my $f (sort keys %broken_encoding) {
+		print "    $f\n";
+	}
+	$auto_8bit_encoding =3D ask("Which 8bit encoding should I declare [UT=
=46-8]? ",
+				  default =3D> "UTF-8");
+}
+
 my $prompting =3D 0;
 if (!defined $sender) {
 	$sender =3D $repoauthor || $repocommitter || '';
@@ -1221,6 +1253,18 @@ foreach my $t (@files) {
 			or die "(cc-cmd) failed to close pipe to '$cc_cmd'";
 	}
=20
+	if ($broken_encoding{$t} && !$has_content_type) {
+		$has_content_type =3D 1;
+		push @xh, "MIME-Version: 1.0",
+			"Content-Type: text/plain; charset=3D$auto_8bit_encoding",
+			"Content-Transfer-Encoding: 8bit";
+		$body_encoding =3D $auto_8bit_encoding;
+	}
+
+	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
+		$subject =3D quote_rfc2047($subject, $auto_8bit_encoding);
+	}
+
 	if (defined $author and $author ne $sender) {
 		$message =3D "From: $author\n\n$message";
 		if (defined $author_encoding) {
@@ -1233,6 +1277,7 @@ foreach my $t (@files) {
 				}
 			}
 			else {
+				$has_content_type =3D 1;
 				push @xh,
 				  'MIME-Version: 1.0',
 				  "Content-Type: text/plain; charset=3D$author_encoding",
@@ -1310,3 +1355,17 @@ sub file_has_nonascii {
 	}
 	return 0;
 }
+
+sub body_or_subject_has_nonascii {
+	my $fn =3D shift;
+	open(my $fh, '<', $fn)
+		or die "unable to open $fn: $!\n";
+	while (my $line =3D <$fh>) {
+		last if $line =3D~ /^$/;
+		return 1 if $line =3D~ /^Subject.*[^[:ascii:]]/;
+	}
+	while (my $line =3D <$fh>) {
+		return 1 if $line =3D~ /[^[:ascii:]]/;
+	}
+	return 0;
+}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 640b3d2..0b8a591 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -918,4 +918,81 @@ test_expect_success '--no-bcc overrides sendemail.=
bcc' '
 	! grep "RCPT TO:<other@ex.com>" stdout
 '
=20
+cat >email-using-8bit <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: author@example.com
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+Subject: subject goes here
+
+Dieser deutsche Text enth=C3=A4lt einen Umlaut!
+EOF
+
+cat >content-type-decl <<EOF
+MIME-Version: 1.0
+Content-Type: text/plain; charset=3DUTF-8
+Content-Transfer-Encoding: 8bit
+EOF
+
+test_expect_success 'asks about and fixes 8bit encodings' '
+	clean_fake_sendmail &&
+	echo |
+	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			email-using-8bit >stdout &&
+	grep "do not declare a Content-Transfer-Encoding" stdout &&
+	grep email-using-8bit stdout &&
+	grep "Which 8bit encoding" stdout &&
+	grep "Content\\|MIME" msgtxt1 >actual &&
+	test_cmp actual content-type-decl
+'
+
+test_expect_success 'sendemail.8bitEncoding works' '
+	clean_fake_sendmail &&
+	git config sendemail.assume8bitEncoding UTF-8 &&
+	echo bogus |
+	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			email-using-8bit >stdout &&
+	grep "Content\\|MIME" msgtxt1 >actual &&
+	test_cmp actual content-type-decl
+'
+
+test_expect_success '--8bit-encoding overrides sendemail.8bitEncoding'=
 '
+	clean_fake_sendmail &&
+	git config sendemail.assume8bitEncoding "bogus too" &&
+	echo bogus |
+	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			--8bit-encoding=3DUTF-8 \
+			email-using-8bit >stdout &&
+	grep "Content\\|MIME" msgtxt1 >actual &&
+	test_cmp actual content-type-decl
+'
+
+cat >email-using-8bit <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: author@example.com
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+Subject: Dieser Betreff enth=C3=A4lt auch einen Umlaut!
+
+Nothing to see here.
+EOF
+
+cat >expected <<EOF
+Subject: =3D?UTF-8?q?Dieser=3D20Betreff=3D20enth=3DC3=3DA4lt=3D20auch=3D=
20einen=3D20Umlaut!?=3D
+EOF
+
+test_expect_success '--8bit-encoding also treats subject' '
+	clean_fake_sendmail &&
+	echo bogus |
+	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			--8bit-encoding=3DUTF-8 \
+			email-using-8bit >stdout &&
+	grep "Subject" msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.1.557.gd161
