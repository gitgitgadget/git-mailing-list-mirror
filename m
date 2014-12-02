From: Luis Henriques <henrix@camandro.org>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Tue, 2 Dec 2014 19:32:44 +0000
Message-ID: <20141202193243.GA2999@charon.olymp>
References: <20140324213814.GA1267@achilles.my.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 21:00:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvtcA-0002dG-8k
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 21:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbaLBT76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 14:59:58 -0500
Received: from balrog.mythic-beasts.com ([93.93.130.6]:35043 "EHLO
	balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934045AbaLBT7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 14:59:13 -0500
X-Greylist: delayed 1588 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Dec 2014 14:59:13 EST
Received: from [188.80.111.241] (port=55346 helo=localhost)
	by balrog.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XvtBl-0003pi-Eb
	for git@vger.kernel.org; Tue, 02 Dec 2014 19:32:46 +0000
Content-Disposition: inline
In-Reply-To: <20140324213814.GA1267@achilles.my.domain>
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260590>

On Mon, Mar 24, 2014 at 09:38:27PM +0000, Luis Henriques wrote:
> Add --[no-]xmailer that allows a user to disable adding the 'X-Mailer=
:'
> header to the email being sent.
>

Ping

It's been a while since I sent this patch.  Is there any interest in
having this switch in git-send-email?

I honestly don't like disclosing too much information about my system,
in this case which MUA I'm using and its version.

Cheers,
--=20
Lu=EDs

> Signed-off-by: Luis Henriques <henrix@camandro.org>
> ---
>  Documentation/config.txt         |  1 +
>  Documentation/git-send-email.txt |  3 +++
>  git-send-email.perl              | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 73c8973..c33d5a1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2222,6 +2222,7 @@ sendemail.smtpserveroption::
>  sendemail.smtpuser::
>  sendemail.thread::
>  sendemail.validate::
> +sendemail.xmailer::
>  	See linkgit:git-send-email[1] for description.
> =20
>  sendemail.signedoffcc::
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index f0e57a5..fab6264 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -131,6 +131,9 @@ Note that no attempts whatsoever are made to vali=
date the encoding.
>  	Specify encoding of compose message. Default is the value of the
>  	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assum=
ed.
> =20
> +--xmailer::
> +	Prevent adding the "X-Mailer:" header.  Default value is
> +	'sendemail.xmailer'.
> =20
>  Sending
>  ~~~~~~~
> diff --git a/git-send-email.perl b/git-send-email.perl
> index fdb0029..8789124 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -54,6 +54,7 @@ git send-email [options] <file | directory | rev-li=
st options >
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> +    --[no-]xmailer                 * Don't add "X-Mailer:" header.  =
Default on.
>      --[no-]annotate                * Review each patch that will be =
sent in an editor.
>      --compose                      * Open an editor for introduction=
=2E
>      --compose-encoding      <str>  * Encoding to assume for introduc=
tion.
> @@ -174,6 +175,9 @@ my $force =3D 0;
>  my $multiedit;
>  my $editor;
> =20
> +# Usage of X-Mailer email header
> +my $xmailer;
> +
>  sub do_edit {
>  	if (!defined($editor)) {
>  		$editor =3D Git::command_oneline('var', 'GIT_EDITOR');
> @@ -214,7 +218,8 @@ my %config_bool_settings =3D (
>      "signedoffcc" =3D> [\$signed_off_by_cc, undef],      # Deprecate=
d
>      "validate" =3D> [\$validate, 1],
>      "multiedit" =3D> [\$multiedit, undef],
> -    "annotate" =3D> [\$annotate, undef]
> +    "annotate" =3D> [\$annotate, undef],
> +    "xmailer" =3D> [\$xmailer, 1]
>  );
> =20
>  my %config_settings =3D (
> @@ -311,6 +316,7 @@ my $rc =3D GetOptions("h" =3D> \$help,
>  		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
>  		    "compose-encoding=3Ds" =3D> \$compose_encoding,
>  		    "force" =3D> \$force,
> +		    "xmailer!" =3D> \$xmailer,
>  	 );
> =20
>  usage() if $help;
> @@ -1144,8 +1150,10 @@ To: $to${ccline}
>  Subject: $subject
>  Date: $date
>  Message-Id: $message_id
> -X-Mailer: git-send-email $gitversion
>  ";
> +	if ($xmailer) {
> +		$header .=3D "X-Mailer: git-send-email $gitversion\n";
> +	}
>  	if ($reply_to) {
> =20
>  		$header .=3D "In-Reply-To: $reply_to\n";
> --=20
> 1.9.1
