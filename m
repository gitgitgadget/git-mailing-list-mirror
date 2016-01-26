From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Mon, 25 Jan 2016 21:37:53 -0500
Message-ID: <20160126023753.GA4012@sigill.intra.peff.net>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
 <20160124071234.GA24084@sigill.intra.peff.net>
 <20160124071815.GB24084@sigill.intra.peff.net>
 <xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
 <20160124222736.GA29115@sigill.intra.peff.net>
 <xmqqsi1m9yxh.fsf@gitster.mtv.corp.google.com>
 <20160125100141.GC24452@sigill.intra.peff.net>
 <xmqqmvrtfm0u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 03:38:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNtW4-0000Ne-KN
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 03:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbcAZCh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 21:37:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:60356 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756758AbcAZCh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 21:37:56 -0500
Received: (qmail 29347 invoked by uid 102); 26 Jan 2016 02:37:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jan 2016 21:37:56 -0500
Received: (qmail 25824 invoked by uid 107); 26 Jan 2016 02:38:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Jan 2016 21:38:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jan 2016 21:37:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqqmvrtfm0u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284773>

On Mon, Jan 25, 2016 at 12:21:21PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure "remove-standard-prefix" doesn't open its own questions.
> > Like "what are the standard prefixes?".
> 
> It is easy to define, no?  This is invented for the internal use of
> the listing modes of "tag" and "branch", so the users are welcome to
> use it if they see fit, but how the prefixes are stripped is defined
> by the convenience of these commands--the behaviour might even change
> when these commands are enhanced.

What does this do:

  git for-each-ref --format='%(refname:remove-standard-prefix)'

?

Is there no standard prefix, because we are not in branch/tag? Does it
remove well-known prefixes like "refs/heads/", "refs/tags/", etc? Does
it remove the first two components (e.g., what happens to
"refs/foo/bar")? If so, what happens to "refs/stash"?

We can say "it is all internally defined and subject to change". But
that is not very helpful to a user, and this "it's magic, don't rely on
it" wart will be part of the user-facing interface. We have to write
_something_ in the "default format" documentation for git-tag.

> Yeah, I really do not like any of the "do not error out but assume
> that the user would not care about the ambiguities" solutions for
> something we primarily intend to use for internal purposes.
> 
> I agree that "strip=<n>", "remove-prefix=<glob>", and the friends
> are good for end-user scripting, but they can come later, outside of
> the scope of this regression fix, and that is the proper time to
> debate and decide if it is really ok to assume that the user does
> not care about ambiguity, or it is prudent to error out.  A separate
> "remove-standard-prefix" that is meant for internal use would allow
> us to push the fix out without having to decide now.

Yeah, I am definitely on board with trying to do the most minimal thing
for the regression fix and worry about more advanced concerns later (if
at all). It seems to me that "error out" is a pretty minimal behavior,
though, and one that doesn't lock us into any behaviors (i.e., it is
generally OK to take something that did not work at all before, and give
it new useful behavior; it is not OK to change something that did
something useful before).

So what about this:

  1. Implement ":strip=<n>" and use it from git-tag.

  2. Have it error out on a ref with fewer than <n> components. This
     should be impossible to trigger via "git-tag" with the default
     format.

  3. Explicitly document that the behavior for values of <n> that are
     not positive integers is undefined and subject to change (or
     alternatively, we can simply error out).

That _is_ user-visible, but it seems like "strip" is a fairly flexible
mechanism by itself (enough that I do not mind living with it forever),
and we haven't made any promises about the ambiguous parts.


If we are going to do something _really_ internal and undocumented to
fix the regression, I think I would rather not introduce a new formatter
at all, but simply teach "%(refname:short)" to do the magic internal
shortening in the context of git-tag. That does not let people emulate
"tag" with "for-each-ref", but that is not part of the regression or its
fix.

-Peff
