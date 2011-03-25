From: Jeff King <peff@peff.net>
Subject: Re: Confusing error message due to Git trusting is_bare_repository()
Date: Fri, 25 Mar 2011 14:25:36 -0400
Message-ID: <20110325182536.GC25851@sigill.intra.peff.net>
References: <AANLkTi=9CpMU9aZs2zuvRyv3rpECkRAvYA0Srnc61whg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:25:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3Bhh-0006Cv-80
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 19:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab1CYSZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 14:25:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51139
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754525Ab1CYSZj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 14:25:39 -0400
Received: (qmail 16412 invoked by uid 107); 25 Mar 2011 18:26:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 14:26:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 14:25:36 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=9CpMU9aZs2zuvRyv3rpECkRAvYA0Srnc61whg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170013>

On Fri, Mar 25, 2011 at 11:56:20AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I had a co-worker git this well-known error message:
>=20
>     error: refusing to update checked out branch: refs/heads/master
>     error: By default, updating the current branch in a non-bare repo=
sitory
>     error: is denied, because it will make the index and work tree in=
consistent
>     error: with what you pushed, and will require 'git reset --hard' =
to match
>     error: the work tree to HEAD.
>=20
> It *was* a bare repo, but the config file had bare=3Dfalse because
> someone had simply copied a .git tree from a non-bare repo to make it=
=2E

That seems like the problem there. I'm not blaming the user; what they
expected to happen is reasonable, and even used to work. But I wonder i=
f
better education is possible.

> The issue is that we just use this:
>=20
>     int is_bare_repository(void)
>     {
>         /* if core.bare is not 'false', let's see if there is a work =
tree */
>         return is_bare_repository_cfg && !get_git_work_tree();
>     }

> For the purposes of the error message it would be helpful if we also
> detected whether something didn't have a working tree, but was set to
> bare=3Dfalse, and tell the user to updatet he bare=3Dfalse to bare=3D=
true
> for his almost-bare repository.

How do we know whether or not it has a working tree? Can't I do
something like:

  cd /var/working-trees/foo
  git init
  mv .git /var/repositories/foo.git
  export GIT_DIR=3D/var/repositories/foo.git
  echo content >file && git add file && git commit -m foo

I thought the reason that core.bare was introduced was to handle weird
cases like this.

-Peff
