From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] help.c: make term_columns() cached and export it
Date: Thu, 09 Feb 2012 16:50:52 -0800
Message-ID: <7vehu3tssz.fsf@alter.siamese.dyndns.org>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
 <1328831921-27272-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:51:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvehY-0001Gw-Cs
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758691Ab2BJAu4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:50:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab2BJAuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 19:50:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C886562E1;
	Thu,  9 Feb 2012 19:50:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CPLtfF2QtTRx
	93O4VS47OQMuMsk=; b=pULBlDaXaC77b0noy3RtEsZriRooe5VbTQJfNrYd7Cig
	fQiLr//yWCaEGk/9I154wCML9tocSmXOAzhCSeblG/ZNXSSaCch5j6wpbyOgEFqT
	TS/+HvBcrMkFVPlcixsD8UJLhy7t2B1qQCvG3T3DOtX9JK/W5xravrIIr99gUN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ewMCkJ
	Ep3QHxFyd1wcqHEnmBQsRlw6YkEhUS21Ndfgwccp3eJ/zyN+SFY1JRpaB3E4VHwC
	3gOLUQtI23wtHZehNXiMfmZcn7lv6TukKfnVA+V7h/PepPxO5kzxcXRav00ewW0I
	KKKTbXPQpqdo+VtlYfIEQ7FGMAqxyax3+zY/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BED2462E0;
	Thu,  9 Feb 2012 19:50:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E11562DF; Thu,  9 Feb 2012
 19:50:54 -0500 (EST)
In-Reply-To: <1328831921-27272-3-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 10 Feb 2012
 00:58:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 494A3822-5381-11E1-8AA6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190356>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> diff --git a/help.c b/help.c
> index bc15066..75b8d4b 100644
> --- a/help.c
> +++ b/help.c
> @@ -5,26 +5,41 @@
>  #include "help.h"
>  #include "common-cmds.h"
> =20
> -/* most GUI terminals set COLUMNS (although some don't export it) */
> -static int term_columns(void)
> +/* cache for term_columns() value. Set on first use or when
> + * installing a pager and replacing stdout.
> + */

Just a style.

	/*
         * We format multi-line
         * comment block like
         * this.
         */

> +static int term_columns_cache;
> +
> +/* Return cached value (iff set) or $COLUMNS (iff set and positive) =
or
> + * ioctl(1, TIOCGWINSZ).ws_col (if positive) or 80.
> + *
> + * $COLUMNS even if set, is usually not exported, so
> + * the variable can be used to override autodection.
> + */
> +int term_columns(void)
>  {
> -	char *col_string =3D getenv("COLUMNS");
> -	int n_cols;
> +	if (term_columns_cache)
> +		return term_columns_cache;
> =20
> -	if (col_string && (n_cols =3D atoi(col_string)) > 0)
> -		return n_cols;
> +	{
> +		char *col_string =3D getenv("COLUMNS");
> +		int n_cols;
> +
> +		if (col_string && (n_cols =3D atoi(col_string)) > 0)
> +			return (term_columns_cache =3D n_cols);
> +	}

I can see the justification for the existing one inside the #ifdef belo=
w,
but why do you need the extra scope above?

We tend to avoid assignment as a part of another expression.  The old c=
ode
already violates that convention, but please do not make it worse by
introducing three new ones.
