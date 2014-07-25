From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] refs.c: refactor resolve_ref_unsafe() to use strbuf internally
Date: Fri, 25 Jul 2014 11:55:10 -0400
Message-ID: <CAPig+cSvymyM3G+LujopPAVtaXVYN_mYJ0pxPkvb2pvLsq+e-A@mail.gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
	<1406285039-22469-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAhq5-0003ec-83
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 17:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbaGYPzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 11:55:13 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:52613 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaGYPzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2014 11:55:11 -0400
Received: by mail-yk0-f177.google.com with SMTP id 79so2883452ykr.8
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=wVYZWmaqlMHzRpeDdPNP7jWiRU8agpIKG7JjjmnCOzk=;
        b=dJMWVJgaR8RCL9ZRf3gURjW1hcPtjH8W+r/eCSLOx6ndAbjPT54utx1Mly2ASdVCld
         fiP+9KSOU7RoJ2Ca8EHfii9KAUA59DkCXhQfM1QZVhQ7r4LPt7cR3/dHrpJ7QXtRLHw7
         04dfq0WbgSsyD3SKCroSA4PtNde1Oyr84KLViNkiIVVrEsZHkYqmxzhNpP36Xi3UFs7q
         VyQxU4KJc8nNalILtfT91Th9THPQlXm6h7RjwQk8Eeu0rEV+DYuBrayzC8KqqV2BP5fn
         A5CaahLW2bn2Lv0+xOSV0OXBt5dyajZqZTzhW+rE+KPopciduIIsnl2wWPcbV8nShu1B
         uoJw==
X-Received: by 10.236.92.133 with SMTP id j5mr24460803yhf.22.1406303710890;
 Fri, 25 Jul 2014 08:55:10 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Fri, 25 Jul 2014 08:55:10 -0700 (PDT)
In-Reply-To: <1406285039-22469-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: GUsf6QPsz8UvDRolDKUVYonNq1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254229>

On Fri, Jul 25, 2014 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> In the beginning, we had resolve_ref() that returns a buffer owned by
> this function. Then we started to move away from that direction becau=
se
> the buffer could be overwritten by the next resolve_ref() call and
> introduced two new functions: resolve_ref_unsafe() and resolve_refdup=
().
> The static buffer is still kept internally.
>
> This patch makes the core of resolve_ref use a strbuf instead of stat=
ic
> buffer. Which makes resolve_refdup() more efficient (no need to copy
> from the static buffer to a new buffer). It also removes the (random?=
)
> 256 char limit. In future, resolve_ref() could be used directly witho=
ut
> going through resolve_refdup() wrapper.
>
> A minor bonus. resolve_ref(dup) are now more thread-friendly (althoug=
h I'm
> not 100% sure if they are thread-safe yet).
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h |   1 +
>  refs.c  | 122 +++++++++++++++++++++++++++++++++++-------------------=
----------
>  2 files changed, 68 insertions(+), 55 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index fcb511d..5ffbafb 100644
> --- a/cache.h
> +++ b/cache.h
> +const char *resolve_ref_unsafe(const char *refname, unsigned char *s=
ha1, int reading, int *flag)
> +{
> +       static struct strbuf buf =3D STRBUF_INIT;
> +       if (!resolve_ref(refname, &buf, sha1, reading, flag))
> +               return buf.buf;
> +       else
> +               return NULL;
>  }
>
>  char *resolve_refdup(const char *ref, unsigned char *sha1, int readi=
ng, int *flag)
>  {
> -       const char *ret =3D resolve_ref_unsafe(ref, sha1, reading, fl=
ag);
> -       return ret ? xstrdup(ret) : NULL;
> +       struct strbuf buf =3D STRBUF_INIT;
> +       if (!resolve_ref(ref, &buf, sha1, reading, flag))
> +               return buf.buf;

return strbuf_detach(&buf, NULL);

> +       else {
> +               strbuf_release(&buf);
> +               return NULL;
> +       }
>  }
>
>  /* The argument to filter_refs */
> --
> 1.9.1.346.ga2b5940
