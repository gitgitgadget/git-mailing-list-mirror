From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/6] read-cache: new extension to mark what file is
 watched
Date: Mon, 13 Jan 2014 09:02:22 -0800
Message-ID: <20140113170222.GA18964@google.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389524622-6702-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 18:02:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2kuO-0000nk-Pl
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 18:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbaAMRCi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jan 2014 12:02:38 -0500
Received: from mail-gg0-f176.google.com ([209.85.161.176]:50847 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbaAMRCd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 12:02:33 -0500
Received: by mail-gg0-f176.google.com with SMTP id b1so1740476ggn.7
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mVltItZ7WbRqt6UQylvvQVATg5y8Sp8LSSKbW+XqPUk=;
        b=Nw2SsT5+jKLHzScJRH2bhYWLUQkWZGOrtRdPDIrceNh7LHBFUxf2rgX7LPCBj9ZDtz
         g4e0UWq9pu/pgGrOX/pjAqrZpWQNoNmjthuem4mHgnydVktPn/xYl39WIqELxZQJXDB4
         710zdCxBOFHF6VCKLw4addoSq7NBuRSyrpg7P6GUhqpkhhBxrhoKBG0344XtrExQpxbo
         spJ2S5zbV4Eb6d+lqZxHv+EtDCpc7m/VSGwxPOqPSj44PD36kuKHCPP22gihaD5vZ/OJ
         jwdISaJGaF8wLdxZg9LBUcAxFc8alrbOFLdaHucsF8u+mzIOV+jSZSqT1VzwPwY08r32
         yGmg==
X-Received: by 10.236.141.132 with SMTP id g4mr4148792yhj.93.1389632551944;
        Mon, 13 Jan 2014 09:02:31 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id s21sm28634765yhk.9.2014.01.13.09.02.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 09:02:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389524622-6702-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240362>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> If an entry is "watched", git lets an external program decide if the
> entry is modified or not. It's more like --assume-unchanged, but
> designed to be controlled by machine.
>
> We are running out of on-disk ce_flags, so instead of extending
> on-disk entry format again, "watched" flags are in-core only and
> stored as extension instead.

Makes sense.

Care to add a brief description of the on-disk format for
Documetnation/technical/index-format.txt as well?

[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -168,6 +168,7 @@ struct cache_entry {
> =20
>  /* used to temporarily mark paths matched by pathspecs */
>  #define CE_MATCHED           (1 << 26)
> +#define CE_WATCHED           (1 << 27)

Nit: I'd add a blank line before the definition of CE_WATCHED to make
it clear that the comment doesn't apply to it.

Maybe it belongs with one of the groups before (e.g., UNPACKED +
NEW_SKIP_WORKTREE).  I dunno.

> --- a/read-cache.c
> +++ b/read-cache.c
[...]
> @@ -1289,6 +1290,19 @@ static int verify_hdr(struct cache_header *hdr=
,
>  	return 0;
>  }
> =20
> +static void read_watch_extension(struct index_state *istate, uint8_t=
 *data,
> +				 unsigned long sz)
> +{
> +	int i;
> +	if ((istate->cache_nr + 7) / 8 !=3D sz) {
> +		error("invalid 'WATC' extension");
> +		return;
> +	}
> +	for (i =3D 0; i < istate->cache_nr; i++)
> +		if (data[i / 8] & (1 << (i % 8)))
> +			istate->cache[i]->ce_flags |=3D CE_WATCHED;
> +}

So the WATC section has one bit per index entry, encoding whether that
entry is WATCHED.  Makes sense.

Do I understand correctly that this patch just takes care of the
bookkeeping for the CE_WATCHED bit and the actual semantics will
come in a later patch?

Thanks,
Jonathan
