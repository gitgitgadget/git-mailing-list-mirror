From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Wed, 11 Jun 2008 08:27:53 +0200
Message-ID: <20080611062753.GB15034@diana.vm.bytemark.co.uk>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk> <484E87B2.2090506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 08:29:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Jpb-0001kq-Aj
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 08:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYFKG2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 02:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYFKG2T
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 02:28:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4880 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbYFKG2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 02:28:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K6JoH-00047N-00; Wed, 11 Jun 2008 07:27:53 +0100
Content-Disposition: inline
In-Reply-To: <484E87B2.2090506@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84594>

On 2008-06-10 08:54:58 -0500, Clark Williams wrote:

> --- a/stgit/commands/imprt.py
> +++ b/stgit/commands/imprt.py
> @@ -178,8 +178,22 @@ def __create_patch(filename, message, author_nam=
e, author_email,
>  def __import_file(filename, options, patch =3D None):
>      """Import a patch from a file or standard input
>      """
> +    if patch:
> +        pname =3D patch
> +    else:
> +        pname =3D filename
> +
>      if filename:
> -        f =3D file(filename)
> +        if filename.endswith('.gz'):
> +            import gzip
> +            f =3D gzip.open(filename)
> +            pname =3D strip_suffix('.gz', filename)
> +        elif filename.endswith('.bz2'):
> +            import bz2
> +            f =3D bz2.BZ2File(filename)
> +            pname =3D strip_suffic('.bz2', filename)
                                  ^
Here's why I keep blathering about tests! In Python, you don't have a
compiler to catch these for you ...

> +        else:
> +            f =3D file(filename)
>      else:
>          f =3D sys.stdin
> =20
> @@ -197,11 +211,6 @@ def __import_file(filename, options, patch =3D N=
one):
>      if filename:
>          f.close()
> =20
> -    if patch:
> -        pname =3D patch
> -    else:
> -        pname =3D filename
> -

I just realized a problem with this that was already present in your
first version: if patch !=3D None, so that you set pname =3D patch, you
overwrite pname since you strip the .gz/.bz2 suffixes _later_.

Other than that, it looks good. But you sounded tempted to go with the
idea of just trying the decompressors rather than go by the suffix? I
think that'd be an improvement.

As for testing, you'd simply make two copies of one of the subtests in
t1800, where you test .gz- and .bz2-compressed versions of the same
patch. Should take about five minutes to write.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
