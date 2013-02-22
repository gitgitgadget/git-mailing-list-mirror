From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] format-patch: --inline-single
Date: Fri, 22 Feb 2013 12:23:53 -0500
Message-ID: <20130222172353.GA17475@sigill.intra.peff.net>
References: <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
 <20130220020046.GC7860@pacific.linksys.moosehall>
 <7vppzv3dd8.fsf@alter.siamese.dyndns.org>
 <20130220104720.GD7860@pacific.linksys.moosehall>
 <7vehg9v2xj.fsf@alter.siamese.dyndns.org>
 <7v4nh5v2fl.fsf_-_@alter.siamese.dyndns.org>
 <20130221231328.GA19808@sigill.intra.peff.net>
 <7vmwuws3bo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>, Adam Spiers <git@adamspiers.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8wMA-00063y-DT
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab3BVRX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:23:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57178 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758518Ab3BVRXz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:23:55 -0500
Received: (qmail 6168 invoked by uid 107); 22 Feb 2013 17:25:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 12:25:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 12:23:53 -0500
Content-Disposition: inline
In-Reply-To: <7vmwuws3bo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216844>

On Fri, Feb 22, 2013 at 08:47:39AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> ... <helper function to see if the user is the author> ...
> >> +}
> >
> > Nice, I'm glad you handled this case properly. I've wondered if we
> > should have an option to do a similar test when writing out the "real"
> > message format. I.e., to put the extra "From" line in the body of the
> > message when !is_current_user(). Traditionally we have just said "that
> > is the responsibility of the MUA you use", and let send-email handle it.
> > But it means people who do not use send-email have to reimplement the
> > feature themselves.
> 
> I am not sure if I follow.  Do you mean that you have to remove
> fewer lines if you omit Date/From when it is from you in the first
> place?

Sorry, I think I confused you by going off on a tangent. The rest of my
email was about dropping unnecessary lines from the inline view.  But
here I was talking about another possible use of the "is user the
author" function. For the existing view, we show:

  From: A U Thor <author@example.com>
  Date: ...
  Subject: [PATCH] whatever

  body

and if committer != author, we expect the MUA to convert that to:

  From: C O Mitter <committer@example.com>
  Date: ...
  Subject: [PATCH] whatever

  From: A U Thor <author@example.com>

  body

That logic happens in git-send-email right now, but given that your
patch adds the "are we the author?" function, it would be trivial to add
a "--sender-is-committer" option to format-patch to have it do it
automatically. That saves the MUA from having to worry about it.

> People who do not use send-email (like me) slurp the output
> 0001-have-gostak-distim-doshes.patch into their MUA editor, tell the
> MUA to use the contents on the Subject: line as the subject, and
> remove what is redundant, including the Subject.  Because the output
> cannot be used as-is anyway, I do not think it is such a big deal.

That is one way to do it. Another way is to hand the output of
format-patch to your MUA as a template, making it a starting point for a
message we are about to send. No manual editing is necessary in that
case, unless the "From" header does not match the sender identity.

> And those who have a custom mechanism to stuff our output in their
> MUA's outbox, similar to what imap-send does, would already have to
> have a trivial parser to read the first part of our output up to the
> first blank line (i.e. parsing out the header part) and formatting
> the information it finds into a form that is understood by their
> MUA.

Not necessarily. The existing format is an rfc822 message, which mailers
understand already. It's perfectly cromulent to do:

  git format-patch --stdout "$@" >mbox &&
  mutt -f mbox

and use mutt's "resend-message" as a starting point for sending each
message. No editing is necessary except for adding recipients (which you
can also do on the command-line to format-patch).

> Omitting From: or Date: lines would not help those people who
> already have established the procedure to handle the "Oh, this one
> is from me" case, or to send the output always with the Sender: and
> keeping the From: intact.  So,...

Right, my point was to help people who _should_ have implemented the
"oh, this one is from me" case, but were too lazy to do so (and it's
actually a little tricky to get right, because you might have to adjust
the mime headers to account for encoded author names).

-Peff
