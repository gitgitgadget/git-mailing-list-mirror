From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] upload-pack: provide a hook for running pack-objects
Date: Thu, 26 May 2016 01:37:58 -0400
Message-ID: <20160526053758.GA21580@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224537.GF22443@sigill.intra.peff.net>
 <CACBZZX5SVJ2CSB0AS3Lj1A8_S+ejGOPUDn6Sc3whotkyFwxEiA@mail.gmail.com>
 <20160519120848.GC3050@sigill.intra.peff.net>
 <CACBZZX7nuy3RYPQ5e_FFqvCTStZka49ZSNNe9q2agffa7fp-EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 07:38:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5nzm-0003rf-3H
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 07:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbcEZFiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 01:38:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:44465 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbcEZFiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 01:38:02 -0400
Received: (qmail 7973 invoked by uid 102); 26 May 2016 05:38:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 01:38:01 -0400
Received: (qmail 17165 invoked by uid 107); 26 May 2016 05:38:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 01:38:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 01:37:58 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX7nuy3RYPQ5e_FFqvCTStZka49ZSNNe9q2agffa7fp-EA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295634>

On Thu, May 19, 2016 at 04:54:37PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > This is the "could we just set a bool" option I discussed in the co=
mmit
> > message. The problem is that it doesn't let the admin say "I don't =
trust
> > these repositories, but I _do_ want to run just this one hook when
> > serving them, and not any other hooks".
>=20
> Indeed. I wonder if there's really any overlap in practice between
> systems administrators on a central Git server that are going to want
> this relatively obscure feature *but* have potentially malicious user=
s
> / repos, or enough to warrant this unusual edge case in how this
> specific hook is configured, as opposed to reducing the special case
> in how the hook is run with something like core.runDangerousHooks.

I dunno. Certainly I am not running such a site. But something like
kernel.org might fit into that boat. For a long time I think people had
actual shell accounts and a common git-daemon served the repositories. =
I
think that these days it might be more locked-down, though.

> I'm definitely not saying that these patches should be blocked by
> this, but it occurs to me that both your uploadpack.packObjectsHook
> implementation and my proposed core.runDangerousHooks which normalize=
s
> it a bit in some ways, but leaves it as a special case in others, are
> both stumbling their way toward hacks that we might also solve with
> some generally configurable restrictions system that takes advantage
> of your earlier patches, e.g.:
>=20
>     $ cat /etc/gitconfig
>     # Not "repository" so hooksPath can't be set per-repo
>     [core]
>         configRestriction                 =3D "core.hooksPath: system=
, global"

I was hoping to avoid setting up configuration restriction via the
configuration files, if only because it implies some ordering in the
parsing. So for example, you'd need to do a separate pass to load the
restrictions system, and then actually parse the config.

I guess that's not too bad with the caching system that's in place,
though.

> Of course those are some rather large hoops to jump through just to
> accomplish this particular thing, but it would be more generally
> composable and you could e.g. say users can't disable gc.auto or
> whatever on their repos if they're hosted on your server. Which of
> course assumes that you control the git binary and they can't run
> their own.

Yeah, I was also hoping to avoid something too baroque. :) I don't know
if there's much value in restricting things like gc.auto. If they can
make arbitrary edits to the config file, they can run arbitrary code. I
think this is _just_ about protecting a git-daemon serving the untruste=
d
repositories (or a user fetching from an untrusted other-user on the
system).

> Yeah, the reason I'm prodding you about this is because I want to tes=
t
> this out at some point, and a *really* nice thing about the Git
> configuration facility is that you can test all these sorts of things
> on a per-repo basis now due to how all the git-config variables work
> now.
>=20
> With uploadpack.packObjectsHook you *can* do that by defining a globa=
l
> pass-through hook, but it makes it more of a hassle to test changes
> that straddle the divide between testing & production.

One thing I didn't elaborate on is that the "don't respect this key fro=
m
the repo config" could be made more featureful. For example, your
core.allowDangerousHooks could just as easily be an environment
variable: $GIT_ALLOW_DANGEROUS_CONFIG. [1]=20

And then you could set that on your servers, and only set
uploadpack.packObjectsHook in the repositories you wanted, achieving
your goal.

This does still leave the pack-objects hook unlike the other hooks (in
that it leaves the command in the config rather than in a script), but =
I
actually like that flexibility. Being able to use "git -c" to set the
hook for a one-shot invocation is kind of nice (though you do have to d=
o
tricks with "--upload-pack=3D" to get it to cross the remote boundary).

-Peff

[1] We also talked long ago (in the v1.6.x days, regarding a
post-upload-pack hook) of auto-enabling "dangerous" hooks when getuid()
matched the owner of the hook. We could do the same thing for the confi=
g
file (though TBH, it is confusing enough of a rule that I think I prefe=
r
something like the explicit environment variable).
