From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] remote: separate out the remote_find_tracking logic
 into query_refspecs
Date: Sat, 15 Oct 2011 21:45:59 -0700
Message-ID: <7vobxhtugo.fsf@alter.siamese.dyndns.org>
References: <1318655066-29001-1-git-send-email-cmn@elego.de>
 <1318655066-29001-4-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, mathstuf@gmail.com
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Oct 16 06:46:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFIc4-0004f1-Az
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 06:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab1JPEqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 00:46:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab1JPEqE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 00:46:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49F6125FA;
	Sun, 16 Oct 2011 00:46:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vy5rn+Kcsxhq
	Qq6mh6aYCuPohx8=; b=Lo/yT0AWaIVqz9X2opyLly/ceqiYXDtZ1JKTrTlWGWlS
	DPckgAuH4iqxHUCG595OZpsohE01hNZDujp38ia2+GZUhdrSRyHOKIQ7bluNOtHy
	Dx6cD08fXSqA6gIBYWF8t0yn5cTxfLzUedkzQcPaAIEUzEpO3o71LqiVwKiHiQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XJdLdj
	+RCnDmBLP1FM3m80m636CL1DZRCG+GzRxEhKwWvzlmMxu8rcblO37YkPOStEA6Oe
	s9mHVIRoDzZfSNNnpP1LT6089iJ6Xnfb0Tdwb9hm8/ajhGvnY5PvoBQrMdq0tvTV
	XZezAQ6DEKXJW+DbkfuREyzagRX7JG4EcvNpA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1EA25F9;
	Sun, 16 Oct 2011 00:46:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AA3425F8; Sun, 16 Oct 2011
 00:46:00 -0400 (EDT)
In-Reply-To: <1318655066-29001-4-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sat, 15 Oct 2011 07:04:24
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF38C368-F7B1-11E0-9016-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183687>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Move the body of remote_find_tracking to a new function query_refspec=
s
> which does the same (find a refspec that matches and apply the
> transformation) but explicitly wants the list of refspecs.
>
> Make remote_find_tracking and apply_refspecs use query_refspecs.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> ---
>  remote.c |   70 ++++++++++++++++++++++++++++++----------------------=
---------
>  1 files changed, 34 insertions(+), 36 deletions(-)

Looks very sensible, especially knowing what you want to do in the next
patch ;-).

Thanks.

>
> diff --git a/remote.c b/remote.c
> index b8ecfa5..e94c6d2 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -828,59 +828,57 @@ static int match_name_with_pattern(const char *=
key, const char *name,
>  	return ret;
>  }
> =20
> -char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
> -		     const char *name)
> +static int query_refspecs(struct refspec *refs, int ref_count, struc=
t refspec *query)
>  {
>  	int i;
> -	char *ret =3D NULL;
> -	for (i =3D 0; i < nr_refspec; i++) {
> -		struct refspec *refspec =3D refspecs + i;
> -		if (refspec->pattern) {
> -			if (match_name_with_pattern(refspec->src, name,
> -						    refspec->dst, &ret))
> -				return ret;
> -		} else if (!strcmp(refspec->src, name))
> -			return strdup(refspec->dst);
> -	}
> -	return NULL;
> -}
> +	int find_src =3D query->src =3D=3D NULL;
> =20
> -int remote_find_tracking(struct remote *remote, struct refspec *refs=
pec)
> -{
> -	int find_src =3D refspec->src =3D=3D NULL;
> -	char *needle, **result;
> -	int i;
> +	if (find_src && !query->dst)
> +		return error("query_refspecs: need either src or dst");
> =20
> -	if (find_src) {
> -		if (!refspec->dst)
> -			return error("find_tracking: need either src or dst");
> -		needle =3D refspec->dst;
> -		result =3D &refspec->src;
> -	} else {
> -		needle =3D refspec->src;
> -		result =3D &refspec->dst;
> -	}
> +	for (i =3D 0; i < ref_count; i++) {
> +		struct refspec *refspec =3D &refs[i];
> +		const char *key =3D find_src ? refspec->dst : refspec->src;
> +		const char *value =3D find_src ? refspec->src : refspec->dst;
> +		const char *needle =3D find_src ? query->dst : query->src;
> +		char **result =3D find_src ? &query->src : &query->dst;
> =20
> -	for (i =3D 0; i < remote->fetch_refspec_nr; i++) {
> -		struct refspec *fetch =3D &remote->fetch[i];
> -		const char *key =3D find_src ? fetch->dst : fetch->src;
> -		const char *value =3D find_src ? fetch->src : fetch->dst;
> -		if (!fetch->dst)
> +		if (!refspec->dst)
>  			continue;
> -		if (fetch->pattern) {
> +		if (refspec->pattern) {
>  			if (match_name_with_pattern(key, needle, value, result)) {
> -				refspec->force =3D fetch->force;
> +				query->force =3D refspec->force;
>  				return 0;
>  			}
>  		} else if (!strcmp(needle, key)) {
>  			*result =3D xstrdup(value);
> -			refspec->force =3D fetch->force;
> +			query->force =3D refspec->force;
>  			return 0;
>  		}
>  	}
> +
>  	return -1;
>  }
> =20
> +char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
> +		     const char *name)
> +{
> +	struct refspec query;
> +
> +	memset(&query, 0x0, sizeof(struct refspec));
> +	query.src =3D (char *) name;
> +
> +	if (query_refspecs(refspecs, nr_refspec, &query))
> +		return NULL;
> +
> +	return query.dst;
> +}
> +
> +int remote_find_tracking(struct remote *remote, struct refspec *refs=
pec)
> +{
> +	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refs=
pec);
> +}
> +
>  static struct ref *alloc_ref_with_prefix(const char *prefix, size_t =
prefixlen,
>  		const char *name)
>  {
