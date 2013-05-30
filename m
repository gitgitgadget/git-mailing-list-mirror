From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 7/7] unpack-trees: free cache_entry array members for merges
Date: Thu, 30 May 2013 07:04:42 -0500
Message-ID: <CAMP44s2=YuBLHgz52ie-FZYU5iz4o4tY0-zH+6XuzpiupjomLA@mail.gmail.com>
References: <1369913664-49734-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1369913664-49734-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 30 14:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1b6-0004EM-EO
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab3E3MEp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 08:04:45 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:42855 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab3E3MEo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 08:04:44 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so151606lab.32
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2KeUPlXXwBeQuLKCif6HMjcr5CvuP06SLj1nfU8QnHg=;
        b=PVnr8ejoRi/1P63i3lS+UbcGeJ6OJ3bqTV5S+oKSeW2JiqmRYLWyxYPPC59WgMYdZw
         3Y4HmshkpPDhK6G7MQnua4w2L6Gik+EVEvp+eF0zEqiHO5mlyBblkdRi1kQ8XzEAmW3d
         m+ORei+6XGBpKutAT0p+v5Hg2XYaF0TqPMASIaZ/qE8eZdhKn18Xp8Cp+K6cpsprV8Pl
         nCRc2YAKCg1Ba96bStb6G/qXIG35XoogWF1dFJXYPtdol+sLtGHtn2kR6dyJpVljan8R
         ZKi2XQBPk4NfOyJQtCFU7A3z6Qsa8fNu7Bs4X/PrJfRS0AUibsYtIezTEnSy/TPei8Dn
         rjAQ==
X-Received: by 10.152.28.233 with SMTP id e9mr3416270lah.41.1369915482314;
 Thu, 30 May 2013 05:04:42 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 05:04:42 -0700 (PDT)
In-Reply-To: <1369913664-49734-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225973>

On Thu, May 30, 2013 at 6:34 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> The merge functions duplicate entries as needed and they don't free
> them.  Release them in unpack_nondirectories, the same function
> where they were allocated, after we're done.

Ah, you beat me to this change, but..

> @@ -600,9 +600,14 @@ static int unpack_nondirectories(int n, unsigned=
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
> +               for (i =3D 1; i <=3D n; i++)
> +                       if (src[i] && src[i] !=3D o->df_conflict_entr=
y)
> +                               free(src[i]);

Doesn't it make more sense to follow the code above and do src[i + o->m=
erge]?

--=20
=46elipe Contreras
