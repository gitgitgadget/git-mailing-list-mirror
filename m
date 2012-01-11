From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/10] clone: delay cloning until after remote HEAD
 checking
Date: Wed, 11 Jan 2012 11:36:44 -0800
Message-ID: <7v8vle6ng3.fsf@alter.siamese.dyndns.org>
References: <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326189427-20800-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:36:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl3yg-00067A-MK
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 20:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757350Ab2AKTgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 14:36:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898Ab2AKTgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 14:36:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD82C6CA1;
	Wed, 11 Jan 2012 14:36:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zsk4rEh/Zpqs
	8jo1oLS95QwsJyo=; b=HvHugbjNf/ULZVYLWXNcTjN5DnjV6b7zb/WyR0hpbRSn
	xUCHiFgpEBMAJheSwOmMpC38wAIsKW/15J6AzvqbChREfucouJQyg6pWswPU19i6
	EZeOAx4q9+aePOVjYkad4xCWreZC76kXz3iBht17eYzJIVHQ9x6aAcchRsClOzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YI0d24
	xSwpswgrESQrH9w1cDqrIte2C9mg0OxBp9BJdtVpmpeK71kC5dh9M17k5WGtnrnd
	TOBVc8cXnlW5hjEEeiKXIiK/ciWdZtdBURbkPKAvcyJBxsdrlhPAR4mbpwXljQ5Y
	O6NBdAnAWbCh7eVhjW6oMoKNIUCdqYhZUASKE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B546F6CA0;
	Wed, 11 Jan 2012 14:36:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CFB76C9F; Wed, 11 Jan 2012
 14:36:45 -0500 (EST)
In-Reply-To: <1326189427-20800-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 10 Jan
 2012 16:57:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98DE1AC8-3C8B-11E1-86D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188384>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This gives us an opportunity to abort the command during remote HEAD
> check without wasting much bandwidth.
>
> Cloning with remote-helper remains before the check because the remot=
e
> helper updates mapped_refs, which is necessary for remote ref checks.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I'm not familiar with remote-helper to see if there's any better way
>  to do this..
> ...
> +	refs =3D transport_get_remote_refs(transport);
> +	mapped_refs =3D refs ? wanted_peer_refs(refs, refspec) : NULL;
> +
> +	/*
> +	 * mapped_refs may be updated if transport-helper is used so
> +	 * we need fetch it early because remote_head code below
> +	 * relies on it.
> +	 *
> +	 * for normal clones, transport_get_remote_refs() should
> +	 * return reliable ref set, we can delay cloning until after
> +	 * remote HEAD check.
> +	 */
> +	if (!is_local && remote->foreign_vcs && refs)
> +		transport_fetch_refs(transport, mapped_refs);
> +

I like the goal of this change, but wouldn't remote->url indicate it is=
 a
remote that needs a helper invocation by having double-colon in it,
without having an explicit value in foreign_vcs field?

Would it be cleaner if transport_get() learned to mark the transport as
needing special treatment (i.e. we won't know the final ref mapping unt=
il
we fetch the data from the other side) and check is made on that mark l=
eft
in the transport, instead of foreign_vcs in remote?

> diff --git a/transport.c b/transport.c
> index a99b7c9..aae9889 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -895,8 +895,10 @@ struct transport *transport_get(struct remote *r=
emote, const char *url)
> =20
>  		while (is_urlschemechar(p =3D=3D url, *p))
>  			p++;
> -		if (!prefixcmp(p, "::"))
> +		if (!prefixcmp(p, "::")) {
>  			helper =3D xstrndup(url, p - url);
> +			remote->foreign_vcs =3D helper;
> +		}
>  	}
> =20
>  	if (helper) {

Ahhh, Ok. You are reusing the existing "foreign_vcs" field exactly for
that purpose. Earlier the field was strictly for configured .vcs value,
but now you use it also for the helper embedded within the URL, which
sounds like the right change to me.

> @@ -938,6 +940,7 @@ struct transport *transport_get(struct remote *re=
mote, const char *url)
>  		char *handler =3D xmalloc(len + 1);
>  		handler[len] =3D 0;
>  		strncpy(handler, url, len);
> +		remote->foreign_vcs =3D helper;
>  		transport_helper_init(ret, handler);
>  	}

This I am not sure. What value does "helper" variable have at this poin=
t
in the flow? Wouldn't it be a NULL? Or did you mean "handler"?
