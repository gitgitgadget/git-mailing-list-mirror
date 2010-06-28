From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] git --paginate: do not commit pager choice too
 early
Date: Mon, 28 Jun 2010 06:22:01 -0400
Message-ID: <20100628102201.GA24817@coredump.intra.peff.net>
References: <20100626192203.GA19973@burratino>
 <20100628094033.GA18629@coredump.intra.peff.net>
 <20100628101335.GA5007@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 12:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTBTl-00040y-Sq
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 12:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0F1KWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jun 2010 06:22:12 -0400
Received: from peff.net ([208.65.91.99]:50961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab0F1KWL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 06:22:11 -0400
Received: (qmail 21493 invoked by uid 107); 28 Jun 2010 10:23:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 28 Jun 2010 06:23:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jun 2010 06:22:01 -0400
Content-Disposition: inline
In-Reply-To: <20100628101335.GA5007@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149828>

On Mon, Jun 28, 2010 at 05:13:35AM -0500, Jonathan Nieder wrote:

> > But reading the message for patch 4/4, I can't help but wonder if t=
he
> > right way forward is for the git wrapper to _always_ find the repos=
itory
> > as the very first thing.
> [...]
> > the worst case should be a little bit of
> > wasted effort.
>=20
> This is a very useful thought.  Git without the chdir() to toplevel
> would be pleasanter, I think.  (Yes, I realize you weren=E2=80=99t ne=
cessarily
> suggesting suppressing a chdir_to_toplevel() in place of
> setup_git_repository() and friends.)

I had just meant that we would not do the chdir() initially, but would
do so right before running the actual command which wanted repository
setup (and commands like init which do not do that setup would never
chdir to the toplevel). But we must always run at least aliases and
external sub-commands from the toplevel to keep backwards compatibility=
=2E

> Regarding the repository search: automounters can cause pain if
> DISCOVERY_ACROSS_FILESYSTEM is set and GIT_CEILING_DIRECTORIES is not
> set appropriately.  An important script that does
>=20
>   tmpdir=3D$(mktemp -d)
>   cd "$tmpdir"
>   ...
>=20
>   git diff --no-index a b
>   ...
>=20
> could hang indefinitely if some nut has created a named pipe at
> /tmp/.git.  I haven=E2=80=99t come up with any non far-fetched reason=
 to mind
> the repository search, though.
>=20
> Will think about this.

Yeah, I considered that, too. But I doubt it is a big problem. If it
were, then just running "git log" when you are not in a repository woul=
d
be similarly painful. The people who have setups like that are already
having to deal with GIT_CEILING_DIRECTORIES to make things less painful
(though I imagine the new cross-filesystem discovery code will prevent
most of the pain without them having to actually do anything).

So yes, we are adding the extra lookup for commands like "git clone",
but I suspect in practice nobody will care. If it is a big deal, we can
do something like:

  if (!strcmp(cmd, "clone") || !strcmp(cmd, "init"))
     ... don't do setup ...

which I admit is a terrible hack, but it is an optimization, not a
correctness thing. So we are not shutting out external user-defined
commands that might not care about the repo. We are just making our
common built-in ones a bit more efficient.

-Peff
