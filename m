From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] reject @{-1} not at beginning of object name
Date: Fri, 29 Jan 2010 06:22:19 -0500
Message-ID: <20100129112219.GC6165@coredump.intra.peff.net>
References: <20100128094446.GA14244@coredump.intra.peff.net>
 <20100128095643.GC14253@coredump.intra.peff.net>
 <7vsk9qknf6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 12:22:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naovm-00031R-E1
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 12:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab0A2LWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 06:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462Ab0A2LWX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 06:22:23 -0500
Received: from peff.net ([208.65.91.99]:44565 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab0A2LWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 06:22:23 -0500
Received: (qmail 4336 invoked by uid 107); 29 Jan 2010 11:22:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 Jan 2010 06:22:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2010 06:22:19 -0500
Content-Disposition: inline
In-Reply-To: <7vsk9qknf6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138312>

On Thu, Jan 28, 2010 at 12:02:53PM -0800, Junio C Hamano wrote:

> We might want to use @{-some string that has non digit} for other purposes
> and it may be a safer change to tweak the "do we only have digits" check
> in the post-context to detect and reject only @{-<all digits>}.

I considered that, but I didn't think it was really worth it. If we
later want to make @{-foobar} meaningful, we can loosen the safety check
then.

> But what I am puzzled by the code structure of get_sha1_basic(), which
> looks like this:

You are not the only one who is puzzled. :)

But yes, your analysis of what is there now looks right to me.

> And the place that parses @{-1} and @{u} are different, even though both
> dwim_log() called by the third one and dwim_ref() called by the fourth one
> call substitute_branch_name() and they are perfectly capable of resolving
> @{-1} and @{u} (and even nested stuff like @{-1}@{u}@{u} with your patch).

Ooh, gross. I didn't try @{u}@{u} in my tests, but it should work.

>     Side note.  I am wondering if dwim_log()'s current implementation is
>     even correct in the first place.  When you have two "ambiguous" refs,
>     it appears to me that you will get a warning from dwim_ref(), but if
>     only one of them has a reflog associated with it, dwim_log() won't
>     complain.  Why isn't the function be (1) dwim_ref() to find the ref
>     from abbreviated refname given in str; and then (2) check if the log
>     exists for that ref?

I guess the original rationale was that you might have reflog'd one, so
by asking for "foo@{yesterday}" you are disambiguating as "the one with
a reflog". But that seems kind of useless to me since:

  1. It is somewhat error-prone, as it assumes that from the user's
     perspective, the fact that one ref has a log and the other does not
     is somehow a meaningful disambiguation. Which implies that users
     carefully figure out which refs have reflogs and which do not, and
     I don't think that is true.

  2. For quite a while, we have had logallrefupdates on by default (and
     I don't remember the exact semantics before that, but wasn't it
     enough to simply create a "logs" directory, which meant that you
     either logged everything or nothing?). So I don't even know how you
     would get into a situation where one ref has a log and the other
     does not.

In other words, I totally agree with your statement, and we could
probably just drop the dwim_log code.

> It might be cleaner if the logic went like this instead:

Your logic makes sense to me. I think we could also simply do a
left-to-right parse, eating refs, @{-N}, and @{u} as we go and
converting them into a "real ref". If we get to something else, we stop.
If we have a @{} left, it's a reflog.  Otherwise, it's bogus (I think ^
suffixes and such have already been stripped off at this point).

Interpret_branch_name already does most of the "eating..." part above
(and it needs to remain separate from get_sha1_basic, as things like
"checkout" need to use it directly).

But I didn't really look too hard at it, as:

> But that is a kind of code churn that may not be worth doing.  I dunno.

Yeah, the code was sufficiently nasty and sufficiently core that I
didn't really want to risk breaking it for the sake of cleanup
(especially not during the -rc cycle).

-Peff
