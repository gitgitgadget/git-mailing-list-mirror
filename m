From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
 non-ascii characters
Date: Wed, 21 May 2008 12:39:44 -0700
Message-ID: <7vve171m67.fsf@gitster.siamese.dyndns.org>
References: <20080328212700.GA9529@coredump.intra.peff.net>
 <20080328212900.GB9656@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 21:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyuBS-0007Z2-MB
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308AbYEUTkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 15:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758960AbYEUTkS
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:40:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758861AbYEUTkQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 15:40:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 97E7C6601;
	Wed, 21 May 2008 15:40:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A60DD65DD; Wed, 21 May 2008 15:40:06 -0400 (EDT)
In-Reply-To: <20080328212900.GB9656@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 28 Mar 2008 17:29:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B8C920F8-276D-11DD-9FE1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82572>

Last night I was going through old mail-logs and found this and another
one that this is a follow-up to, which I think are still needed.  Does
anybody see anything wrong with them?

Jeff King <peff@peff.net> writes:

> We always use 'utf-8' as the encoding, since we currently
> have no way of getting the information from the user.
>
> This also refactors the quoting of recipient names, since
> both processes can share the rfc2047 quoting code.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-send-email.perl   |   19 +++++++++++++++++--
>  t/t9001-send-email.sh |   15 +++++++++++++++
>  2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 7c4f06c..d0f9d4a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -536,6 +536,14 @@ EOT
>  		if (!$in_body && /^MIME-Version:/i) {
>  			$need_8bit_cte =3D 0;
>  		}
> +		if (!$in_body && /^Subject: ?(.*)/i) {
> +			my $subject =3D $1;
> +			$_ =3D "Subject: " .
> +				($subject =3D~ /[^[:ascii:]]/ ?
> +				 quote_rfc2047($subject) :
> +				 $subject) .
> +				"\n";
> +		}
>  		print C2 $_;
>  	}
>  	close(C);
> @@ -626,6 +634,14 @@ sub unquote_rfc2047 {
>  	return wantarray ? ($_, $encoding) : $_;
>  }
> =20
> +sub quote_rfc2047 {
> +	local $_ =3D shift;
> +	my $encoding =3D shift || 'utf-8';
> +	s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord($1))/eg;
> +	s/(.*)/=3D\?$encoding\?q\?$1\?=3D/;
> +	return $_;
> +}
> +
>  # use the simplest quoting being able to handle the recipient
>  sub sanitize_address
>  {
> @@ -643,8 +659,7 @@ sub sanitize_address
> =20
>  	# rfc2047 is needed if a non-ascii char is included
>  	if ($recipient_name =3D~ /[^[:ascii:]]/) {
> -		$recipient_name =3D~ s/([^-a-zA-Z0-9!*+\/])/sprintf("=3D%02X", ord=
($1))/eg;
> -		$recipient_name =3D~ s/(.*)/=3D\?utf-8\?q\?$1\?=3D/;
> +		$recipient_name =3D quote_rfc2047($recipient_name);
>  	}
> =20
>  	# double quotes are needed if specials or CTLs are included
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index e222c49..a4bcd28 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -210,4 +210,19 @@ test_expect_success '--compose respects user mim=
e type' '
>  	! grep "^Content-Type: text/plain; charset=3Dutf-8" msgtxt1
>  '
> =20
> +test_expect_success '--compose adds MIME for utf8 subject' '
> +	clean_fake_sendmail &&
> +	echo y | \
> +	  GIT_EDITOR=3D$(pwd)/fake-editor \
> +	  GIT_SEND_EMAIL_NOTTY=3D1 \
> +	  git send-email \
> +	  --compose --subject utf8-s=C3=BCbj=C3=ABct \
> +	  --from=3D"Example <nobody@example.com>" \
> +	  --to=3Dnobody@example.com \
> +	  --smtp-server=3D"$(pwd)/fake.sendmail" \
> +	  $patches &&
> +	grep "^fake edit" msgtxt1 &&
> +	grep "^Subject: =3D?utf-8?q?utf8-s=3DC3=3DBCbj=3DC3=3DABct?=3D" msg=
txt1
> +'
> +
>  test_done
> --=20
> 1.5.5.rc1.141.g50ecd.dirty
