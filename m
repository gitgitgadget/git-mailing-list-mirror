From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git p4: chdir resolves symlinks only for relative paths
Date: Sun, 3 Feb 2013 18:08:03 -0500
Message-ID: <20130203230803.GA25555@padd.com>
References: <CAAMmcSSvrsZqEVf68Nrqy_ZG6r5ESKhtx7JdQ7vzypkZ3gOFnA@mail.gmail.com>
 <CAAMmcSSEzs3+vZDO=FDMV9c2rp-8HTdMuPeeQCkok6y7sRDYJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: =?iso-8859-1?Q?Mikl=F3s?= Fazekas <mfazekas@szemafor.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 00:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U28fn-0006rn-73
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 00:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab3BCXII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2013 18:08:08 -0500
Received: from honk.padd.com ([74.3.171.149]:34267 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab3BCXIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 18:08:07 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id 40758E8E;
	Sun,  3 Feb 2013 15:08:06 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id ED35323215; Sun,  3 Feb 2013 18:08:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAAMmcSSEzs3+vZDO=FDMV9c2rp-8HTdMuPeeQCkok6y7sRDYJw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215340>

mfazekas@szemafor.com wrote on Tue, 29 Jan 2013 09:37 +0100:
> If a p4 client is configured to /p/foo which is a symlink
> to /vol/bar/projects/foo, then resolving symlink, which
> is done by git-p4's chdir will confuse p4: "Path
> /vol/bar/projects/foo/... is not under client root /p/foo"
> While AltRoots in p4 client specification can be used as a
> workaround on p4 side, git-p4 should not resolve symlinks
> in client paths.
> chdir(dir) uses os.getcwd() after os.chdir(dir) to resolve
> relative paths, but as a side effect it resolves symlinks
> too. Now it checks if the dir is relative before resolving.
>=20
> Signed-off-by: Mikl=F3s Fazekas <mfazekas@szemafor.com>
> ---
>  git-p4.py |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index 2da5649..5d74649 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -64,7 +64,10 @@ def chdir(dir):
>      # not using the shell, we have to set it ourselves.  This path c=
ould
>      # be relative, so go there first, then figure out where we ended=
 up.
>      os.chdir(dir)
> -    os.environ['PWD'] =3D os.getcwd()
> +    if os.path.isabs(dir):
> +        os.environ['PWD'] =3D dir
> +    else:
> +        os.environ['PWD'] =3D os.getcwd()
>=20
>  def die(msg):
>      if verbose:

Thanks, this is indeed a bug and I have reproduced it with a test
case.  Your patch works, but I think it would be better to
separate the callers of chdir():  those that know they are
cd-ing to a path from a p4 client, and everybody else.  The former
should not use os.getcwd(), as you show.

I'll whip something up soon, unless you beat me to it.

		-- Pete
