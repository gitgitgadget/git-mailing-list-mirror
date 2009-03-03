From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3] send-email: add --confirm option and configuration setting
Date: Mon,  2 Mar 2009 23:52:18 -0500
Message-ID: <1236055938-65407-1-git-send-email-jaysoffian@gmail.com>
References: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 05:54:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeMds-0003zt-D2
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 05:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbZCCEwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 23:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753577AbZCCEwh
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 23:52:37 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:26829 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005AbZCCEwg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 23:52:36 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1740787ywh.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 20:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=jPnx6T97sqDctNpqt37DACSljmlFD4fLKc+6/KY6J4Y=;
        b=tuTfj8EnXvY18N0Bf2CA/Mza6rFnqYORiqizhuRwr6h5GUO8ttzm5zud7DwBKxY5Vj
         3FyzhkzFWbzYdth0i9qEvF9AkLRrhbS37ishrlDoQOFWESNnJS5A3eBQ1ZMnopp9ivDT
         h1l1WNgyoEtxaetjnyo/WFoYUxn/BHgmFB1fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rxTY0iO/LISdIcfYiciJV++8dCRj+N5HTmqPl4Wj+uKBg3m/fd//KqRoiAmXaYUmEQ
         3mdbiFJKnloki16TCepsCUrBtBdaK45H+wTt9MYBctj2Iu4LlNltvo297GrO/WRKyq/r
         eTUgbmc8ZWzlMZZe93DmJM4FT3zwtCY1Saihc=
Received: by 10.100.254.15 with SMTP id b15mr5412789ani.155.1236055953823;
        Mon, 02 Mar 2009 20:52:33 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c14sm1187799ana.1.2009.03.02.20.52.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Mar 2009 20:52:21 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <7v1vtfjpad.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111994>

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

If sendemail.confirm is unconfigured, the option defaults to 'compose'
if any suppress-Cc related options have been used, otherwise it default=
s
to 'auto'.

Unfortunately, it is impossible to introduce this patch such that it
helps new users without potentially annoying some existing users. We
attempt to mitigate the latter by:

 * Allowing the user to set 'git config sendemail.confirm never'
 * Allowing the user to say 'all' after the first prompt to not be
   prompted on remaining emails during the same invocation.
 * Telling the user about the 'sendemail.confirm' setting if it is
   unconfigured whenever we prompt due to Cc before sending.
 * Only prompting if no --suppress related options have been passed, as
   using such an option is likely to indicate an experienced send-email
   user.

There is a slight fib in message informing the user of the
sendemail.confirm setting and this is intentional. Setting 'auto'
differs from leaving sendemail.confirm unset in two ways: 1) 'auto'
obviously squelches the informational message; 2) 'auto' prompts when
the Cc list has been expanded even in the presence of a --suppress
related option, where leaving sendemail.confirm unset does not. This is
intentional to keep the message simple, and to avoid adding another
sendemail.confirm value ('auto-except-suppress'?).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Differences from v2:

 * Inform user of sendemail.confirm if it is unconfigured and we are
   in a prompting situation where the Cc list has been expanded, per
   Junio's suggestion. This is instead of informing everytime "all"
   is used.

 * Fixed typo in commit message

 * Documented sendemail.confirm configuration setting.

 Documentation/git-send-email.txt |   21 +++++++
 git-send-email.perl              |   84 +++++++++++++++++++++--------
 t/t9001-send-email.sh            |  108 ++++++++++++++++++++++++++++++=
++------
 3 files changed, 174 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 164d149..0335727 100644
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
@@ -242,6 +258,11 @@ sendemail.multiedit::
 	summary when '--compose' is used). If false, files will be edited one
 	after the other, spawning a new editor each time.
=20
+sendemail.confirm::
+	Sets the default for whether to confirm before sending. Must be
+	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
+	in the previous section for the meaning of these values.
+
=20
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index adf7ecb..57127aa 100755
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
@@ -346,6 +350,14 @@ if ($suppress_cc{'body'}) {
 	delete $suppress_cc{'body'};
 }
=20
+# Set confirm's default value
+my $confirm_unconfigured =3D !defined $confirm;
+if ($confirm_unconfigured) {
+	$confirm =3D scalar %suppress_cc ? 'compose' : 'auto';
+};
+die "Unknown --confirm setting: '$confirm'\n"
+	unless $confirm =3D~ /^(?:auto|cc|compose|always|never)/;
+
 # Debugging, print out the suppressions.
 if (0) {
 	print "suppressions:\n";
@@ -663,25 +675,13 @@ if (!defined $smtp_server) {
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
@@ -837,6 +837,37 @@ X-Mailer: git-send-email $gitversion
 	unshift (@sendmail_parameters,
 			'-f', $raw_from) if(defined $envelope_sender);
=20
+	if ($needs_confirm && !$dry_run) {
+		print "\n$header\n";
+		if ($needs_confirm eq "inform") {
+			$confirm_unconfigured =3D 0; # squelch this message for the rest of=
 this run
+			print "    The Cc list above has been expanded by additional\n";
+			print "    addresses found in the patch commit message. By default\=
n";
+			print "    send-email prompts before sending whenever this occurs.\=
n";
+			print "    This behavior is controlled by the sendemail.confirm\n";
+			print "    configuration setting.\n";
+			print "\n";
+			print "    For additional information, run 'git send-email --help'.=
\n";
+			print "    To retain the current behavior, but squelch this message=
,\n";
+			print "    run 'git config --global sendemail.confirm auto'.\n\n";
+		}
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
@@ -935,6 +966,7 @@ X-Mailer: git-send-email $gitversion
 $reply_to =3D $initial_reply_to;
 $references =3D $initial_reply_to || '';
 $subject =3D $initial_subject;
+$message_num =3D 0;
=20
 foreach my $t (@files) {
 	open(F,"<",$t) or die "can't open file $t";
@@ -943,11 +975,12 @@ foreach my $t (@files) {
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
@@ -1080,6 +1113,14 @@ foreach my $t (@files) {
 		}
 	}
=20
+	$needs_confirm =3D (
+		$confirm eq "always" or
+		($confirm =3D~ /^(?:auto|cc)$/ && @cc) or
+		($confirm =3D~ /^(?:auto|compose)$/ && $compose && $message_num =3D=3D=
 1));
+	$needs_confirm =3D "inform" if ($needs_confirm && $confirm_unconfigur=
ed && @cc);
+
+	@cc =3D (@initial_cc, @cc);
+
 	send_message();
=20
 	# set up for the next message
@@ -1094,13 +1135,10 @@ foreach my $t (@files) {
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
index 4df4f96..08d5b91 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -35,6 +35,47 @@ test_expect_success 'Extract patches' '
     patches=3D`git format-patch -s --cc=3D"One <one@example.com>" --cc=
=3Dtwo@example.com -n HEAD^1`
 '
=20
+# Test no confirm early to ensure remaining tests will not hang
+test_no_confirm () {
+	rm -f no_confirm_okay
+	echo n | \
+		GIT_SEND_EMAIL_NOTTY=3D1 \
+		git send-email \
+		--from=3D"Example <from@example.com>" \
+		--to=3Dnobody@example.com \
+		--smtp-server=3D"$(pwd)/fake.sendmail" \
+		$@ \
+		$patches > stdout &&
+		test_must_fail grep "Send this email" stdout &&
+		> no_confirm_okay
+}
+
+# Exit immediately to prevent hang if a no-confirm test fails
+check_no_confirm () {
+	test -f no_confirm_okay || {
+		say 'No confirm test failed; skipping remaining tests to prevent han=
ging'
+		test_done
+	}
+}
+
+test_expect_success 'No confirm with --suppress-cc' '
+	test_no_confirm --suppress-cc=3Dsob
+'
+check_no_confirm
+
+test_expect_success 'No confirm with --confirm=3Dnever' '
+	test_no_confirm --confirm=3Dnever
+'
+check_no_confirm
+
+# leave sendemail.confirm set to never after this so that none of the
+# remaining tests prompt unintentionally.
+test_expect_success 'No confirm with sendemail.confirm=3Dnever' '
+	git config sendemail.confirm never &&
+	test_no_confirm --compose --subject=3Dfoo
+'
+check_no_confirm
+
 test_expect_success 'Send patches' '
      git send-email --suppress-cc=3Dsob --from=3D"Example <nobody@exam=
ple.com>" --to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake.sendma=
il" $patches 2>errors
 '
@@ -175,15 +216,13 @@ test_set_editor "$(pwd)/fake-editor"
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
@@ -375,15 +414,56 @@ test_expect_success '--suppress-cc=3Dcc' '
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
@@ -405,9 +485,7 @@ test_expect_success '--compose respects user mime t=
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
@@ -421,9 +499,7 @@ test_expect_success '--compose respects user mime t=
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
@@ -445,7 +521,7 @@ test_expect_success 'detects ambiguous reference/fi=
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
