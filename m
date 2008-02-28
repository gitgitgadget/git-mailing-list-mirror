From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] clone: support cloning full bundles
Date: Thu, 28 Feb 2008 09:57:23 -0800
Message-ID: <7vmyplj75o.fsf@gitster.siamese.dyndns.org>
References: <1204165372-12175-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUn1J-0004eg-Dx
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbYB1R5h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2008 12:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbYB1R5h
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:57:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYB1R5g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2008 12:57:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1EB5C1FBD;
	Thu, 28 Feb 2008 12:57:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 530811FBC; Thu, 28 Feb 2008 12:57:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75430>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> diff --git a/git-clone.sh b/git-clone.sh
> index 0d686c3..0580b5a 100755
> --- a/git-clone.sh
> +++ b/git-clone.sh
> @@ -210,11 +210,14 @@ if base=3D$(get_repo_base "$repo"); then
>  	then
>  		local=3Dyes
>  	fi
> +elif [ -f "$repo" ] ; then
> +	case "$repo" in /*);; *) repo=3D"$PWD/$repo" ; esac
>  fi
> =20
>  dir=3D"$2"
>  # Try using "humanish" part of source repo if user didn't specify on=
e
> -[ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.=
git$||' -e 's|.*[/:]||g')
> +[ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.=
git$||' -e 's|.*[/:]||g') &&
> +[ -f "$repo" ] && dir=3D$(echo "$repo" | sed -e 's|/*\.bundle$||' -e=
 's|.*/||g')
>  [ -e "$dir" ] && die "destination directory '$dir' already exists."
>  [ yes =3D "$bare" ] && unset GIT_WORK_TREE
>  [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&

This sequence was terse, to the point and very readable when the
logic was simpler, but now it is getting out of hand.  I think
it is a time for rewriting to something more verbose, like...

	# Decide the directory name of the new repository
        if test -n "$2"
        then
        	dir=3D"$2"
	else
        	# Derive one from the repository name
                if test -f "$repo"
                then
                        # Cloning from a bundle
                        dir=3D... humanish ...
                else
                        dir=3D... humanish ...
                fi
        fi

