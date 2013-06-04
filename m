From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] core: use env variable instead of config var to turn on logging pack access
Date: Mon, 03 Jun 2013 23:26:28 -0700
Message-ID: <7vzjv68k8b.fsf@alter.siamese.dyndns.org>
References: <7vmwr7c59b.fsf@alter.siamese.dyndns.org>
	<1370299959-5573-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 08:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjkhY-0004hh-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 08:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219Ab3FDG0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jun 2013 02:26:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59130 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab3FDG0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jun 2013 02:26:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC1DE20D7B;
	Tue,  4 Jun 2013 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bzbKUqqpWIdp
	fWAQRahv6pftzB0=; b=pGgugRs43mr52tnglRmU1xzEgdwbzKXCAjv2TafB/etC
	/0sgEqm3KQQIR/9RfSsAf+qLlTxpyeMnZD43Z40n/LxDG3dSESJpdsKmcU2dpM7v
	bfT7HOjzNmpmBjXOB9/FoaS00hRmoESgCaonHOqB6+QgmeLZ/GA7cWQXPntmfsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mfB2xz
	4bVQmZWaL7fDd1SC4NboEkmaaD8wGY9ajXvbRmlgoNOg7lpiWSYaezs653mrJmwW
	VpxAvy7Z9WblnmddFctlU3TgrlXKHR87kAC2wMqcIrR6L6r8GBTa6OYIOIVNyg3U
	vNLHE2pmJ7MrqtLv3Jee/TwKx87NWRG2s/Nng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E174D20D7A;
	Tue,  4 Jun 2013 06:26:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C37C20D6F;
	Tue,  4 Jun 2013 06:26:30 +0000 (UTC)
In-Reply-To: <1370299959-5573-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Jun
 2013 05:52:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B18E561A-CCDF-11E2-A531-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226319>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  > Have you ever tested this?
>  >
>  > Once log_pack_access goes to NULL (e.g. when it sees the empty
>  > string it was initialized to), this new test will happily
>  > dereference NULL.
>
>  My bad. I did test when GIT_TRACE_PACK_ACCESS was set, not when it
>  was set to an empty string. All cases tested now.
>
> @@ -1956,6 +1958,14 @@ static void write_pack_access_log(struct packe=
d_git *p, off_t obj_offset)
>  {
>  	static FILE *log_file;
> =20
> +	if (!*log_pack_access) {

The first time, we will see the static empty string and come into
this block...

> +		log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
> +		if (log_pack_access && !*log_pack_access)
> +			log_pack_access =3D NULL;
> +		if (!log_pack_access)
> +			return;
> +	}

This may=20

 (1) not find the env-var, in which case log_pack_access becomes
     NULL here, and the function returns.

 (2) find the env-var to be an empty string, in which case
     log_pack_access becomes NULL in the next statement, and the
     function returns.

 (3) find the env-var to be a non-empty string, and the function
     does not return.

And the next time around, (3) above may work fine; the first if()
will fail and we do not come in.  But in either (1) or (2), don't
you keep checking the environment every time you come here?

Oh, no, it is worse than that.  Either case you set the variable to
NULL, so the very first "if (!*log_pack_access)" would dereference
NULL.

Why not start from NULL:

    static const char *log_pack_access;

treat that NULL as "unknown" state, and avoid running getenv over
and over again by treating non-NULL value as "known"?  Perhaps like
this?

	if (!log_pack_access) {
        	/* First time: is env set? */
                log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
                if (!log_pack_access)
                	log_pack_access =3D "";
	}
        /* Now GIT_TRACE_PACK_ACCESS is known */
        if (!*log_pack_access)
        	return; /* not wanted */

As you can no longer rely on "config is read before we do anything
else" by switching to lazy env checking, your guard at the caller
needs to be updated, if you want to reduce unneeded call-return
overhead:

	if (!log_pack_access || *log_pack_access)
		write_pack_access_log(...);

But the guard is purely for performance, not correctness, because
the function now does the "return no-op if we know we are not
wanted" itself.

Also you no longer need to have an extern variable in environment.c
