From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: give early feedback
Date: Mon, 24 Jun 2013 14:55:46 -0400
Message-ID: <20130624185546.GA25306@sigill.intra.peff.net>
References: <1372095662-24527-1-git-send-email-artagnon@gmail.com>
 <20130624182809.GA15296@sigill.intra.peff.net>
 <CALkWK0=d1wkKWngH+6gBd-2svj7r_tgC5=+zUbgJRDfUCzupSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBve-0000i1-4T
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab3FXSzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 14:55:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:40697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab3FXSzs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 14:55:48 -0400
Received: (qmail 3229 invoked by uid 102); 24 Jun 2013 18:56:51 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Jun 2013 13:56:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jun 2013 14:55:46 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=d1wkKWngH+6gBd-2svj7r_tgC5=+zUbgJRDfUCzupSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228897>

On Tue, Jun 25, 2013 at 12:12:16AM +0530, Ramkumar Ramachandra wrote:

> >   1. It does not tell very much about how the refspecs are expanded or
> >      what is going to happen. "git push --dry-run" gives a much more
> >      complete view of what will be pushed.
> 
> Yes.
> 
>   $ git push
>   # pushing refspecs ':' to ram
> 
> Completely useless.
> 
> On the other hand, if I implement it at the transport layer like
> TRANSPORT_PUSH_DRY_RUN, it takes *way* too long to say anything
> useful; the whole "early" part has been thrown out the window.  The
> issue is again related to the same nightmare I'm having: not being
> able to implement @{push} refspec because the transport API is so
> tangled up; I can't call into the refspec-pattern-expander from
> anywhere else.

Leaving aside the transport API for a minute, you are always going to
have this lack-of-information versus time problem. A refspec like ":"
says nothing particularly useful, but it can only be expanded once
contact is made with the other side (which is what takes time).

I do not personally think the "early" information is particularly
useful. I don't have a problem with it as part of "-v" output (or
enabled by config), but it seems useless for enough cases (e.g., user
gave explicit refspecs, or refspecs are not useful without being
expanded) that showing it by default is going to be considered noisy
cruft by many users.

Was the unconditional nature of your earlier patch meant to be part of
the final version, or was it just illustrative?

> Yes, ^C is a hack, but it's useful in practice (there is ofcourse no
> guarantee): I've been saved many times by it.  The only way to prevent
> the race is to wait (either indefinitely for some user-input or for N
> seconds), but I don't want to trade of speed.

I have had the opposite experience. Many times I tried "rm -v" to keep
an eye on what was being removed, but I do not recall once where I
frantically reached for the keyboard in time to make a difference. But
of course that is anecdotal, and push can be somewhat slower.

> > As discussed in the top thread, this could also be used for "interactive
> > push" where you could examine and confirm the changes for each proposed
> > ref change.
> 
> Overkill, I think.  I don't want to bolt on very heavy safety
> features: just help the user help themselves with feedback.

Yes. I do not have any interest in such an interactive push, but the
point is that a potential first step to any confirmation scheme, no
matter what you want it to look like, is a hook. You don't seem to want
a confirmation scheme, though, due to the wait (and I cannot blame you,
as I would not want it either; but then I would not want the extra
refspec message you propose, either).

-Peff
