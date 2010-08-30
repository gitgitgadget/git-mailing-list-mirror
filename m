From: Jeff King <peff@peff.net>
Subject: Re: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sun, 29 Aug 2010 23:08:19 -0400
Message-ID: <20100830030819.GA25415@sigill.intra.peff.net>
References: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 05:08:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpujE-0001pQ-2E
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 05:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab0H3DIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 23:08:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51457 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390Ab0H3DIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 23:08:05 -0400
Received: (qmail 16747 invoked by uid 111); 30 Aug 2010 03:08:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 30 Aug 2010 03:08:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Aug 2010 23:08:19 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154756>

On Sun, Aug 29, 2010 at 08:30:15PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I have this alias in my .gitconfig:
>=20
>     review =3D "!f() { for rev in $(git rev-list --reverse \"$@\"); d=
o
> git show $rev; done; }; f"
>=20
> I use it after I "git pull" to see what changed, e.g.:
>=20
>     git review 49ea7b8..e1ef3c1

It took me a minute of reading this to see why you would want to call
"git show" in a loop when you could have the same data from "git log"
all at once (and much faster, too). But I guess you like having an
individual less invocation for each commit. Have you tried "tig", which
might suit your purpose even better?

> But sometimes I find that I want to do that for other things too, so =
I
> have these hacks:
>=20
>     review-grep =3D "!f() { for rev in $(git log --reverse
> --pretty=3Dformat:%H --grep=3D\"$@\"); do git show $rev; done; }; f"
>     review-file =3D "!f() { for rev in $(git log --reverse
> --pretty=3Dformat:%H \"$@\"); do git show $rev; done; }; f"
>=20
> But just now I wanted to use -S instead of grep, but adding aliases
> like this is a bit silly.

I don't understand why you have these at all. Just use "git log
--format=3D%H" in your git review above (instead of rev-list), and then
you can just do:

  git review --grep=3Dwhatever
  git review -Sfoo
  git review file

Or am I missing something subtle?

You wouldn't even need to switch to log over rev-list, except that
rev-list misses log's useful "default to HEAD if no revisions given"
behavior.

> Maybe we should have something like:
>=20
>     git log --for-each=3Dless a..b
>=20
> To call "less" for each commit, what do you think?

I think it is not very Unix-y. We already have many ways to to call a
command once per commit, including:

  - for i in `git rev-list "$@"`; do git show $i; done

  - git rev-list "$@" | xargs -n 1 git show

  - git log -z "$@" | perl -0ne 'open(LESS, "|less"); print LESS'

What does your solution offer that the other do not? Because you are
actually reinvoking git for each commit, it is more efficient than the
first two (as you seem to assume that the --for-each command will
receive the entire log output). But the third one should be more or les=
s
equivalent to what you want (though note: if you want tty-ish things
like color on, you should set GIT_PAGER_IN_USE=3D1 so git knows output =
is
eventually going to a pager). Sure, yours is slightly less typing, but
it's _way_ less flexible, and that typing should probably be hidden
behind an alias anyway.

-Peff
