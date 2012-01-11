From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [msysGit] [PATCH 2/2] git-cvsexportcommit: Fix calling Perl's
 rel2abs() on MSYS
Date: Wed, 11 Jan 2012 11:29:53 +0000
Message-ID: <CABNJ2GKRD-v85zA8dgoQUn66FcFp1ZsqxnOrJOYeaf+QCdDkSQ@mail.gmail.com>
References: <4F0D5367.1000506@gmail.com>
	<4F0D5486.7020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 12:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkwNY-0008In-SO
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 12:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939Ab2AKL3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 06:29:54 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36813 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932432Ab2AKL3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 06:29:53 -0500
Received: by iabz25 with SMTP id z25so988033iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=K4xzA9pqYtjj58ZKbviltFhp5iNBBXH8APAUd2gjc9M=;
        b=aDmmNKMOyDTtqfsHooOR6Fg63pn/NYnk/4HdFr7tIOS9rPc+OqGm5LwpO9i6E+ck+X
         kT2icy9UuJYGkVANblEQluo93oj0HCP/qOhiZhxc7LALdF7R5+ONYvIFeIe1uF0/kXt0
         e2jKpn6+pSLl/kYpT0cII6ALPfQbMhgku51NI=
Received: by 10.50.76.162 with SMTP id l2mr6472240igw.1.1326281393373; Wed, 11
 Jan 2012 03:29:53 -0800 (PST)
Received: by 10.231.18.4 with HTTP; Wed, 11 Jan 2012 03:29:53 -0800 (PST)
In-Reply-To: <4F0D5486.7020707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188356>

On 11 January 2012 09:21, Sebastian Schuberth <sschuberth@gmail.com> wr=
ote:
> Due to MSYS path mangling GIT_DIR contains a Windows-style path when
> checked inside a Perl script even if GIT_DIR was previously set to an
> MSYS-style path in a shell script. So explicitly convert to an MSYS-s=
tyle
> path before calling Perl's rel2abs() to make it work.
>
> This fix was inspired by a very similar patch in WebKit:
>
> http://trac.webkit.org/changeset/76255/trunk/Tools/Scripts/commit-log=
-editor
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
> =C2=A0git-cvsexportcommit.perl | =C2=A0 =C2=A07 +++++++
> =C2=A01 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index 39a426e..e6bf252 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -30,6 +30,13 @@ if ($opt_w || $opt_W) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chomp($gd);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$ENV{GIT_DIR} =
=3D $gd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 # On MSYS, convert a Windows-style path to an =
MSYS-style path
> + =C2=A0 =C2=A0 =C2=A0 # so that rel2abs() below works correctly.
> + =C2=A0 =C2=A0 =C2=A0 if ($^O eq 'msys') {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ENV{GIT_DIR} =3D~=
 s#^([[:alpha:]]):/#/$1/#;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Make sure GIT_DIR is absolute
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ENV{GIT_DIR} =3D File::Spec->rel2abs($ENV=
{GIT_DIR});
> =C2=A0}
> --
> 1.7.9.rc0.5096.g30a61
>

Cool - works for me. I just assumed we didn't support cvsexport.

Tested-by: Pat Thoyts <patthoyts@users.sourceforge.net>
