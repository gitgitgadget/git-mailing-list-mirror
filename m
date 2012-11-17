From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/7] completion: fix expansion issue in __gitcomp()
Date: Sat, 17 Nov 2012 12:39:24 +0100
Message-ID: <CAMP44s3J3e_bcyoQmcdQno59dPJuJ4=7ej=-eseE5j2tteD=dA@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-7-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 17 12:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZgkO-0004sb-O4
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab2KQLj0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 06:39:26 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:36432 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab2KQLjZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 06:39:25 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3587831oag.19
        for <git@vger.kernel.org>; Sat, 17 Nov 2012 03:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UCvQNKlUdE8hJHCiqj6mulYIiF5MwvNeGIY19hF0+ho=;
        b=yWLRvDDhwQ94YZckpAFYBURkcPZvtOkPRn8WXFWvC2plmvnrkCcY1nLo0DtAgAPSKo
         8iBhn42htHaUTQCYDzWQvBrb6UoIqI5+d/Rn1y9XUQro9uVABM24lmKM4d0/ePxgcHhI
         KjL8c5SZ6I69TSeM6TwfiWv6rbxu9ZfeJt2ns6uByaikT+6vdoLn2dO/96i0YRPn4PWG
         DrRk1Ai2qhAXK0K4uPPUu7I+sA1V09f8T+i81iNxK7gS9Mnfg6YuH2w/f203CqBuJPRv
         3NTVP8KSdyUl/fpf5S85BmlUD6+h5CDWg+z8DYZ+lqSWkGhYhqYW42a7VdIP3KMrrpoJ
         m/2w==
Received: by 10.60.14.101 with SMTP id o5mr3697433oec.85.1353152364917; Sat,
 17 Nov 2012 03:39:24 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 17 Nov 2012 03:39:24 -0800 (PST)
In-Reply-To: <1353150353-29874-7-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209949>

On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:

> -# Generates completion reply with compgen, appending a space to poss=
ible
> -# completion words, if necessary.
> +# Generates completion reply for the word in $cur, appending a space=
 to
> +# possible completion words, if necessary.
>  # It accepts 1 to 4 arguments:
>  # 1: List of possible completion words.
>  # 2: A prefix to be added to each possible completion word (optional=
).
> -# 3: Generate possible completion matches for this word (optional).
> +# 3: Generate possible completion matches for this word instead of $=
cur
> +#    (optional).
>  # 4: A suffix to be appended to each possible completion word (optio=
nal).
>  __gitcomp ()
>  {
> @@ -241,10 +242,22 @@ __gitcomp ()
>                 COMPREPLY=3D()
>                 ;;
>         *)
> -               local IFS=3D$'\n'
> -               COMPREPLY=3D($(compgen -P "${2-}" \
> -                       -W "$(__gitcomp_1 "${1-}" "${4-}")" \
> -                       -- "$cur_"))
> +               local i=3D0 c IFS=3D$' \t\n'
> +               for c in $1; do
> +                       case $c in
> +                       "$cur_"*)
> +                               c=3D"$c${4-}"
> +                               case $c in
> +                               --*=3D*|*.) ;;
> +                               *) c=3D"$c " ;;
> +                               esac
> +                               COMPREPLY[$i]=3D"${2-}$c"
> +                               i=3D$((++i))
> +                               ;;
> +                       *)
> +                               ;;
> +                       esac
> +               done

This is not quite the same as before, is it? Before the suffix would
be taken into consideration for the comparison with $cur_, but not any
more.

Cheers.

--=20
=46elipe Contreras
