From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 11:24:45 +0100
Message-ID: <20140114102445.GA27915@sandbox-ub>
References: <20140108010504.GE26583@odin.tremily.us>
 <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Jan 14 11:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W31Bl-0002hb-GV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 11:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbaANKZG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jan 2014 05:25:06 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:34046 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaANKZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 05:25:03 -0500
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1W31B3-0000dp-BG; Tue, 14 Jan 2014 11:24:57 +0100
Content-Disposition: inline
In-Reply-To: <20140109221840.GW29954@odin.tremily.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240394>

Hi,

On Thu, Jan 09, 2014 at 02:18:40PM -0800, W. Trevor King wrote:
> On Thu, Jan 09, 2014 at 10:40:52PM +0100, Jens Lehmann wrote:
> > Am 09.01.2014 20:55, schrieb W. Trevor King:
> > > On Thu, Jan 09, 2014 at 08:23:07PM +0100, Jens Lehmann wrote:
> > >> Am 09.01.2014 18:32, schrieb W. Trevor King:
> > >>>> later updates,
> > >>>
> > >>> The same thing that currently happens, with the exception that
> > >>> checkout-style updates should use reset to update the
> > >>> currently-checked out branch (or detached-HEAD), instead of
> > >>> always detaching the HEAD.
> > >>
> > >> Won't the user loose any modifications to his local branch here?
> > >=20
> > > They just called for a checkout-style update, so yes.  If they
> > > want to keep local modifications, chose an integration mode that
> > > preserves local changes.
> >=20
> > Hmm, as current "submodule updates" already makes it too easy to
> > loose commits, this does not look right to me. I'd prefer to stop a=
t
> > that point and tell the user what he can do to solve the conflict.
>=20
> Users who are worried about loosing local updates should not be using
> a checkout-style updates.  If they are using a checkout-style update,
> and they ask for an update, they're specifically requesting that we
> blow away their local work and checkout/reset to the new sha1.
> Solving update conflicts is the whole point of the non-checkout updat=
e
> modes.

But checkout is different from reset --hard in that it does not blow
away local uncommitted changes. Please see below.

> > > Maybe you meant "for checkout I can easily overwrite the local
> > > changes with the upstream branch", which is what I understand
> > > checkout to do.
> >=20
> > But which I find really unfriendly and would not like to see in a
> > new feature. We should protect the user from loosing any local
> > changes, not simply throw them away. Recursive update makes sure it
> > won't overwrite any local modification before it checks out anythin=
g
> > and will abort before doing so (unless forced of course).
>=20
> If you want to get rid of checkout-mode updates, I'm fine with that.
> However, I don't think it supports use-cases like Heiko's (implied) =E2=
=80=9CI
> don't care what's happening upstream, I never touch that submodule,
> just checkout what the superproject maintainer says should be checked
> out for this branch.  Even if they have been rebasing or whatever=E2=80=
=9D
> [3].

I never stated that in that post. Even with the current checkout-mode
updates you'll never loose local modifications (without force) that are
not committed. I think you have to distinguish between local
modifications in the worktree and the ones that are committed.

The recursive checkout Jens is working on is simply implementing the
current checkout-mode to the places where the superproject checks out
its files. That way submodules get checked out when the superproject is
checked out. If the submodule does not match the sha1 registered in the
superproject it either stays there (if the checkout would not need to
update the submodule) or (if checkout would need to update) git will no=
t
do the checkout and bail out with "you have local modifications to ... =
=2E

I think the whole recursive checkout topic is already complicated enoug=
h
as it is so we should currently not add anything from this discussion t=
o
it until it is cleaned up and merged. We also need recursive fetch for
that which I am planning to work on as soon as we settle this
discussion. I will write another post about how I think we should/can
proceed.

> > or be asked to resolve the conflict manually when "checkout" is
> > configured and the branches diverged.
>=20
> I still think that checkout-mode updates should be destructive.  See
> my paraphrased-version of Heiko's use case above.  How are they going
> to resolve this manually?  Merge or rebase?  Why weren't they using
> that update mode in the first place?

I strongly disagree. They should only be destructive in the sense that
another commit get checked out but never loose local modifications.

> [1]: http://article.gmane.org/gmane.comp.version-control.git/240251
> [2]: http://article.gmane.org/gmane.comp.version-control.git/240248
> [3]: http://article.gmane.org/gmane.comp.version-control.git/240013

Cheers Heiko
