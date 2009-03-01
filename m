From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: add --confirm option
Date: Sun,  1 Mar 2009 03:23:21 -0500
Message-ID: <1235895801-80414-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 09:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldgyo-00077K-GP
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 09:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZCAIX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 03:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZCAIX3
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 03:23:29 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:43011 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZCAIX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 03:23:28 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1262674yxm.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 00:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=1+NMZoiZcw4aLuKy9XkSTlWafP7Mw6SYkItl0sASAG0=;
        b=JMUBf10bjVbuu384QzgiOCre8fyGminRe/HppjpHzNSe9LxV2budUGR5kNATL4bGtM
         hlfkUvLAJfGxmwIi3zAca/kj+KPZhFITAhx3a9ZALQyDv8w0x/DPqXi+krfT/8dcW0Nk
         B8HE6BTTKxIz78vB0c7xHLXFRTapK5IHRdEgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=vOw+PlUjsUXu0I+j/sJ3EUctLzn/RH4InhyP9j9s14hro2m9ErZ7gaA2eqjKXaGWBz
         whz+c235TVvJ0T/hxG0n31P6zowifPPNbs3V5s8YX7VsrywC1fz+8hPV3Y7qxGjKlj9q
         2PWZ1kYQkol6WqKREB8DI9HdtZUKR+6JZbG0M=
Received: by 10.100.165.5 with SMTP id n5mr3912324ane.69.1235895805651;
        Sun, 01 Mar 2009 00:23:25 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d21sm7197551and.46.2009.03.01.00.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 00:23:24 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111826>

send-email violates the principle of least surprise by automatically
cc'ing additional recipients without confirming this with the user.

This patch teaches send-email a --confirm option. It takes the
following values:

 --confirm=3Dalways   always confirm before sending
 --confirm=3Dnever    never confirm before sending
 --confirm=3Dcc       confirm before sending when send-email has
                    automatically added addresses from the patch to
                    the Cc list
 --confirm=3Dcompose  confirm before sending the first message when
                    using --compose. (Needed to maintain backwards
                    compatibility with existing behavior.)
 --confirm=3Dauto     'cc' + 'compose'

The option defaults to 'compose' if any suppress Cc related options hav=
e
been used, otherwise it defaults to 'auto'.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Junio,

I based this on top of js/send-email.

j.

 Documentation/git-send-email.txt |   16 ++++++++
 git-send-email.perl              |   68 +++++++++++++++++++++++-------=
-----
 t/t9001-send-email.sh            |   72 +++++++++++++++++++++++++++++-=
-------
 3 files changed, 117 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 164d149..bcf7ff1 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -199,6 +199,22 @@ specified, as well as 'body' if --no-signed-off-cc=
 is specified.
 Administering
 ~~~~~~~~~~~~~
=20
+--confirm::
+	Confirm just before sending:
++
+--
+- 'always' will always confirm before sending
+- 'never' will never confirm before sending
+- 'cc' will confirm before sending when send-email has automatically
+  added addresses from the patch to the Cc list
+- 'compose' will confirm before sending the first message when using -=
-compose.
+- 'auto' is equivalent to 'cc' + 'compose'
+--
++
+Default is the value of 'sendemail.confirm' configuration value; if th=
at
+is unspecified, default to 'auto' unless any of the suppress options
+have been specified, in which case default to 'compose'.
+
 --dry-run::
 	Do everything except actually send the emails.
=20
diff --git a/git-send-email.perl b/git-send-email.perl
index adf7ecb..a777e3f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -75,6 +75,8 @@ git send-email [options] <file | directory | rev-list=
 options >
     --[no-]thread                  * Use In-Reply-To: field. Default o=
n.
=20
   Administering:
+    --confirm               <str>  * Confirm recipients before sending=
;
+                                     auto, cc, compose, always, or nev=
er.
     --quiet                        * Output one line of info per email=
=2E
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Defa=
ult on.
@@ -181,7 +183,7 @@ sub do_edit {
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_c=
md);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption)=
;
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
-my ($validate);
+my ($validate, $confirm);
 my (@suppress_cc);
=20
 my %config_bool_settings =3D (
@@ -207,6 +209,7 @@ my %config_settings =3D (
     "suppresscc" =3D> \@suppress_cc,
     "envelopesender" =3D> \$envelope_sender,
     "multiedit" =3D> \$multiedit,
+    "confirm"   =3D> \$confirm,
 );
=20
 # Handle Uncouth Termination
@@ -258,6 +261,7 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$send=
er,
 		    "suppress-from!" =3D> \$suppress_from,
 		    "suppress-cc=3Ds" =3D> \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" =3D> \$signed_off_by_cc,
+		    "confirm=3Ds" =3D> \$confirm,
 		    "dry-run" =3D> \$dry_run,
 		    "envelope-sender=3Ds" =3D> \$envelope_sender,
 		    "thread!" =3D> \$thread,
@@ -346,6 +350,11 @@ if ($suppress_cc{'body'}) {
 	delete $suppress_cc{'body'};
 }
=20
+# Set confirm
+if (!defined $confirm) {
+	$confirm =3D scalar %suppress_cc ? 'compose' : 'auto';
+};
+
 # Debugging, print out the suppressions.
 if (0) {
 	print "suppressions:\n";
@@ -663,25 +672,13 @@ if (!defined $smtp_server) {
 	$smtp_server ||=3D 'localhost'; # could be 127.0.0.1, too... *shrug*
 }
=20
-if ($compose) {
-	while (1) {
-		$_ =3D $term->readline("Send this email? (y|n) ");
-		last if defined $_;
-		print "\n";
-	}
-
-	if (uc substr($_,0,1) ne 'Y') {
-		cleanup_compose_files();
-		exit(0);
-	}
-
-	if ($compose > 0) {
-		@files =3D ($compose_filename . ".final", @files);
-	}
+if ($compose && $compose > 0) {
+	@files =3D ($compose_filename . ".final", @files);
 }
=20
 # Variables we set as part of the loop over files
-our ($message_id, %mail, $subject, $reply_to, $references, $message);
+our ($message_id, %mail, $subject, $reply_to, $references, $message,
+	$needs_confirm, $message_num);
=20
 sub extract_valid_address {
 	my $address =3D shift;
@@ -837,6 +834,25 @@ X-Mailer: git-send-email $gitversion
 	unshift (@sendmail_parameters,
 			'-f', $raw_from) if(defined $envelope_sender);
=20
+	if ($needs_confirm && !$dry_run) {
+		print "\n$header\n";
+		while (1) {
+			chomp ($_ =3D $term->readline(
+				"Send this email? ([y]es|[n]o|[q]uit|[a]ll): "
+			));
+			last if /^(?:yes|y|no|n|quit|q|all|a)/i;
+			print "\n";
+		}
+		if (/^n/i) {
+			return;
+		} elsif (/^q/i) {
+			cleanup_compose_files();
+			exit(0);
+		} elsif (/^a/i) {
+			$confirm =3D 'never';
+		}
+	}
+
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =3D~ m#^/#) {
@@ -935,6 +951,7 @@ X-Mailer: git-send-email $gitversion
 $reply_to =3D $initial_reply_to;
 $references =3D $initial_reply_to || '';
 $subject =3D $initial_subject;
+$message_num =3D 0;
=20
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
@@ -943,11 +960,12 @@ foreach my $t (@files) {
 	my $author_encoding;
 	my $has_content_type;
 	my $body_encoding;
-	@cc =3D @initial_cc;
+	@cc =3D ();
 	@xh =3D ();
 	my $input_format =3D undef;
 	my @header =3D ();
 	$message =3D "";
+	$message_num++;
 	# First unfold multiline header fields
 	while(<F>) {
 		last if /^\s*$/;
@@ -1080,6 +1098,13 @@ foreach my $t (@files) {
 		}
 	}
=20
+	$needs_confirm =3D (
+		$confirm eq "always" or
+		($confirm =3D~ /^(?:auto|cc)$/ && @cc) or
+		($confirm =3D~ /^(?:auto|compose)$/ && $compose && $message_num =3D=3D=
 1));
+
+	@cc =3D (@initial_cc, @cc);
+
 	send_message();
=20
 	# set up for the next message
@@ -1094,13 +1119,10 @@ foreach my $t (@files) {
 	$message_id =3D undef;
 }
=20
-if ($compose) {
-	cleanup_compose_files();
-}
+cleanup_compose_files();
=20
 sub cleanup_compose_files() {
-	unlink($compose_filename, $compose_filename . ".final");
-
+	unlink($compose_filename, $compose_filename . ".final") if $compose;
 }
=20
 $smtp->quit if $smtp;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4df4f96..2f4a654 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -31,6 +31,11 @@ clean_fake_sendmail() {
 	rm -f commandline* msgtxt*
 }
=20
+# Prevent any tests from hanging
+test_expect_success 'Set sendemail.confirm=3Dnever' '
+	git config sendemail.confirm never
+'
+
 test_expect_success 'Extract patches' '
     patches=3D`git format-patch -s --cc=3D"One <one@example.com>" --cc=
=3Dtwo@example.com -n HEAD^1`
 '
@@ -175,15 +180,13 @@ test_set_editor "$(pwd)/fake-editor"
=20
 test_expect_success '--compose works' '
 	clean_fake_sendmail &&
-	echo y | \
-		GIT_SEND_EMAIL_NOTTY=3D1 \
-		git send-email \
-		--compose --subject foo \
-		--from=3D"Example <nobody@example.com>" \
-		--to=3Dnobody@example.com \
-		--smtp-server=3D"$(pwd)/fake.sendmail" \
-		$patches \
-		2>errors
+	git send-email \
+	--compose --subject foo \
+	--from=3D"Example <nobody@example.com>" \
+	--to=3Dnobody@example.com \
+	--smtp-server=3D"$(pwd)/fake.sendmail" \
+	$patches \
+	2>errors
 '
=20
 test_expect_success 'first message is compose text' '
@@ -375,15 +378,56 @@ test_expect_success '--suppress-cc=3Dcc' '
 	test_suppression cc
 '
=20
+test_confirm () {
+	echo y | \
+		GIT_SEND_EMAIL_NOTTY=3D1 \
+		git send-email \
+		--from=3D"Example <nobody@example.com>" \
+		--to=3Dnobody@example.com \
+		--smtp-server=3D"$(pwd)/fake.sendmail" \
+		$@ \
+		$patches | grep "Send this email"
+}
+
+test_expect_success '--confirm=3Dalways' '
+	test_confirm --confirm=3Dalways --suppress-cc=3Dall
+'
+
+test_expect_success '--confirm=3Dauto' '
+	test_confirm --confirm=3Dauto
+'
+
+test_expect_success '--confirm=3Dcc' '
+	test_confirm --confirm=3Dcc
+'
+
+test_expect_success '--confirm=3Dcompose' '
+	test_confirm --confirm=3Dcompose --compose
+'
+
+test_expect_success 'confirm by default (due to cc)' '
+	CONFIRM=3D$(git config --get sendemail.confirm) &&
+	git config --unset sendemail.confirm &&
+	test_confirm &&
+	git config sendemail.confirm $CONFIRM
+'
+
+test_expect_success 'confirm by default (due to --compose)' '
+	CONFIRM=3D$(git config --get sendemail.confirm) &&
+	git config --unset sendemail.confirm &&
+	test_confirm --suppress-cc=3Dall --compose
+	ret=3D"$?"
+	git config sendemail.confirm ${CONFIRM:-never}
+	test $ret =3D "0"
+'
+
 test_expect_success '--compose adds MIME for utf8 body' '
 	clean_fake_sendmail &&
 	(echo "#!$SHELL_PATH" &&
 	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
 	) >fake-editor-utf8 &&
 	chmod +x fake-editor-utf8 &&
-	echo y | \
 	  GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\"" \
-	  GIT_SEND_EMAIL_NOTTY=3D1 \
 	  git send-email \
 	  --compose --subject foo \
 	  --from=3D"Example <nobody@example.com>" \
@@ -405,9 +449,7 @@ test_expect_success '--compose respects user mime t=
ype' '
 	 echo " echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA) >\"\$1\""
 	) >fake-editor-utf8-mime &&
 	chmod +x fake-editor-utf8-mime &&
-	echo y | \
 	  GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8-mime\"" \
-	  GIT_SEND_EMAIL_NOTTY=3D1 \
 	  git send-email \
 	  --compose --subject foo \
 	  --from=3D"Example <nobody@example.com>" \
@@ -421,9 +463,7 @@ test_expect_success '--compose respects user mime t=
ype' '
=20
 test_expect_success '--compose adds MIME for utf8 subject' '
 	clean_fake_sendmail &&
-	echo y | \
 	  GIT_EDITOR=3D"\"$(pwd)/fake-editor\"" \
-	  GIT_SEND_EMAIL_NOTTY=3D1 \
 	  git send-email \
 	  --compose --subject utf8-s=C3=BCbj=C3=ABct \
 	  --from=3D"Example <nobody@example.com>" \
@@ -445,7 +485,7 @@ test_expect_success 'detects ambiguous reference/fi=
le conflict' '
 test_expect_success 'feed two files' '
 	rm -fr outdir &&
 	git format-patch -2 -o outdir &&
-	GIT_SEND_EMAIL_NOTTY=3D1 git send-email \
+	git send-email \
 	--dry-run \
 	--from=3D"Example <nobody@example.com>" \
 	--to=3Dnobody@example.com \
--=20
1.6.2.rc1.309.g5f417
