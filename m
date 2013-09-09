From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 9 Sep 2013 16:44:16 -0400
Message-ID: <20130909204415.GC14536@sigill.intra.peff.net>
References: <20130908041805.GB14019@sigill.intra.peff.net>
 <CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
 <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
 <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
 <20130909000153.GG5359@vauxhall.crustytoothpaste.net>
 <CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
 <vpqr4cy4g5q.fsf@anie.imag.fr>
 <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
 <20130909195231.GA14021@sigill.intra.peff.net>
 <20130909202435.GJ2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Sep 09 22:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ8Jr-00082j-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 22:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab3IIUoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 16:44:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:57854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498Ab3IIUoS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 16:44:18 -0400
Received: (qmail 25393 invoked by uid 102); 9 Sep 2013 20:44:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Sep 2013 15:44:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Sep 2013 16:44:16 -0400
Content-Disposition: inline
In-Reply-To: <20130909202435.GJ2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234371>

On Mon, Sep 09, 2013 at 09:24:35PM +0100, John Keeping wrote:

> > I think that would address the concern I raised, because it does not
> > create a roadblock to new users accomplishing their task. They can
> > ignore the warning, or choose "merge" as the default to shut up the
> > warning (and it is easy to choose that if you are confused, because it
> > is what git is doing by default alongside the warning).
> 
> I think we need to make sure that we give instructions for how to go
> back if the default hasn't done what you wanted.  Something like this:
> 
>     Your pull did not fast-forward, so Git has merged '$upstream' into
>     your branch, which may not be correct for your project.  If you
>     would rather rebase your changes, run
> 
>         git rebase
> 
>     See "pull.mode" in git-config(1) to suppress this message in the
>     future.

Yes, that's a good point. I don't know if just "git rebase" is the right
advice, though; it would depend on whether we were actually pulling from
the upstream or not.

I wonder if we have sufficient information at the time of the warning to
print out the actual "git rebase" invocation that would rebase as if
they had run "pull --rebase". I think we may have to do a little
refactoring around the base selection from the reflog (IIRC, git-pull
does not even calculate it at all if you are not using --rebase).

It is also depending on "git rebase" throwing away the merge commit we
just created. Which I think should happen always if you have not
configured anything (though perhaps we will eventually support a pull
mode that does "rebase -p", you would not see this warning with that
option anyway). But another option would be to simply tell them:

  git reset --keep HEAD^
  git pull --rebase [X...]

where "[X...]" is the arguments they gave to rebase in the first place.
That looks a little less friendly, though.

-Peff
