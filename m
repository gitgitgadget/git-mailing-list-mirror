From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Utilize config variable pager.stash in stash list command
Date: Tue, 16 Aug 2011 15:56:40 -0700
Message-ID: <20110816225639.GA20050@sigill.intra.peff.net>
References: <20110815234714.GB4699@sigill.intra.peff.net>
 <4e4a4743.4e230d8a.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 17 00:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtSYz-00020f-GV
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 00:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab1HPW4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 18:56:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54920
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab1HPW4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 18:56:43 -0400
Received: (qmail 6963 invoked by uid 107); 16 Aug 2011 22:57:22 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Aug 2011 18:57:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2011 15:56:40 -0700
Content-Disposition: inline
In-Reply-To: <4e4a4743.4e230d8a.bm000@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179483>

On Tue, Aug 16, 2011 at 12:10:45PM +0200, Ingo Br=C3=BCckl wrote:

> > http://thread.gmane.org/gmane.comp.version-control.git/161756/focus=
=3D161771
>=20
> Actually, I only wanted to change the stash list behavior (but better=
 should
> have used $(git config --get pager.stash.list) for that). Unfortunate=
ly, it
> is impossible then to force the pager with --paginate again.
>=20
> > I think what it really needs is more testing to see if looking at t=
he
> > config then has any unintended side effects.
>=20
> Yours surely is a far better approach, although it only can handle th=
e main
> command (stash), not the sub-command (list), but this is totally in
> accordance with everything else in git.

Yeah, that is a general problem with git's pager handling. We only have
one context: a single git command. But some commands may have multiple
subcommands, and a pager only makes sense for some of them.

You've run into it for "stash show", but it is no different than
something like "git branch". You might want the list of branches to go
through a pager, but almost certainly not branch creation or deletion
operations.

I think something like pager.stash.list is the right way forward. But
your patch by itself isn't enough. It only handles the negative case.
Setting "pager.stash.list" to "true" would do nothing.

> With "pager.stash false" (which would then require --paginate for a l=
ot of
> stash commands), I found that a paginated output of 'git -p stash sho=
w -p'
> loses the diff colors, but that seems unrelated to your patch. It sti=
ll is
> strange though.

We auto-detect whether to use colors based on whether we are outputting
to a terminal or not. If we start the pager ourselves, we will also
output colors (unless color.pager is false). I suspect the "pager in
use" flag is not making it to the external command.

-Peff
