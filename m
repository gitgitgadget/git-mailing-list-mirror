From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Thu, 28 Feb 2008 00:04:29 +0100
Message-ID: <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
	 <7v63waqasu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVKp-0007pG-Et
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbYB0XEe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 18:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYB0XEe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:04:34 -0500
Received: from ti-out-0910.google.com ([209.85.142.188]:36000 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYB0XEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 18:04:33 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2423844tif.23
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 15:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WfJ+LVyqNnpQcAzR+hU30xSYWk2vmm5ZJQ+c02WAsiM=;
        b=ekwmCtiuIzf0QJkiyZHbmniHpV9l28Yg87tvUutwIlrXGCnfTQNofTgLRiRgB0nwPdXAW6u6lxhfaAJulilIyllqVWdx7SE1SnvmBCoVyisffniccYfITUP2BKnl31dRW2dTPUOxWhUqJE/ICFxzJFPZqkAxMtYVLTRHW5i5ejw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HMRmnGqwllUnlip6YpO35ZfhE9IZbwwSXvqCQfU/m1Pj7ftPei1XRf+5aOthZL7fOuZWIrTZRT5Nja54LOBRvI0eZtbQUOoVX1Kf+Z5mNyRtZ/i6QsAazXzA/Pp7iabDtipYpReXXc3HH+2ekOwtoR8m9BzV8M1ymcMy3BkmN1o=
Received: by 10.150.96.10 with SMTP id t10mr2556133ybb.1.1204153469347;
        Wed, 27 Feb 2008 15:04:29 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 27 Feb 2008 15:04:29 -0800 (PST)
In-Reply-To: <7v63waqasu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75319>

On Wed, Feb 27, 2008 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>  > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>
> > diff --git a/git-clone.sh b/git-clone.sh
>  > index 0d686c3..2efb947 100755
>  > --- a/git-clone.sh
>  > +++ b/git-clone.sh
>  > @@ -210,11 +210,14 @@ if base=3D$(get_repo_base "$repo"); then
>  >       then
>  >               local=3Dyes
>  >       fi
>  > +elif [ -f "$repo" ] ; then
>  > +     case "$repo" in /*);; *) repo=3D"$PWD/$repo" ; esac
>  >  fi
>  >
>  >  dir=3D"$2"
>  >  # Try using "humanish" part of source repo if user didn't specify=
 one
>  >  [ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|:*/=
*\.git$||' -e 's|.*[/:]||g')
>  > +[ -f "$dir" ] && dir=3D$(expr "$repo" : '.*/\([^/]*\)\.[^/]*')
>  >  [ -e "$dir" ] && die "destination directory '$dir' already exists=
=2E"
>  >  [ yes =3D "$bare" ] && unset GIT_WORK_TREE
>  >  [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
>
>  What is this [ -f "$dir" ] line doing?  The purpose of these
>  lines is:
>
>   - The user (might have) said "clone to $2";
>
>   - If the user didn't, then set dir to humanish part;
>
>   - If that exists, we barf.
>
>  I do not see any valid reason for an additional logic in this
>  sequence when adding a new clone _source_ type.
>
>  The check to see if "$dir" _exists_ is even worse.  If the user
>  said "clone _to_ this", then we would not have invented $dir
>  based on the $repo (which is what the user said "clone _from_")
>  but used whatever name the user has given us.  The existing
>  check to barf "Hey, that explicit location you told me to clone
>  to is WRONG!!!" should not be broken.
>

Oops, I did not thought about that possibility. The check was to be
able to clone a bundle that was in the local directory. So:

$ git clone git.bundle

clones git.bundle to the directory git. Maybe we can add an && in the
previous line, or we can say simply that to clone a bundle in the same
directory you have to specify explicitly where to clone.

In another patch we could add an "official" extension to the bundles
(the same way as with the repositories "*.git") as project.bdl or
project.bundle and just remove this extension.

Santi
