From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Sat, 26 Nov 2011 14:48:12 -0800
Message-ID: <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Nov 26 23:48:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUR2q-0006qu-1G
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 23:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab1KZWsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 17:48:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab1KZWsP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 17:48:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27638551D;
	Sat, 26 Nov 2011 17:48:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Nztxo17n+bPp
	rT077d0t7KPoChY=; b=QsKZZ5MzBWrXAJiCqHo0C36mxKOiHNNxPGB8qIqnFzgA
	ElpjKS8FE5kIdw0DbqWYffIQvKLR9F1u7iSM68wtFKs+EVqzeyb597+Lpa1pL3Zf
	0WiUb7HNkTbOeBUxPDp7qjJjuxzrxM+qXR4RsK5VOriC99fPAuANi3B3WV7ITyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RsekTi
	y0mRJQw+aaawl8IMEVXm6lcPDJYfy94w+ZEWK87DfQu9WK6se9hw3MW/AOQqn8cn
	BeJo9GAOAiwKB3XRaZoqf5S1h9WHLFHd1R/l2t8NHXha60WTS65oEzN8HI9zDRgy
	hyNI0+rEytfhPSsDRZboyz1108kD84pEKnkZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E9D3551C;
	Sat, 26 Nov 2011 17:48:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78FC6551B; Sat, 26 Nov 2011
 17:48:14 -0500 (EST)
In-Reply-To: <20111125170219.GD10417@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 25 Nov 2011 18:02:19
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B982D504-1880-11E1-BE2C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185957>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> diff --git a/convert.c b/convert.c
> index 86e9c29..c050b86 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -880,20 +880,29 @@ static int lf_to_crlf_filter_fn(struct stream_f=
ilter *filter,
>  				const char *input, size_t *isize_p,
>  				char *output, size_t *osize_p)
>  {
> -	size_t count;
> +	size_t count, o =3D 0;
> +	static int want_lf =3D 0;

I do not think we want function scope static state anywhere in the casc=
ade
filter chain, as it will forbid us from running more than one output ch=
ain
at the same time in the future. I think the correct way to structure it
would be to create lf_to_crlf_filter as a proper subclass of stream_fil=
ter
(see how cascade_filter_fn() casts its filter argument down to an insta=
nce
of the cascade_filter class and uses it to keep track of its state) and
keep this variable as its own filter state [*1*].

[Footnote]

*1* We currently use a singleton instance of lf_to_crlf_filter object
because the implementation assumed there is no need for per-instance
state.
