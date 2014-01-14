From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Re: [RFC v2] submodule: Respect requested branch on all
 clones
Date: Tue, 14 Jan 2014 23:19:07 +0100
Message-ID: <20140114221907.GC838@sandbox-ub>
References: <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
 <20140114165709.GH7078@odin.tremily.us>
 <20140114205830.GA838@sandbox-ub>
 <20140114214209.GJ23617@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 14 23:19:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3CKQ-0004Gf-6b
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 23:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbaANWTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 17:19:19 -0500
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:33410 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbaANWTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 17:19:17 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W3CKD-0006or-5G; Tue, 14 Jan 2014 23:19:09 +0100
Content-Disposition: inline
In-Reply-To: <20140114214209.GJ23617@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240417>

On Tue, Jan 14, 2014 at 01:42:09PM -0800, W. Trevor King wrote:
> On Tue, Jan 14, 2014 at 09:58:30PM +0100, Heiko Voigt wrote:
> > A typical workflow where a feature in a project needs some extensio=
n or
> > change in a submodule goes like this:
> >=20
> > 1. The developer does his changes locally implementing everything
> >    needed. To commit he creates a local branch in the submodule and=
 in
> >    the superproject (most of the times from the current HEAD that i=
s
> >    checked out).
> >=20
> > 2. For convenience I usually commit the resulting commit sha1 of th=
e
> >    submodule in the commit that needs the change. That way when I s=
witch
> >    to a different branch and back I can simply say: git submodule u=
pdate
> >    and get the correct code everywhere.
>=20
> This checkout functionality is exactly what my
> submodule.<name>.localBranch is designed to automate [1].  I think
> that should be different from integrating local and external changes,
> which is what 'git submodule update' is about.  For example, after yo=
u
> run 'git submodule update' here, you'll have your original commit
> checked out, but you'll be on a detached HEAD instead of your origina=
l
> branch.  If you want to further develop the submodule feature branch,
> you currently have to cd into the submodule and check the branch out
> by hand.

Yes and thats exactly what my idea was about but after further thinking
am afraid that this is the wrong place. I am not sure but afraid as I
wrote in the other post that it would be way to dangerous to accidental=
ly
merge these changes in. We would need something to prevent this
configuration from ever entering a stable branch.

Another solution (and completely different approach) would be to have
something that is outside of the tree and actually attached to a
branchname. E.g. at the gitmerge last year I though it would be nice to
have a place for a description for a branch inside git. In a short
discussion we were envisioning a special ref like the notes trees but
allowing to attach and describe branches. That place could also be wher=
e
we could store such a configuration. Once the branchname ceases to exis=
t
so would the configuration.

I know this is a completely different piece of work so I am not sure
whether we want to pursue it at the moment. But at the moment I think
this would actually be the correct solution.

> > How about the use-case I sketched above? Is that what you are searc=
hing
> > for? In that use-case we have to update to the new master after a
> > submodule change was merged. That could be achieved by
> >=20
> > 	git submodule update --remote <submodule>
> >=20
> > with the wanted stable branch configured. But in practise something
> > along the lines of
> >=20
> > 	(cd <submodule> && git checkout origin/<stable>)
> >=20
> > is usually used and simple enough.
>=20
> The =E2=80=9Cgitlinked commits must be in the subproject's master=E2=80=
=9D rule
> protects you from blowing stuff away here.  You could use rebase- or
> merge-style integration as well, assuming the maintainer didn't have
> dirty local work in their submodule.

No we can't. Developers are not allowed to merge in some submodules.
The most central ones have maintainers and only they are allowed to
merge into the stable branch. So we need to track exact commits on the
stable branch, no local merge (except the fast-forward case of course)
allowed. Thats why the developer does an exact checkout here.

> > We have a tool in our git gui configuration that does
> >=20
> > 	git submodule foreach 'git fetch && git checkout origin/master'
>=20
> I agree that with 'submodule update' seems superfluous.  With proper
> out-of-tree submodule configs specifying remote URLs and upstream
> branches,
>=20
>   git submodule foreach 'git fetch && git checkout @{upstream}'
>=20
> (or merge/rebase/=E2=80=A6) should cover this case more generically a=
nd with
> less mental overhead.
>=20
> > I hope that draws a clear picture of how we use submodules.
>=20
> It's certainly clearer, thanks :).  I'm not sure where checkout-mode
> is specifically important, though.  In your step-2, it doesn't restor=
e
> your original branch.  In your =E2=80=9Cupdate the superproject's mas=
ter=E2=80=9D
> step, you aren't even using 'submodule update' :p.

Ah sorry I though that was clear. The "others" are using submodule upda=
te ;-)

I mean someone who gets stuff from a stable superproject branch by
either rebasing their development branch or updating their local copy o=
f
a stable branch (e.g. master) by using

	git checkout master
	git pull --ff --ff-only
	git submodule update --init --recursive

This also prevents the pure "updaters" from creating unnecessary merges=
=2E

Cheers Heiko

> [1]: http://article.gmane.org/gmane.comp.version-control.git/240336
