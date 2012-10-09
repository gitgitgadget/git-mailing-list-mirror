From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 2/2] git-send-email: use locale encoding for compose
Date: Wed, 10 Oct 2012 01:02:56 +0200
Message-ID: <20121009230256.GA22477@shrek.podlesie.net>
References: <1349301931-11912-1-git-send-email-krzysiek@podlesie.net>
 <1349301931-11912-2-git-send-email-krzysiek@podlesie.net>
 <7vehl7e3cs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 01:03:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLipV-000567-1a
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084Ab2JIXDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 19:03:01 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:56242 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab2JIXDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 19:03:00 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 9D021F14; Wed, 10 Oct 2012 01:02:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vehl7e3cs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207352>

On Tue, Oct 09, 2012 at 02:34:59PM -0700, Junio C Hamano wrote:
> Krzysztof Mazur <krzysiek@podlesie.net> writes:
>=20
> > The introduction email (--compose option) use UTF-8 as default enco=
ding.
> > The current locale encoding is much better default value.
> >
>=20
> These two patches make sense in general, but t9001.62 (--compose
> adds MIME for utf8 body) seems to be broken by it.  I didn't check
> to see if the code is broken, or the test has expecting a wrong
> behaviour.  If the latter, the test needs to be updated to match the
> improved new world order.
>=20
> Thanks.

The second patch was broken - for C locale the ANSI_X3.4-1968 codeset
was used, which is insane because git-send-email adds Content-Type
only when non-ASCII characters were found. I think this can be fixed
by just using UTF-8 if langinfo returns ANSI_X3.4-1968.

However I think that that patch should be dropped for now, because also
other git commands like "git commit" don't use codeset from locale.
The git commit just detects invalid UTF-8 characters and prints hint
for user to set i18n.commitencoding. If you like the idea of using code=
set
from locale I can send fixed patch and also change "git commit".

=46or now I think it's better to just take only the first patch.

I'm resending the first patch with added tests.

Thanks,
Chris
---=20
=46rom 0d1fccc5e70367f3eeb2372b8fc24401bf88d748 Mon Sep 17 00:00:00 200=
1
=46rom: Krzysztof Mazur <krzysiek@podlesie.net>
Date: Wed, 10 Oct 2012 00:17:29 +0200
Subject: [PATCH] git-send-email: introduce compose-encoding

The introduction email (--compose option) have encoding hardcoded to
UTF-8, but invoked editor may not use UTF-8 encoding.
The encoding used by patches can be changed by the "8bit-encoding"
option, but this option does not have effect on introduction email
and equivalent for introduction email is missing.

Added compose-encoding command line option and sendemail.composeencodin=
g
configuration option specify encoding of introduction email.

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 Documentation/git-send-email.txt |  5 ++++
 git-send-email.perl              |  9 ++++++-
 t/t9001-send-email.sh            | 55 ++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-=
email.txt
index 3241170..9f09e92 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -126,6 +126,11 @@ The --to option must be repeated for each user you=
 want on the to list.
 +
 Note that no attempts whatsoever are made to validate the encoding.
=20
+--compose-encoding=3D<encoding>::
+	Specify encoding of compose message. Default is the value of the
+	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed=
=2E
++
+
=20
 Sending
 ~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index aea66a0..107e814 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -56,6 +56,7 @@ git send-email [options] <file | directory | rev-list=
 options >
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --annotate                     * Review each patch that will be se=
nt in an editor.
     --compose                      * Open an editor for introduction.
+    --compose-encoding      <str>  * Encoding to assume for introducti=
on.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if =
undeclared
=20
   Sending:
@@ -198,6 +199,7 @@ my ($identity, $aliasfiletype, @alias_files, $smtp_=
domain);
 my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
+my ($compose_encoding);
=20
 my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
=20
@@ -231,6 +233,7 @@ my %config_settings =3D (
     "confirm"   =3D> \$confirm,
     "from" =3D> \$sender,
     "assume8bitencoding" =3D> \$auto_8bit_encoding,
+    "composeencoding" =3D> \$compose_encoding,
 );
=20
 my %config_path_settings =3D (
@@ -315,6 +318,7 @@ my $rc =3D GetOptions("h" =3D> \$help,
 		    "validate!" =3D> \$validate,
 		    "format-patch!" =3D> \$format_patch,
 		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
+		    "compose-encoding=3Ds" =3D> \$compose_encoding,
 		    "force" =3D> \$force,
 	 );
=20
@@ -638,10 +642,13 @@ EOT
 			$summary_empty =3D 0 unless (/^\n$/);
 		} elsif (/^\n$/) {
 			$in_body =3D 1;
+			if (!defined $compose_encoding) {
+				$compose_encoding =3D "UTF-8";
+			}
 			if ($need_8bit_cte) {
 				print $c2 "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
-					   "charset=3DUTF-8\n",
+					   "charset=3D$compose_encoding\n",
 					 "Content-Transfer-Encoding: 8bit\n";
 			}
 		} elsif (/^MIME-Version:/i) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 0351228..265ae04 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -854,6 +854,61 @@ test_expect_success $PREREQ 'utf8 author is correc=
tly passed on' '
 	grep "^From: F=C3=BC=C3=B1n=C3=BD N=C3=A2m=C3=A9 <odd_?=3Dmail@exampl=
e.com>" msgtxt1
 '
=20
+test_expect_success $PREREQ 'sendemail.composeencoding works' '
+	clean_fake_sendmail &&
+	git config sendemail.composeencoding iso-8859-1 &&
+	(echo "#!$SHELL_PATH" &&
+	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
+	) >fake-editor-utf8 &&
+	chmod +x fake-editor-utf8 &&
+	  GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\"" \
+	  git send-email \
+	  --compose --subject foo \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^utf8 body" msgtxt1 &&
+	grep "^Content-Type: text/plain; charset=3Diso-8859-1" msgtxt1
+'
+
+test_expect_success $PREREQ '--compose-encoding works' '
+	clean_fake_sendmail &&
+	(echo "#!$SHELL_PATH" &&
+	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
+	) >fake-editor-utf8 &&
+	chmod +x fake-editor-utf8 &&
+	  GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\"" \
+	  git send-email \
+	  --compose-encoding iso-8859-1 \
+	  --compose --subject foo \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^utf8 body" msgtxt1 &&
+	grep "^Content-Type: text/plain; charset=3Diso-8859-1" msgtxt1
+'
+
+test_expect_success $PREREQ '--compose-encoding overrides sendemail.co=
mposeencoding' '
+	clean_fake_sendmail &&
+	git config sendemail.composeencoding iso-8859-1 &&
+	(echo "#!$SHELL_PATH" &&
+	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
+	) >fake-editor-utf8 &&
+	chmod +x fake-editor-utf8 &&
+	  GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\"" \
+	  git send-email \
+	  --compose-encoding iso-8859-2 \
+	  --compose --subject foo \
+	  --from=3D"Example <nobody@example.com>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  $patches &&
+	grep "^utf8 body" msgtxt1 &&
+	grep "^Content-Type: text/plain; charset=3Diso-8859-2" msgtxt1
+'
+
 test_expect_success $PREREQ 'detects ambiguous reference/file conflict=
' '
 	echo master > master &&
 	git add master &&
--=20
1.7.12.2.2.g1c3c581
