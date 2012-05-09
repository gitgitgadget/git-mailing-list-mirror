From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 08/19] completion: use $__git_dir instead of $(__gitdir)
Date: Wed, 9 May 2012 22:22:20 +0200
Message-ID: <20120509202220.GB7824@goldbirke>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
	<1336524290-30023-9-git-send-email-szeder@ira.uka.de>
	<7vaa1hrvh6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 09 22:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDPG-0004ip-F0
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761000Ab2EIUWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 16:22:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57396 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760376Ab2EIUWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:22:37 -0400
Received: from localhost6.localdomain6 (p5B1303EC.dip0.t-ipconnect.de [91.19.3.236])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M7A1q-1SFLdy0qT0-00wxQo; Wed, 09 May 2012 22:22:20 +0200
Content-Disposition: inline
In-Reply-To: <7vaa1hrvh6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:pzZ1BhI0GDnk6KkljASwUb8mVF2LsnimQns6QD2K/II
 T9ukf75kpiCgZTMqVqzA6mo+wO/jNK4Qf81aMQbjXpg1h53UEk
 h58yQ2pudvYIQykT7DMM58dPJDgd8qNf5tDE+OV42rNbPWfA0p
 mpK+2wbZAbmVsbzIAYB2ZUdj2TsydTTGCB9oPJ+0FGOUVulpY4
 yLkP6B5ce+B3+fToTzVtlHVoncVAnnpAiD9peI4+H2ybfxScB0
 iNBaybtGauXju4PJE127UvR3Fu0sPcG2JVLUv1LWuUbUi5qFgP
 eCwSDZ5qG6zlnItZFZs2N1FQ5gqshwN8x//eYI9SlAAdalkrs+
 StLaQfnvr2QPe9FJAJ4A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197505>

On Wed, May 09, 2012 at 12:43:33PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > +	__gitdir >/dev/null
>=20
> If this becomes the only call site of __gitdir helper function (and t=
hat
> was the way I read the log message), it would be sane to rename it to
> a more descriptive __setup_dash_dash_git_dir function and lose the ne=
ed to
> redirect its output, no?

There might be user-defined completion functions using __gitdir(), and
I didn't want to break them by changing the function's name or
altering its existing behavior, i.e. printing the path.

> > @@ -962,7 +967,8 @@ __git_aliases ()
> >  # __git_aliased_command requires 1 argument
> >  __git_aliased_command ()
> >  {
> > -	local word cmdline=3D$(git --git-dir=3D"$(__gitdir)" \
> > +	__gitdir >/dev/null
> > +	local word cmdline=3D$(git --git-dir=3D"$__git_dir" \
> >  		config --get "alias.$1")
> >  	for word in $cmdline; do
> >  		case "$word" in
>=20
> Now this worries me.  The way I read 07/19 was that the local __git_d=
ir=3D""
> declarations in __git_ps1 and __git were what protected this whole
> machinery to protect us against surprises from user doing "cd" betwee=
n
> interactive commands, but you have the same __gitdir call to set up t=
he
> global $__git_dir variable there, without the initialization to "".
>=20
> Having to have a call to __gitdir seems to indicate to me that you ca=
nnot
> assume that the other initialization sites may not have been called b=
efore
> we get to this point.  Then why is 'local __git_dir=3D""' unneeded he=
re?

Your comments to the previous patch apply here.

All completion functions are called either from _git() or from
_gitk(), where $__git_dir is declared as local.  So no matter how deep
is $__git_dir set in the callchain, it can't leak into the
environment.  It won't even survive between two subsequent completions
on the same command line.

Now, it would definitely be simpler to just initialize $__git_dir in
the two toplevel functions.  But there are many codepatch that don't
need $__git_dir at all, and would only be slowed down by an additional
$(git rev-parse --git-dir).


G=E1bor
