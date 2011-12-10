From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] Rename resolve_ref() to resolve_ref_unsafe()
Date: Sat, 10 Dec 2011 14:55:19 -0600
Message-ID: <20111210205519.GA24817@elie.hsd1.il.comcast.net>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
 <1323521631-24320-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Tony Wang <wwwjfy@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 21:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZTxQ-0001vT-Ci
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 21:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab1LJUz2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 15:55:28 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61732 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1LJUz1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 15:55:27 -0500
Received: by ggdk6 with SMTP id k6so11711ggd.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 12:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fb4i3MDP09UTfFn98ETxZ7xVRsZzQbmKoFbQwDib1w4=;
        b=VtJl61sEc3V2/Alzxv4a+6n2PhDn/lPzjTKVxeTgSTFtZNoAOurtEo4JkSaPoOJ8eG
         mufAS94QHrizVHlbSjsYaqKsZXIMg0ae11dyw33Wvv31tXsuVANzVQq3TumLkqg5vJ1R
         Ivb/QaFwi40IYTqONzzRNb6a1fsGUZhl+7DkU=
Received: by 10.100.153.16 with SMTP id a16mr2998573ane.138.1323550527400;
        Sat, 10 Dec 2011 12:55:27 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i4sm22006297yhk.21.2011.12.10.12.55.26
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 12:55:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323521631-24320-3-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186792>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> resolve_ref() may return a pointer to a shared buffer and can be
> overwritten by the next resolve_ref() calls. Callers need to
> pay attention, not to keep the pointer when the next call happens.
[...]
> --- a/branch.c
> +++ b/branch.c
> @@ -182,7 +182,7 @@ int validate_new_branchname(const char *name, str=
uct strbuf *ref,
>  		const char *head;
>  		unsigned char sha1[20];
> =20
> -		head =3D resolve_ref("HEAD", sha1, 0, NULL);
> +		head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);

I wonder if it would make sense to have a separate function that
maintains a shared buffer describing what HEAD resolves to, lazily
loaded.  Would invalidating the cache when appropriate be too fussy
and subtle?

[...]
> +++ b/transport.c
> @@ -163,7 +163,7 @@ static void set_upstreams(struct transport *trans=
port, struct ref *refs,
>  		/* Follow symbolic refs (mainly for HEAD). */
>  		localname =3D ref->peer_ref->name;
>  		remotename =3D ref->name;
> -		tmp =3D resolve_ref(localname, sha, 1, &flag);
> +		tmp =3D resolve_ref_unsafe(localname, sha, 1, &flag);

Anyway, this patch looks sane.  The reminder seems useful and doesn't
feel over-the-top.
