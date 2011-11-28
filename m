From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Mon, 28 Nov 2011 03:27:58 -0500
Message-ID: <20111128082758.GD16901@sigill.intra.peff.net>
References: <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
 <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
 <20111126235135.GA7606@sigill.intra.peff.net>
 <CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
 <20111127000603.GA7687@sigill.intra.peff.net>
 <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com>
 <7vzkfgvjdo.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hX3fEf1nL28yxASLw_cveJbC5aQRdixgBF6zaPyAEsdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 09:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUwZM-0006yX-3S
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 09:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab1K1I2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 03:28:01 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53965
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab1K1I2B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 03:28:01 -0500
Received: (qmail 22523 invoked by uid 107); 28 Nov 2011 08:34:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Nov 2011 03:34:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Nov 2011 03:27:58 -0500
Content-Disposition: inline
In-Reply-To: <CAMK1S_hX3fEf1nL28yxASLw_cveJbC5aQRdixgBF6zaPyAEsdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186005>

On Mon, Nov 28, 2011 at 01:47:44PM +0530, Sitaram Chamarty wrote:

> > Jeff may be right that any approach based on hooks cannot be made totally
> > safe. But the discussion can lead to a workable alternative. The "enable
> > the hook only on git:// and http:// and no other" approach might or might
> > not be such a workable alternative. The "try talking to a service process
> > via named pipe, instead of spawning a hook" might or might not be such a
> > workable alternative. Other possibilities may be there to be explored.
> 
> There are only 2 cases: git-upload-pack runs as invoking user, or it
> runs as some common user/repo owner.

I think it is slightly more complicated. You may have a common user, but
that user may or may not trust the contents of the repo on disk (e.g.,
a system daemon serving repos for arbitrary users).

> I see pre-upload hooks for case 1 as being hard/impossible to do,
> while case 2 is trivial (just check if the hook file owner == UID of
> the git-upload-pack process).

The UID check doesn't quite tell you what you want. If I am in a shared
repo situation with a liberal umask and I write a hook, it will have my
UID. But it may have group-write permissions. Other people in my group
can write arbitrary contents to the file, but it will retain my UID, and
git's check will think the code is OK to run.

> Yes, this means pre-upload won't work identically in *all* setups.
> But as you said somewhere: perfect is the enemy of good.

Yes, I think we have to accept inconsistency if we have them at all.
Because such hooks are dangerous in some setups, and OK in others. So no
matter what the rule for determining danger, they will sometimes run and
sometimes not.

-Peff
