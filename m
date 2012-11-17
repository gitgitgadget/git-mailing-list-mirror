From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 5/5] completion: refactor __gitcomp_1
Date: Sat, 17 Nov 2012 15:13:30 +0100
Message-ID: <20121117141330.GH12052@goldbirke>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
 <1353116298-11798-6-git-send-email-felipe.contreras@gmail.com>
 <20121117105837.GC12052@goldbirke>
 <CAMP44s3OG+dzxZNpR+qELvcS37KDWh+Bnf0K1zGze4f3P4OWNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:13:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZj9c-0008G1-V8
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817Ab2KQONj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 09:13:39 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:53127 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab2KQONj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:13:39 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LfFgy-1SyCTz2JQm-00ojVi; Sat, 17 Nov 2012 15:13:32 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3OG+dzxZNpR+qELvcS37KDWh+Bnf0K1zGze4f3P4OWNg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:H8bthgiUV7QHSxSRI2mcIPg0dVRTiQ9YcbALu+WUXZp
 NORvnEIqmDlKcMLE4UdX7TVv/IwtPNzMcw9Lbjm/SJzz4YveJH
 +2gq4CY8G5GwN2StweK9r1sVJGtauDhZEwGx3sK7kOHtZbauVw
 ierbgwn8aKXFHS1SsH8LwWkfx8lFjqi9JyYHy+dWYwL1DTSB/3
 syDIoe3Gsms4uve2YISJKsdxGn2qDw7Rz+mYn9NYFYSwiHnBIt
 6k8XPMDKih3D7K1jSC0bZBzt1nFkloF6CDOKT5k74q64O5yGti
 3IlXpomvAitFKA75f4AnVXZOLE6hiuxs1M9AWQfcSpMCnXkAE4
 XeD9QwhwMQ44Wngxexsg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209956>

On Sat, Nov 17, 2012 at 12:27:40PM +0100, Felipe Contreras wrote:
> On Sat, Nov 17, 2012 at 11:58 AM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
>=20
> >>  # The following function is based on code from:
> >> @@ -249,10 +246,16 @@ __gitcomp ()
> >>       --*=3D)
> >>               ;;
> >>       *)
> >> -             local IFS=3D$'\n'
> >> -             __gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}=
" "$cur_" ""
> >> +             local c IFS=3D$' \t\n'
> >> +             for c in ${1-}; do
> >> +                     c=3D`__gitcomp_1 "$c${4-}"`
> >
> > 1. Backticks.
> > 2. A subshell for every word in the wordlist?
>=20
> Fine, lets make it hard for zsh then:

No, it's about keeping it usable.  With this change offering the
approximately 170 commands for 'git help <TAB>' would take more than 4
seconds on Windows.


> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -56,19 +56,6 @@ __gitdir ()
>         fi
>  }
>=20
> -__gitcomp_1 ()
> -{
> -       local c IFS=3D$' \t\n'
> -       for c in $1; do
> -               c=3D"$c$2"
> -               case $c in
> -               --*=3D*|*.) ;;
> -               *) c=3D"$c " ;;
> -               esac
> -               printf '%s\n' "$c"
> -       done
> -}
> -
>  # The following function is based on code from:
>  #
>  #   bash_completion - programmable completion functions for bash 3.2=
+
> @@ -241,12 +228,22 @@ __gitcomp ()
>                 COMPREPLY=3D()
>                 ;;
>         *)
> -               local IFS=3D$'\n'
> -               COMPREPLY=3D($(compgen -P "${2-}" \
> -                       -W "$(__gitcomp_1 "${1-}" "${4-}")" \
> -                       -- "$cur_"))
> +               local c i IFS=3D$' \t\n'
> +               i=3D0
> +               for c in ${1-}; do
> +                       c=3D"$c${4-}"
> +                       case $c in
> +                       --*=3D*|*.) ;;
> +                       *) c=3D"$c " ;;
> +                       esac
> +                       if [[ "$c" =3D "$cur_"* ]]; then
> +                               (( i++ ))
> +                               COMPREPLY[$i]=3D"${2-}$c"
> +                       fi
> +               done
>                 ;;
>         esac
> +
>  }
>=20
>  # Generates completion reply with compgen from newline-separated pos=
sible
>=20
> --=20
> Felipe Contreras
