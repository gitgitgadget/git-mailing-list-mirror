From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/5] Simplify editor selection logic
Date: Wed, 30 Jan 2008 18:57:57 +0100
Message-ID: <20080130175757.GA30529@diana.vm.bytemark.co.uk>
References: <20080129030059.926.29897.stgit@yoghurt> <20080129030349.926.45486.stgit@yoghurt> <200801292109.37785.kumbayo84@arcor.de> <20080130072828.GA24648@diana.vm.bytemark.co.uk> <76718490801300655r3d1b5b41l2945b4f730faedb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Oberndorfer <kumbayo84@arcor.de>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 18:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKHCz-0003nP-3C
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 18:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYA3R6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jan 2008 12:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbYA3R6Q
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 12:58:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1768 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYA3R6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 12:58:15 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JKHC9-0000Hy-00; Wed, 30 Jan 2008 17:57:57 +0000
Content-Disposition: inline
In-Reply-To: <76718490801300655r3d1b5b41l2945b4f730faedb2@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72060>

On 2008-01-30 09:55:18 -0500, Jay Soffian wrote:

> On Jan 30, 2008 2:28 AM, Karl Hasselstr=F6m <kha@treskal.com> wrote:

> > You could write it kind of like this:
> >
> >   def e(key): return os.environ.get(key, None)
> >   def c(key): return config.get(key)
> >   editor =3D filter(None, [e('GIT_EDITOR'), c('stgit.editor'), c('c=
ore.editor'),
> >                          e('VISUAL'), e('EDITOR'), 'vi'])[0]
>
> Too clever by half if you ask me. Why not just:
>
> editor =3D (os.environ.get('GIT_EDITOR') or
>           config.get('stgit.editor') or
>           config.get('core.editor') or
>           os.environ.get('VISUAL') or
>           os.environ.get('EDITOR') or
>           'vi')
>
> And be done with it?

Yes. It's more repetitive, but not much longer. With only five options
and one default -- if there were more, my version would be nicer
(IMHO).

> > Of course, if we're going to have code like this in several places
> > (you already mentioned the pager), we could build a function like
> > this:
> >
> >   editor =3D get_config(['GIT_EDITOR', 'stgit.editor', 'core.editor=
',
> >                        'VISUAL', 'EDITOR'], default =3D 'vi')
> >
> > that would differentiate between env variables and conf keys by
> > looking for dots in the name or something.
>=20
> def get_config(keys, default=3DNone):
>     rv =3D default
>     for k in keys:
>         if '.' in k:
>             d =3D config
>         else:
>             d =3D os.environ
>         if k in d:
>             rv =3D d[k]
>             break
>     return rv

'config' isn't a dict, so you have to use config.get, and you can't
use 'k in config'. But otherwise yes. So something like this maybe:

def get_config(keys, default =3D None):
    rv =3D None
    for k in keys:
        if '.' in k:
            rv =3D config.get(k)
        else:
            rv =3D os.environ.get(k, None)
        if rv !=3D None:
            return rv
    return default

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
