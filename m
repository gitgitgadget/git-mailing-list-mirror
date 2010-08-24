From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/32] index: make narrow index incompatible with older
 git
Date: Tue, 24 Aug 2010 18:43:01 -0500
Message-ID: <20100824234301.GG2376@burratino>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
 <1282688422-7738-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 01:46:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo3Bk-0002MM-Qm
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 01:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab0HXXoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 19:44:54 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49187 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754302Ab0HXXot convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 19:44:49 -0400
Received: by qyk9 with SMTP id 9so4291923qyk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IZDHQ60FlTvWSWS/0qc77boJ+12YmiQaafAj766ozFM=;
        b=sheGE5sT7yavdD3PePTKjzPogpLjdConZsxkz7I6EGuGhfJgBBfCTfi4imBHrZ4ha+
         s072Gdx5dmjnYxm/1sdCTfNval0CEq1jrpyBClIpvem2eTBReGB/Ugl1I7XMskriEQpy
         E5rOx+0nIV/6CdCMJxMdRp3OdoU9ogDPh50wI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=daNMA/CDgudVHwbxew+dk51djjqOzeGPgi2lGFd5QIRghlwHHssu3h0ed3XT/BRIWg
         QTSrzcWSAk7EfSzDA7Wl3/dpbb4rXsbXycngVPtaF2ikzDxEBLSp73g4kF8YHdTxEC3D
         GE3ZY6RKh0nc02FNYC6AwYeB/EWkSXASLEzgk=
Received: by 10.229.237.130 with SMTP id ko2mr5403346qcb.121.1282693488775;
        Tue, 24 Aug 2010 16:44:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r36sm768520qcs.3.2010.08.24.16.44.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 16:44:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282688422-7738-10-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154384>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Index in narrow repos is not a full index and should not be used
> to create commits without modification (to be explained later on).
[...]
> +++ b/read-cache.c
> @@ -25,8 +25,9 @@ static struct cache_entry *refresh_cache_entry(stru=
ct cache_entry *ce, int reall
>   */
> =20
>  #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
> -#define CACHE_EXT_TREE 0x54524545	/* "TREE" */
> +#define CACHE_EXT_TREE 0x54524545	  /* "TREE" */
>  #define CACHE_EXT_RESOLVE_UNDO 0x52455543 /* "REUC" */
> +#define CACHE_EXT_NARROW 0x4e415257	  /* "NARW" */

Just curious: why aren't we using

 #define CACHE_EXT_TREE CACHE_EXT("TREE")
 #define CACHE_EXT_RESOLVE_UNDO CACHE_EXT("REUC")
 #define CACHE_EXT_NARROW CACHE_EXT("NARW")

Are they invalid case labels?

I think non-optional extensions might need to be lowercase ("narw")
though I am not sure.

> @@ -1168,7 +1169,9 @@ static int verify_hdr(struct cache_header *hdr,=
 unsigned long size)
> =20
>  	if (hdr->hdr_signature !=3D htonl(CACHE_SIGNATURE))
>  		return error("bad signature");
> -	if (hdr->hdr_version !=3D htonl(2) && hdr->hdr_version !=3D htonl(3=
))
> +	if (hdr->hdr_version !=3D htonl(2) &&
> +	    hdr->hdr_version !=3D htonl(3) &&
> +	    hdr->hdr_version !=3D htonl(4))
>  		return error("bad index version");
[...]
> @@ -1568,7 +1584,11 @@ int write_index(struct index_state *istate, in=
t newfd)
[...]
> +	if (get_narrow_prefix() && ver < 4)
> +		ver =3D 4;	/* narrow-unaware git should to touch this index */
> +
> +	hdr.hdr_version =3D htonl(ver);
>  	hdr.hdr_entries =3D htonl(entries - removed);
> =20
>  	git_SHA1_Init(&c);

Oh, or you can do this. :)

Thanks for a pleasant read.  Looks good so far, though I didn't read
the tests.
