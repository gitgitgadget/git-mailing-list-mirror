From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 08/19] completion: use $__git_dir instead of $(__gitdir)
Date: Wed, 9 May 2012 23:36:36 +0200
Message-ID: <20120509213636.GC7824@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-9-git-send-email-szeder@ira.uka.de>
	<7vaa1hrvh6.fsf@alter.siamese.dyndns.org>
	<20120509202220.GB7824@goldbirke>
	<7vmx5hqdjx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 23:36:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEYt-0007kr-6A
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421Ab2EIVgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 17:36:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55892 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213Ab2EIVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 17:36:37 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MP3gp-1SXTcq3B03-006Ab7; Wed, 09 May 2012 23:36:35 +0200
Content-Disposition: inline
In-Reply-To: <7vmx5hqdjx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:HsX77WyDSe3ayZxz25DZQL1Yh9PO2uz3STkBxS0sO6v
 BYHEFstqo4khxkOQIsxwLxwYFy22fZI+rVeFDelT0zsMtVRc7D
 9CLGREVz561BoftDFfHU9u/DsvkayUXR0vAQvLFB5HijmFZQ2b
 MmOfrOHi3FJECun7BxB0oeJyA0/H2zb7Pb/WV6pOVFzEnAu3EZ
 R9PhICRL5nSuCor7zN/ZGZmDlpHlh/aML4fiDWVt6SZ7u9z54M
 D20UMzrrwGsUHneLlm3ZqRgXXH1xNccq/DBx5twvUpkumO9cnT
 lNOUApWpVigrQ/wjLowp8w09L7yYRocMRIg0H5/NMlEnDcYe+r
 hDPiR8QsdMxeKMzgD8Wo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197516>

On Wed, May 09, 2012 at 01:56:02PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> >> > @@ -962,7 +967,8 @@ __git_aliases ()
> >> >  # __git_aliased_command requires 1 argument
> >> >  __git_aliased_command ()
> >> >  {
> >> > -	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
> >> > +	__gitdir >/dev/null
> >> > +	local word cmdline=3D$(git --git-dir=3D"$__git_dir" \
> >> >  		config --get "alias.$1")
> >> >  	for word in $cmdline; do
> >> >  		case "$word" in
> >>=20
> >> Now this worries me.  The way I read 07/19 was that the local __gi=
t_dir=3D""
> >> declarations in __git_ps1 and __git were what protected this whole
> >> machinery to protect us against surprises from user doing "cd" bet=
ween
> >> interactive commands, but you have the same __gitdir call to set u=
p the
> >> global $__git_dir variable there, without the initialization to ""=
=2E
> >>=20
> >> Having to have a call to __gitdir seems to indicate to me that you=
 cannot
> >> assume that the other initialization sites may not have been calle=
d before
> >> we get to this point.  Then why is 'local __git_dir=3D""' unneeded=
 here?
> >
> > Your comments to the previous patch apply here.
>=20
> Not really.  __git_ps1 and __gitk seems to do __gitdir very early to =
make
> sure anybody that use $__git_dir can rely on it

No, __git_ps1() and __gitk() do __gitdir() early, because they need
the path to the repository very early.

> but having to sprinkle
> "set up $__git_dir variable" everywhere means anybody who wants to up=
date
> need to know if it is already called, which defeats the point of "we =
can
> use $__git_dir instead of calling $(__gitdir)" from maintainability's
> point of view.

Well, the point is better explained in the body of the commit message:

  just call __gitdir() directly and then use $__git_dir instead of
  doing 'dir=3D"$(__gitdir)"' command substitution

Unfortunately, I just couldn't manage to squeeze all this into a
one-line short description.  So it really is about performance, and
not maintainability.
