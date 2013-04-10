From: Jeff King <peff@peff.net>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 00:13:43 -0400
Message-ID: <20130410041343.GB795@sigill.intra.peff.net>
References: <CALkWK0nYECHZaxit9jR-tS=7fXyOP5dy6mqUz0DKmbTRU-xRNw@mail.gmail.com>
 <20130318170804.GA15924@sigill.intra.peff.net>
 <CALkWK0k2a6DSUodhKjRFKGvE1Rb_QmFgpy=Pvbu2Q=nGNYuByA@mail.gmail.com>
 <7vzjx7sj9u.fsf@alter.siamese.dyndns.org>
 <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org>
 <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 06:13:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPmPz-0001fb-9a
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 06:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab3DJENu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 00:13:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37077 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab3DJENt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 00:13:49 -0400
Received: (qmail 31954 invoked by uid 107); 10 Apr 2013 04:15:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 00:15:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 00:13:43 -0400
Content-Disposition: inline
In-Reply-To: <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220658>

On Tue, Apr 09, 2013 at 06:19:01PM -0700, Junio C Hamano wrote:

> > 	git push -- master next; # push two refs to default remote
> 
> ... or default "push remote" if there is one, I presume?
> 
> As you are giving what to push, I am assuming that
> branch.$name.remote would not come into play in this case.

I would have assumed the opposite. We feed "push" two items: where to
push (dst), and what refspecs to push (refs). We may or may not have
each item. Here's what's possible today:

  dst=present, refs=present: (case 1)
    push to $dst, using $refs
  dst=present, refs=missing: (case 2)
    push to $dst, using refspecs from remote.$dst.push or push.default
  dst=missing, refs=missing: (case 3)
    push to remote.pushDefault, branch.*.remote, or "origin"; use
    refspecs from remote.$x.push or push.default, where $x is the remote
    we decide to use.

The missing case 4 is obviously:

  dst=missing, refs=present

And I would expect it to select the remote in the same way as case 3. In
other words, the "where" and the "what" are orthogonal, and the presence
or absence of one does not affect how the other is calculated (with the
exception that _if_ we have a configured remote, whether it was
specified by the user or calculated, we may use its config if no
refspecs are specified).

Do you want to explain your thinking? I'm guessing it has to do with the
fact that choosing branch.*.remote is about trying to push to the
configured upstream (even though we traditionally do _not_ take into
account branch.*.merge when doing so).

> > 	git push origin korg --; # push default refspec to 2 remotes, again
> 
> As you are _not_ saying what to push, I would expect
> branch.$name.remote may have to come into the picture, but because
> you are saying where to push, that is not the case.  What does
> "default refspec" mean in this context?  What "git push origin" (no refspecs)
> would push by default will be sent to "origin", and what "git push
> korg" (no refspecs) would push by default will be sent to "korg"?

Yeah, I would expect that each uses its own default refspec. That is,
the above command is exactly equivalent to:

  git push origin && git push korg

(possibly without the short-circuit behavior of "&&", but definitely
taking both into account in the exit code).

I'd also be fine if we punted on the multiple remotes thing for now. You
can accomplish it easily in the shell, as I showed above (and it is not
any less efficient, since we have to make two network connections
anyway). Jonathan's syntax allows for 0 to N remotes alongside 0 to N
refspecs. The interesting new case (to me, anyway) is the 0 remotes, >0
refspecs case. But we don't have to handle >1 remotes now; once we have
the syntax in place, we can make it work later when we've decided on the
semantics.

-Peff
