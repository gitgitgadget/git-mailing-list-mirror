From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Mon, 25 May 2009 03:36:06 -0700
Message-ID: <20090525103604.GB13411@gmail.com>
References: <1243226693-72293-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johannes.schindelin@gmx.de, git@vger.kernel.org,
	markus.heidelberg@web.de, nick@incise.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 25 12:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8XXw-00037f-Lw
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 12:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZEYKgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 06:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbZEYKgN
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 06:36:13 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:53705 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbZEYKgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 06:36:12 -0400
Received: by pxi1 with SMTP id 1so2503447pxi.33
        for <git@vger.kernel.org>; Mon, 25 May 2009 03:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=O//JhAcBSE8t5iafp6u5wTqVSiDKXL8b3daSadk+s8o=;
        b=nFSEcPGJoggF/QPeazZoJ+zMbMtZINvIXQ7h9tHzxvTy65igV1uUGYGN1Lt1cbqm0p
         HIr2SXzrT7RARuDbwFj9gJtcBXUO91NwutQXU7K+6wOzzvAlxmtnUlUmKYlj0fwhZMEt
         26L4e4XVdY2SRHnsTfpp9xDTUuCecg1bmJQ4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iFAfMXPsRKydkIewMvPSyOH2DChyRWNFPtWgyg05dhXLAaHhdltpUoB3Me9BBHdPgD
         GKV+UOiRp+TlaY504LVS45AutdHZuLeHfYctc4Pk50AYDAR7uCgfiTvUNKd9VNbnVU+J
         h5BUp75B5TNQ7hi0vlgbyp8QBYxAGA6Z95+i8=
Received: by 10.115.18.1 with SMTP id v1mr14507299wai.175.1243247773736;
        Mon, 25 May 2009 03:36:13 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id v39sm14147126wah.62.2009.05.25.03.36.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 May 2009 03:36:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1243226693-72293-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119915>

On Sun, May 24, 2009 at 09:44:53PM -0700, David Aguilar wrote:
> diff --git a/path.c b/path.c
> index 8a0a674..c2a0fb6 100644
> --- a/path.c
> +++ b/path.c
> @@ -140,6 +140,24 @@ int git_mkstemp(char *path, size_t len, const ch=
ar *template)
>  }
> =20
> =20
> +/* git_mkstemp() - create tmp file with suffix honoring TMPDIR varia=
ble */
> +int git_mkstemps(char *path, size_t len, const char *template, int s=
uffix_len)
> +{
> +	const char *tmp;
> +	size_t n;
> +
> +	tmp =3D getenv("TMPDIR");
> +	if (!tmp)
> +		tmp =3D "/tmp";
> +	n =3D snprintf(path, len, "%s/%s", tmp, template);
> +	if (len <=3D n) {
> +		errno =3D ENAMETOOLONG;
> +		return -1;
> +	}
> +	return mkstemps(path, suffix_len);
> +}


Lured by a mac.  I came home and I tried it on linux:

path.c:157: warning: implicit declaration of function
=E2=80=98mkstemps=E2=80=99

Gah.
Darn you OS X and your non-portable 4.4 BSD extensions.
Sorry about that.

The original patch could do without the strbuf_detach
and free(), too.  Being tricked by an OS X manpage like
that is quite unpleasant.

mkstemp() won't do since it doesn't work with suffixes
(the templates must end with "XXXX").  I'm sure there has to
be another way, but I just can't think of it right now.

It seemed so easy at the time.
Sigh...

--=20

	David
