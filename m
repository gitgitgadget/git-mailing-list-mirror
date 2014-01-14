From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 21:58:30 +0100
Message-ID: <20140114205830.GA838@sandbox-ub>
References: <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
 <20140114165709.GH7078@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 14 21:58:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3B4R-0004WS-Qb
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 21:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbaANU6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 15:58:44 -0500
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:43698 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaANU6n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 15:58:43 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W3B4G-0004R1-10; Tue, 14 Jan 2014 21:58:36 +0100
Content-Disposition: inline
In-Reply-To: <20140114165709.GH7078@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240413>

On Tue, Jan 14, 2014 at 08:57:09AM -0800, W. Trevor King wrote:
> > > On Thu, Jan 09, 2014 at 10:40:52PM +0100, Jens Lehmann wrote:
> > > > Am 09.01.2014 20:55, schrieb W. Trevor King:
> > > > > Maybe you meant "for checkout I can easily overwrite the loca=
l
> > > > > changes with the upstream branch", which is what I understand
> > > > > checkout to do.
> > > >=20
> > > > But which I find really unfriendly and would not like to see in
> > > > a new feature. We should protect the user from loosing any loca=
l
> > > > changes, not simply throw them away. Recursive update makes sur=
e
> > > > it won't overwrite any local modification before it checks out
> > > > anything and will abort before doing so (unless forced of
> > > > course).
> > >=20
> > > If you want to get rid of checkout-mode updates, I'm fine with
> > > that.  However, I don't think it supports use-cases like Heiko's
> > > (implied) =E2=80=9CI don't care what's happening upstream, I neve=
r touch
> > > that submodule, just checkout what the superproject maintainer
> > > says should be checked out for this branch.  Even if they have
> > > been rebasing or whatever=E2=80=9D [3].
> >=20
> > I never stated that in that post.
>=20
> Sorry for misunderstanding.  I think I'm just unclear on your
> workflow?

Yes probably. We mostly use submodules for shared code and for tracking
external libraries. For the shared code we want to make sure that
the changes that come from one project do not break anything in another
project that also uses that code so the submodules are maintained and
reviewed separately and ideally contain tests for the expected
functionality.

A typical workflow where a feature in a project needs some extension or
change in a submodule goes like this:

1. The developer does his changes locally implementing everything
   needed. To commit he creates a local branch in the submodule and in
   the superproject (most of the times from the current HEAD that is
   checked out).

2. For convenience I usually commit the resulting commit sha1 of the
   submodule in the commit that needs the change. That way when I switc=
h
   to a different branch and back I can simply say: git submodule updat=
e
   and get the correct code everywhere.

3. Once done with the whole feature I first do the review process
   (adding any missing tests to ensure my change does not break, ...)
   for the submodule to get the feature branch merged into a stable one=
=2E
   In our superproject only commits sha1 from a stable branch are
   allowed so the submodule change needs to be reviewed first.

4. Once the change is in a stable branch in the submodule I then update
   the commit sha1 link in the superproject that needs the change. That
   is usually done by rebasing the branch in the superproject and
   registering the new stable branch (typically master).

5. Then I proceed with the review process in the superproject as if it
   was a normal change without a submodule.

Thats our main use case.

> > The recursive checkout Jens is working on is simply implementing th=
e
> > current checkout-mode to the places where the superproject checks
> > out its files. That way submodules get checked out when the
> > superproject is checked out. If the submodule does not match the
> > sha1 registered in the superproject it either stays there (if the
> > checkout would not need to update the submodule) or (if checkout
> > would need to update) git will not do the checkout and bail out wit=
h
> > "you have local modifications to ... .
>=20
> Sounds good to me as far as it goes.  I think it misses the =E2=80=9C=
what
> should we do if the gitlinked hashes are different=E2=80=9D case, bec=
ause the
> checkout will always leave you with a detached HEAD.
>=20
> > > > or be asked to resolve the conflict manually when "checkout" is
> > > > configured and the branches diverged.
> > >=20
> > > I still think that checkout-mode updates should be destructive.
> > > See my paraphrased-version of Heiko's use case above.  How are
> > > they going to resolve this manually?  Merge or rebase?  Why
> > > weren't they using that update mode in the first place?
> >=20
> > I strongly disagree. They should only be destructive in the sense
> > that another commit get checked out but never loose local
> > modifications.
>=20
> I think the key I'm missing is an example workflow where a developer
> wants to make local submodule changes, but also wants to use
> checkout-mode updates instead of merge/rebase updates.  Can you sketc=
h
> one out for me?

How about the use-case I sketched above? Is that what you are searching
for? In that use-case we have to update to the new master after a
submodule change was merged. That could be achieved by

	git submodule update --remote <submodule>

with the wanted stable branch configured. But in practise something
along the lines of

	(cd <submodule> && git checkout origin/<stable>)

is usually used and simple enough.

We have a tool in our git gui configuration that does

	git submodule foreach 'git fetch && git checkout origin/master'

which can be used by the maintainer before a release to ensure that all
submodules are up-to-date. But in practise it turn out that all
submodules are fairly current since everyone is adding features to the
quite frequently and thus pulling in the current version automatically.

I hope that draws a clear picture of how we use submodules.

Cheers Heiko
