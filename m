From: Luis Henriques <henrix@camandro.org>
Subject: Re: [RFC][PATCH] send-email: add --[no-]xmailer option
Date: Wed, 3 Dec 2014 18:02:48 +0000
Message-ID: <20141203180248.GA3362@charon.olymp>
References: <20140324213814.GA1267@achilles.my.domain>
 <xmqqfvcwk6en.fsf@gitster.dls.corp.google.com>
 <xmqq388wk5q8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:03:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwEGR-0004v9-8n
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaLCSCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2014 13:02:55 -0500
Received: from balrog.mythic-beasts.com ([93.93.130.6]:58731 "EHLO
	balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaLCSCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:02:53 -0500
Received: from [2.81.129.121] (port=50645 helo=localhost)
	by balrog.mythic-beasts.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henrix@camandro.org>)
	id 1XwEGI-0004jQ-Ns; Wed, 03 Dec 2014 18:02:52 +0000
Content-Disposition: inline
In-Reply-To: <xmqq388wk5q8.fsf@gitster.dls.corp.google.com>
X-BlackCat-Spam-Score: -28
X-Mythic-Debug: Threshold =  On = 
X-Spam-Status: No, score=-2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260672>

On Wed, Dec 03, 2014 at 09:23:11AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Two problems here.
> > ...
> > tests?
>=20
> Something like this squashed into the patch you posted earlier,
> perhaps, would be a good place to start.
>

Awesome, thank you for your review.  I'll post a new version of the
patch including your suggestions.  Regarding the tests, I'll need a
bit more time to work on those.

Cheers,
--=20
Lu=EDs


>  Documentation/git-send-email.txt |  6 ++++--
>  git-send-email.perl              | 11 +++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index f2425ef..a0bd806 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -132,8 +132,10 @@ Note that no attempts whatsoever are made to val=
idate the encoding.
>  	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assum=
ed.
> =20
>  --xmailer::
> -	Prevent adding the "X-Mailer:" header.  Default value is
> -	'sendemail.xmailer'.
> +--no-xmailer::
> +	Add (or prevent adding) the "X-Mailer:" header.  By default,
> +	the header is added, but it can be turned off by setting the
> +	`sendemail.xmailer` configuration variable to `false`.
> =20
>  Sending
>  ~~~~~~~
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9ca7c5b..a6e66b9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -54,7 +54,7 @@ sub usage {
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> -    --[no-]xmailer                 * Don't add "X-Mailer:" header.  =
Default on.
> +    --[no-]xmailer                 * Add "X-Mailer:" header (default=
).
>      --[no-]annotate                * Review each patch that will be =
sent in an editor.
>      --compose                      * Open an editor for introduction=
=2E
>      --compose-encoding      <str>  * Encoding to assume for introduc=
tion.
> @@ -177,8 +177,7 @@ sub format_2822_time {
>  my $multiedit;
>  my $editor;
> =20
> -# Usage of X-Mailer email header
> -my $xmailer;
> +my $use_xmailer;
> =20
>  sub do_edit {
>  	if (!defined($editor)) {
> @@ -224,7 +223,7 @@ sub do_edit {
>      "validate" =3D> [\$validate, 1],
>      "multiedit" =3D> [\$multiedit, undef],
>      "annotate" =3D> [\$annotate, undef],
> -    "xmailer" =3D> [\$xmailer, 1]
> +    "xmailer" =3D> [\$use_xmailer, 1]
>  );
> =20
>  my %config_settings =3D (
> @@ -323,7 +322,7 @@ sub signal_handler {
>  		    "8bit-encoding=3Ds" =3D> \$auto_8bit_encoding,
>  		    "compose-encoding=3Ds" =3D> \$compose_encoding,
>  		    "force" =3D> \$force,
> -		    "xmailer!" =3D> \$xmailer,
> +		    "xmailer!" =3D> \$use_xmailer,
>  	 );
> =20
>  usage() if $help;
> @@ -1170,7 +1169,7 @@ sub send_message {
>  Date: $date
>  Message-Id: $message_id
>  ";
> -	if ($xmailer) {
> +	if ($use_xmailer) {
>  		$header .=3D "X-Mailer: git-send-email $gitversion\n";
>  	}
>  	if ($reply_to) {
> --=20
> 2.2.0-141-gd3f4719
>=20
