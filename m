From: Jeff King <peff@peff.net>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 21 Nov 2011 17:19:34 -0500
Message-ID: <20111121221934.GA21882@sigill.intra.peff.net>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
 <20111114103451.GA10847@sigill.intra.peff.net>
 <4ECACC13.7050507@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Brenner <olsner@gmail.com>, git@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 23:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RScDG-00077A-E7
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 23:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481Ab1KUWTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 17:19:37 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48845
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab1KUWTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 17:19:36 -0500
Received: (qmail 23909 invoked by uid 107); 21 Nov 2011 22:19:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Nov 2011 17:19:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Nov 2011 17:19:34 -0500
Content-Disposition: inline
In-Reply-To: <4ECACC13.7050507@cfl.rr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185766>

On Mon, Nov 21, 2011 at 05:09:23PM -0500, Phillip Susi wrote:

> I hacked together a setup a few weeks ago that doesn't suffer from
> that problem.  I had two repos that had considerable shared history (
> one forked from the other ), so I created a temporary repository and
> pointed its alternates to the other two.  I then did some shell magic
> to generate a list of all objects shared by both repos, and sent that
> list to git-pack-objects.  This gave me a pack file in the temp repo
> that contained all of the shared objects.  I then made a .keep file
> and hard linked this pack file ( and index, and .keep file ) into
> both original repos, deleted the temp repo, and then repacked both
> original repos. This left them both with two pack files: one that is
> shared, and one that is all of the objects specific to that repo.
> 
> Because the shared objects are in a pack file that both repos hard
> link to, neither one will break if I (re)move the other.

Yes, that is one way to do it. The big drawback there is that by using
hard links, you can only share objects between repos within the same
filesystem.

I think the presence of the '.keep' files should make "git gc" do the
right thing, and not waste space. The relinking procedure is a little
more complex, but that's not a big deal. It's just a periodic
maintenance thing that will happen inside a script (and you would want
to do the periodic maintenance as often as you would with the shared
repo approach).

Nothing is maintaining the list of "here are all of the related repos
that are sharing objects".  Which is a feature in some ways, because you
don't have to care if repos go away or move. But when your periodic "git
relink" comes around, the burden is on the user to redecide the set of
related repos.

So unlike with the shared repo, where "git gc" in a child repo could say
"Oh, I have a shared parent; I should go there and do the parent-gc
there", relinking would be a more manual thing. On the other hand,
nothing is stopping you from building something more automated around
this relink-repos-together building block.

So yeah, I think it's a perfectly reasonable approach, if you don't mind
the hard link requirement, and your relink is something like "git relink
~/linux-repos/*".

Patches? :)

-Peff
