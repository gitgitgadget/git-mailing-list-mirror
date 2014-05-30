From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 13:03:30 -0400
Message-ID: <20140530170330.GA25443@sigill.intra.peff.net>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
 <20140530015855.GG28683@sigill.intra.peff.net>
 <CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
 <20140530065737.GA13591@sigill.intra.peff.net>
 <xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 19:03:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQDQ-00073r-LG
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933472AbaE3RDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:03:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:34245 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932413AbaE3RDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:03:32 -0400
Received: (qmail 13553 invoked by uid 102); 30 May 2014 17:03:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 12:03:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 13:03:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250445>

On Fri, May 30, 2014 at 09:55:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 29, 2014 at 09:54:10PM -0700, Linus Torvalds wrote:
> >
> >> That said, part of it is just that show-signature is so suboptimal
> >> performance-wise, re-parsing the commit buffer for each commit when
> >> "show_signature" is set. That's just crazy, we've already parsed the
> >> commit text, we already *could* know if it has a signature or not, and
> >> skip it if it doesn't. That would require one of the flag bits in the
> >> object, though, or something, so it's probably not worth doing.
> >
> > Wow, it's really quite bad. Not only do we spend time on commits that we
> > could otherwise know do not have signatures, but we actually pull the
> > buffer from disk, even though we generally have it saved as
> > commit->buffer.
> 
> The one for the signature on the commit itself is me being lazy and
> defensive; I did not want to have to worry about people mucking with
> what is in commit->buffer for whatever reason (e.g. re-encode in
> different charset, etc.) and then asking the signature validated.
> 
> The other one for the merge-tag is me just being lazy, as it is
> unlikely to be corrupt by any reasonable kinds of mucking with
> commit->buffer on a merge.

I don't think we need to worry about commit->buffer being mucked with.
It is always either NULL, or points to the original object contents.
Encoded log messages are always placed in a separate buffer (and in fact
we use the same "optionally point to commit->buffer" trick there). And
things like mucking with parents always happen on the parsed form.

Of course I may be missing a site, and it's certainly a maintenance risk
for the future. But I'd go so far as to say that anything modifying
commit->buffer is wrong, and that side should be fixed.

Do you want me to roll it up with a real commit message?

The other option is to do something like Linus suggested, and note the
presence/absence of signature and mergetag headers with a few bits (we
could even use a commit slab if we don't want to waste bits in the
object struct). That would prevent us hitting this code at all for most
commits, so we would save not only the read_sha1_file cost, but the
extra parsing cost.

However, that does nothing to help the cases where we _do_ have
signatures. A repo where somebody GPG-signed every commit, for example,
would still perform terribly. So even if we go that route, I think we'd
want to apply this technique, too.

-Peff
