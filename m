From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] gitweb: Move check-ref-format code into separate function
Date: Wed, 04 Dec 2013 12:31:49 -0800
Message-ID: <xmqqsiu8jr2i.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-3-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 21:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoJ7H-0006oW-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192Ab3LDUcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 15:32:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab3LDUcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 15:32:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4CC57090;
	Wed,  4 Dec 2013 15:32:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Dbk8MPcyzV8d
	cMFRjjCERNugc/s=; b=yHXFHtEM6D6QDP46H1Jj+aUlPRjoGe3noGvZlKOqU1Xw
	pSdRbAdiGishR3UwL31p1xfmWZmgcuIXefiv1gCWS1phxg8eYY6XfELPGkkIlVsY
	PdyKj+L/LFWZQX4ZMisGkSCJjM1q6EPmwpWpcZ9KbTdAaARMB7DbNLDHV7oHDkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pgwAdm
	/v2FR+ceyid42LuHD2YJNFRrdwjs5QpQ4LkT+NWaDDSL2CWRMrYGCObEpowIfJAg
	G7rdyp5PzdDzCxdyUKrWs91vqaA53lyCJMYTN4+h8aXjKsrt1eerTuOxFTy9l5G9
	dU6wqDxK5bjnVUah1uJ2dYVWBIJgIVja7DT9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC30E5708E;
	Wed,  4 Dec 2013 15:31:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 710A75708A;
	Wed,  4 Dec 2013 15:31:51 -0500 (EST)
In-Reply-To: <1386164583-14109-3-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Wed, 4 Dec 2013 14:43:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1BEAB5C0-5D23-11E3-9CA2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238811>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> This check will be used in more than one place later.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

Again, I do not think I reviewed this exact version. Nor did I say
that use of the "... or return undef" is a good idea.

> Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index ee61f9e..67415b9 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1452,6 +1452,16 @@ sub validate_pathname {
>  	return $input;
>  }
> =20
> +sub check_ref_format {
> +	my $input =3D shift || return undef;
> +
> +	# restrictions on ref name according to git-check-ref-format
> +	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> +		return undef;
> +	}
> +	return $input;
> +}
> +
>  sub validate_refname {
>  	my $input =3D shift || return undef;
> =20
> @@ -1462,10 +1472,9 @@ sub validate_refname {
>  	# it must be correct pathname
>  	$input =3D validate_pathname($input)
>  		or return undef;
> -	# restrictions on ref name according to git-check-ref-format
> -	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
> -		return undef;
> -	}
> +	# check git-check-ref-format restrictions
> +	check_ref_format($input)
> +		or return undef;
>  	return $input;
>  }
