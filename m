From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: don't consider branch lagging behind as
	errors.
Date: Thu, 19 Jun 2008 11:11:10 -0400
Message-ID: <20080619151110.GA31654@sigill.intra.peff.net>
References: <1213872715-11182-1-git-send-email-madcoder@debian.org> <20080619133747.GA31209@sigill.intra.peff.net> <20080619135159.GA19560@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 17:12:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Lo4-0007cn-Dl
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 17:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYFSPLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 11:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbYFSPLN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 11:11:13 -0400
Received: from peff.net ([208.65.91.99]:1921 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbYFSPLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 11:11:12 -0400
Received: (qmail 18920 invoked by uid 111); 19 Jun 2008 15:11:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 19 Jun 2008 11:11:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2008 11:11:10 -0400
Content-Disposition: inline
In-Reply-To: <20080619135159.GA19560@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85482>

On Thu, Jun 19, 2008 at 03:52:00PM +0200, Pierre Habouzit wrote:

> >   http://thread.gmane.org/gmane.comp.version-control.git/73038/focu=
s=3D73186
> [...]
> >   - should stale branches be shown without -v?
>=20
>   I believe so, it's valuable information. It's as valuable as what y=
ou
> get after a git fetch nowadays (like branches have diverged n and m
> commits each or similar) But oh well=E2=80=A6 I don't care that much.

If you read the beginning of that thread, the original impetus was
people cloning repos that had dozens of branches, then doing a push.
If they hadn't recently done a fetch, they got dozens of lines of
"rejected".

> >   - calling ref_newer here is inefficient, since we have already ca=
lled
> >     it in the other direction. We should probably do the traversal =
once
> >     in such a way as to find out which ref is newer (or if it is
> >     indeterminate).
>=20
>   Well, true, though I don't expect people to have tons of local
> branches that match a refspec _and_ lag behind. I suspect this is a v=
ery
> minor performance loss.

Yeah, maybe it is not worth worrying about; I haven't actually measured
any performance issue. I'll try to look and see how painful it is to
combine the traversals.

> >   - there is a possible danger with "git push -f", in that you forc=
e
> >     both rejected branches as well as stale branches. Junio and I
>   Well afaict this is a separate issue, as we're (with such a patch)
> only changing what gets printed on the console, not the internal
> behavior. So solving this second issue should not really be a
> precondition to the inclusion of such a patch.

It is a separate issue, but it is exacerbated by hiding stale refs.
Imagine:

$ git push
To /path/to/repo
   ! [rejected]        master -> master (non-fast forward)

$ git push -f
To /path/to/repo
   + 0abfa88...c1ed93b master -> master (forced update)
   + 0329485...3498576 stale_branch -> stale_branch (forced update)

I think that is a nasty surprise to spring on an unsuspecting user.
Another solution might be "-f" not pushing rewound branches, but then w=
e
need a way to specify "no, really, push this rewound branch". Perhaps
"-f -f"?

>   Please please please do :)
>   The exit 1 of git-push is really annoying me these days.

OK, I will try to take a look in the next few days.

-Peff
