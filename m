From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Sun, 2 Jun 2013 12:25:08 -0500
Message-ID: <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jun 02 19:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjC1u-0004N6-Dv
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 19:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab3FBRZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 13:25:12 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61045 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab3FBRZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 13:25:10 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so3057364lbd.20
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=n9rYHlKKJOS/KEwe09oVEKPMnZnKF6F4DpmR9/KGZbQ=;
        b=Wk/GDzLd4rqkcBMirTHADwzuD5VFAP8FrIYohEEcjbu6/hOiuJkmiFaXzLkPJGs0eI
         Ge4zLulT92J8D8vZASAWoVX/LWQhJ7I2afMFcjqCQUI54s3BNB/lxIXb62z5zhLIfdSZ
         zs6bYUamErTqSM0OpmbBFp4IWShoEBdunNTkymMRyKGaGF0e3+ZZBfMX/TdsY2/LkffN
         FAnikEqUq0CjG4lQk4VAm1B1wPtqPgzDCbUb28uLv8+M9wgKfbH6c5AtZUXesebKr1ws
         zZDh61HBt2BxY92vepuTq7fSDU18gUC7ipiOZUP9nsIJDvlu3r36mehgJKwDGP0suED4
         4ZPQ==
X-Received: by 10.112.160.105 with SMTP id xj9mr6809628lbb.11.1370193908970;
 Sun, 02 Jun 2013 10:25:08 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 10:25:08 -0700 (PDT)
In-Reply-To: <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226168>

On Sun, Jun 2, 2013 at 10:46 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> The merge functions duplicate entries as needed and they don't free
> them.  Release them in unpack_nondirectories, the same function
> where they were allocated, after we're done.
>
> As suggested by Felipe, use the same loop style (zero-based for loop)
> for freeing as for allocating.
>
> Improved-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  unpack-trees.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 2dbc05d..57b4074 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -600,9 +600,16 @@ static int unpack_nondirectories(int n, unsigned=
 long mask,
>                 src[i + o->merge] =3D create_ce_entry(info, names + i=
, stage);
>         }
>
> -       if (o->merge)
> -               return call_unpack_fn((const struct cache_entry * con=
st *)src,
> -                                     o);
> +       if (o->merge) {
> +               int rc =3D call_unpack_fn((const struct cache_entry *=
 const *)src,
> +                                       o);
> +               for (i =3D 0; i < n; i++) {
> +                       struct cache_entry *ce =3D src[i + o->merge];
> +                       if (ce !=3D o->df_conflict_entry)

It's possible that ce is NULL, but you didn't add that check because
free(NULL) still works? Or because ce cannot be NULL?

If it's the former, I think it's clearer if we check that ce is not
NULL either way.

Otherwise it's OK by me.

> +                               free(ce);
> +               }
> +               return rc;
> +       }

--=20
=46elipe Contreras
