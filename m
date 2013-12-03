From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] gitweb: Move check-ref-format code into separate function
Date: Tue, 03 Dec 2013 11:02:11 -0800
Message-ID: <xmqqd2ldoj0s.fsf@gitster.dls.corp.google.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	<1386082603-8404-2-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:02:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvEh-00039G-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab3LCTCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 14:02:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753757Ab3LCTCO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 14:02:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01C32551CE;
	Tue,  3 Dec 2013 14:02:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t6/m5WZ8ci/I
	k2ajik5XPHSfgl0=; b=ZepVoYeDeu0cy0fE5cwaDZjMk61nVjPvnMoyCc8CzdV/
	+re2GB5QiMJmx0eWpE0rl/gYltDMD9uWcTxS3c6uZMBjTYxlA7JRLo/TGqC0Yns9
	7URe5t9ovxsW2YBYHbbT0rRXte3uONXIuqQVdVSKcK6tl6fNQMUj38fGHWzTH9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TE8ScL
	yiNntb8doftzfqEqWpkU0e0PYjGBQQIyQ5n1YBckPNZFFmueZDoaJTTi06IHShEJ
	7GRdoYpP8WeyPxe7/KVgND+gm1ygzQoZlHfhfe39XKyo18bWxg/oRuBA7mNL1mJl
	/Bil82b96CbeawWNLTzdWbhfR9mvtyG5H33IY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FEC551CD;
	Tue,  3 Dec 2013 14:02:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2389C551C8;
	Tue,  3 Dec 2013 14:02:13 -0500 (EST)
In-Reply-To: <1386082603-8404-2-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Tue, 3 Dec 2013 15:56:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6B2C2FAA-5C4D-11E3-9893-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238716>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> This check will be used in more than one place later.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  gitweb/gitweb.perl | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..f7730d7 100755
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

So far, so good.

> +	# check git-check-ref-format restrictions
> +	$input =3D check_ref_format($input)
> +		or return undef;
>  	return $input;

Hmmm.  Why do you need "<LF><INDENT>or return under" here?  It would
not hurt too much per-se (strictly speaking, if the $input were a
string "0", this will return undef instead of "0", which should be
an OK name as far as the regexp is concerned), but it seems to be
making the logic unnecessarily complex for no real gain.

>  }
