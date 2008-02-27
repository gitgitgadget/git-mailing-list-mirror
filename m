From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Wed, 27 Feb 2008 14:44:33 -0800
Message-ID: <7v63waqasu.fsf@gitster.siamese.dyndns.org>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:45:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUV1f-0000Yr-Mn
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbYB0Wor convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 17:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbYB0Wor
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:44:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYB0Wor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 17:44:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D0541C23;
	Wed, 27 Feb 2008 17:44:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8F8B3189D; Wed, 27 Feb 2008 17:44:38 -0500 (EST)
In-Reply-To: <1203934349-12125-1-git-send-email-sbejar@gmail.com> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Mon, 25 Feb 2008 11:12:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75314>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

> Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
> diff --git a/git-clone.sh b/git-clone.sh
> index 0d686c3..2efb947 100755
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
>  [ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.=
git$||' -e 's|.*[/:]||g')
> +[ -f "$dir" ] && dir=3D$(expr "$repo" : '.*/\([^/]*\)\.[^/]*')
>  [ -e "$dir" ] && die "destination directory '$dir' already exists."
>  [ yes =3D "$bare" ] && unset GIT_WORK_TREE
>  [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&

What is this [ -f "$dir" ] line doing?  The purpose of these
lines is:

 - The user (might have) said "clone to $2";

 - If the user didn't, then set dir to humanish part;

 - If that exists, we barf.

I do not see any valid reason for an additional logic in this
sequence when adding a new clone _source_ type.

The check to see if "$dir" _exists_ is even worse.  If the user
said "clone _to_ this", then we would not have invented $dir
based on the $repo (which is what the user said "clone _from_")
but used whatever name the user has given us.  The existing
check to barf "Hey, that explicit location you told me to clone
to is WRONG!!!" should not be broken.
