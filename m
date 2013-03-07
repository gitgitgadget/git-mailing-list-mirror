From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git p4: chdir resolves symlinks only for relative paths
Date: Thu, 7 Mar 2013 09:13:18 +0000
Message-ID: <20130307091317.GY7738@serenity.lan>
References: <CAAMmcSSvrsZqEVf68Nrqy_ZG6r5ESKhtx7JdQ7vzypkZ3gOFnA@mail.gmail.com>
 <CAAMmcSSEzs3+vZDO=FDMV9c2rp-8HTdMuPeeQCkok6y7sRDYJw@mail.gmail.com>
 <20130203230803.GA25555@padd.com>
 <CAAMmcSQszVbDERd964VLu1d4UG7SihC+Pn99D0gPvG7HAZp2UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Gary Gibbons <ggibbons@perforce.com>
To: =?iso-8859-1?Q?Mikl=F3s?= Fazekas <mfazekas@szemafor.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 10:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDWti-00017G-SK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 10:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab3CGJNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 04:13:32 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:49755 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab3CGJN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 04:13:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9909223136;
	Thu,  7 Mar 2013 09:13:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iWBf49cdbQUj; Thu,  7 Mar 2013 09:13:26 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 4E38C231A9;
	Thu,  7 Mar 2013 09:13:19 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAAMmcSQszVbDERd964VLu1d4UG7SihC+Pn99D0gPvG7HAZp2UQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217582>

On Thu, Mar 07, 2013 at 09:36:06AM +0100, Mikl=F3s Fazekas wrote:
> Sorry for the late turnaround here is an improved version. Now chdir
> has an optional argument client_path, if it's true then we don't do
> os.getcwd. I think that my first patch is also valid too - when the
> path is absolute no need for getcwd no matter what is the context,
> when it's relative we have to use os.getcwd() no matter of the
> context.
>=20
> ---
> If p4 client is configured to /p/foo which is a symlink:
> /p/foo -> /vol/barvol/projects/foo.  Then resolving the
> symlink will confuse p4:
> "Path /vol/barvol/projects/foo/... is not under client root
> /p/foo". While AltRoots in p4 client specification can be
> used as a workaround on p4 side, git-p4 should not resolve
> symlinks in client paths.
> chdir(dir) uses os.getcwd() after os.chdir(dir) to resolve
> relative paths, but as a sideeffect it resolves symlinks
> too. Now for client paths we don't call os.getcwd().
>=20
> Signed-off-by: Mikl=F3s Fazekas <mfazekas@szemafor.com>
> ---
>  git-p4.py |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index 0682e61..2bd8cc2 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -68,12 +68,17 @@ def p4_build_cmd(cmd):
>          real_cmd +=3D cmd
>      return real_cmd
>=20
> -def chdir(dir):
> +def chdir(dir,client_path=3DFalse):

Style (space after comma):

    def chdir(dir, client_path=3DFalse):

>      # P4 uses the PWD environment variable rather than getcwd(). Sin=
ce we're
>      # not using the shell, we have to set it ourselves.  This path c=
ould
>      # be relative, so go there first, then figure out where we ended=
 up.
> +    # os.getcwd() will resolve symlinks, so we should avoid it for
> +    # client_paths.
>      os.chdir(dir)
> -    os.environ['PWD'] =3D os.getcwd()
> +    if client_path:
> +        os.environ['PWD'] =3D dir
> +    else:
> +               os.environ['PWD'] =3D os.getcwd()

Indentation seems to have gone a bit wrong here...

>=20
>  def die(msg):
>      if verbose:
> @@ -1554,7 +1559,7 @@ class P4Submit(Command, P4UserMap):
>              new_client_dir =3D True
>              os.makedirs(self.clientPath)
>=20
> -        chdir(self.clientPath)
> +        chdir(self.clientPath,client_path=3DTrue)

Again, there should be a space after the comma here.

>          if self.dry_run:
>              print "Would synchronize p4 checkout in %s" % self.clien=
tPath
>          else:
> --=20
> 1.7.10.2 (Apple Git-33)
