From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/5] enter_repo: allow .git files in strict mode
Date: Fri, 25 Sep 2015 12:59:17 -0700
Message-ID: <xmqqwpve2ru2.fsf@gitster.mtv.corp.google.com>
References: <1440204002-7638-1-git-send-email-pclouds@gmail.com>
	<1442106148-22895-1-git-send-email-pclouds@gmail.com>
	<1442106148-22895-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bjornar@snoksrud.no
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:59:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfZ9W-00043r-PH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 21:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933255AbbIYT7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2015 15:59:21 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33903 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932955AbbIYT7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 15:59:20 -0400
Received: by padhy16 with SMTP id hy16so114502006pad.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=b0EE+owYyvDwfswvzSOkeqzzHIR+xNk4M316ogbA8b8=;
        b=y589nm+27I5gby/YD3jBGWMolJaycaqjY1vLGV6NN2f+sb+QDwYvF6vwMZmkEu0q2d
         QwNqWJkQ1mASSM6jPCP1E/jjl3viB7ABS08/CyJPcFc+A+A7jqSd1EdDFRWzM8Y2kGso
         CAFDQtbRNkYy3+Y4IVuQ0ZYBFRiEXMVdb6zzWiyNq7iieBDRvO/+DWpA2EXmn1IkSlEJ
         t5pmduisA4OPCUvQYf+mDEStSwKdUgOwuw6w5k7z3unWTMomL+kaoavAT712wVq5BNft
         QUhxRt40BlarHst29G1zp0DjWKdRSioWL2TM+rBn0j9Tiw8UumOgIznZoVpf5p+Qws+c
         StuA==
X-Received: by 10.69.16.166 with SMTP id fx6mr9533566pbd.18.1443211160129;
        Fri, 25 Sep 2015 12:59:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id xm9sm5371299pbc.32.2015.09.25.12.59.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 12:59:19 -0700 (PDT)
In-Reply-To: <1442106148-22895-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13
 Sep 2015 08:02:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278679>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Strict mode is about not guessing where .git is. If the user points t=
o a
> .git file, we know exactly where the target .git dir will be.
>
> This is needed even in local clone case because transport.c code uses
> upload-pack for fetching remote refs.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  path.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/path.c b/path.c
> index 7340e11..32d4ca6 100644
> --- a/path.c
> +++ b/path.c
> @@ -438,8 +438,13 @@ const char *enter_repo(const char *path, int str=
ict)
>  			return NULL;
>  		path =3D validated_path;
>  	}
> -	else if (chdir(path))
> -		return NULL;
> +	else {
> +		const char *gitfile =3D read_gitfile(used_path);

At this point, used_path[] has not been touched since this function
was called.  What file are we reading from?

Is that just a typo of used_path?  Do we lack test that cover this
codepath?

Thanks.

> +		if (gitfile)
> +			path =3D gitfile;
> +		if (chdir(path))
> +			return NULL;
> +	}
> =20
>  	if (is_git_directory(".")) {
>  		set_git_dir(".");
