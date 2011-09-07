From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] fetch: bigger forced-update warnings
Date: Wed, 7 Sep 2011 17:57:00 -0400
Message-ID: <20110907215700.GA27292@sigill.intra.peff.net>
References: <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
 <20110905204729.GB4221@sigill.intra.peff.net>
 <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
 <20110905205735.GA5578@sigill.intra.peff.net>
 <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com>
 <20110907212042.GG13364@sigill.intra.peff.net>
 <7vty8o10kj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:57:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Q7M-0006Kr-8V
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab1IGV5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:57:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51935
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab1IGV5D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:57:03 -0400
Received: (qmail 6830 invoked by uid 107); 7 Sep 2011 21:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 17:57:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 17:57:00 -0400
Content-Disposition: inline
In-Reply-To: <7vty8o10kj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180920>

On Wed, Sep 07, 2011 at 02:53:32PM -0700, Junio C Hamano wrote:

> > Some branches are expected to rewind, so the prominent
> > warning would be annoying. However, git doesn't know what
> > the expectation is for a particular branch. We can have it
> > guess by peeking at the lost couple of reflog entries. If we
> 
> s/lost/last/

Oops, thanks.

> This is slightly offtopic, but I have been wondering if this approach do
> the right thing for "git pull". Wouldn't the underlying "git fetch" give a
> warning, and then the calling "git pull" go ahead and make a merge,
> scrolling the warning away with the merge/update summary diffstat? That
> would be a larger change if "git pull" needs to stash away the warning
> message, do its thing and then spit out the warning later.

I think this particular warning has nothing to do with git-pull. But
rather, that we should _always_ abort a pull with a forced-update.
Because the only sane things to do there are:

  1. Stop and look around, and see if you should be doing a "git reset"
     first.

or

  2. "git pull --rebase"

But proceeding with the pull just seems like a disaster. So it is not
about "this usually fast forwards, but isn't now, so let's make the
warning bigger". It is more about noticing that it is a forced-update at
all. Maybe that's what you meant by "off-topic". :)

> > +static int forced_update_is_uncommon(const char *ref)
> > +{
> > +	struct update_counts uc;
> > +	memset(&uc, 0, sizeof(&uc));
> > +	if (for_each_recent_reflog_ent(ref, count_updates, 4096, &uc) < 0)
> > +		for_each_reflog_ent(ref, count_updates, &uc);
> > +	return uc.fastforward && uc.forced <= 1; /* 1 for the one we just did */
> > +}
> 
> Looks sensible.

Now we just need to paint the shed. :)

-Peff
