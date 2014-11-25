From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/2] git-send-email: add --transfer-encoding option
Date: Tue, 25 Nov 2014 15:00:27 +0100
Message-ID: <1416924027-29862-3-git-send-email-bonzini@gnu.org>
References: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: lersek@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 15:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtGfg-0007P6-J1
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbaKYOAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 09:00:42 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:59661 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaKYOAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:00:40 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so922940wgg.21
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5bCzNnhvYbIAdS6ASJmgC2alUv9rKo73hVCyyzpG7ek=;
        b=pD44BNnIdvOs0S0HXud0pSB/JpsRfMahQpLmAkFa5flvrjKnhj39VUrEzICvDPxNOI
         K6uozpn4gGKyAeA9i51YCKknifflfDYaCFBmjy28EE29Djp65xpwnJwkXeOHkefxh/7M
         ZOgihMsrp7L7WPgD3bmgZqwEjyS1aETxVTqE7MtBUgfY8W1iiyrk411d5j/VOGqLD/Oa
         Np08mIBsHf1RFjFporrQL5FC9e+lpSv/w09A8+UJ6HnR1IkZh7Y9ndsxVmeBLpNku6DD
         6eT6u4zqeYPJ0WD0Hg+a1oIiH77QFKuLXdiNwAh4NbCkc+O2PwoDNc8yThRAzZRnwrsJ
         sJcg==
X-Received: by 10.180.73.235 with SMTP id o11mr13156801wiv.51.1416924038908;
        Tue, 25 Nov 2014 06:00:38 -0800 (PST)
Received: from donizetti.redhat.com (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id cq4sm2005989wjc.35.2014.11.25.06.00.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 06:00:37 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1416924027-29862-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260217>

=46rom: Paolo Bonzini <pbonzini@redhat.com>

The thread at http://thread.gmane.org/gmane.comp.version-control.git/25=
7392
details problems when applying patches with "git am" in a repository wi=
th
CRLF line endings.  In the example in the thread, the repository origin=
ated
from "git-svn" so it is not possible to use core.eol and friends on it.

Right now, the best option is to use "git am --keep-cr".  However, when
a patch create new files, the patch application process will reject the
new file because it finds a "/dev/null\r" string instead of "/dev/null"=
=2E

The problem is that SMTP transport is CRLF-unsafe.  Sending a patch by
email is the same as passing it through "dos2unix | unix2dos".  The new=
ly
introduced CRLFs are normally transparent because git-am strips them. T=
he
keepcr=3Dtrue setting preserves them, but it is mostly working by chanc=
e
and it would be very problematic to have a "git am" workflow in a
repository with mixed LF and CRLF line endings.

The MIME solution to this is the quoted-printable transfer enconding.
This is not something that we want to enable by default, since it makes
received emails horrible to look at.  However, it is a very good match
for projects that store CRLF line endings in the repository.

The only disadvantage of quoted-printable is that quoted-printable
patches fail to apply if the maintainer uses "git am --keep-cr".  This
is because the decoded patch will have two carriage returns at the end
of the line.  Therefore, add support for base64 transfer encoding too,
which makes received emails downright impossible to look at outside
a MUA, but really just works.

The patch covers all bases, including users that still live in the late
80s, by also providing a 7bit content transfer encoding that refuses
to send emails with non-ASCII character in them.  And finally, "8bit"
will add a Content-Transfer-Encoding header but otherwise do nothing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/config.txt               |   1 +
 Documentation/git-send-email.txt       |  10 +++
 contrib/completion/git-completion.bash |   4 +
 git-send-email.perl                    |  36 ++++++++
 t/t9001-send-email.sh                  | 157 +++++++++++++++++++++++++=
++++++++
 5 files changed, 208 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..cc2ff20 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2303,6 +2303,7 @@ sendemail.smtpserverport::
 sendemail.smtpserveroption::
 sendemail.smtpuser::
 sendemail.thread::
+sendemail.transferencoding::
 sendemail.validate::
 	See linkgit:git-send-email[1] for description.
=20
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index a60776e..a9efa5c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -131,6 +131,16 @@ Note that no attempts whatsoever are made to valid=
ate the encoding.
 	Specify encoding of compose message. Default is the value of the
 	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed=
=2E
=20
+--transfer-encoding=3D(7bit|8bit|quoted-printable|base64)::
+	Specify the transfer encoding to be used to send the message over SMT=
P.
+	7bit will fail upon encountering a non-ASCII message.  quoted-printab=
le
+	can be useful when the repository contains files that contain carriag=
e
+	returns, but makes the raw patch email file (as saved from a MUA) muc=
h
+	harder to inspect manually.  base64 is even more fool proof, but also
+	even more opaque.  Default is the value of the 'sendemail.transferEnc=
oding'
+	configuration value; if that is unspecified, git will use 8bit and no=
t
+	add a Content-Transfer-Encoding header.
+
=20
 Sending
 ~~~~~~~
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 2fece98..b154f70 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1875,6 +1875,10 @@ _git_config ()
 		__gitcomp "$__git_send_email_suppresscc_options"
 		return
 		;;
+	sendemail.transferencoding)
+		__gitcomp "7bit 8bit quoted-printable base64"
+		return
+		;;
 	--get|--get-all|--unset|--unset-all)
 		__gitcomp_nl "$(__git_config_get_set_variables)"
 		return
diff --git a/git-send-email.perl b/git-send-email.perl
index b29a304..82c6fea 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -58,6 +58,7 @@ git send-email [options] <file | directory | rev-list=
 options >
     --compose                      * Open an editor for introduction.
     --compose-encoding      <str>  * Encoding to assume for introducti=
on.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if =
undeclared
+    --transfer-encoding     <str>  * Transfer encoding to use (quoted-=
printable, 8bit, base64)
=20
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -206,6 +207,7 @@ my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
+my ($target_xfer_encoding);
=20
 my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
=20
@@ -242,6 +244,7 @@ my %config_settings =3D (
     "from" =3D> \$sender,
     "assume8bitencoding" =3D> \$auto_8bit_encoding,
     "composeencoding" =3D> \$compose_encoding,
+    "transferencoding" =3D> \$target_xfer_encoding,
 );
=20
 my %config_path_settings =3D (
@@ -314,6 +317,7 @@ my $rc =3D GetOptions("h" =3D> \$help,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
 		    "validate!" =3D> \$validate,
+		    "transfer-encoding=3Ds" =3D> \$target_xfer_encoding,
 		    "format-patch!" =3D> \$format_patch,
 		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
 		    "compose-encoding=3Ds" =3D> \$compose_encoding,
@@ -1482,6 +1486,12 @@ foreach my $t (@files) {
 			}
 		}
 	}
+	if (defined $target_xfer_encoding) {
+		$xfer_encoding =3D '8bit' if not defined $xfer_encoding;
+		$message =3D apply_transfer_encoding(
+			$message, $xfer_encoding, $target_xfer_encoding);
+		$xfer_encoding =3D $target_xfer_encoding;
+	}
 	if (defined $xfer_encoding) {
 		push @xh, "Content-Transfer-Encoding: $xfer_encoding";
 	}
@@ -1556,6 +1566,32 @@ sub cleanup_compose_files {
=20
 $smtp->quit if $smtp;
=20
+sub apply_transfer_encoding {
+	my $message =3D shift;
+	my $from =3D shift;
+	my $to =3D shift;
+
+	return $message if ($from eq $to and $from ne '7bit');
+
+	require MIME::QuotedPrint;
+	require MIME::Base64;
+
+	$message =3D MIME::QuotedPrint::decode($message)
+		if ($from eq 'quoted-printable');
+	$message =3D MIME::Base64::decode($message)
+		if ($from eq 'base64');
+
+	die "cannot send message as 7bit"
+		if ($to eq '7bit' and $message =3D~ /[^[:ascii:]]/);
+	return $message
+		if ($to eq '7bit' or $to eq '8bit');
+	return MIME::QuotedPrint::encode($message, "\n", 0)
+		if ($to eq 'quoted-printable');
+	return MIME::Base64::encode($message, "\n")
+		if ($to eq 'base64');
+	die "invalid transfer encoding";
+}
+
 sub unique_email_list {
 	my %seen;
 	my @emails;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 19a3ced..e5016f4 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1298,6 +1298,163 @@ test_expect_success $PREREQ '--8bit-encoding al=
so treats subject' '
 	test_cmp expected actual
 '
=20
+test_expect_success $PREREQ 'setup expect' '
+cat >email-using-8bit <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: A U Thor <author@example.com>
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+Content-Type: text/plain; charset=3DUTF-8
+Subject: Nothing to see here.
+
+Dieser Betreff enth=C3=A4lt auch einen Umlaut!
+EOF
+'
+
+test_expect_success $PREREQ 'sendemail.transferencoding=3D7bit fails o=
n 8bit data' '
+	clean_fake_sendmail &&
+	git config sendemail.transferEncoding 7bit &&
+	test_must_fail git send-email \
+	  --transfer-encoding=3D7bit \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-8bit \
+	  2>errors >out &&
+	grep "cannot send message as 7bit" errors &&
+	test -z "$(ls msgtxt*)"
+'
+
+test_expect_success $PREREQ '--transfer-encoding overrides sendemail.t=
ransferEncoding' '
+	clean_fake_sendmail &&
+	git config sendemail.transferEncoding 8bit
+	test_must_fail git send-email \
+	  --transfer-encoding=3D7bit \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-8bit \
+	  2>errors >out &&
+	grep "cannot send message as 7bit" errors &&
+	test -z "$(ls msgtxt*)"
+'
+
+test_expect_success $PREREQ 'sendemail.transferencoding=3D8bit' '
+	clean_fake_sendmail &&
+	git send-email \
+	  --transfer-encoding=3D8bit \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-8bit \
+	  2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	sed '1,/^$/d' email-using-8bit >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+Dieser Betreff enth=3DC3=3DA4lt auch einen Umlaut!
+EOF
+'
+
+test_expect_success $PREREQ '8-bit and sendemail.transferencoding=3Dqu=
oted-printable' '
+	clean_fake_sendmail &&
+	git send-email \
+	  --transfer-encoding=3Dquoted-printable \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-8bit \
+	  2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+RGllc2VyIEJldHJlZmYgZW50aMOkbHQgYXVjaCBlaW5lbiBVbWxhdXQhCg=3D=3D
+EOF
+'
+
+test_expect_success $PREREQ '8-bit and sendemail.transferencoding=3Dba=
se64' '
+	clean_fake_sendmail &&
+	git send-email \
+	  --transfer-encoding=3Dbase64 \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-8bit \
+	  2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'setup expect' '
+cat >email-using-qp <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: A U Thor <author@example.com>
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+MIME-Version: 1.0
+Content-Transfer-Encoding: quoted-printable
+Content-Type: text/plain; charset=3DUTF-8
+Subject: Nothing to see here.
+
+Dieser Betreff enth=3DC3=3DA4lt auch einen Umlaut!
+EOF
+'
+
+test_expect_success $PREREQ 'convert from quoted-printable to base64' =
'
+	clean_fake_sendmail &&
+	git send-email \
+	  --transfer-encoding=3Dbase64 \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-qp \
+	  2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'setup expect' "
+tr -d '\\015' | tr '%' '\\015' > email-using-crlf <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: A U Thor <author@example.com>
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+Content-Type: text/plain; charset=3DUTF-8
+Subject: Nothing to see here.
+
+Look, I have a CRLF and an =3D sign!%
+EOF
+"
+
+test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+Look, I have a CRLF and an =3D3D sign!=3D0D
+EOF
+'
+
+test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=3Dquo=
ted-printable' '
+	clean_fake_sendmail &&
+	git send-email \
+	  --transfer-encoding=3Dquoted-printable \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-crlf \
+	  2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+TG9vaywgSSBoYXZlIGEgQ1JMRiBhbmQgYW4gPSBzaWduIQ0K
+EOF
+'
+
+test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=3Dbas=
e64' '
+	clean_fake_sendmail &&
+	git send-email \
+	  --transfer-encoding=3Dbase64 \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  email-using-crlf \
+	  2>errors >out &&
+	sed '1,/^$/d' msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
+
 # Note that the patches in this test are deliberately out of order; we
 # want to make sure it works even if the cover-letter is not in the
 # first mail.
--=20
2.1.0
