From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 23:38:58 +0100
Message-ID: <20140107223858.GB10782@sandbox-ub>
References: <20140105225733.GB4660@book.hvoigt.net>
 <20140105233943.GJ3156@odin.tremily.us>
 <20140106003314.GL3156@odin.tremily.us>
 <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de>
 <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
 <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:39:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0fIn-0000HS-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbaAGWjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:39:09 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:45357 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbaAGWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:39:07 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W0fIZ-0003FO-On; Tue, 07 Jan 2014 23:39:00 +0100
In-Reply-To: <20140107194503.GA26583@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240178>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

here my current thoughts in a kind of summary email.

On Tue, Jan 07, 2014 at 11:45:03AM -0800, W. Trevor King wrote:
> On Tue, Jan 07, 2014 at 08:19:49PM +0100, Francesco Pretto wrote:
> > 2014/1/7 Junio C Hamano <gitster@pobox.com>:
> > > It is not immediately obvious to me why anybody who specifies the
> > > submodule.*.branch variable to say "I want _that_ branch" not to
> > > want to be on that branch but in a detached state, so from that
> > > perspective, submodule.*.attach feels superfluous.
> > 
> > Junio, for what it concerns me I fully support this patch as, IMO, it
> > makes cleaner the role of the property "submodule.<name>.branch".
> 
> No, submodule.<name>.branch is the name of the remote-tracking branch
> for 'update --remote'.  In this patch, I'm using it as a hint for the
> preferred local branch name [1], which I now think was a bad idea.
> After [2], I think that we should just define the preferred local
> branch name explicitly (submodule.<name>.local-branch?).

I am not so sure about that. Having an extra value adds more
configuration burden to the user and it also does not help to understand
how this feature is supposed to be used.

Even though I was confused in the first place by the remote/local branch
switch for this option, after thinking a little bit more about it I
think it makes perfect sense to use the branch option as a hint for the
local branch.

Let me explain by an example. Suppose we have the following setup:

1. Fast-forward situation

    superproject      submodule

 master PA--------------->A master
                          |
                          B origin/master

Lets say superproject has submodule.submodule.branch=master and
submodule.submodule.update=merge.

Doing the initial update which clones results in the submodules master
branch being set to the sha1 registered in the superproject.

Now an update to the newest master in submodule is straightforward:

$ git submodule update --remote

2. Direct work situation

The developer start with the same setup as in situation 1 but now
directly starts to work in the submodule and creates commit C.

    superproject      submodule

 master PA--------------->A
                          |\
            origin/master B C master

$ git submodule update --remote
$ git commit -a -m "update submodule"

gets him this:

    superproject      submodule

        PA--------------->A
         |                |\
         |  origin/master B C
         |                |/
 master PB--------------->D master

Where now both the submodule and the superproject can be directly
pushed. If origin/master in the submodule is tracked by master this is
actually one command

$ git push --recurse-submodules=on-demand

So with your (Trevors) patch and reusing submodule.<name>.branch using
this kind of direct work in submodules is made easy. And wasn't that
what people always requested? ;-) Well, at least if you do not use
feature branches this makes it easy. But I think that is a good start
make the simple things easy first. Then we can later discuss the more
complicated ones. It seems to me that is also the case David wants for
his emacs/CEDET workflow: Make it easy for the superproject developers
to directly push out trivial fixes to the submodule.

And it also seems to me that is want Francesco wants.

One thing is missing though (and I think thats where Francesco came
from): What if the developer already has a detached HEAD in the
submodule?

How does he attach to a branch? For this we need something similar to
Francescos attach/detach or Trevors submodule checkout with Junio's checkout
HEAD~0 from here[1].

I am still undecided how we should call it. Because of my

Idea for feature branch support
- -------------------------------

For the branch attaching feature I would also like something that can actually
modify .git/config and for me more importantly .gitmodules.

So e.g. if I want to work on a longer lived feature branch in a submodule which
I need in a feature branch in the superproject I would do something like this:

$ git submodule checkout --gitmodules --merge -b hv/my-cool-feature

Which should create a local feature branch hv/my-cool-feature in the submodule,
checkout that branch and modify .gitmodules (because of --gitmodules) to have
submodule.<name>.update=merge, submodule.<name>.branch=hv/my-cool-feature and
stage that to the index.

This is a temporary setting so everyone who is working together can update
their branches easily. Once finished (with the prove that the big feature in
the superproject works) everyone can go and polish the submodule branches,
get their changes accepted there first, and then the update/branch setting
local for this branch will be dropped. In this workflow these settings never
enter a stable branch but are still very useful to transport this information
while developing.

Just an idea of a future extension we should keep in mind when designing the
command to attach to a branch. But maybe the command to configure this should
be completely independent from checkout. I.e.:

git submodule checkout - syncs to a possible update/branch
git submodule attach   - creates a submodule branch and configures
			 update/branch in .git/config or .gitmodules
git submodule detach?  - reverse attach

or maybe --attach and --detach in this scenario could be options to checkout?

Still unsure...

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/240097
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iEYEARECAAYFAlLMggIACgkQjLR3Aoip+rpoMACgpn4XzDD4CvD+HCi8coIlwueP
gQUAn1v1BSJ+k8IJT7S/hwtojT+sUmgP
=GGTX
-----END PGP SIGNATURE-----
