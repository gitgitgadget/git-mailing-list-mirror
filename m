From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Limit refs to fetch to minimum in shallow clones
Date: Thu, 05 Jan 2012 13:25:37 -0800
Message-ID: <7vmxa1n8oe.fsf@alter.siamese.dyndns.org>
References: <1325676922-6995-1-git-send-email-pclouds@gmail.com>
 <1325743516-14940-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 22:25:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Riuok-00088j-QB
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 22:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828Ab2AEVZm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 16:25:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932707Ab2AEVZl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 16:25:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 123C2624B;
	Thu,  5 Jan 2012 16:25:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BiPaL0rqe1Og
	rUy7jxN/bSPTcgQ=; b=c7d3mx1tSrHvazQKE8TtzCqPwiwyMegKznOWv86iYzwL
	MwI5iFd0piDqnrDeR/78x/thpryxnFnVrodf/oC3nXj2gDbgCiv0txKmTQESr/LQ
	5HMCafy5BlO2GXnXAn02xg9P1t9QOSejMAmY2Zh+zRic+8wvEgkiVdiBpwD9CN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DEm32X
	BwfTC2xPMKjz0vBogAeQ5mVXoNiKgF6SqCiPmBJtgkGF2IQ4S7wm4Fv/V950rMWT
	tgr2jmS9ar9zWZsek3HZrbdtvO+HYgX/lUgg43WP1Y22+9oNEAKWWEZYhpY/+oeR
	vKmKQn9rTu3uVajZkIVBqREnvky24vI7s6Pks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 081A96249;
	Thu,  5 Jan 2012 16:25:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80EEC6247; Thu,  5 Jan 2012
 16:25:39 -0500 (EST)
In-Reply-To: <1325743516-14940-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 5 Jan
 2012 13:05:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0A4C03A-37E3-11E1-B488-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187995>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The main purpose of shallow clones is to reduce download by only
> fetching objects up to a certain depth from the given refs. The numbe=
r
> of objects depends on how many refs to follow. So:
>
>  - Only fetch HEAD or the ref specified by --branch
>  - Only fetch tags that point to downloaded objects
>
> More tags/branches can be fetched later using git-fetch as usual.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Only lightly tested, but seems to work.

Thanks.

Perhaps you would want to add tests so that you do not have to say
"lightly tested"?

> diff --git a/builtin/clone.c b/builtin/clone.c
> index efe8b6c..8de9248 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -48,6 +48,7 @@ static int option_verbosity;
>  static int option_progress;
>  static struct string_list option_config;
>  static struct string_list option_reference;
> +static char *src_ref_prefix =3D "refs/heads/";

Would this be const?

>  static int opt_parse_reference(const struct option *opt, const char =
*arg, int unset)
>  {
> @@ -427,9 +428,27 @@ static struct ref *wanted_peer_refs(const struct=
 ref *refs,
>  	struct ref *local_refs =3D head;
>  	struct ref **tail =3D head ? &head->next : &local_refs;
> =20
> -	get_fetch_map(refs, refspec, &tail, 0);
> -	if (!option_mirror)
> -		get_fetch_map(refs, tag_refspec, &tail, 0);
> +	if (option_depth) {
> +		struct ref *remote_head =3D NULL;
> +
> +		if (!option_branch)
> +			remote_head =3D guess_remote_head(head, refs, 0);
> +		else {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			strbuf_addstr(&sb, src_ref_prefix);
> +			strbuf_addstr(&sb, option_branch);
> +			remote_head =3D find_ref_by_name(refs, sb.buf);
> +			strbuf_release(&sb);
> +		}
> +
> +		if (remote_head)
> +			get_fetch_map(remote_head, refspec, &tail, 0);

What happens when we fail to find any remote_head and make no call to
get_fetch_map() here?  I am wondering if that should trigger an error
here.

Also this breaks 5500 for rather obvious reasons, as the point of this
patch is to reduce the object transferred when a shallow clone is made.

Perhaps there should be an option to give users the historical "all
branches equally shallow" behaviour?
