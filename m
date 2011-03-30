From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] remote: separate the concept of push and fetch
 mirrors
Date: Wed, 30 Mar 2011 16:57:34 -0400
Message-ID: <20110330205734.GA2940@sigill.intra.peff.net>
References: <20110330195139.GA814@sigill.intra.peff.net>
 <20110330195318.GB30624@sigill.intra.peff.net>
 <7vhbakmj5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: chris <jugg@hotmail.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:57:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q52SZ-00009P-6x
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 22:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932908Ab1C3U5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 16:57:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34115
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252Ab1C3U5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 16:57:37 -0400
Received: (qmail 22003 invoked by uid 107); 30 Mar 2011 20:58:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 16:58:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 16:57:34 -0400
Content-Disposition: inline
In-Reply-To: <7vhbakmj5k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170424>

On Wed, Mar 30, 2011 at 01:45:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > git-remote currently has one option, "--mirror", which sets
> > up mirror configuration which can be used for either
> > fetching or pushing. It looks like this:
> >
> >   [remote "mirror"]
> >     url = wherever
> >     fetch = +refs/*:refs/*
> >     mirror = true
> >
> > However, a remote like this can be dangerous and confusing.
> 
> When --mirror was introduced at 3894439 (Teach "git remote" a mirror mode,
> 2007-09-02), it was only about fetching into a bare repository from
> another repository and there wasn't any confusion.
> 
> I knew about this potential confusion when we applied 84bb2df (Add a
> remote.*.mirror configuration option, 2008-04-17), but chose to be lazy
> and ignored the issue, thinking that users are intelligent enough not to
> mix these obviously incompatible modes of operation.  If a repository is a
> mirror to fetch from somebody else, you wouldn't develop in it in the
> first place, and you would definitely not push it back to where you are
> mirroring from.  If a repository is mirrored into somewhere else to
> publish your work in there, you wouldn't be fetching back from there to
> obliterate your work.
> 
> Being explicit like your series does is much safer than relying on "common
> sense".

I think the problem is not that users lack common sense. It is that we
give them an option called "--mirror" that sets up a bogus config in
some circumstances. So it is the git developers who lack common sense, I
think. :)

Specifically, 84bb2df should not have started setting "remote.*.mirror",
as it was already about fetching into a bare repository. And probably
--mirror in a non-bare repo should have complained from the beginning.

But hey, hindsight is 20/20.

> I briefly wondered if this affects one use case where you want to
> configure a bare repository at your firewall boundary as a relay that
> mirrors an external public repository of somebody else by fetching and
> then publishes that to a repository internal to your network by pushing,
> but in that case you would have two remotes (the external --mirror=fetch
> one, and the internal --mirror=push one) that are separate, so it is not
> an issue.

Exactly. I almost said in the commit message for 3/3 that you would
never ever want to have both remote.*.mirror set to true _and_ have
remote.*.fetch set to "+refs/*:refs/*". Because by deprecating --mirror,
we are saying that situation is not useful.

But I really don't think it is. The only instance I could think of would
be a case where you have two backup repos, and you might sometimes
mirror in one direction and sometimes in the other depending on some
external factors (e.g., which one you were last able to connect to from
some third repo). But even then, I think I would use two separate repos.

Not to mention that "git remote" is supposed to be a friendly helper. If
you want to do something crazy, you're welcome to "git config" it
yourself. :)

> Thanks for cleaning up the two-year old mess.

No problem. Two complaints in recent memory triggered my "OK, I guess
this is biting people" instinct. :)

-Peff
