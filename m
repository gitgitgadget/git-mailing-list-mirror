From: Jeff King <peff@peff.net>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Mon, 11 Feb 2013 15:41:42 -0500
Message-ID: <20130211204142.GA28248@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
 <7vvc9ylh97.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:42:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50CX-00026A-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 21:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131Ab3BKUlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 15:41:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44571 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758813Ab3BKUlp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 15:41:45 -0500
Received: (qmail 26680 invoked by uid 107); 11 Feb 2013 20:43:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 15:43:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 15:41:42 -0500
Content-Disposition: inline
In-Reply-To: <7vvc9ylh97.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216084>

On Mon, Feb 11, 2013 at 12:36:52PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> On Fri, Feb 08, 2013 at 04:47:01PM -0800, Junio C Hamano wrote:
> >>
> >>> > Yeah, that actually is a good point.  We should be using logmsg_reencode
> >>> > so that we look for strings in the user's encoding.
> >>> 
> >>> Perhaps like this.  Just like the previous one (which should be
> >>> discarded), this makes the function always use the temporary strbuf,
> >>> so doing this upfront actually loses more code than it adds ;-)
> >>
> >> I didn't see this in What's Cooking or pu. We should probably pick an
> >> approach and go with it.
> >>
> >> I think using logmsg_reencode makes sense. I'd be in favor of avoiding
> >> the extra copy in the common case, so something like the patch below. If
> >> you feel strongly about the code cleanup at the minor run-time expense,
> >> I won't argue too much, though.
> >
> > Sounds good to me.  Care to do the log message while at it?
> 
> Heh, how about this?  I still need a sign-off from you.

I'm working on the log message and tests right now. There's also a minor
code fixup needed to compile with -Wall.

>     log --grep: look for the given string in log output encoding
>     
>     We used to grep in the raw commit buffer contents, possibly pieces
>     of notes encoded in log output encoding appended to it, which was
>     insane.
>     
>     Convert the contents of the commit message also to log output
>     encoding before looking for the string.  This incidentally fixes a
>     possible NULL dereference that can happen when commit->buffer has
>     already been freed, which can happen with
>     
>     	git commit -m 'text1' --allow-empty
>     	git commit -m 'text2' --allow-empty
>     	git log --graph --no-walk --grep 'text2'
>     
>     which arguably does not make any sense (--graph inherently wants a
>     connected history, and by --no-walk the command line is telling us
>     to show discrete points in history without connectivity), and we
>     probably should forbid the combination, but that is a separate
>     issue.

I'll use bits of that. I had sort of punted on the "how to reproduce the
segfault" issue entirely because you had noted that it was not a sane
thing to do. Still, I think it makes sense to mention it with the caveat
you give here.

-Peff
