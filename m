From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 5/9] grep/pcre: prepare locale-dependent tables for
 icase matching
Date: Wed, 8 Jul 2015 18:00:34 +0700
Message-ID: <CACsJy8AiuiY=scqaH57wYVk4sWvvb0ddJzJGs+iaRj9ouHfCqw@mail.gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com> <1436351919-2520-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Plamen Totev <plamen.totev@abv.bg>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 13:01:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCn6C-0003iG-47
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbGHLBG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 07:01:06 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35260 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbbGHLBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 07:01:04 -0400
Received: by igcqs7 with SMTP id qs7so53258847igc.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vFdJVFiVyyk8yJ5BfxoujtgCru3+QEZclfbV4HTHzxw=;
        b=UigQNST8XtxeS/AOamoEflOM3Fy52uOj8j660SALlPs1QF8XChhBaXSX/cS+Sevg4K
         eufXlxr286DpDZJFwanLdIa+Q/Ff1PTyGkQ40lXy6TcRXE64v+gtrvFBdZqt2HgLVUJA
         SiPHnkWymuOpj4fD96BCOScP9XC2AbVo89xmj/T72qeVIY1AqiTcn2g/kZjuBoyJWM+x
         PM0ND1FFILPCs5Zas6xPcS+6JWWNLWBZPIlpKRRiRMsh+MWpjThUEGR13gfZVo0uiyMw
         WK20rB8uUvAYv6HjAxurjAt5Nx8Z36voUhQpysHnE7MKi1XOwvx4mlSws3PNduVvOTsE
         InoQ==
X-Received: by 10.107.15.153 with SMTP id 25mr16706650iop.44.1436353263601;
 Wed, 08 Jul 2015 04:01:03 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 8 Jul 2015 04:00:34 -0700 (PDT)
In-Reply-To: <1436351919-2520-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273669>

On Wed, Jul 8, 2015 at 5:38 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> diff --git a/grep.c b/grep.c
> index 8fce54f..c79aa70 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -324,11 +324,13 @@ static void compile_pcre_regexp(struct grep_pat=
 *p, const struct grep_opt *opt)
>         int erroffset;
>         int options =3D PCRE_MULTILINE;
>
> -       if (opt->ignore_case)
> +       if (opt->ignore_case) {
> +               p->pcre_tables =3D pcre_maketables();

This affects ascii-only case too because I didn't use has_non_ascii()
here. I guess it's ok because the doc says there are default tables
anyway. But I'm not really familiar with pcre... If they have
optimizations for when the last argument of pcre_compile() is NULL, we
have a regression.

>                 options |=3D PCRE_CASELESS;
> +       }
>
>         p->pcre_regexp =3D pcre_compile(p->pattern, options, &error, =
&erroffset,
> -                       NULL);
> +                                     p->pcre_tables);
>         if (!p->pcre_regexp)
>                 compile_regexp_failed(p, error);
>
--=20
Duy
