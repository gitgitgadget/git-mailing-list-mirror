From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] upload-pack: provide a hook for running pack-objects
Date: Thu, 19 May 2016 08:08:49 -0400
Message-ID: <20160519120848.GC3050@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224537.GF22443@sigill.intra.peff.net>
 <CACBZZX5SVJ2CSB0AS3Lj1A8_S+ejGOPUDn6Sc3whotkyFwxEiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 19 14:09:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3MlF-0000l7-Ma
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 14:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbcESMIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 08:08:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:41749 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754578AbcESMIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 08:08:52 -0400
Received: (qmail 12076 invoked by uid 102); 19 May 2016 12:08:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 May 2016 08:08:51 -0400
Received: (qmail 31537 invoked by uid 107); 19 May 2016 12:08:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 May 2016 08:08:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2016 08:08:49 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX5SVJ2CSB0AS3Lj1A8_S+ejGOPUDn6Sc3whotkyFwxEiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295057>

On Thu, May 19, 2016 at 12:12:43PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Thu, May 19, 2016 at 12:45 AM, Jeff King <peff@peff.net> wrote:
> >   3. You may want to insert a caching layer around
> >      pack-objects; it is the most CPU- and memory-intensive
> >      part of serving a fetch, and its output is a pure
> >      function[1] of its input, making it an ideal place to
> >      consolidate identical requests.
>=20
> Cool to see this on the list after we talked briefly about this at Gi=
t
> Merge. Being able to cache this so simply is a great optimization.
>=20
> As I recall you guys at GitHub ended up writing your own utility to
> cache output depending on stdin/argv because none existed already.

Yeah, we do have such a tool internally. It's possible we may one day
open-source that, but there aren't plans to do so right now.

I don't know whether this kind of caching would be useful to most sites
or not. It's good if you have lots of clients asking you for the same
thing at roughly the same time (say, somebody using "git pull" as a
deploy mechanism from their AWS cluster), but otherwise not.

> So do I understand correctly that you're trying to guard against the
> case where you e.g.:
>=20
>     rsync untrusted.example.com:/tmp/poison.git /tmp/
>     git clone /tmp/poison.git /tmp/safe.git
>=20
> Not hosing your system if the poison.git/config has a
> uploadpack.packObjectsHook that's "sudo rm -rf /".

I'm not that worried about this case, as it's just not that common.  I
think we're more concerned with two cases:

  1. multi-user servers where you ssh as yourself, but then access
     repositories owned by somebody else. This is basically the ssh cas=
e
     you described later.

  2. hosting sites that run git-daemon as the "daemon" user, but serve
     repositories owned by random untrusted users (where you would not
     want those users to run arbitrary code as "daemon").

> We've already accepted that "push" hooks like the pre-receive or
> update hook can do something malicious like this, so on one hand mayb=
e
> we should say if you scp raw *.git repositories with hooks this sort
> of thing might happen, or if you ssh to a remote box and run their
> per-repo hooks it's really their problem to make sure their users
> don't run malicious hooks on your behalf.

Yeah, we make no promises for repositories that you push to. It's _only=
_
for the fetching side. It's kind of a funny distinction, but it's one w=
e
have maintained since the beginning of git, and I do think there are
real sites that depend on it (see, e.g., the history of the
post-upload-pack hook added in the v1.6.x time frame).

Rsyncing a repository is generally of questionable safety. It's OK to
fetch from the result, but certainly not to run "git log" (which can ru=
n
arbitrary commands via external diff, etc).

> But as you point out this makes the hook interface a bit unusual.
> Wouldn't this give us the same security and normalize the hook
> interface:
>=20
>  * Don't do the uploadpack.packObjectsHook variable, just have a
> normal "pack-objects" hook that works like any other git hook
>  * By default we don't run this hook unless core.runDangerousHooks (o=
r
> whatever we call it) is true.
>  * The core.runDangerousHooks variable cannot be set on a per-repo
> basis using your new config facility.
>  * If there's a pack-objects hook and core.runDangerousHooks isn't
> true we warn "not executing potentially unsafe hook $path_to_hook" an=
d
> carry on

This is the "could we just set a bool" option I discussed in the commit
message. The problem is that it doesn't let the admin say "I don't trus=
t
these repositories, but I _do_ want to run just this one hook when
serving them, and not any other hooks".

> This would allow use-cases that are a bit inconvenient with your patc=
h
> (again, if I'm understanding it correctly):
>=20
>  * I can set core.runDangerousHooks=3Dtrue in /etc/gitconfig on my gi=
t
> server because I also control all the repos, and I want to experiment
> with trying this on a per-repo basis for users that are cloning from
> me.
>  * I can similarly play with this locally knowing I'm only cloning
> repos I trust by setting core.runDangerousHooks=3Dtrue in ~/.gitconfi=
g

Yes, those use cases are not well served by the git config alone. But
you can do them (and much more) once your trusted hook is running (by
checking $GIT_DIR, or looking in a database, or whatever you want).

-Peff
