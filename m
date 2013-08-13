From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: plug a memory leak
Date: Tue, 13 Aug 2013 14:12:44 -0700
Message-ID: <7va9klwb03.fsf@alter.siamese.dyndns.org>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
	<CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com>
	<CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com>
	<CAMP44s1CAMPWXDSAc7WHahmrKRrB8aG_H9fnXAMi2LFOGy5EdA@mail.gmail.com>
	<520A7AAE.6010309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	=?iso-2022-jp?B?GyRCJy0nVidYJ1EnXydcJ1onXxsoQiAbJEInKidTJ1EnXxsoQg==?= 
	<abyss.7@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 13 23:13:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Lth-0004ri-CT
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 23:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249Ab3HMVMv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Aug 2013 17:12:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61468 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab3HMVMt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Aug 2013 17:12:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09689386D9;
	Tue, 13 Aug 2013 21:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zEYFrUR9KO9I
	Z6Ufj2UGfNZXr3w=; b=pr2h9Q+D1dSsJUEEMi4vPIL7W8E+a3J4GE3NfcEna2dA
	4cPtvF61gSiB935efOBhqBAhZOqRbKNJe/ik6fmXQYhx9+AltwLtlqSPB5ucTSgJ
	HTJuysv6PpTkMU/WFerVBW2eGzAyrmHrQjWdeP9ipt7UPCi2uv0oISLbm9Uht3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Gky6h8
	4Vg9Ys0iQpEQbPzouBppNtUo8dmMYLCNP/mpGvJ4FTmCpm/HJc1v4258rWKfUTDX
	b8I+nWXq6No7w68fntsogEkO+A+huuBSr38EhoH9DZcyFFrLp96R3LLcfVIf5cHf
	ZZnUWEKCm5TbWUwP61UZ+bbICSZ42DxYbYlkI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEFB1386D5;
	Tue, 13 Aug 2013 21:12:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55204386D3;
	Tue, 13 Aug 2013 21:12:46 +0000 (UTC)
In-Reply-To: <520A7AAE.6010309@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 13
	Aug 2013 20:27:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19E958A4-045D-11E3-9563-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232249>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> Before overwriting the destination index, first let's discard its
> contents.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Tested-by: =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=
=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
> ---
> Felipe sent this patch as part of multiple series in June, but it can
> stand on its own.  This version is trivially rebased against master.
> The leak seems to have been introduced by 34110cd4 (2008-03-06,
> "Make 'unpack_trees()' have a separate source and destination index")=
=2E

It was lost in the follow-up discussion and I missed it.

I assume that this is signed-off by you as a forwarder?  I'd prefer
to even mark it Reviewed-by: you.

Thanks.

>  unpack-trees.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index bf01717..1a61e6f 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1154,8 +1154,10 @@ int unpack_trees(unsigned len, struct tree_des=
c *t, struct unpack_trees_options
> =20
>  	o->src_index =3D NULL;
>  	ret =3D check_updates(o) ? (-2) : 0;
> -	if (o->dst_index)
> +	if (o->dst_index) {
> +		discard_index(o->dst_index);
>  		*o->dst_index =3D o->result;
> +	}
> =20
>  done:
>  	clear_exclude_list(&el);
