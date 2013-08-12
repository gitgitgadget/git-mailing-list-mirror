From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: respect --no-thin
Date: Sun, 11 Aug 2013 22:59:59 -0700
Message-ID: <7vhaev1mao.fsf@alter.siamese.dyndns.org>
References: <1376184258-6784-1-git-send-email-pclouds@gmail.com>
	<1376211178-17444-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Martin Fick <mfick@codeaurora.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 08:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lAn-0006iQ-Db
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab3HLGAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 02:00:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755754Ab3HLGAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 02:00:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21F983451F;
	Mon, 12 Aug 2013 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=D8sJvjOyMz9l
	4bK6TC0gvX0qmik=; b=BKABIF5uLUVYWWWdsu9BmTO9DXo6FHUDN2uv5+sHI3f6
	6nMhjDVO+Vo2uvKEJkngN7cazLaEsE7ySZDNXsazOAc5VsPkfqeonercNPSGaisw
	+TMDoa38hGAEsu651TWRkPbdDo6TaJWBBv4kBZCvMcGS+8Cicf4qAvxrbOowSgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ohmkdT
	X6AeWHPVMCyP9IIvW+5V4e8qYwZW7COuYEp885T8XQdF6MAHWT20K9eWPIPsHXUo
	EzHBxSSB8dRJf7WuXq+7y0M7VfYe5+1mmAMt45F6d4xY36pHXYOJeV3ihGtkFuuP
	K3ELsCMJwKt5MIbre8uu9BaAnmylnbefoX95A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1146E3451D;
	Mon, 12 Aug 2013 06:00:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E97E34513;
	Mon, 12 Aug 2013 06:00:00 +0000 (UTC)
In-Reply-To: <1376211178-17444-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 11
 Aug 2013 15:52:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CCC79F6-0314-11E3-8971-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232154>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Over the time the default value for --thin has been switched between
> on and off. As of now it's always on, even if --no-thin is given.
> Correct the code to respect --no-thin.
>
> receive-pack learns about --no-thin only for testing purposes, hence
> no document update.

Please name it "--reject-thin-pack-for-testing" to make it crystal
clear that a documentation patch to "document undocumented option"
is unwanted.

> diff --git a/builtin/push.c b/builtin/push.c
> index 04f0eaf..333a1fb 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -15,7 +15,7 @@ static const char * const push_usage[] =3D {
>  	NULL,
>  };
> =20
> -static int thin;
> +static int thin =3D 1;
>  static int deleterefs;
>  static const char *receivepack;
>  static int verbosity;
> @@ -313,8 +313,7 @@ static int push_with_options(struct transport *tr=
ansport, int flags)
>  	if (receivepack)
>  		transport_set_option(transport,
>  				     TRANS_OPT_RECEIVEPACK, receivepack);
> -	if (thin)
> -		transport_set_option(transport, TRANS_OPT_THIN, "yes");
> +	transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL=
);
> =20
>  	if (verbosity > 0)
>  		fprintf(stderr, _("Pushing to %s\n"), transport->url);

Hmm, I am utterly confused.

How does the original code have thin as an non-overridable default?
The variable is initialized to 0, parse-options specifies it as
OPT_BOOLEAN, and TRANS_OPT_THIN is set only if "thin" is set.

Updated code flips the default to "1" but unconditionally uses
TRANS_OPT_THIN to set it to either "yes" or NULL.  While it is not
wrong per-se, do_push() (i.e. the caller of this function) grabs the
transport from transport_get() which initializes the transport with
the thin option disabled by default, so it is not immediately
obvious to me why "always call TRANS_OPT_THIN but set it explicitly
to NULL when --no-thin is asked" is necessary or improvement.

Puzzled....
